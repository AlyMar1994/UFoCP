-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Bespin_Piracy.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_Bespin_Piracy.lua $
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
--			DO NOT PUT OBJECT REFERENCES HERE.  THEY ARE NOT CREATED YET.
--
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Bespin_Piracy_Mission_Begin = State_Bespin_Piracy_Mission_Begin,
		Bespin_Piracy_Mission_Speech_Line_06_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_06_Remove_Text,
		Bespin_Piracy_Mission_Speech_Line_07_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_07_Remove_Text,
		Bespin_Piracy_Mission_Speech_Line_08_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_08_Remove_Text,
		Bespin_Piracy_Mission_Speech_Line_09_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_09_Remove_Text,
		Bespin_Piracy_Mission_Speech_Line_10_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_10_Remove_Text,
		Bespin_Piracy_Mission_Speech_Line_11_Remove_Text = State_Bespin_Piracy_Mission_Speech_Line_11_Remove_Text
	}
	
	emp_convoy0spawn0_list = {
		"TIE_INTERCEPTOR_SQUADRON"
	}
	
	emp_convoy0spawn1_list = {
		"TIE_DEFENDER_SQUADRON"
	}
	
	emp_convoy1spawn0_list = {
		"TIE_INTERCEPTOR_SQUADRON"
	}
	
	emp_convoy1spawn1_list = {
		"ACCLAMATOR_ASSAULT_SHIP",
		"TIE_INTERCEPTOR_SQUADRON"
	}
	
	reb_convoy0spawn0_list = {
		"A_Wing_Squadron",
		"Rebel_X-Wing_Squadron"
	}
	
	reb_convoy0spawn1_list = {
		"A_Wing_Squadron",
		"Rebel_X-Wing_Squadron"
	}
	
	reb_convoy1spawn0_list = {
		"A_Wing_Squadron",
		"Rebel_X-Wing_Squadron"
	}
	
	reb_convoy1spawn1_list = {
		"Nebulon_B_Frigate",
		"A_Wing_Squadron",
		"Rebel_X-Wing_Squadron"
	}
		
	underworld = Find_Player("Underworld")
	rebel = Find_Player("Rebel")
	empire = Find_Player("Empire")
	hutts = Find_Player("Hutts")
	neutral = Find_Player("Neutral")
	
	empire_defender = false
	rebel_defender = false
	
	mission_started = false
	objective_02_given = false
	objective_03_given = false
	obj_02_complete = false
	obj_03_complete = false
	path1_triggered = false
	shuttle_at_exit = false
	convoy0_spawned = false
	convoy1_spawned = false
	
	convoy0_shuttle0_reveal = nil
	convoy0_shuttle1_reveal = nil
	convoy1_shuttle0_reveal = nil
	convoy1_shuttle1_reveal = nil
	
	interdictor_at_dest = false
	interdict_message = false
	
	path_0_shuttles_moved = {}
	path_1_shuttles_moved = {}
end

function State_Bespin_Piracy_Mission_Begin(message)
	if message == OnEnter then
		mission_started = true
		
		hero = Find_First_Object("THE_PEACEBRINGER")
		if not TestValid(hero) then
			hero = Find_First_Object("INTERCEPTOR4_FRIGATE")
		end
		
		rebel_list = Find_All_Objects_Of_Type(rebel)
		empire_list = Find_All_Objects_Of_Type(empire)
		
		if TestValid(rebel_list[1]) then
			rebel_defender = true
		end
		if TestValid(empire_list[1]) then
			empire_defender = true
		end
		
		end_guard = Find_All_Objects_With_Hint("endguard")
		for k, unit in pairs(end_guard) do
			if TestValid(unit) then
				unit.Stop(true)
				unit.Prevent_AI_Usage(true)
			end
		end
		center_defense = Find_All_Objects_With_Hint("centerdefense")
		for k, unit in pairs(center_defense) do
			if TestValid(unit) then
				unit.Stop(true)
				unit.Prevent_AI_Usage(true)
			end
		end
		
		convoy0_spawn0 = Find_Hint("STORY_TRIGGER_ZONE_00","convoy0spawn0")
		convoy0_spawn0a = Find_Hint("STORY_TRIGGER_ZONE_00","convoy0spawn0a")
		convoy0_spawn1 = Find_Hint("STORY_TRIGGER_ZONE_00","convoy0spawn1")
		convoy0_spawn1a = Find_Hint("STORY_TRIGGER_ZONE_00","convoy0spawn1a")
		convoy1_spawn0 = Find_Hint("STORY_TRIGGER_ZONE_00","convoy1spawn0")
		convoy1_spawn0a = Find_Hint("STORY_TRIGGER_ZONE_00","convoy1spawn0a")
		convoy1_spawn1 = Find_Hint("STORY_TRIGGER_ZONE_00","convoy1spawn1")
		convoy1_spawn1a = Find_Hint("STORY_TRIGGER_ZONE_00","convoy1spawn1a")
		
		interdictor = Find_First_Object("INTERDICTOR_CRUISER")
		interdictor_dest = Find_Hint("STORY_TRIGGER_ZONE_00","interdictordest")
		
		Register_Prox(interdictor_dest, Prox_Interdictor, 150, underworld)
		
		convoy_path_0 = Find_Hint("STORY_TRIGGER_ZONE_00","convoypath0")
		convoy_path_1 = Find_Hint("STORY_TRIGGER_ZONE_00","convoypath1")		
		
		if empire_defender then
			Register_Prox(convoy_path_0, Prox_Shuttle_Move, 150, empire)
			Register_Prox(convoy_path_1, Prox_Shuttle_Move_End, 150, empire)
		end
		if rebel_defender then
			Register_Prox(convoy_path_0, Prox_Shuttle_Move, 150, rebel)
			Register_Prox(convoy_path_1, Prox_Shuttle_Move_End, 150, rebel)
		end
		
		Point_Camera_At(hero)

		-- 9/19/06 JAC - We need this even if we're not doing a cinematic intro
		-- otherwise the Master Volume will be stuck at 0
		Start_Cinematic_Camera()
		End_Cinematic_Camera()
		Letter_Box_Out(0)
		
		--current_cinematic_thread = Create_Thread("Intro_Cinematic", hero)
		Fade_Screen_In(1)
		Lock_Controls(0)
		
		Story_Event("ADD_OBJECTIVE_00")
		Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_06")
		
	end
end

function Story_Mode_Service()
	if mission_started then		
		if not TestValid(hero) or not TestValid(interdictor) then
			Story_Event("FAIL_OBJECTIVE_00")
						
			if rebel_defender then
				Story_Event("VICTORY_REBEL")
			end			
			if empire_defender then
				Story_Event("VICTORY_EMPIRE")
			end
		end
	end
	
	if interdictor_at_dest then
		if TestValid(interdictor) and interdictor.Is_Ability_Active("INTERDICT") and not interdict_message then
			interdict_message = true
			Story_Event("COMPLETE_OBJECTIVE_01")
			Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_07")
		end
	end
	
	if convoy0_spawned and not TestValid(convoy0_shuttle0) and not TestValid(convoy0_shuttle1) and not obj_02_complete then
		obj_02_complete = true
		Story_Event("COMPLETE_OBJECTIVE_02")
		Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_09")
	end
	
	if convoy0_spawned then
		if TestValid(convoy0_shuttle0) then
			convoy0_shuttle0_reveal.Undo_Reveal()
			convoy0_shuttle0_reveal = FogOfWar.Reveal(underworld, convoy0_shuttle0, 250, 250)
		end
		if TestValid(convoy0_shuttle1) then
			convoy0_shuttle1_reveal.Undo_Reveal()
			convoy0_shuttle1_reveal = FogOfWar.Reveal(underworld, convoy0_shuttle1, 250, 250)
		end
	end
	
	if convoy1_spawned and not TestValid(convoy1_shuttle0) and not TestValid(convoy1_shuttle1) and not obj_03_complete then
		obj_03_complete = true
		Story_Event("COMPLETE_OBJECTIVE_03")
		
		Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_11")
	end
	
	if convoy1_spawned then
		if TestValid(convoy1_shuttle0) then
			convoy1_shuttle0_reveal.Undo_Reveal()
			convoy1_shuttle0_reveal = FogOfWar.Reveal(underworld, convoy1_shuttle0, 250, 250)
		end
		if TestValid(convoy1_shuttle1) then
			convoy1_shuttle1_reveal.Undo_Reveal()
			convoy1_shuttle1_reveal = FogOfWar.Reveal(underworld, convoy1_shuttle1, 250, 250)
		end
	end
end

function State_Bespin_Piracy_Mission_Speech_Line_06_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ADD_OBJECTIVE_01")
		
		interdictor_dest.Highlight(true)
		Add_Radar_Blip(interdictor_dest, "interdictor_dest_blip")
	end
end

function State_Bespin_Piracy_Mission_Speech_Line_07_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ADD_OBJECTIVE_02")
		Sleep(3)
		Create_Thread("Warp_In_Convoy_0")
	end
end

function State_Bespin_Piracy_Mission_Speech_Line_09_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ADD_OBJECTIVE_03")
		
		Sleep(3)
		Create_Thread("Warp_In_Convoy_1")
	end
end

function Warp_In_Convoy_0()
	
	if empire_defender then
		convoy0_shuttle0_list = Spawn_Unit(Find_Object_Type("IMPERIAL_LANDING_CRAFT"), convoy0_spawn0, empire)
		convoy0_shuttle1_list = Spawn_Unit(Find_Object_Type("IMPERIAL_LANDING_CRAFT"), convoy0_spawn1, empire)
		convoy0_shuttle0_list[1].Teleport_And_Face(convoy0_spawn0)
		convoy0_shuttle1_list[1].Teleport_And_Face(convoy0_spawn1)
	end
	if rebel_defender then
		convoy0_shuttle0_list = Spawn_Unit(Find_Object_Type("MERCHANT_FREIGHTER"), convoy1_spawn0, rebel)
		convoy0_shuttle1_list = Spawn_Unit(Find_Object_Type("MERCHANT_FREIGHTER"), convoy1_spawn1, rebel)
		convoy0_shuttle0_list[1].Teleport_And_Face(convoy1_spawn0)
		convoy0_shuttle1_list[1].Teleport_And_Face(convoy1_spawn1)
	end
	
	convoy0_shuttle0 = convoy0_shuttle0_list[1]
	convoy0_shuttle1 = convoy0_shuttle1_list[1]
		
	convoy0_shuttle0.Prevent_AI_Usage(true)
	convoy0_shuttle1.Prevent_AI_Usage(true)
	
	convoy0_shuttle0.Cinematic_Hyperspace_In(90)
	convoy0_shuttle1.Cinematic_Hyperspace_In(120)
		
	Sleep(2.5)
	--	function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)
	if empire_defender then
		ReinforceList(emp_convoy0spawn0_list, convoy0_spawn0a, empire, false, true, true, Callback_Guard_Shuttle_0)	
	end
	if rebel_defender then
		ReinforceList(reb_convoy0spawn0_list, convoy1_spawn0a, rebel, false, true, true, Callback_Guard_Shuttle_0)	
	end
	Sleep(1)
	if empire_defender then
		ReinforceList(emp_convoy0spawn1_list, convoy0_spawn1a, empire, false, true, true, Callback_Guard_Shuttle_1)
	end
	if rebel_defender then
		ReinforceList(reb_convoy0spawn1_list, convoy1_spawn1a, rebel, false, true, true, Callback_Guard_Shuttle_1)
	end
	
	Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_08")
	Sleep(6)
	if TestValid(convoy0_shuttle0) then
		convoy0_shuttle0.Override_Max_Speed(1.5)
		convoy0_shuttle0.Move_To(convoy_path_0)
	end
	if TestValid(convoy0_shuttle1) then
		convoy0_shuttle1.Override_Max_Speed(1.5)
		convoy0_shuttle1.Move_To(convoy_path_0)
	end
	if TestValid(convoy0_shuttle0) then
		convoy0_shuttle0_reveal = FogOfWar.Reveal(underworld, convoy0_shuttle0, 250, 250)
		convoy0_shuttle0.Highlight(true)
	end
	if TestValid(convoy0_shuttle1) then
		convoy0_shuttle1_reveal = FogOfWar.Reveal(underworld, convoy0_shuttle1, 250, 250)
		convoy0_shuttle1.Highlight(true)
	end
	
	convoy0_spawned = true
end

function Warp_In_Convoy_1()
	
	if empire_defender then
		convoy1_shuttle0_list = Spawn_Unit(Find_Object_Type("IMPERIAL_LANDING_CRAFT"), convoy1_spawn0, empire)
		convoy1_shuttle1_list = Spawn_Unit(Find_Object_Type("IMPERIAL_LANDING_CRAFT"), convoy1_spawn1, empire)
		convoy1_shuttle0_list[1].Teleport_And_Face(convoy1_spawn0)
		convoy1_shuttle1_list[1].Teleport_And_Face(convoy1_spawn1)
	end
	if rebel_defender then
		convoy1_shuttle0_list = Spawn_Unit(Find_Object_Type("MERCHANT_FREIGHTER"), convoy0_spawn0, rebel)
		convoy1_shuttle1_list = Spawn_Unit(Find_Object_Type("MERCHANT_FREIGHTER"), convoy0_spawn1, rebel)
		convoy1_shuttle0_list[1].Teleport_And_Face(convoy0_spawn0)
		convoy1_shuttle1_list[1].Teleport_And_Face(convoy0_spawn1)
	end
	
	convoy1_shuttle0 = convoy1_shuttle0_list[1]
	convoy1_shuttle1 = convoy1_shuttle1_list[1]
	
	convoy1_shuttle0.Prevent_AI_Usage(true)
	convoy1_shuttle1.Prevent_AI_Usage(true)
	
	convoy1_shuttle0.Cinematic_Hyperspace_In(90)
	convoy1_shuttle1.Cinematic_Hyperspace_In(120)
		
	Sleep(2.5)
	--	function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)
	if empire_defender then
		ReinforceList(emp_convoy1spawn0_list, convoy1_spawn0a, empire, false, true, true, Callback_Guard_Shuttle_2)
	end
	if rebel_defender then
		ReinforceList(reb_convoy1spawn0_list, convoy0_spawn0a, rebel, false, true, true, Callback_Guard_Shuttle_2)
	end
	
	Sleep(1)
	if empire_defender then
		ReinforceList(emp_convoy1spawn1_list, convoy1_spawn1a, empire, false, true, true, Callback_Guard_Shuttle_3)
	end
	if rebel_defender then
		ReinforceList(reb_convoy1spawn1_list, convoy0_spawn1a, rebel, false, true, true, Callback_Guard_Shuttle_3)
	end
	
	Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_10")
	Sleep(6)
	
	if TestValid(convoy1_shuttle0) then
		convoy1_shuttle0.Override_Max_Speed(1.5)		
		convoy1_shuttle0.Move_To(convoy_path_0)
	end
	if TestValid(convoy1_shuttle1) then
		convoy1_shuttle1.Override_Max_Speed(1.5)
		convoy1_shuttle1.Move_To(convoy_path_0)
	end
	
	if TestValid(convoy1_shuttle0) then
		convoy1_shuttle0_reveal = FogOfWar.Reveal(underworld, convoy1_shuttle0, 250, 250)
		convoy1_shuttle0.Highlight(true)
	end
	if TestValid(convoy1_shuttle1) then
		convoy1_shuttle1_reveal = FogOfWar.Reveal(underworld, convoy1_shuttle1, 250, 250)
		convoy1_shuttle1.Highlight(true)
	end
	
	convoy1_spawned = true
end

function Callback_Guard_Shuttle_0(new_list)
	for k, unit in pairs(new_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Override_Max_Speed(1.5)
			unit.Attack_Move(convoy_path_0)
		end
	end
end

function Callback_Guard_Shuttle_1(new_list)
	for k, unit in pairs(new_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Override_Max_Speed(1.5)
			unit.Attack_Move(convoy_path_0)
		end
	end
end

function Callback_Guard_Shuttle_2(new_list)
	for k, unit in pairs(new_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Override_Max_Speed(1.5)
			unit.Attack_Move(convoy_path_0)
		end
	end
end

function Callback_Guard_Shuttle_3(new_list)
	for k, unit in pairs(new_list) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Override_Max_Speed(1.5)
			unit.Attack_Move(convoy_path_0)
		end
	end
end

function Prox_Interdictor(self_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "INTERDICTOR_CRUISER" and not interdictor_at_dest then
		interdictor_at_dest = true
		
		interdictor_dest.Highlight(false)
		Remove_Radar_Blip("interdictor_dest_blip")
	end
end

function Prox_Shuttle_Move(self_obj, trigger_obj)
	if not path_0_shuttles_moved[trigger_obj] then
		if trigger_obj.Get_Type().Get_Name() == "IMPERIAL_LANDING_CRAFT" then
			trigger_obj.Move_To(convoy_path_1)
			path_0_shuttles_moved[trigger_obj] = true
		end
		if trigger_obj.Get_Type().Get_Name() ~= "IMPERIAL_LANDING_CRAFT" and not trigger_obj.Is_Category("Fighter") then
			trigger_obj.Attack_Move(convoy_path_1)
			path_0_shuttles_moved[trigger_obj] = true
		end
		
	end
end

function Prox_Shuttle_Move_End(self_obj, trigger_obj)
	if not path_1_shuttles_moved[trigger_obj] then
		if trigger_obj.Get_Type().Get_Name() == "IMPERIAL_LANDING_CRAFT" then
			trigger_obj.Hyperspace_Away()
			path_1_shuttles_moved[trigger_obj] = true
			
			if convoy0_spawned and not convoy1_spawned then
				Story_Event("FAIL_OBJECTIVE_02")
			end
			
			if convoy1_spawned then
				Story_Event("FAIL_OBJECTIVE_03")
			end
						
			if rebel_defender then
				Story_Event("VICTORY_REBEL")
			end			
			if empire_defender then
				Story_Event("VICTORY_EMPIRE")
			end
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
	
	camera_distance = 1000
	camera_rotation = 0
	
	Transition_Cinematic_Camera_Key(focus_unit, 0, camera_distance, 25, (camera_rotation - 90), 1, 1, 1, 0)
	Transition_Cinematic_Target_Key(focus_unit, 0, 0, 0, 7, 0, focus_unit, 0, 0)
	
	Transition_Cinematic_Camera_Key(focus_unit, 5, camera_distance, 25, camera_rotation, 1, 1, 1, 0)
	
	Sleep(4.5)
	
	while true do
		camera_rotation = camera_rotation + 90
		Transition_Cinematic_Camera_Key(focus_unit, 5, camera_distance, 25, camera_rotation, 1, 1, 1, 0)
		
		if camera_rotation == 180 then
			Story_Handle_Esc()
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
	Story_Event("TEXT_SPEECH_BESPIN_PIR_TACTICAL_COR06_06")
end