-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Thyferra_Kidnapping.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Thyferra_Kidnapping.lua $
--
--    Original Author: Dan Etter
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

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
--
function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents =
	{
		Thyferra_Kidnapping_Mission_Begin = State_Thyferra_Kidnapping_Mission_Begin,
		Thyferra_Kidnapping_Mission_Speech_Line_02_Remove_Text = State_Thyferra_Kidnapping_Mission_Speech_Line_02_Remove_Text,
		Thyferra_Kidnapping_Mission_Speech_Line_06_Remove_Text = State_Thyferra_Kidnapping_Mission_Speech_Line_06_Remove_Text,
		Thyferra_Kidnapping_Mission_Speech_Line_07_Remove_Text = State_Thyferra_Kidnapping_Mission_Speech_Line_07_Remove_Text,
		Thyferra_Kidnapping_Mission_Speech_Line_08_Remove_Text = State_Thyferra_Kidnapping_Mission_Speech_Line_08_Remove_Text
	}

	underworld = Find_Player("Underworld")
	rebel = Find_Player("Rebel")
	empire = Find_Player("Empire")
	hutts = Find_Player("Hutts")
	neutral = Find_Player("Neutral")

	camera_offset = 135

	phase_0_triggered = false
	mission_started = false
	victory_triggered = false
	follow_triggered = false

	nearest_rebel_list = {}
	nearest_empire_list = {}
end

function State_Thyferra_Kidnapping_Mission_Begin(message)
	if message == OnEnter then
		mission_started = true

		rebel_list = Find_All_Objects_Of_Type(rebel)
		empire_list = Find_All_Objects_Of_Type(empire)
		hutt_list = Find_All_Objects_Of_Type(hutts)

		hero = Find_First_Object("TYBER_ZANN")

		if TestValid(rebel_list[1]) then
			rebel_defender = true
		end
		if TestValid(empire_list[1]) then
			empire_defender = true
		end

		if rebel_defender then
			for k, unit in pairs(rebel_list) do
				if TestValid(unit) then
					unit.Prevent_AI_Usage(true)
					unit.Guard_Target(unit.Get_Position())
				end
			end
		end
		if empire_defender then
			for k, unit in pairs(empire_list) do
				if TestValid(unit) then
					unit.Prevent_AI_Usage(true)
					unit.Guard_Target(unit.Get_Position())
				end
			end
		end

		objective_list = Find_All_Objects_With_Hint("objective")
		objective = objective_list[1]
		objective.Make_Invulnerable(true)
		objective.Change_Owner(neutral)

		objective_dest_list = Find_All_Objects_With_Hint("objectivedest")
		objective_dest = objective_dest_list[1]

		Register_Prox(objective, Prox_Objective_Object, 20, underworld)
		Register_Prox(objective_dest, Prox_Kidnap_Destination, 100, neutral)

		Point_Camera_At(hero)
		Start_Cinematic_Camera()
		End_Cinematic_Camera()
		Letter_Box_Out(0)

		--current_cinematic_thread = Create_Thread("Intro_Cinematic", hero)
		Fade_Screen_In(1)
		Lock_Controls(0)

		Story_Event("ADD_OBJECTIVE_00")
		Story_Event("TEXT_SPEECH_THYFERRA_KID_TACTICAL_COR48_02")

		Create_Thread("Move_Objective_To_Nearest_Ally")
	end
end

function Story_Mode_Service()
	if mission_started then
		if not TestValid(hero) then
			Story_Event("FAIL_OBJECTIVE_01")

			if empire_defender then
				Story_Event("VICTORY_EMPIRE")
			end
			if rebel_defender then
				Story_Event("VICTORY_REBEL")
			end
		end
	end

	if follow_triggered then
		if TestValid(objective) then
			objective.Move_To(hero)
		end
	end
end

function Prox_Objective_Object(self_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "TYBER_ZANN" and not follow_triggered then
		Story_Event("TEXT_SPEECH_THYFERRA_KID_TACTICAL_COR48_06")
		objective.Stop()

		Story_Event("COMPLETE_OBJECTIVE_00")
	end
end

function Prox_Kidnap_Destination(self_obj, trigger_obj)
	if follow_triggered and trigger_obj == objective then
		Story_Event("COMPLETE_OBJECTIVE_02")
	end
end

function State_Thyferra_Kidnapping_Mission_Speech_Line_02_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ADD_OBJECTIVE_00")
	end
end

function State_Thyferra_Kidnapping_Mission_Speech_Line_06_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ADD_OBJECTIVE_02")
		follow_triggered = true
		Story_Event("TEXT_SPEECH_THYFERRA_KID_TACTICAL_COR48_07")

		if rebel_defender then
			rebel_list = Find_All_Objects_Of_Type(rebel)
			for k, unit in pairs(rebel_list) do
				if TestValid(unit) then
					unit.Attack_Move(objective)
				end
			end
		end
		if empire_defender then
			empire_list = Find_All_Objects_Of_Type(empire)
			for k, unit in pairs(empire_list) do
				if TestValid(unit) then
					unit.Attack_Move(objective)
				end
			end
		end
	end
end

function State_Thyferra_Kidnapping_Mission_Speech_Line_07_Remove_Text(message)
	if message == OnEnter then
		Story_Event("TEXT_SPEECH_THYFERRA_KID_TACTICAL_COR48_08")
	end
end

function Move_Objective_To_Nearest_Ally()
	local objective_retreat = Find_All_Objects_With_Hint("emergency-safespace")

	while not follow_triggered do
		if TestValid(objective) and rebel_defender then
			nearest_rebel = Find_Nearest(objective, "Infantry | Vehicle", rebel, true)
			if TestValid(nearest_rebel) then
				objective.Move_To(nearest_rebel)
			else
				objective.Move_To(objective_retreat[1])
			end
			Sleep(5)
		end
		if TestValid(objective) and empire_defender then
			empire_list = Find_All_Objects_Of_Type(empire)
			nearest_empire = Find_Nearest(objective, "Infantry | Vehicle", empire, true)
			if TestValid(nearest_empire) then
				objective.Move_To(nearest_empire)
			else
				objective.Move_To(objective_retreat[1])
			end
			Sleep(5)
		end
	end
end

-- ************************************************************************
-- ***********************INTRO CINEMATIC FUNCTION*************************
-- ************************************************************************

function Intro_Cinematic(focus_unit)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	Fade_Screen_In(2)

	camera_distance = 50
	camera_rotation = 45
	camera_end = (camera_rotation + 180)

	Transition_Cinematic_Camera_Key(focus_unit, 0, camera_distance, 25, (camera_rotation - 90), 1, 1, 1, 0)
	Transition_Cinematic_Target_Key(focus_unit, 0, 0, 0, 7, 0, focus_unit, 0, 0)

	Transition_Cinematic_Camera_Key(focus_unit, 5, camera_distance, 25, camera_rotation, 1, 1, 1, 0)

	Sleep(4.5)

	while true do
		camera_rotation = camera_rotation + 90
		Transition_Cinematic_Camera_Key(focus_unit, 5, camera_distance, 25, camera_rotation, 1, 1, 1, 0)

		if camera_rotation == camera_end then
			End_Camera()
		end

		Sleep(4.5)
	end
end

function Story_Handle_Esc()
	if current_cinematic_thread ~= nil then
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil
		Create_Thread("End_Camera")
	end
end

function End_Camera()
	Transition_To_Tactical_Camera(6)
	Sleep(4)
	Letter_Box_Out(2)
	Sleep(2)
	Lock_Controls(0)
	End_Cinematic_Camera()

	Story_Event("ADD_OBJECTIVE_00")
	Story_Event("TEXT_SPEECH_THYFERRA_KID_TACTICAL_COR48_02")
end
