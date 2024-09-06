-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/HanSoloPlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/HanSoloPlan.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

-- This is actually for the HanSolo and Chewie team object that exists in galactic mode.

require("HeroPlanAttach")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- only join plans that meet our expense requirements.
	MinPlanAttachCost = 45000
	MaxPlanAttachCost = 0

	-- Commander hit list.
	Attack_Ability_Type_Names = {
		"Death_Star", "Death_Star_II",	-- Attack these types.
		"Darth_Team", "Darth_Team_Executor", "Boba_Fett_Team" 				-- Stay away from these types.
	}
	Attack_Ability_Weights = {
		10,   				-- attack type weights.
		BAD_WEIGHT, BAD_WEIGHT   				-- feared type weights.
	}
	Attack_Ability_Types = WeightedTypeList.Create()
	Attack_Ability_Types.Parse(Attack_Ability_Type_Names, Attack_Ability_Weights)

	-- Prefer task forces with these units.
	Escort_Ability_Type_Names = { "Capital", "Corvette", "Frigate", "Fleet_Com_Rebel_Team", "Fleet_Com_Empire_Team" }
	Escort_Ability_Weights = { 10, 10, 10, BAD_WEIGHT, BAD_WEIGHT }
	Escort_Ability_Types = WeightedTypeList.Create()
	Escort_Ability_Types.Parse(Escort_Ability_Type_Names, Escort_Ability_Weights)
end

function Evaluate_Attack_Ability(target, goal)
	return Get_Target_Weight(target, Attack_Ability_Types, Attack_Ability_Weights)
end

function Get_Escort_Ability_Weights(goal)
	return Escort_Ability_Types
end

function HeroService()

end
