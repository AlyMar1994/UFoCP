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
--              $File: 
--
--            $Author: Joseph_Gernert $
--
--            $Change: 
--
--          $DateTime: 
--
--          $Revision: 
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
		Rebel_Act1_M02_Begin = State_Rebel_A01M02_Begin
		,Rebel_ActI_M02_OK_To_Hack = State_Rebel_A01M02_OK_To_Hack
		,Rebel_ActI_M02_Stormtrooper_Speech_00 = State_Rebel_ActI_M02_Clear_Base
		--,Rebel_ActI_M02_Entry_Speech_03a = State_Intro_Dialogue_Done
		,Rebel_ActI_M02_Entry_Speech_000b = State_ActI_M02_Entry_Speech_000b
		,Rebel_ActI_M02_Entry_Speech_00_Remove_Text = State_Rebel_ActI_M02_Entry_Speech_00_Remove_Text
		,Rebel_ActI_M02_Entry_Speech_01_Remove_Text = State_Rebel_ActI_M02_Entry_Speech_01_Remove_Text
		,Rebel_ActI_M02_Entry_Speech_03a = State_Rebel_ActI_M02_Entry_Speech_03a
		,Rebel_Act1_M02_R2_Victory = State_Play_R2_VictoryAnim
		
	}
	
	reinforcement_list1 = {
		"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Heavy_Scout_Squad"
	}

	reinforcement_list2 = {
		"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Heavy_Scout_Squad"
		--,"Imperial_Heavy_Scout_Squad"
	}

	reinforcement_list3 = {
		"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Medium_Stormtrooper_Squad"
		--,"Imperial_Heavy_Scout_Squad"
		--,"Imperial_Heavy_Scout_Squad"
		,"Imperial_Anti_Infantry_Brigade_Small"
	}

	marker_function_list = {
		lz1_setup
		,lz2_setup
		,lz3_setup
	}

	droid_hunter_list1 = {
		"Imperial_Light_Scout_Squad"
	}

	droid_hunter_list2 = {
		"Imperial_Light_Scout_Squad"
		,"Imperial_Light_Scout_Squad"
	}

	droid_hunter_list3 = {
		"Imperial_Light_Scout_Squad"
		,"Imperial_Light_Scout_Squad"
		,"Imperial_Anti_Infantry_Brigade_Small"
	}

	num_reinforcements = 0
	allowed_reinforcements = 3
	reinforcement_delay = 30
	initial_reinforcement_delay = 10
	r2_uplink_range = 80
	r2_enemy_range = 30
	r2_hack_time = 180
	r2_hack_done = false
	r2_reinforcement_range = 180

	turret_reveal_range = 200

	camera_reset_time = 8

	reinforcement_waves = 3
	
	r_marker_loc = 0
	end_triggered = false
	flag_playing_lightning_sound = false
	trooper_group1 = nil
	trooper_group2 = nil

	-- For memory pool cleanup hints
	rebel_player = nil
	unit = nil
	r2d2_team = nil
	r2d2 = nil
	fog_id = nil
	fog_id2 = nil
	fog_id3 = nil
	fog_id4 = nil
	
end

-- ##########################################################################################
--	Set up the mission
-- ##########################################################################################

function State_Rebel_A01M02_Begin(message)
	if message == OnEnter then
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)

		--Fade_Screen_Out(0)
		--Suspend_AI(1)
		--Lock_Controls(1)
		--Letter_Box_In(0)

		r_marker_list = Find_All_Objects_Of_Type("REINFORCEMENT_POINT_PLUS10_CAP")
		r_marker_list[0] = Find_Hint("REINFORCEMENT_POINT_PLUS10_CAP", "area0")
		r_marker_list[1] = Find_Hint("REINFORCEMENT_POINT_PLUS10_CAP", "area1")
		r_marker_list[2] = Find_Hint("REINFORCEMENT_POINT_PLUS10_CAP", "area2")
		
		-- Find the uplink where R2 needs to go
		r2_uplink = Find_Hint("GENERIC_MARKER_LAND", "UPLINK")		-- Marker in front of uplink that r2 moves to
		uplink = Find_First_Object("Droid_Interface_Station")		-- Actual uplink

		-- Find the spawn points													 
		empire_spawn_0 = Find_Hint("GENERIC_MARKER_LAND", "REINFORCE_0")
		empire_spawn_1 = Find_Hint("GENERIC_MARKER_LAND", "REINFORCE_1")
		empire_spawn_2 = Find_Hint("GENERIC_MARKER_LAND", "REINFORCE_2")

		rebel_transport_pos = Find_Hint("GENERIC_MARKER_LAND", "introshuttle")

		attk_flag_0 = Find_Hint("GENERIC_MARKER_LAND", "attack0")
		attk_flag_1 = Find_Hint("GENERIC_MARKER_LAND", "attack1")
		attk_flag_2 = Find_Hint("GENERIC_MARKER_LAND", "attack2")
		st_guardpos_01 = Find_Hint("GENERIC_MARKER_LAND", "st-guard-01")
		st_guardpos_02 = Find_Hint("GENERIC_MARKER_LAND", "st-guard-02")
		st_guard_01 = Find_Hint("AT_ST_WALKER", "st01")
		st_guard_02 = Find_Hint("AT_ST_WALKER", "st02")
		hacking_turret = Find_Hint("SKIRMISH_BUILD_PAD", "hackhint")
		droid_move = Find_Hint("GENERIC_MARKER_LAND", "3pomoveto")
		droid_teleport = Find_Hint("GENERIC_MARKER_LAND", "3poteleport")		
		cinematic_droids_prime = Find_First_Object("Tactical_R2_3PO_Team") 		
		cinematic_c3po = Find_First_Object("Droid_C3P0") 
		cinematic_r2d2 = Find_First_Object("Droid_R2D2") 
		
		scout_trooper = Find_Hint("SCOUT_TROOPER", "scouttrooper")
		--scout_trooper.Prevent_AI_Usage(true)
		
		stormtrooper_guard_list = Find_All_Objects_Of_Type("STORMTROOPER")
		for j, unit in pairs(stormtrooper_guard_list) do
			unit.Prevent_AI_Usage(true)
			nearest_unit = Find_Nearest(unit, "AT_ST_WALKER")
			unit.Guard_Target(nearest_unit.Get_Position())
		end

		st_guard_01.Guard_Target(st_guardpos_01.Get_Position())
		st_guard_02.Guard_Target(st_guardpos_02.Get_Position())
		
		-- Make sure we found everything
		if not empire_spawn_0 or not empire_spawn_1 or not empire_spawn_2 or not r2_uplink or not uplink then
			--MessageBox("%s-expected objects not found; aborting", tostring(Script))
			return
		else
			rebel_player = Find_Player("Rebel")
			empire_player = Find_Player("Empire")
			neutral_player = Find_Player("Neutral")
			-- Force create all anti-infantry turrets
		
			e_turret_list = Find_All_Objects_Of_Type("SKIRMISH_BUILD_PAD")
		
			for i,unit in pairs(e_turret_list) do
				unit.Change_Owner(empire_player)
				unit.Build("UC_Empire_Buildable_Anti_Infantry_Turret")
				unit.Lock_Build_Pad_Contents(true)
				unit.Change_Owner(neutral_player)
			end
		end

		-- Lock out controls for intro cinematic and reveal FOW

		-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
		rebel_shuttle = Create_Cinematic_Transport("Gallofree_Transport_Landing", rebel_player.Get_ID(), rebel_transport_pos, 344, 1, 1.0, 14, 0)
		
		if not rebel_shuttle then
			MessageBox("No Shuttle For Joo!")
		end
		
		Create_Thread("Intro_Cinematic")
		
		-- uplink.Highlight(true)

	end
end

function Shuttle_Liftoff()

	-- Sleep(1.5)
	-- BlockOnCommand(rebel_transport.Play_Animation("Takeoff",false))
	-- rebel_transport.Despawn()
	
	

end

-- ##########################################################################################
--	Intro Cinematic functions
-- ##########################################################################################

function Intro_Cinematic()
	Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)	
	Start_Cinematic_Camera()
		
	if TestValid(cinematic_r2d2) then
		cinematic_droids = cinematic_r2d2.Get_Parent_Object()
	end
	cinematic_droids.Teleport_And_Face(droid_teleport)
	cinematic_droids.Face_Immediate(droid_move)	
	Fade_Screen_In(2)
	
	Set_Cinematic_Camera_Key(cinematic_droids, 400, 45, 90, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(cinematic_droids, 0, 0, 0, 0, 0, 0, 0)
	Cinematic_Zoom(10,0.9)
	Story_Event("RM02_REBELTROOPER_LINE01_GO")


end


function State_ActI_M02_Entry_Speech_000b(message)
	if message == OnEnter then
	
		Story_Event("RM02_C3P0_LINE01_GO")
		
		Set_Cinematic_Camera_Key(cinematic_droids, 55, 12, 280, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(cinematic_droids, 0, 0, 14, 0, 0, 0, 0)
		cinematic_c3po.Play_Animation("Idle",false,2)
		Cinematic_Zoom(10,0.9)
	end
end

function State_Rebel_ActI_M02_Entry_Speech_00_Remove_Text(message)
	if message == OnEnter then
		
		Story_Event("RM02_R2D2_LINE01_GO")
		
	end
end

function State_Rebel_ActI_M02_Entry_Speech_01_Remove_Text(message)
	if message == OnEnter then
	
		Story_Event("RM02_ANTILLES_LINE01_GO")
		
		Sleep(.5)
		
		Set_Cinematic_Camera_Key(r2_uplink, 400, 35, 0, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(r2_uplink, 0, 10, 0, 0, 0, 0, 0)
		Sleep(.5)	
		Cinematic_Zoom(2,0.15)		
		Sleep(2)			
		
		if TestValid(cinematic_r2d2) then
			cinematic_droids = cinematic_r2d2.Get_Parent_Object()
		end
		Set_Cinematic_Camera_Key(droid_move, 100, 12, 180, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(droid_teleport, 0, 0, 10, 1, 0, 0, 0)
		
		cinematic_droids.Override_Max_Speed(.4)
		cinematic_droids.Move_To(droid_move)
		Transition_Cinematic_Target_Key(droid_move, 5, 0, 0, 10, 1, 0, 0, 0)
		
		Sleep(5)
					
		-- Create_Thread("Shuttle_Liftoff")
		
	end
end

function State_Rebel_ActI_M02_Entry_Speech_03a(message)
	if message == OnEnter then
	
		Set_Cinematic_Camera_Key(cinematic_droids, 300, 45, 320, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(cinematic_droids, 0, 0, 0, 0, 0, 0, 0)
		
		Sleep(1)
		
		--end of cinematic ... return to gameplay here
		Transition_To_Tactical_Camera(1)
        --Small_Reveal_Area.Undo_Reveal()
		Sleep(1)
		End_Cinematic_Camera()
		cinematic_droids.Override_Max_Speed(false)
		Letter_Box_Out(1)	
		Lock_Controls(0)
		Suspend_AI(0)
		Story_Event("Start_Mission")
		Register_Prox(hacking_turret, Turret_Hack_Message, turret_reveal_range, rebel_player)
		fog_id = FogOfWar.Reveal_All(empire_player) -- TEST for AI aggressiveness
	end
end

function Turret_Hack_Message(prox_obj, trigger_obj)

	prox_obj.Cancel_Event_Object_In_Range(Turret_Hack_Message)
	Turret_Reveal = FogOfWar.Reveal(rebel_player, prox_obj, 100, 100)
        Story_Event("Hack_Turret_Message")
	Register_Timer(Remove_Turret_FOW, 10)

end

function Remove_Turret_FOW()

	Turret_Reveal.Undo_Reveal()

end


-- ##########################################################################################
--	Reveal base, set guards to attack
-- ##########################################################################################

function State_Rebel_ActI_M02_Clear_Base(message)
	if message == OnEnter then
		-- Set up proximities for R2 near the uplink
		Register_Prox(r2_uplink, Uplink_Prox, r2_uplink_range, rebel_player)
		fog_id2 = FogOfWar.Reveal(rebel_player, uplink, 600, 600)

		Create_Thread("Biker_Flees")

		Suspend_AI(0)

		closest_target = Find_Nearest(r2_uplink, rebel_player, true)
		for k, unit in pairs(stormtrooper_guard_list) do
			if TestValid(closest_target) and TestValid(unit) then
				unit.Attack_Move(closest_target)
			end
		end

	end
end

function Biker_Flees()

	if TestValid(scout_trooper) then
		BlockOnCommand(scout_trooper.Move_To(empire_spawn_2))
		scout_trooper.Make_Invulnerable(false)
		scout_trooper.Despawn()

		-- MessageBox("Biker killed")

		Sleep(1)
		pad_list = nil
		pad_list = Find_All_Objects_Of_Type("Scout_Trooper_No_Bike")
		if pad_list then
			for i,unit in pairs(pad_list) do
				unit.Despawn()
			end
		end
	else
		-- MessageBox("Biker not found!")
	end

	Story_Event("ok_to_hack")

end

-- ##########################################################################################
--	Prox when R2 gets close enough...
-- ##########################################################################################

function Uplink_Prox(prox_obj, trigger_obj)

	if TestValid(trigger_obj) and trigger_obj.Get_Type() == Find_Object_Type("Droid_R2D2") then

		r2d2 = trigger_obj

		prox_obj.Cancel_Event_Object_In_Range(Uplink_Prox)

		-- Have to do this because Prox can't hold BlockOnCommand
		Create_Thread("Droids_Get_Busy", trigger_obj)

	end
end

function Droids_Get_Busy(r2d2)

	if TestValid(r2d2) then
		r2d2_team = r2d2.Get_Parent_Object()
	end
	
	-- Don't let the player control R2
	
	if TestValid(r2d2_team) then
		r2d2_team.Set_Selectable(false)
	end
	
	-- MessageBox("about to move")

	if TestValid(r2d2_team) then
		BlockOnCommand(r2d2_team.Move_To(r2d2_team.Get_Position()))
	end
	if TestValid(r2d2_team) then
		BlockOnCommand(r2d2_team.Move_To(uplink)) --r2_uplink
	end
	
	-- MessageBox("done moving")

	if TestValid(r2d2_team) then
		BlockOnCommand(r2d2_team.Turn_To_Face(uplink))
	end
	
	if TestValid(r2d2_team) then

		-- Inform the story script that R2 has arrived at his destination
		Story_Event("begin_hacking_0")
		
		-- Add timer to wait until the hack is done
		Register_Timer(R2_Hack_Done,r2_hack_time)
		
		-- Bring in the first wave of imperial forces
		Register_Timer(Bring_In_Reinforcements, initial_reinforcement_delay)
		
		-- MessageBox("R2 = %s",tostring(r2d2))
		Create_Thread("R2_Hacking_Turret", r2d2)
	end
end

-- ##########################################################################################
--	Hacking turret functions & timer callbacks
-- ##########################################################################################

function R2_Hacking_Turret(r2pass)

	-- MessageBox("r2pass = %s",tostring(r2pass))

	uplink_bone = uplink.Get_Bone_Position("MuzzleA_01")

	while r2_hack_done == false do
		if TestValid(r2d2_team) then
			r2d2_team.Teleport(r2_uplink.Get_Position())
			r2_bone = r2pass.Get_Bone_Position("MuzzleA_00")
			if not flag_playing_lightning_sound then
				flag_playing_lightning_sound = true
				r2d2_team.Play_SFX_Event("Unit_R2_Lightning")
			end
			
			BlockOnCommand(Play_Lightning_Effect("Hack_Electicity_Zaps", r2_bone, uplink_bone))
			--add sound here
			
		else
			r2_team_killed = true
			r2_hack_done = true
			Cancel_Timer(R2_Hack_Done)
		end
	end

	if not r2_team_killed then
		r2d2_team.Set_Selectable(true)
		Story_Event("hack_complete")
		--remove sound here
		if TestValid(r2d2_team) then
			r2d2_team.Stop_SFX_Event("Unit_R2_Lightning")
		end
	end

end

function R2_Hack_Done()

	r2_hack_done = true

	-- Now that R2 is done hacking, we need to detect when he's near a reinforcement marker
	for i, marker in pairs(r_marker_list) do
		Register_Prox(marker, Reinforcement_Prox, r2_reinforcement_range, rebel_player)
	end	
end

-- ##########################################################################################
--	Reinforcement timer functions
-- ##########################################################################################    			

function Grab_Reinforcement_Point(wave)

	if wave == 1 then
		rand_index = GameRandom(1,3)
		--MessageBox("index is %d",rand_index)
		run_function = marker_function_list[rand_index]
		run_function()
		table.remove(marker_function_list, rand_index)

	elseif wave == 2 then
		rand_index = GameRandom(1,2)
		--MessageBox("index is %d",rand_index)
		run_function = marker_function_list[rand_index]
		run_function()
		table.remove(marker_function_list, rand_index)

	else
		run_function = marker_function_list[1]
		run_function()
	end
end

function lz1_setup()

	spawn_point = empire_spawn_0
	attack_marker = attk_flag_0
	warning_direction = "incoming_reinforcements_0"

end

function lz2_setup()

	spawn_point = empire_spawn_1
	attack_marker = attk_flag_1
	warning_direction = "incoming_reinforcements_1"

end

function lz3_setup()

	spawn_point = empire_spawn_2
	attack_marker = attk_flag_2
	warning_direction = "incoming_reinforcements_2"

end

function Bring_In_Reinforcements()

	if num_reinforcements < allowed_reinforcements then

		attack_marker = nil

		if num_reinforcements == 0 then

			reinforce_list = reinforcement_list1

		elseif num_reinforcements == 1 then

			reinforce_list = reinforcement_list2

		else

			reinforce_list = reinforcement_list3

		end

		Grab_Reinforcement_Point(num_reinforcements + 1)
		Story_Event(warning_direction)

		if TestValid(spawn_point) then
			if TestValid(empire_player) then
				--MessageBox("Spawning reinforcements")
				fog_id3 = FogOfWar.Temporary_Reveal(rebel_player, spawn_point, 300)
				ReinforceList(reinforce_list, spawn_point, empire_player, false, true, true, Find_And_Attack)
				num_reinforcements = num_reinforcements + 1
				
				-- Add a timer so that this function will be called again
				if num_reinforcements <= allowed_reinforcements then
					Register_Timer(Bring_In_Reinforcements, reinforcement_delay)
				end
			else
				--MessageBox("Invalid player")
			end
		else
			--MessageBox("Invalid spawn point")
		end
	end
end												

function Find_And_Attack(attack_list)

	-- find the closest rebel unit and have the newly reinforced units attack it!
	if attack_marker == nil then
		attack_marker = r2_uplink
	end

--	closest_target = Find_Nearest(attack_marker, rebel_player, true)
	for k, unit in pairs(attack_list) do
		if TestValid(unit) then
			if TestValid(r2d2_team) then
				unit.Attack_Move(r2d2_team)
			end
		end
	end
end

-- ##########################################################################################
--	Droids get to rebel owned marker (win)
-- ##########################################################################################  

function Reinforcement_Prox(prox_obj, trigger_obj)

	-- This proximity check is only valid once R2 has done his hacking
	if r2_hack_done then
		if not end_triggered then
			-- We only want to check for R2's proximity																			
			if trigger_obj == r2d2_team or trigger_obj.Get_Type() == Find_Object_Type("Droid_R2D2") then
				-- The marker must be rebel owned
				if prox_obj.Get_Owner() == rebel_player then
					end_triggered = true
					--start end cinematic.
					Create_Thread("End_Cinematic")
					--figure out which reforcement point the droids are at.
					if prox_obj == r_marker_list[0] then
						r_marker_loc = 0
					elseif prox_obj == r_marker_list[1] then
						r_marker_loc = 1
					elseif prox_obj == r_marker_list[2] then
						r_marker_loc = 2
					end
					--MessageBox("Reinforcement location = %s", r_marker_loc)
				end
			end
		end
	end
end


-- ##########################################################################################
--	End Cinematic functions
-- ##########################################################################################
--r2's cinematic anim call back 
function State_Play_R2_VictoryAnim(message)
	if message == OnEnter then
		cinematic_r2d2 = Find_First_Object("Droid_R2D2")
		cinematic_r2d2.Play_Animation("idle", false, 3)
	end
end

function End_Cinematic()
	
	Cancel_Fast_Forward() 
	--Set up markers for cinematic.
	if r_marker_loc == 0 then
		transport1_loc = Find_Hint("GENERIC_MARKER_LAND", "trans1loc0")
		transport2_loc = Find_Hint("GENERIC_MARKER_LAND", "trans2loc0")
		transport3_loc = Find_Hint("GENERIC_MARKER_LAND", "trans3loc0")
		droid_start = Find_Hint("GENERIC_MARKER_LAND", "droid1loc0")
		forces11_start = Find_Hint("GENERIC_MARKER_LAND", "forces11loc0")
		forces12_start = Find_Hint("GENERIC_MARKER_LAND", "forces12loc0")
		forces13_start = Find_Hint("GENERIC_MARKER_LAND", "forces13loc0")
		forces2_start =	Find_Hint("GENERIC_MARKER_LAND", "forces2loc0")
	elseif r_marker_loc == 1 then
		transport1_loc = Find_Hint("GENERIC_MARKER_LAND", "trans1loc1")
		transport2_loc = Find_Hint("GENERIC_MARKER_LAND", "trans2loc1")
		transport3_loc = Find_Hint("GENERIC_MARKER_LAND", "trans3loc1")
		droid_start = Find_Hint("GENERIC_MARKER_LAND", "droid1loc1")
		forces11_start = Find_Hint("GENERIC_MARKER_LAND", "forces11loc1")
		forces12_start = Find_Hint("GENERIC_MARKER_LAND", "forces12loc1")
		forces13_start = Find_Hint("GENERIC_MARKER_LAND", "forces13loc1")
		forces2_start =	Find_Hint("GENERIC_MARKER_LAND", "forces2loc1")
	elseif r_marker_loc == 2 then
		transport1_loc = Find_Hint("GENERIC_MARKER_LAND", "trans1loc2")
		transport2_loc = Find_Hint("GENERIC_MARKER_LAND", "trans2loc2")
		transport3_loc = Find_Hint("GENERIC_MARKER_LAND", "trans3loc2")
		droid_start = Find_Hint("GENERIC_MARKER_LAND", "droid1loc2")
		forces11_start = Find_Hint("GENERIC_MARKER_LAND", "forces11loc2")
		forces12_start = Find_Hint("GENERIC_MARKER_LAND", "forces12loc2")
		forces13_start = Find_Hint("GENERIC_MARKER_LAND", "forces13loc2")
		forces2_start =	Find_Hint("GENERIC_MARKER_LAND", "forces2loc2")
	end
	
	--Find Current Forces
	plex_list = Find_All_Objects_Of_Type("Squad_Plex_Soldier")
	T2B_list = Find_All_Objects_Of_Type("T2B_Tank")
	dpad_list = Find_All_Objects_Of_Type("Rebel_Mobile_Defense_Unit")
	Infantry_list = Find_All_Objects_Of_Type("Squad_Rebel_Trooper")
		
	Fade_Screen_Out(1)
	Suspend_AI(1)
	Lock_Controls(1)
	
	Sleep(1)
	
	-- Turn off Fog of War
	fog_id4 = FogOfWar.Reveal(rebel_player, transport1_loc, 9999, 9999)
	
	Letter_Box_In(0)	
	Start_Cinematic_Camera()
	
	--Cleanup for valid plex
	for i,unit in pairs(plex_list) do
		plex_group = unit.Get_Parent_Object()
		plex_group.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	
	--Cleanup for valid T2Bs
	
	for i,unit in pairs(T2B_list) do
		unit.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	
	for i,unit in pairs(T2B_list) do
		if i == 1 then
			unit.Teleport_And_Face(forces11_start)
		end
		if i == 2 then
			unit.Teleport_And_Face(forces12_start)
		end
		if i == 3 then
			unit.Teleport_And_Face(forces13_start)
		end
	end
	
	--Cleanup for valid Pads
	
	for i,unit in pairs(dpad_list) do
		unit.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	
	for i,unit in pairs(dpad_list) do
		if i == 1 then
			unit.Teleport_And_Face(forces11_start)
		end
		if i == 2 then
			unit.Teleport_And_Face(forces12_start)
		end
		if i == 3 then
			unit.Teleport_And_Face(forces13_start)
		end
	end
	
	--Cleanup for valid infantry
	for i,unit in pairs(Infantry_list) do
		troop_group = unit.Get_Parent_Object()
		troop_group.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	
	for i,unit in pairs(Infantry_list) do
		if i <= 6 then
			--MessageBox("Infantry_list[%s] teleported", i)
			trooper_group_prime = unit.Get_Parent_Object()
			if trooper_group1 == nil then
				trooper_group1 = trooper_group_prime
				trooper_group1.Teleport_And_Face(forces2_start)
			elseif trooper_group2 == nil then
				trooper_group2 = trooper_group_prime
				trooper_group2.Teleport_And_Face(forces2_start)
			end
		end
	end
	
	
	cinematic_r2d2 = Find_First_Object("Droid_R2D2")
	cinematic_c3po = Find_First_Object("Droid_C3P0")
	if TestValid(cinematic_r2d2) and TestValid(cinematic_c3po) then
		cinematic_droids = cinematic_r2d2.Get_Parent_Object()
	end
	cinematic_droids.Teleport_And_Face(droid_start)
	cinematic_r2d2.Face_Immediate(droid_start)
	cinematic_c3po.Face_Immediate(droid_start)
	
	Fade_Screen_In(2)
	
	--Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(droid_start, 60, 15, 90, 1, 0, 1, 0)
	Set_Cinematic_Target_Key(transport1_loc, 0, 0, 100, 0, 0, 0, 0)
	
	Sleep(1)
	
	cinematic_c3po.Face_Immediate(transport1_loc)
	
	Transition_Cinematic_Target_Key(transport1_loc, 5, 0, 0, 0, 1, 0, 0, 0)
	Story_Event("end_cin_audio")
	
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
	rebel_shuttle1 = Create_Cinematic_Transport("Gallofree_Transport_Landing", rebel_player.Get_ID(), transport1_loc, 0, 1, 0.25, 15, 0)
	rebel_shuttle2 = Create_Cinematic_Transport("Gallofree_Transport_Landing", rebel_player.Get_ID(), transport2_loc, 0, 1, 0.15, 15, 0)
	rebel_shuttle3 = Create_Cinematic_Transport("Gallofree_Transport_Landing", rebel_player.Get_ID(), transport3_loc, 0, 1, 0.0, 15, 0)
	
	Sleep(4)
	
	cinematic_c3po.Face_Immediate(transport1_loc)
	
	Set_Cinematic_Camera_Key(cinematic_c3po, 60, 25, -90, 1, 0, 1, 0)
	Set_Cinematic_Target_Key(cinematic_c3po, 0, 0, 10, 0, 0, 0, 0)
		
	Story_Event("end_c3po_audio")
	cinematic_c3po.Play_Animation("idle", false, 3)
	
	Transition_Cinematic_Camera_Key(cinematic_c3po, 5, 70, 25, -90, 1, 0, 1, 0)
		
	Sleep(5)
		
	Transition_Cinematic_Camera_Key(droid_start, 4, 400, 25, -65, 1, 0, 1, 0)
	
	Sleep(2)
	
	cinematic_droids.Move_To(transport1_loc)
	
	Sleep(1)
	
	for i,unit in pairs(T2B_list) do
		if i <= 3 then
			unit.Move_To(transport2_loc)
		end
	end
	
	for i,unit in pairs(dpad_list) do
		if i <= 3 then
			unit.Move_To(transport2_loc)
		end
	end
	
	if TestValid(trooper_group1) then
		trooper_group1.Move_To(transport3_loc)
	end
	if TestValid(trooper_group2) then
		trooper_group2.Move_To(transport3_loc)
	end
	
	Sleep(3)
	
	Transition_Cinematic_Target_Key(transport1_loc, 5, 0, 0, 0, 1, 0, 0, 0)
	Sleep(2)
	Transition_Cinematic_Camera_Key(transport1_loc, 5, 900, 60, -50, 1, 0, 1, 0)
	
	cinematic_droids.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	if TestValid(trooper_group1) then
		trooper_group1.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	if TestValid(trooper_group2) then
		trooper_group2.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
	end
	
	for i,unit in pairs(T2B_list) do
		if i <= 3 then
			unit.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
		end
	end
	
	for i,unit in pairs(dpad_list) do
		if i <= 3 then
			unit.Teleport_And_Face(Find_Hint("GENERIC_MARKER_LAND", "UPLINK"))
		end
	end
		
	-- Tell the story script that the win condition has been met
	Story_Event("win_a01m02")
	
	Sleep(9)
	
	Letter_Box_Out(0)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	
	
end