-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SpaceMode/AI_Plan_ExpansionGeneric_DefendSpaceStation.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SpaceMode/AI_Plan_ExpansionGeneric_DefendSpaceStation.lua $
--
--    Original Author: James Yarrow
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

require("pgevents")

function Definitions()
	
	AllowEngagedUnits = true
	IgnoreTarget = true
	Category = "Defend_Space_Station"
	TaskForce = {
	{
		"MainForce"
		, "TaskForceRequired"
		, "DenySpecialWeaponAttach"
	}
	}

end

function MainForce_Thread()

	focus_fire_on_target = Find_Nearest(Target, "Frigate | Capital", PlayerObject, false)
	
	while TestValid(focus_fire_on_target) do
		-- Cancel all goals
		Purge_Goals(PlayerObject)
		
		Sleep(1)
		
		-- Use all idle units, mapwide
		MainForce.Collect_All_Free_Units()	
		
		while TestValid(focus_fire_on_target) do
			MainForce.Collect_All_Free_Units()
			BlockOnCommand(MainForce.Attack_Target(focus_fire_on_target), 5)
		end
	
		Sleep(1)
		MainForce.Set_Plan_Result(true)
		
		focus_fire_on_target = Find_Nearest(Target, "Frigate | Capital", PlayerObject, false)
	
	end
end

function MainForce_Unit_Damaged(tf, unit, attacker, deliberate)
	--Override self preservation behavior, just save the station!
end