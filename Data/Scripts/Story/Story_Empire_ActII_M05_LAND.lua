-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M05_LAND.lua#52 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M05_LAND.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 36397 $
--
--          $DateTime: 2006/01/13 16:54:32 $
--
--          $Revision: #52 $
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
		Empire_A02M05_Cinematic_Start = State_A02M05_Cinematic_Start,
		Empire_A02M05_Cinematic_End = State_Empire_A02M05_Cinematic_End,
		Empire_A02M05_Begin = State_Empire_A02M05_Begin,
		Empire_A02M05_All_Rebel_Destroyed_WIN = State_Empire_A02M05_All_Rebel_Destroyed_WIN,
		Empire_A02M05_Actual_Win = State_Empire_A02M05_Actual_Win
	}

	reinforcement_list1 = {
		"Rebel_Infantry_Squad"
		,"Rebel_Tank_Buster_Squad"
		,"Rebel_Light_Tank_Brigade"
	}

	unarmed_wookie_type_list = {
		"Kashyyyk_Wookie_War_Party_Unarmed"
		,"Kashyyyk_Wookie_War_Party_Unarmed"
	}

	armed_wookie_type_list = {
		"Kashyyyk_Wookie_War_Party"
	}
	
	unarmed_wookie_prisoner_type_list = {
		"EM6_Captured_Wookies_Party"
	}

		
	num_reinforcements = 0
	allowed_reinforcements = 10
	reinforcement_delay = 90
	wookie_armed_range = 100
	enemy_range = 600
	time_required_to_jailbreak = 30
	distance_required_to_jailbreak = 200

	prisonprox1 = nil
	prisonprox3 = nil
	prisonprox4 = nil
	prisonprox5 = nil
	prisonprox6 = nil

	initial_units_spawned = false
	han_run_away_active = false
	han_run_away_done = false

	-- For memory pool cleanup hints
	
	rebel_player = nil
	unit = nil
end

function State_Empire_A02M05_Begin(message)
	if message == OnEnter then
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		Suspend_AI(1)
		Lock_Controls(1)

		-- Cinematic Hint Marker Definitions
		
		hanrunaway = Find_Hint("GENERIC_MARKER_LAND", "hanrunaway")
		runawaycamerastart = Find_Hint("GENERIC_MARKER_LAND", "runawaycamerastart")
		hanrunawaystart = Find_Hint("GENERIC_MARKER_LAND", "hanrunawaystart")
		intro_han_start = Find_Hint("GENERIC_MARKER_LAND", "intro-han-start")
		intro_han_destination = Find_Hint("GENERIC_MARKER_LAND", "intro-han-destination")
		intro_camera_position_01 = Find_Hint("GENERIC_MARKER_LAND", "intro-camera-position-01")
		intro_camera_position_02 = Find_Hint("GENERIC_MARKER_LAND", "intro-camera-position-02")
		intro_camera_position_03 = Find_Hint("GENERIC_MARKER_LAND", "intro-camera-position-03")
		intro_wookie_spawn = Find_Hint("GENERIC_MARKER_LAND", "intro-wookie-spawn")
		intro_wookie_destination = Find_Hint("GENERIC_MARKER_LAND", "intro-wookie-destination")
		

		outro_officer_position = Find_Hint("GENERIC_MARKER_LAND", "outro-officer-position")
		outro_stormtrooper_position = Find_Hint("GENERIC_MARKER_LAND", "outro-stormtrooper-position")
		outro_camera_position_start = Find_Hint("GENERIC_MARKER_LAND", "outro-camera-position-start")
		outro_camera_position_end = Find_Hint("GENERIC_MARKER_LAND", "outro-camera-position-end")
		outro_stormtrooper_move_to_position = Find_Hint("GENERIC_MARKER_LAND", "outro-stormtrooper-move-to-position")
		outro_guard_01_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-01-start")
		outro_guard_02_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-02-start")
		outro_guard_03_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-03-start")
		outro_guard_04_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-04-start")
		outro_guard_05_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-05-start")
		outro_guard_06_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-06-start")
		outro_guard_07_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-07-start")
		outro_guard_08_start = Find_Hint("GENERIC_MARKER_LAND", "outro-guard-08-start")
		outro_wookie_prisoners_01_start = Find_Hint("GENERIC_MARKER_LAND", "outro-wookie-prisoners-01-start")
		outro_wookie_prisoners_02_start = Find_Hint("GENERIC_MARKER_LAND", "outro-wookie-prisoners-02-start")
		outro_wookie_prisoners_03_start = Find_Hint("GENERIC_MARKER_LAND", "outro-wookie-prisoners-03-start")
		outro_wookie_prisoners_04_start = Find_Hint("GENERIC_MARKER_LAND", "outro-wookie-prisoners-04-start")
		outro_wookie_prisoners_05_start = Find_Hint("GENERIC_MARKER_LAND", "outro-wookie-prisoners-05-start")
		outro_march_final_position = Find_Hint("GENERIC_MARKER_LAND", "outro-march-final-position")

		
		outro_officer = Find_Object_Type("Generic_Field_Commander_Empire")
		outro_stormtrooper = Find_Object_Type("Stormtrooper")
		ref_type = Find_Object_Type("Han_Solo")
		
		-- Regular Mission Definitions
		
		han_spawn = Find_Hint("GENERIC_MARKER_LAND", "spawn-han")
		tree1 = Find_Hint("PATROL_MARKER", "tree1")
		tree2 = Find_Hint("PATROL_MARKER", "tree2")
		tree3 = Find_Hint("PATROL_MARKER", "tree3")
		prison1 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "1")
		prison2 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "2")
		prison3 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "3")
		prison4 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "4")
		prison5 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "5")
		prison6 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "6")
		
		bomb_1 = Find_Hint("PROJ_SPEEDER_BOMB", "bomb1")
		
		MOV_Prison = Find_Hint("EM6_Prison_Wookies", "destroyedprison")

		if not MOV_Prison then
			--MessageBox("Can't find destroyed prison marker.")
		end 

			
		player_start = Find_Hint("ATTACKER ENTRY POSITION", "player-start")
		if not player_start or not han_spawn or not tree1 or not tree2 or not tree3 or not prison1 or not prison2 or not prison3 or not prison4 or not prison5 or not prison6 then
			--MessageBox("Expected objects not found - aborting")
			return
		else
			rebel_player = Find_Player("Rebel")
			empire_player = Find_Player("Empire")
		end
	end
end

function State_A02M05_Cinematic_Start(message)
	if message == OnEnter then
	
		new_units = Spawn_Unit(ref_type, intro_han_start, rebel_player)		
		han = new_units[1]
		han.Mark_Parent_Mode_Object_For_Death()		
		han.Prevent_AI_Usage(true)
		han.Set_Cannot_Be_Killed(true)
		-- han.Move_To(intro_han_destination)
		Point_Camera_At(player_start)
		Letter_Box_In(0)
		han.Play_Animation("Cinematic", false,1)
		bomb_1.Hide(true)
		Fade_Screen_In(1)
		
		Start_Cinematic_Camera()
		Resume_Mode_Based_Music()
		
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Target_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		
		Set_Cinematic_Camera_Key(intro_camera_position_01, 0, 50, 100, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(intro_han_start, 0, 0, 20, 0, 0, 0, 0)
				
		Cinematic_Zoom(8,0.95)
		Sleep (4)
		bomb_1.Hide(false)
		Sleep (3.8)
		han.Move_To(intro_han_destination)		
		
		Transition_Cinematic_Camera_Key(intro_camera_position_01, 5, 0, 35, 60, 0, 0, 0, 0)
		
		Sleep (3)
		
		Set_Cinematic_Camera_Key(bomb_1, 100, 40, 280, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(bomb_1, 0, 0, 0, 0, 0, 0, 0)
		
		Sleep (.5)
		Cinematic_Zoom(1,0.4)		
		
		Sleep (1)
		
		Set_Cinematic_Camera_Key(intro_camera_position_01, 0, 35, 12, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(intro_han_start, 0, 0, 20, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(intro_camera_position_01, 3, 0, 13, 10, 0, 0, 0, 0)
		
		Sleep (1)
		
		explosion = Create_Generic_Object("LARGE_EXPLOSION_LAND", bomb_1.Get_Position(), Find_Player("Neutral"))
		bomb_1.Despawn()
				
		Sleep (0.1)
		prison2.Take_Damage(10000)
		
		
		Sleep (2)
		
		han.Teleport(han_spawn)



		-- Closeup to cinematic Prison ( Elie )

		MOV_Prison.Play_Animation("Cinematic", false)
		Sleep (.2)

		Set_Cinematic_Camera_Key(MOV_Prison,  250, 8, 165, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(MOV_Prison, 0, 0, 15, 0, 0, 0, 0)

		Cinematic_Zoom(7.4,0.8)

		Sleep(7.0)
		Fade_Screen_Out(.5)	
		-- Closeup to cinematic Prison End

		
		wookie_list = SpawnList(unarmed_wookie_type_list, intro_wookie_spawn, rebel_player, false, true)
		for k, unit in pairs(wookie_list) do
			unit.Move_To(intro_wookie_destination)
		end

		Sleep(.5)
		Fade_Screen_In(1)
		Set_Cinematic_Camera_Key(intro_han_start, 225, 15, 350, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(intro_han_start, -50, -50, 0, 0, 0, 0, 0)


		MOV_Prison.Despawn()

		Sleep(3)
		
		Zoom_Camera(1.0, 1)
		Transition_To_Tactical_Camera(5)

		Sleep(5)

		for k, unit in pairs(wookie_list) do
			unit.Despawn()
		end		
						
		
		End_Cinematic_Camera()
		Letter_Box_Out(.5)
		Lock_Controls(0)
		Suspend_AI(0)
		
		Story_Event("A02M05_INTRO_CINEMATIC_DONE")
	end
end

function State_Empire_A02M05_Cinematic_End(message)
	if message == OnEnter then
		-- Set up proximities for the wookie-arming trees
		
		Register_Prox(tree1, Tree_Prox, wookie_armed_range, rebel_player)
		Register_Prox(tree2, Tree_Prox, wookie_armed_range, rebel_player)
		Register_Prox(tree3, Tree_Prox, wookie_armed_range, rebel_player)
		
		-- Set up proximities for the imperial prisons to detect empire player
		
		Register_Prox(prison1, Prison_Prox1, enemy_range, empire_player)
		Register_Prox(prison3, Prison_Prox3, enemy_range, empire_player)
		Register_Prox(prison4, Prison_Prox4, enemy_range, empire_player)
		Register_Prox(prison5, Prison_Prox5, enemy_range, empire_player)
		Register_Prox(prison6, Prison_Prox6, enemy_range, empire_player)
		
		-- Set up a recurring timer for Rebel reinforcements to land
		
		Register_Timer(Timer_Land_Reinforcements, reinforcement_delay)

		initial_units_spawned = true
		
		Attempt_Prison_Break()
	
	end
end

function Prison_Prox1()
	prisonprox1 = 1
end

function Prison_Prox3()
	prisonprox3 = 1
end

function Prison_Prox4()
	prisonprox4 = 1
end

function Prison_Prox5()
	prisonprox5 = 1
end

function Prison_Prox6()
	prisonprox6 = 1
end

function Release_List_To_AI(list)
	for j, unit in pairs(list) do
		unit.Prevent_AI_Usage(false)
	end
end

function Attempt_Prison_Break()

	-- Move Han to appropriate locations away from Imperial interference if possible.
	
	if TestValid(han) then
		if not prisonprox1 and TestValid(prison1) then
			BlockOnCommand(han.Move_To(prison1))
		else
				if not prisonprox3 and TestValid(prison3) then
					BlockOnCommand(han.Move_To(prison3))
				else
					if not prisonprox4 and TestValid(prison4) then
						BlockOnCommand(han.Move_To(prison4))
					else
						if not prisonprox5 and TestValid(prison5)then
							BlockOnCommand(han.Move_To(prison5))
						else
							if not prisonprox6 and TestValid(prison6)then
								BlockOnCommand(han.Move_To(prison6))
							else
								closest_prison = Find_Nearest(han, "IMPERIAL_PRISON_KASHYYYK")
								if TestValid(closest_prison) then
									BlockOnCommand(han.Move_To(closest_prison))
								else
									han.Prevent_AI_Usage(false)
								end
							end
						end
					end
				end
		end

		-- Blow up the prison and spawn wookies
		
		Sleep(time_required_to_jailbreak)
		
		if TestValid(han) then
			closest_prison = Find_Nearest(han, "IMPERIAL_PRISON_KASHYYYK")
			if TestValid(closest_prison) then
				prison_distance = closest_prison.Get_Distance(han)
				if prison_distance < distance_required_to_jailbreak then
				wookie_list = SpawnList(unarmed_wookie_type_list, han.Get_Position(), rebel_player, false, true)
				closest_treehouse = Find_Nearest(closest_prison, "WOOKIEE_HOUSE")
				closest_prison.Take_Damage(10000)
				closest_prison = nil
				
					if (closest_treehouse) then

						-- Run the Wookies to the treehouse.
					
						for k, unit in pairs(wookie_list) do
							unit.Move_To(closest_treehouse)
						end
					else
	
						-- No Wookie trees remain, allow the AI to use the Wookies.
						
						Release_List_To_AI(wookie_list)
					end
				end
			else
				han.Prevent_AI_Usage(false)
			end
		else
			return
		end
		
		-- On to the next prison
		
		Attempt_Prison_Break()
	end
end

function Timer_Land_Reinforcements()
	num_reinforcements = num_reinforcements + 1
	ReinforceList(reinforcement_list1, han_spawn, rebel_player, true, true)
	if num_reinforcements <= allowed_reinforcements then
		Register_Timer(Timer_Land_Reinforcements, reinforcement_delay)
	end
end

function Tree_Prox(prox_obj, trigger_obj)
	if TestValid(trigger_obj) and trigger_obj.Get_Type() == Find_Object_Type("Wookie_Warrior_Unarmed") then
		wookie_team = trigger_obj.Get_Parent_Object()
		if TestValid(wookie_team) then
		
			-- We caught an unarmed wookie.  Replace him with an armed wookie and give him to the AI.
			
			armed_wookie = SpawnList(armed_wookie_type_list, wookie_team, rebel_player, true, true)
			wookie_team.Despawn()
		else
			--MessageBox("invalid parent object")
		end
	end
end

function State_Empire_A02M05_All_Rebel_Destroyed_WIN(message)
	if message == OnEnter then
	
		repeat
			Sleep(1)
		until han_run_away_done
		
		Cancel_Fast_Forward() 
		Suspend_AI(1)
		Lock_Controls(1)
		Fade_Screen_Out(1)
		Letter_Box_In(0)
		
		Do_End_Cinematic_Cleanup()
				
		-- Spawn all the required cinematic units in the appropriate location and begin their motion

		new_units = Spawn_Unit(outro_officer, outro_officer_position, empire_player)
		outro_officer_id = new_units[1]
		outro_officer_id.Mark_Parent_Mode_Object_For_Death()		
		outro_officer_id.Prevent_AI_Usage(true)
		outro_officer_id.Turn_To_Face(outro_stormtrooper_move_to_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_stormtrooper_position, empire_player)
		outro_stormtrooper_id00 = new_units[1]
		outro_stormtrooper_id00.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id00.Prevent_AI_Usage(true)
		outro_stormtrooper_id00.Move_To(outro_stormtrooper_move_to_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_01_start, empire_player)
		outro_stormtrooper_id01 = new_units[1]
		outro_stormtrooper_id01.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id01.Prevent_AI_Usage(true)
		outro_stormtrooper_id01.Move_To(outro_march_final_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_02_start, empire_player)
		outro_stormtrooper_id02 = new_units[1]
		outro_stormtrooper_id02.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id02.Prevent_AI_Usage(true)
		outro_stormtrooper_id02.Move_To(outro_march_final_position)

		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_03_start, empire_player)
		outro_stormtrooper_id03 = new_units[1]
		outro_stormtrooper_id03.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id03.Prevent_AI_Usage(true)
		outro_stormtrooper_id03.Move_To(outro_march_final_position)

		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_04_start, empire_player)
		outro_stormtrooper_id04 = new_units[1]
		outro_stormtrooper_id04.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id04.Prevent_AI_Usage(true)
		outro_stormtrooper_id04.Move_To(outro_march_final_position)

		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_05_start, empire_player)
		outro_stormtrooper_id05 = new_units[1]
		outro_stormtrooper_id05.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id05.Prevent_AI_Usage(true)
		outro_stormtrooper_id05.Move_To(outro_march_final_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_06_start, empire_player)
		outro_stormtrooper_id06 = new_units[1]
		outro_stormtrooper_id06.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id06.Prevent_AI_Usage(true)
		outro_stormtrooper_id06.Move_To(outro_march_final_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_07_start, empire_player)
		outro_stormtrooper_id07 = new_units[1]
		outro_stormtrooper_id07.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id07.Prevent_AI_Usage(true)
		outro_stormtrooper_id07.Move_To(outro_march_final_position)
		
		new_units = Spawn_Unit(outro_stormtrooper, outro_guard_08_start, empire_player)
		outro_stormtrooper_id08 = new_units[1]
		outro_stormtrooper_id08.Mark_Parent_Mode_Object_For_Death()		
		outro_stormtrooper_id08.Prevent_AI_Usage(true)
		outro_stormtrooper_id08.Move_To(outro_march_final_position)
		
		wookie_prisoners_01 = SpawnList(unarmed_wookie_prisoner_type_list, outro_wookie_prisoners_01_start, empire_player, true, true)
		wookie_prisoners_02 = SpawnList(unarmed_wookie_prisoner_type_list, outro_wookie_prisoners_02_start, empire_player, true, true)
		wookie_prisoners_03 = SpawnList(unarmed_wookie_prisoner_type_list, outro_wookie_prisoners_03_start, empire_player, true, true)
		wookie_prisoners_04 = SpawnList(unarmed_wookie_prisoner_type_list, outro_wookie_prisoners_04_start, empire_player, true, true)
		wookie_prisoners_05 = SpawnList(unarmed_wookie_prisoner_type_list, outro_wookie_prisoners_05_start, empire_player, true, true)

		for i,unit in pairs(wookie_prisoners_01) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Move_To(outro_march_final_position)
			end
		end

		for i,unit in pairs(wookie_prisoners_02) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Move_To(outro_march_final_position)
			end
		end

		for i,unit in pairs(wookie_prisoners_03) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Move_To(outro_march_final_position)
			end
		end

		for i,unit in pairs(wookie_prisoners_04) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Move_To(outro_march_final_position)
			end
		end

		for i,unit in pairs(wookie_prisoners_05) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(true)
				unit.Move_To(outro_march_final_position)
			end
		end

		Sleep(0.3)
		Fade_Screen_In(1)
		Point_Camera_At(outro_officer_position)
		Start_Cinematic_Camera()
		
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Target_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		
		Set_Cinematic_Camera_Key(outro_camera_position_start, 0, 25, 14, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(outro_stormtrooper_id00, 0, 0, 0, 1, outro_stormtrooper_id00, 0, 0)

		Sleep(4)

		Story_Event("A02M05_TRIGGER_OUTRO_DIALOG")

		Sleep(1)

		Set_Cinematic_Camera_Key(outro_camera_position_end, 0, 45, 50, 0, 0, 0, 0)
	end
end


function State_Empire_A02M05_Actual_Win(message)
	if message == OnEnter then

		Fade_Screen_Out(2)
		Sleep(2)
		End_Cinematic_Camera()
		Letter_Box_Out(0)
		Lock_Controls(0)
		Suspend_AI(0)
	end
end

function Story_Mode_Service()
	if initial_units_spawned then
		if not han_run_away_active then
			if TestValid(han) then
				if han.Get_Hull() < 0.1 then
					han_run_away_active = true
					han.Make_Invulnerable(true)
					Create_Thread("Han_Run_Away")
				end
			end
		end
	end
end

function Han_Run_Away()
	if TestValid(han) then
		Cancel_Fast_Forward() 
		Fade_Screen_Out(1)
		Letter_Box_In(0)
		Suspend_AI(1)
		Lock_Controls(1)
		han.Teleport(hanrunawaystart)
		
		Story_Event("CUE_HAN_SOLO_ESCAPE_DIALOG")

		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Target_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)

		Point_Camera_At(hanrunaway)
		Start_Cinematic_Camera()
		Set_Cinematic_Camera_Key(runawaycamerastart, 100, -200, 200, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(hanrunaway, 0, 0, 0, 0, 0, 0, 0)
		
		han.Move_To(hanrunaway)
		Fade_Screen_In(2)
		
		Transition_Cinematic_Camera_Key(runawaycamerastart, 5, 100, 0, 80, 0, 0, 0, 0)

		Sleep(3)
		Fade_Screen_Out(2)
		
		Sleep(3)
		
		closest_unit = Find_Nearest(hanrunaway, empire_player, true)
		Point_Camera_At(closest_unit)
		han.Despawn()
		Letter_Box_Out(0)
		Fade_Screen_In(2)
		Transition_To_Tactical_Camera(1)
		End_Cinematic_Camera()
		Suspend_AI(0)
		Lock_Controls(0)
		han_run_away_done = true
	end
end