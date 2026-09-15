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

require("PGEvents")

function Definitions()
	Category = "Defend_Space_Station"
	AllowEngagedUnits = true
	IgnoreTarget = true
	TaskForce =
	{
		{
			"MainForce",
			"TaskForceRequired",
			"DenySpecialWeaponAttach"
		}
	}
end

function MainForce_Thread()
	local focus_fire_on_target = Find_Nearest(Target, "Bomber | Frigate | Capital", PlayerObject, false)

	if TestValid(focus_fire_on_target) and focus_fire_on_target.Get_Type().Get_Name() == "GENERIC_CAPITAL_SHIP_MARKER" then
		DebugMessage("%s -- Tried to attack dummy space station marker, aborting.", tostring(Script))
		ScriptExit()
	end

	while TestValid(focus_fire_on_target) do
		-- Cancel all goals only if the station is taking catastrophic damage,
		-- or if it's about to.
		if TestValid(Target) and (Target.Get_Shield() == 0.0 or Target.Get_Hull() <= 0.75) then
			Purge_Goals(PlayerObject)
		end

		Sleep(1)

		-- Use all idle units, mapwide
		MainForce.Collect_All_Free_Units()

		while TestValid(focus_fire_on_target) do
			DebugMessage("%s -- Collecting all free units and attacking target: %s", tostring(Script), tostring(focus_fire_on_target))
			MainForce.Collect_All_Free_Units()
			BlockOnCommand(MainForce.Attack_Target(focus_fire_on_target), 5)
		end

		Sleep(1)
		MainForce.Set_Plan_Result(true)

		-- Need to manually evaluate otherwise the plan may never be removed.
		-- Check perception manually to ensure we don't chase units across the map,
		-- we need to protect the station!
		-- Techup also NILs target.
		if TestValid(Target) then
			if (EvaluatePerception("Need_To_Defend_Space_Station", PlayerObject, Target) == 0) then
				ScriptExit()
			else
				focus_fire_on_target = Find_Nearest(Target, "Bomber | Frigate | Capital", PlayerObject, false)
				if TestValid(focus_fire_on_target) and focus_fire_on_target.Get_Type().Get_Name() == "GENERIC_CAPITAL_SHIP_MARKER" then
					DebugMessage("%s -- Retarget tried to attack dummy space station marker, aborting.", tostring(Script))
					ScriptExit()
				end
			end
		else
			ScriptExit()
		end
	end
end

function MainForce_Unit_Damaged(tf, unit, attacker, deliberate)
	-- Override self preservation behavior, just save the station!
end
