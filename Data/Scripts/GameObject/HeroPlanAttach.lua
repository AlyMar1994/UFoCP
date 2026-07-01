-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/HeroPlanAttach.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/HeroPlanAttach.lua $
--
--    Original Author: Brian Hayes
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

require("pgcommands")

function Base_Definitions()
	DebugMessage("%s -- In Base_Definitions", tostring(Script))

	Common_Base_Definitions()
	
	ServiceRate = 10

	if Definitions then
		Definitions()
	end
end

function main()

	DebugMessage("%s -- In main for %s", tostring(Script), tostring(Object))
	
	if HeroService then
		while 1 do
			HeroService()
			PumpEvents()
		end
	end
	
	ScriptExit()
end

function inc_found_type_count(ival, type_found_val)
	if type_found_val == true then
		FoundTypeCount = FoundTypeCount + 1
		FoundTypeWeight = FoundTypeWeight + CurrentTypeWeights[ival]
	end
end

function Get_Target_Weight(target, type_list, type_weights)

	FoundTypeCount = 0
	FoundTypeWeight = 0

	CurrentTypeWeights = type_weights
	
	FoundTypes = EvaluateTypeList(PlayerObject, target, type_list)
	
	if not FoundTypes then
		return 0
	end
	
	table.foreachi(FoundTypes, inc_found_type_count)

	if FoundTypeCount == 0 then
		return 0
	end
	
	return FoundTypeWeight / FoundTypeCount
end

