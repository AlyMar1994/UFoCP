-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Kessel_Piracy.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Kessel_Piracy.lua $
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

require("PGStateMachine")
require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Kessel_Piracy_Mission_Begin = State_Kessel_Piracy_Mission_Begin,
		Kessel_Piracy_Mission_Speech_Line_00_Remove_Text = State_Kessel_Piracy_Mission_Speech_Line_00_Remove_Text
	}
		
	underworld = Find_Player("Underworld")
	rebel = Find_Player("Rebel")
	empire = Find_Player("Empire")
	hutts = Find_Player("Hutts")
	
	camera_offset = 135
	
	defenses_destroyed = false
	phase_0_triggered = false
	mission_started = false
	victory_triggered = false
	close_to_objective = false
	
	rebel_enemy = false
	empire_enemy = false
	hutt_enemy = false
end

function State_Kessel_Piracy_Mission_Begin(message)
	if message == OnEnter then
		mission_started = true
		
		empire_list = Find_All_Objects_Of_Type(empire)
		
		for k, unit in pairs(empire_list) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Stop()
			end
		end
		
		rebel_list = Find_All_Objects_Of_Type(rebel)
		
		for k, unit in pairs(rebel_list) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Stop()
			end
		end
		
		ig88 = Find_First_Object("IG-2000")
		Point_Camera_At(ig88)
		Start_Cinematic_Camera()
		End_Cinematic_Camera()
		Letter_Box_Out(0)
		
		--current_cinematic_thread = Create_Thread("Intro_Cinematic", hero)
		Fade_Screen_In(1)
		Lock_Controls(0)
		
		Story_Event("TEXT_SPEECH_UW_CLD_04")
		
		phase_1_flag_list = Find_All_Objects_With_Hint("phase1flag")
		phase_1_flag = phase_1_flag_list[1]
		
		phase_2_flag_list = Find_All_Objects_With_Hint("phase2flag")
		phase_2_flag = phase_2_flag_list[1]
		
		Register_Prox(phase_1_flag, Prox_Phase_1_Entry, 1700, underworld_player)
		Register_Prox(phase_2_flag, Prox_Phase_2_Entry, 1300, underworld_player)
		
		rebel_list = Find_All_Objects_Of_Type(rebel)
		empire_list = Find_All_Objects_Of_Type(empire)
		hutt_list = Find_All_Objects_Of_Type(hutts)
		
		if TestValid(rebel_list[1]) then
			rebel_enemy = true
		end
		
		if TestValid(empire_list[1]) then
			empire_enemy = true
		end
		
		if TestValid(hutt_list[1]) then
			hutt_enemy = true
		end
	end
end

function Story_Mode_Service()
	if mission_started then
		ig88 = Find_First_Object("IG-2000")
				
		if not TestValid(ig88) then
			Story_Event("FAIL_OBJECTIVE_00")
			
			rebel_list = Find_All_Objects_Of_Type(rebel)
			empire_list = Find_All_Objects_Of_Type(empire)
			hutt_list = Find_All_Objects_Of_Type(hutts)
			
			if TestValid(rebel_list[1]) then
				Story_Event("VICTORY_REBEL")
			end
			
			if TestValid(empire_list[1]) then
				Story_Event("VICTORY_EMPIRE")
			end
			
			if TestValid(hutt_list[1]) then
				Story_Event("VICTORY_HUTTS")
			end
		end
	end
	
	if mission_started and not victory_triggered and not defenses_destroyed then
		def_turret_0 = Find_All_Objects_With_Hint("defense0")
		def_turret_1 = Find_All_Objects_With_Hint("defense1")
		def_turret_2 = Find_All_Objects_With_Hint("defense2")
		phase_1_list = Find_All_Objects_With_Hint("phase1")
		phase_2_list = Find_All_Objects_With_Hint("phase2")
		
		if not TestValid(def_turret_0[1]) and
		   not TestValid(def_turret_1[1]) and
		   not TestValid(def_turret_2[1]) then
				if empire_enemy then
					if not TestValid(phase_2_list[1]) then
						defenses_destroyed = true
						Story_Event("COMPLETE_OBJECTIVE_02")				
						Register_Prox(objective_unit, Prox_Objective_Object, 500, underworld_player)
					end
				end
				
				if rebel_enemy then
					if not TestValid(phase_1_list[1]) then
						defenses_destroyed = true
						Story_Event("COMPLETE_OBJECTIVE_02")				
						Register_Prox(objective_unit, Prox_Objective_Object, 500, underworld_player)
					end
				end
		end
	end

		
	if mission_started and not victory_triggered and close_to_objective then
		objective_list = Find_All_Objects_With_Hint("objective")
		objective_unit = objective_list[1]
		objective_unit.Make_Invulnerable(true)
		objective_unit.Prevent_Opportunity_Fire(true)
		
		if TestValid(objective_unit) then
			Story_Event("COMPLETE_OBJECTIVE_00")
			victory_triggered = true
		end		
	end
end

function Turn_On_Units()
	empire_list = Find_All_Objects_Of_Type(empire)		
	for k, unit in pairs(empire_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(false)
		end
	end
	
	rebel_list = Find_All_Objects_Of_Type(rebel)
	for k, unit in pairs(rebel_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(false)
		end
	end
	
	phase_1_list = Find_All_Objects_With_Hint("phase1")
	for k, unit in pairs(phase_1_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Stop()
		end
	end
		
	phase_2_list = Find_All_Objects_With_Hint("phase2")
	for k, unit in pairs(phase_2_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Stop()
		end
	end	
end

function Prox_Phase_1_Entry(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld then
		self_obj.Cancel_Event_Object_In_Range(Prox_Phase_1_Entry)
		phase_1_list = Find_All_Objects_With_Hint("phase1")
		for k, unit in pairs(phase_1_list) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(false)
			end
		end
	end
end

function Prox_Phase_2_Entry(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld then
		self_obj.Cancel_Event_Object_In_Range(Prox_Phase_2_Entry)
		phase_2_list = Find_All_Objects_With_Hint("phase2")
		for k, unit in pairs(phase_2_list) do
			if TestValid(unit) then
				objective_list = Find_All_Objects_With_Hint("objective")
				objective_unit = objective_list[1]
				unit.Prevent_AI_Usage(false)
				unit.Guard_Target(objective_unit)
			end
		end
	end
end

function Prox_Objective_Object(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld then
		close_to_objective = true
	end
end

function State_Kessel_Piracy_Mission_Speech_Line_00_Remove_Text(message)
	if message == OnEnter then
				
		Story_Event("ADD_OBJECTIVE_00")
		
		objective_list = Find_All_Objects_With_Hint("objective")
		objective_unit = objective_list[1]
		
		if TestValid(objective_unit) then
			Add_Radar_Blip(objective_unit, "objective_blip")
			objective_unit.Make_Invulnerable(true)
		end	
		
		Turn_On_Units()	
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
	
	Story_Event("TEXT_SPEECH_UW_CLD_04")
end



-- ************************************************************************
-- ***********************INTRO CINEMATIC FUNCTION*************************
-- ************************************************************************

function Intro_Cinematic ()	
	
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)	
	Fade_Screen_In(2)
	
	ig88 = Find_First_Object("IG-2000")
	
	Transition_Cinematic_Camera_Key(ig88, 0, 175, 25, 45, 1, 1, 1, 0)
	Transition_Cinematic_Target_Key(ig88, 0, 0, 0, 7, 0, ig88, 0, 0)
	--Sleep(7)
	
	Transition_Cinematic_Camera_Key(ig88, 5, 175, 25, 135, 1, 1, 1, 0)
	
	Sleep(4.5)
	
	while true do
		camera_offset = camera_offset + 90
		Transition_Cinematic_Camera_Key(ig88, 5, 175, 25, camera_offset, 1, 1, 1, 0)
		
		if camera_offset == 315 then
			Create_Thread("End_Camera")
			break
		end
		
		Sleep(4.5)
	end
end