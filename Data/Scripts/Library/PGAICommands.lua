-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGAICommands.lua#2 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGAICommands.lua $
--
--    Original Author: Brian Hayes
--
--            $Author: James_Yarrow $
--
--            $Change: 57990 $
--
--          $DateTime: 2006/11/13 17:33:10 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGCommands")

function Base_Definitions()
	-- DebugMessage("%s -- In Base_Definitions", tostring(Script))

	InSpaceConflict = false
	MagicPlan = false
	
	-- Scale all counter forces by this factor
	MinContrastScale = 1.1
	MaxContrastScale = 1.5
	PerFailureContrastAdjust = 0.1
	EnemyContrastTypes = {}
	FriendlyContrastTypes = {}
	ContrastTypeScale = {}

	-- Track abilities that got cancelled (nebula or whatever) so we can turn them on later
	lib_cancelled_abilities = {}

	Common_Base_Definitions()

	-- nil out the global Taskforce variables.
	if TaskForce and type(TaskForce) == "table" then
		for idx,tfdef in pairs(TaskForce) do
         if type(tfdef) == "table" and type(tfdef[1]) == "string" then
				_G[tfdef[1]] = nil
			end
		end
	end
	
	if PlanDefinitionLoad then
		Set_Contrast_Values()
	end

	PlanDefinitionLoad = nil
	
	if Definitions then
		Definitions()
	end
end

function Set_Contrast_Values()
	_e_cnt = 1;

	EnemyContrastTypes[_e_cnt] = "Fighter"
	FriendlyContrastTypeNames = {"AntiFighter", "Bomber", "Fighter", "Corvette", "Frigate", "Capital"}
	FriendlyContrastWeights =	{4.0, 0.25, 1.0, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;
	
	EnemyContrastTypes[_e_cnt] = "Bomber"
	FriendlyContrastTypeNames = {"AntiBomber", "Frigate", "Capital", "Fighter", "Bomber", "Corvette"}
	FriendlyContrastWeights =	{4.0, 0.25, 0.25, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "Transport"
	FriendlyContrastTypeNames = {"Fighter", "Bomber", "Corvette", "Frigate", "Capital", }
	FriendlyContrastWeights =	{1.0, 1.0, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "Corvette"
	FriendlyContrastTypeNames = {"AntiCorvette", "Fighter", "Bomber", "Corvette", "Frigate", "Capital"}
	FriendlyContrastWeights =	{3.0, 0.25, 0.25, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;
	
	EnemyContrastTypes[_e_cnt] = "Frigate"
	FriendlyContrastTypeNames = {"AntiFrigate", "Corvette", "Fighter", "Bomber", "Frigate", "Capital"}
	FriendlyContrastWeights =	{3.0, 0.5, 1.0, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "Capital"
	FriendlyContrastTypeNames = {"AntiCapital", "Corvette", "Frigate", "Fighter", "Bomber", "Capital"}
	FriendlyContrastWeights =	{2.0, 0.33, 0.5, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;
	
	EnemyContrastTypes[_e_cnt] = "Infantry"
	FriendlyContrastTypeNames = {"AntiInfantry", "Vehicle", "Infantry", "Air", "Structure", "LandHero"}
	FriendlyContrastWeights =	{4.0, 0.5, 1.0, 1.0, 1.0, 4.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;
	
	EnemyContrastTypes[_e_cnt] = "Vehicle"
	FriendlyContrastTypeNames = {"AntiVehicle", "Infantry", "Vehicle", "Air", "Structure", "LandHero"}
	FriendlyContrastWeights =	{4.0, 0.25, 1.0, 1.0, 1.0, 2.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "Air"
	FriendlyContrastTypeNames = {"AntiAir", "Infantry", "Vehicle", "Air", "Structure", "LandHero"}
	FriendlyContrastWeights =	{4.0, 1.0, 1.0, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "Structure"
	FriendlyContrastTypeNames = {"AntiStructure", "Infantry", "Vehicle", "Air", "Structure", "LandHero"}
	FriendlyContrastWeights =	{4.0, 1.0, 1.0, 1.0, 1.0, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)	
	_e_cnt = _e_cnt+1;

	EnemyContrastTypes[_e_cnt] = "LandHero"
	FriendlyContrastTypeNames = {"Infantry", "Vehicle", "Air", "Structure", "LandHero"}
	FriendlyContrastWeights =  {0.5, 0.5, 0.5, 0.25, 1.0}
	FriendlyContrastTypes[_e_cnt] = WeightedTypeList.Create()
	FriendlyContrastTypes[_e_cnt].Parse(FriendlyContrastTypeNames, FriendlyContrastWeights)
	_e_cnt = _e_cnt+1;

end


