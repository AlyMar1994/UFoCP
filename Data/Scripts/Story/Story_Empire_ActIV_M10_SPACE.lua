-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIV_M10_SPACE.lua#31 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIV_M10_SPACE.lua $
--
--    Original Author: Steve Copeland
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36026 $
--
--          $DateTime: 2006/01/05 17:48:43 $
--
--          $Revision: #31 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

function Definitions()

	StoryModeEvents = 
	{
		Empire_A04M10_Begin = State_Empire_A04M10_Begin,
		Empire_A04M10_Waiting_For_Princess_00 = State_A04M10_Waiting_For_Princess_00,
		Empire_M10_Clear_The_Sector_Dialog_Remove_Text = State_M10_Clear_The_Sector_Dialog_Remove_Text,
		Empire_A04M010_Win_For_Empire = State_Empire_A04M010_Win_For_Empire,
		Empire_A04M10_Tantive_Destroyed = State_Empire_A04M10_Tantive_Destroyed,
		Tutorial_M05_Disable_BRANCH_EMPIRE_SPOTTED = State_Princess_Warps_Away
	}

	-- Tunable vars
	scout_arrival_delay = 60 --60
	update_unit_list_delay = 4
	scouting_finished_leia_arrives_delay = 5
	duration_to_receive_transmission = 5
	interdictors_killed = 0
	detection_warning_range = 1000
	
	-- Init vars
	pirates_destroyed = false
	scouts_arrived = false
	flag_scouts_attacked = false
	leia_arrived = false
	flag_leia_attacked = false
	leia_received_transmission = false
	flag_interdictor01_killed = false
	flag_interdictor02_killed = false
	flag_interdictor03_killed = false
	flag_interdictor04_killed = false
	flag_fudge_delay = false
	flag_leia_captured = false
	flag_leia_at_sattelite = false
	flag_interdictor_active = false
	flag_okay_for_Leia_to_escape = false
	any_interdictor_active = false
	flag_princess_escaped = false
	flag_pirate_base_attacked = false
	flag_engines_offline = false
	flag_princess_killed = false
	flag_empire_spotted = false
	flag_tantive_vulnerable = false
	flag_tantive_invulnerable = false
	flag_tantive_is_ok_to_attack = false
	

		
	rebel_scout_type_list = {
		"Rebel_X-Wing_Squadron"
		,"Rebel_X-Wing_Squadron"
	}
	
	rebel_reinforce_list01 = {
		"Rebel_X-Wing_Squadron"
		,"Rebel_X-Wing_Squadron"
		,"Rebel_X-Wing_Squadron"
		,"Rebel_X-Wing_Squadron"
		,"Rebel_X-Wing_Squadron"

	}
	
	rebel_reinforce_list02 = {
		
		"Alliance_Assault_Frigate"
		
	}
	
	rebel_reinforce_list03 = {
	
		"Nebulon_B_Frigate"
		
	}
	
	rebel_reinforce_list04 = {
		
		"Marauder_Missile_Cruiser"
	}
	
	rebel_leia_entourage_type_list = {

		"Tantive_IV"
	}
	
	rebel_ending_leia_list = {
		"Tantive_IV"
	}
	
	empire_ending_star_destroyer_list = {
		"Star_Destroyer"
	}
	
	leia_unit_name = "Tantive_IV"
	-- For memory pool cleanup hints
	empire_unit_list = nil
	unit = nil
	empire_player = nil
	rebel_player = nil
	pirate_player = nil
	
	-- nil'ing out reveal names
	initial_reveal = nil
	princess_reveal = nil
	ending_reveal = nil
	pirate_reveal = nil
	
	flag_calvary_entered = false

end


function State_Empire_A04M10_Tantive_Destroyed(message)
	if message == OnEnter then
		flag_princess_killed = true	
	end
end

function State_Empire_A04M10_Begin(message)
	if message == OnEnter then	
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)

	
		-- Vader cinematic fighter
		
		--Hyper_Vader = Find_Hint("EM11_HYPERVADER", "hyper")
				
		Pirate_Frigate1 = Find_Hint("PIRATE_FRIGATE", "attacker1")
		Pirate_Frigate2 = Find_Hint("PIRATE_FRIGATE", "attacker2")
		Pirate_Frigate3 = Find_Hint("PIRATE_FRIGATE", "attacker3")
		
		
		Pirate_Fighter1 = Find_Hint("PIRATE_FIGHTER_SQUADRON", "fighter1")
		Pirate_Fighter2 = Find_Hint("PIRATE_FIGHTER_SQUADRON", "fighter2")
		Pirate_Fighter3 = Find_Hint("PIRATE_FIGHTER_SQUADRON", "fighter3")
		Pirate_Fighter4 = Find_Hint("PIRATE_FIGHTER_SQUADRON", "fighter4")
		Pirate_Fighter5 = Find_Hint("PIRATE_FIGHTER_SQUADRON", "fighter5")
		
		pirate_base = Find_Hint("PIRATE_ASTEROID_BASE", "pirate-base")
	
		flag_fudge_delay = true
		
		-- Find various markers
		player_start = Find_Hint("GENERIC_MARKER_SPACE", "player-start")
		scout_start = Find_Hint("GENERIC_MARKER_SPACE", "scout-start")
		leia_start = Find_Hint("GENERIC_MARKER_SPACE", "leia-start")
		scout_1 = Find_Hint("GENERIC_MARKER_SPACE", "scout-1")
		scout_2 = Find_Hint("GENERIC_MARKER_SPACE", "scout-2")
		scout_3 = Find_Hint("GENERIC_MARKER_SPACE", "scout-3")
		scout_4 = Find_Hint("GENERIC_MARKER_SPACE", "scout-4")
		
		hyper_goto_1 = Find_Hint("GENERIC_MARKER_SPACE", "hyper-goto")
		
		if not hyper_goto_1 then
			--MessageBox("hyper_goto_1; aborting")
			return
		end
		leia_goto = Find_Hint("GENERIC_MARKER_SPACE", "leia-goto")
		if not scout_start or not scout_1 or not scout_2 or not scout_3 or not scout_4 or not leia_goto then
			--MessageBox("couldn't find markers; aborting")
			return
		end
		
		leia_path_01 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-1")
		leia_path_02 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-2")
		leia_path_03 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-3")
		leia_path_04 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-4")
		leia_path_05 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-5")
		leia_path_06 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-6")
		leia_path_07 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-7")
		leia_path_08 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-8")
		leia_path_09 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-9")
		leia_path_10 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-10")
		
		--tracking player interdictors
		
		interdictor_1 = Find_Hint("Interdictor_Cruiser", "interdictor1")
		interdictor_2 = Find_Hint("Interdictor_Cruiser", "interdictor2")
		interdictor_3 = Find_Hint("Interdictor_Cruiser", "interdictor3")
		interdictor_4 = Find_Hint("Interdictor_Cruiser", "interdictor4")
		
		interdictor_goto = Find_Hint("GENERIC_MARKER_SPACE", "interdictor-goto")

		-- Find the players.
		
		pirate_player = Find_Player("Pirates")
		empire_player = Find_Player("Empire")
		rebel_player = Find_Player("Rebel")
		rebel_player.Enable_As_Actor()
		if not pirate_player or not empire_player or not rebel_player then
			--MessageBox("couldn't find players; aborting")
			ScriptExit()
		end
		
		-- Find the units that we'll need to track
		Register_Timer(Update_Empire_Unit_List, update_unit_list_delay)
		
		--jdg 8/24/05 adding in some pirate base 's
		guard_table = Find_All_Objects_With_Hint("guard")
		
		for i,unit in pairs(guard_table) do
			unit.Guard_Target(unit.Get_Position())
		end

		Create_Thread("Intro_Cinematic")
			
	end
end


function Intro_Cinematic()

	-- Use Leia's move marker
	leia_path_01 = Find_Hint("GENERIC_MARKER_SPACE", "leia-patrol-1")
	
	--making "player" interdictors invulnerable during cine
	interdictor_2.Make_Invulnerable(true)
	interdictor_3.Make_Invulnerable(true)
	interdictor_4.Make_Invulnerable(true)

	-- interdictors in trouble...turning around to flee
	interdictor_1.Move_To(leia_path_01)
	interdictor_2.Move_To(interdictor_goto)
	interdictor_3.Move_To(interdictor_goto)
	
	Pirate_Fighter1.Attack_Move(interdictor_1)
	Pirate_Fighter2.Attack_Move(interdictor_1)	
	Pirate_Fighter3.Attack_Move(interdictor_4)
	Pirate_Fighter4.Attack_Move(interdictor_3)
	Pirate_Fighter5.Attack_Move(interdictor_2)
	
	-- Lock out controls for intro cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()
	
	initial_reveal = FogOfWar.Reveal_All(empire_player)
			

	Fade_Screen_In(2)	
	
	--vader = Find_First_Object("TIE_PROTOTYPE")
	--if not TestValid(vader) then 
	--	Messagebox("no vader")
	--end	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(player_start, 100, 0, 45, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(player_start, 0, 0, 0, 0, player_start, 0, 0) 
		
	Sleep(.5)
	Resume_Hyperspace_In() 
	Sleep(1)
	
	-- Pirate Frigates give chase	
	Pirate_Frigate1.Move_To(interdictor_goto)	
	Pirate_Frigate2.Move_To(interdictor_goto)
	Pirate_Frigate3.Move_To(interdictor_goto)
	
	Sleep(3)	
	
	Story_Event("M10_INTRO_DIALOG_01_GO")
	Create_Thread("Interdictor_Takes_Damage")
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(interdictor_1, 250, -10, 270, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(interdictor_1, -50, 0, 0, 0, interdictor_1, 0, 0) 
	
	Sleep(3)
	
		
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(Pirate_Frigate2, 220, -12, 290, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(interdictor_1, 0, 0, 50, 0, interdictor_1, 0, 0) 
	
	Sleep(4)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(interdictor_1, 260, -10, 345, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(Pirate_Frigate3, 0, 0, -30, 0, 0, 0, 0)
	Sleep(.2)
		
	Transition_Cinematic_Camera_Key(Pirate_Frigate2, 9, 220, 15, 330, 1, 0, 0, 0)
	
	Sleep(3)
	
	interdictor_1.Set_Cannot_Be_Killed(false)
	interdictor_1.Take_Damage(10000)
	Pirate_Frigate1.Move_To(hyper_goto_1)
		
	Sleep(3)	
			
	
	Transition_To_Tactical_Camera(4)
	
	Sleep(4)	

	End_Cinematic_Camera()		
	
	--initial_reveal.Undo_Reveal()
	
	Letter_Box_Out(1)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	
	--Resume_Hyperspace_In()
	--Sleep(2)
	Story_Event("M10_INTRO_DIALOG_02_GO")	
	
	
end

function Interdictor_Takes_Damage ()
	--list of hardpoints
	--HP_Interdictor_Weapon_01
	--HP_Interdictor_Weapon_02
	--HP_Interdictor_Weapon_03
	--HP_Interdictor_Weapon_04
	--HP_Interdictor_GravWell_01
	--HP_Interdictor_Shields_01
	--HP_Interdictor_Engines_01
	interdictor_1.Set_Cannot_Be_Killed(true)
	
	interdictor_1.Take_Damage(200000, "HP_Interdictor_Weapon_01")
	Sleep(2)
	interdictor_1.Take_Damage(200000, "HP_Interdictor_Weapon_02")
	Sleep(.5)
	interdictor_1.Take_Damage(200000, "HP_Interdictor_Weapon_03")
	Sleep(.5)
	interdictor_1.Take_Damage(200000, "HP_Interdictor_Weapon_04")
	Sleep(.5)
	interdictor_1.Take_Damage(200000, "HP_Interdictor_GravWell_01")
	Sleep(2)
	interdictor_1.Take_Damage(200000, "HP_Interdictor_Shields_01")
	Sleep(1)
	--interdictor_1.Take_Damage(200000, "HP_Interdictor_Engines_01")

	Sleep(11)

	interdictor_2.Make_Invulnerable(false)
	interdictor_3.Make_Invulnerable(false)
	interdictor_4.Make_Invulnerable(false)

	Letter_Box_Out(1)	
	Lock_Controls(0)
	Suspend_AI(0)
	

end


function State_A04M10_Waiting_For_Princess_00(message)
	if message == OnEnter then
		--MessageBox("All pirate units destroyed.")
		pirates_destroyed = true
		Register_Timer(Rebel_Scouts_Arrive, scout_arrival_delay)
		princess_reveal = FogOfWar.Reveal_All(empire_player)
	end
end

-- The player can bring additional units by reinforcing, so this list must be kept reasonably current.
function Update_Empire_Unit_List()
	empire_unit_list = Find_All_Objects_Of_Type(empire_player)
	Register_Timer(Update_Empire_Unit_List, update_unit_list_delay)
end


function Rebel_Scouts_Arrive()
	--MessageBox("Warp some scouts in and send them on a search path.")
	Create_Thread("Blue_Squadron_Cinematic")
end

function Blue_Squadron_Cinematic()
	
	Cancel_Fast_Forward() 
	-- Lock out controls for blue_squadron cinematic
	Fade_Screen_Out(.5)
	Suspend_AI(.5)
	Lock_Controls(1)
	Letter_Box_In(0)
	Sleep(1)
	
	-- now find blue squadron
	blue_squad_camera = Find_Hint("GENERIC_MARKER_SPACE", "scout-start")
	if not blue_squad_camera then
		--MessageBox("Can't find blue_squadron camera position!!!")
		return
	end
	
	Sleep(.5)
	
	Start_Cinematic_Camera()
	--Point_Camera_At(blue_squadron)
	Fade_Screen_In(.5)
	
	-- this watches the rebel scouts (blue squadron) warp in
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(blue_squad_camera, 1200, 6, 120, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(blue_squad_camera, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(blue_squad_camera, 4, 400, 12, 120, 1, 0, 0, 0) 
	
	Sleep(1)
	ReinforceList(rebel_scout_type_list, scout_start, rebel_player, false, true, true, Scout_Callback)
	
	Sleep(1)
	Story_Event("SCOUTS_ENTER_SCENE")
	
	--make everyone hold their fire 
	empire_unit_list = Find_All_Objects_Of_Type(empire_player)
	rebel_unit_list = Find_All_Objects_Of_Type(rebel_player)
	
	for i, empire_unit in pairs(empire_unit_list) do
		empire_unit.Prevent_Opportunity_Fire(true)
	end
	
	for i, rebel_unit in pairs(rebel_unit_list) do
		rebel_unit.Prevent_Opportunity_Fire(true)
	end
	
	
	Sleep(3)
	
	-- this watches the rebel scouts (blue squadron) warp in
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(blue_squad_camera, 400, 12, 120, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(blue_squad_camera, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(blue_squad_camera, 4, 800, 12, 0, 1, 0, 0, 0) 
	
	Sleep(3)
	
	blue_leader = Find_First_Object("X-Wing")
	if not blue_leader then
		--MessageBox("Can't find blue_leader camera position!!!")
		return
	end
	
	Fade_Screen_Out(1)
	Sleep(1)
	Point_Camera_At(blue_leader)
	Transition_To_Tactical_Camera(1)
	
	Fade_Screen_In(.5)
	
	End_Cinematic_Camera()
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)

end



function Scout_Callback(unit_list)
	--MessageBox("Giving scout orders")
	Create_Thread("Thread_Scout_Orders", unit_list)
	
	scout_list = unit_list
	for i,unit in pairs(scout_list) do
            Register_Prox(unit, Prox_Empire_Detected, detection_warning_range, empire_player)
    end
	
	
end

function Thread_Scout_Orders(unit_list)
	--MessageBox("Thread_Scout_Orders entered")
	scouts_arrived = true
	Formation_Move(unit_list, scout_1)
	Formation_Move(unit_list, scout_2)
	Story_Event("SCOUTS_REPORT_01")
	Formation_Move(unit_list, scout_3)
	Formation_Move(unit_list, scout_4)
	Story_Event("CALL_FOR_PRINCESS")
	Sleep(scouting_finished_leia_arrives_delay)
	--ReinforceList(rebel_leia_entourage_type_list, leia_start, rebel_player, false, true, true, Leia_Callback)
	Create_Thread("Intro_Leia_Cinematic")
end

function Intro_Leia_Cinematic()
	
	Cancel_Fast_Forward() 
	-- Lock out controls for blue_squadron cinematic
	Fade_Screen_Out(.5)
	Suspend_AI(.5)
	Lock_Controls(1)
	Letter_Box_In(0)
	Sleep(1)
	
	-- now find blue squadron
	leia_camera = Find_Hint("GENERIC_MARKER_SPACE", "leia-start")
	if not leia_camera then
		--MessageBox("Can't find leia_camera camera position!!!")
		return
	end
	
	Sleep(.5)
	
	Start_Cinematic_Camera()
	--Point_Camera_At(blue_squadron)
	Fade_Screen_In(.5)
	
	-- this watches the rebel scouts (blue squadron) warp in
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(leia_camera, 1200, 6, 120, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(leia_camera, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(leia_camera, 4, 400, 12, 120, 1, 0, 0, 0) 
	
	Sleep(1)
	ReinforceList(rebel_leia_entourage_type_list, leia_start, rebel_player, false, true, true, Leia_Callback)
	
	
	Sleep(3)
	
	leia = Find_First_Object("Tantive_IV")
	if not leia then
		--MessageBox("Can't find leia !!!")
		return
	end
	
	leia.Set_Cannot_Be_Killed(true)
	
	-- this watches the rebel scouts (blue squadron) warp in
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(leia_camera, 400, 12, 120, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(leia_camera, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(leia_camera, 4, 800, 12, 0, 1, 0, 0, 0) 
	
	Sleep(3)
	
	
	
	Fade_Screen_Out(1)
	Sleep(1)
	Point_Camera_At(leia)
	Transition_To_Tactical_Camera(1)
	
	Fade_Screen_In(.5)
	
	End_Cinematic_Camera()
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)

end








function Leia_Callback(unit_list)
	--MessageBox("Leia_Callback entered")
	leia = Find_First_Object(leia_unit_name)
	if not TestValid(leia) then
		--MessageBox("couldn't find leia")
		return
	end
	
	leia_list = unit_list
	for i,unit in pairs(leia_list) do
            Register_Prox(unit, Prox_Empire_Detected, detection_warning_range, empire_player)
    end
    
	Create_Thread("Thread_Leia_Orders", unit_list)
end

function Thread_Leia_Orders(unit_list)
	
	Story_Event("FLAG_THE_PRINCESS")
	Story_Event("DARTH_VADER_WAIT_LINE")
	leia_arrived = true
	
	Formation_Move(unit_list, leia_goto)
	
	Story_Event("PRINCESS_REACHED_SATELLITE")
	Sleep(duration_to_receive_transmission)
	
	satellite = Find_Hint("DEFENSE_SATELLITE","satellite")
	satellite.Play_SFX_Event("Unit_Data_Transmit")
	
	leia_received_transmission = true
	--make everyone hold their fire 
	empire_unit_list = Find_All_Objects_Of_Type(empire_player)
	rebel_unit_list = Find_All_Objects_Of_Type(rebel_player)
	
	for i, empire_unit in pairs(empire_unit_list) do
		empire_unit.Prevent_Opportunity_Fire(false)
	end
	
	for i, rebel_unit in pairs(rebel_unit_list) do
		rebel_unit.Prevent_Opportunity_Fire(false)
	end
		
	Create_Thread("Bring_In_Leias_Calavary")

	Formation_Move(unit_list, scout_1)
	--MessageBox("leia at starting waypoint") 
	
	
		
	if flag_interdictor_active and not flag_leia_captured and not flag_princess_escaped then
		--MessageBox("player has interdictor active...leia starts escape patrol")
		Create_Thread("Thread_Leia_Escape_Patrol")
	end
       
end

function Bring_In_Leias_Calavary()

	--MessageBox("Bring_In_Leias_Calavary")
	reinforce_spot01 = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-xwings")
	
	reinforce_spot02a = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-1a")
	reinforce_spot02b = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-1b")
	reinforce_spot02c = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-1c")
	reinforce_spot02d = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-1d")
	reinforce_spot02e = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-1e")
	
	reinforce_spot03a = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-2a")
	reinforce_spot03b = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-2b")
	reinforce_spot03c = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-2c")
	reinforce_spot03d = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-2d")
	reinforce_spot03e = Find_Hint("GENERIC_MARKER_SPACE", "reinforce-2e")
	
	--rebel_reinforce_list01 == xwings
	--rebel_reinforce_list02 == Alliance_Assault_Frigate
	--rebel_reinforce_list03 == Nebulon_B_Frigate
	--rebel_reinforce_list04 == Marauder_Missile_Cruiser
	
	
	
	--function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)
	Sleep(5)
	ReinforceList(rebel_reinforce_list01, reinforce_spot01, rebel_player, false, true, true, callback_xwings)
	Sleep(10)	
	ReinforceList(rebel_reinforce_list03, reinforce_spot03a, rebel_player, true, true, true)
	Sleep(3)
	flag_okay_for_Leia_to_escape = true
	ReinforceList(rebel_reinforce_list02, reinforce_spot03b, rebel_player, true, true, true)
	Sleep(3)		
	ReinforceList(rebel_reinforce_list02, reinforce_spot03c, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list02, reinforce_spot03d, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list02, reinforce_spot03e, rebel_player, true, true, true)
	
	Sleep(10)
	ReinforceList(rebel_reinforce_list05, reinforce_spot02a, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list04, reinforce_spot02b, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list04, reinforce_spot02c, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list04, reinforce_spot02d, rebel_player, true, true, true)
	Sleep(3)
	ReinforceList(rebel_reinforce_list04, reinforce_spot02e, rebel_player, true, true, true)
	
end

function callback_xwings()
	--these guys are to attack the interdictors
	interdictor_list = Find_All_Objects_Of_Type("Interdictor_Cruiser")
	xwing_list = Find_All_Objects_Of_Type("Rebel_X-Wing_Squadron")
	
	interdictor = interdictor_list[1]
	if not interdictor then
		--MessageBox("NO interdictors found...xwings should now be attacking CLOSEST")
		closest_enemy = Find_Nearest(reinforce_spot01, empire_player, false)
		--unit_list.Attack_Move(closest_enemy)
		
		for k, unit in pairs(xwing_list) do
			unit.Attack_Target(closest_enemy)
		end
		return
	end
	--MessageBox("interdictors found...xwings should now be attacking them")
	
	--Formation attack move blocks and blocking in callbacks is now illegal (since
	--it can block threads other than the one that scheduled the callback and lead to
	--hangs)
	--Formation_Attack_Move(xwing_list, interdictor)
	for k, unit in pairs(xwing_list) do
		unit.Attack_Target(interdictor)
	end

end





function Thread_Leia_Escape_Patrol()

	leia = Find_First_Object(leia_unit_name)
	
	while (TestValid(leia)) do
		
		--MessageBox("Thread_Leia_Escape_Patrol")
		
		if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_01)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_02)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_03)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_04)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_05)
		end
		
		if not flag_calvary_entered then
			flag_calvary_entered = true
			Create_Thread("Bring_In_Leias_Calavary")
		end
		
		if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_06)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_07)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_08)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_09)
		end if TestValid(leia) and not flag_leia_captured then
			Formation_Move(leia, leia_path_10)
		end
		
		if (flag_leia_captured or flag_princess_escaped or flag_princess_killed) then break end
	end
	
	
	
	
		
	--Create_Thread("Thread_Leia_Escape_Patrol")
end

function Play_Interdictor_Message ()
	if interdictors_killed == 1 then
		--Story_Event("FIRST_INTERDICTOR_KILLED")
	
	elseif interdictors_killed == 2 then
		Story_Event("SECOND_INTERDICTOR_KILLED")
	
	elseif interdictors_killed == 3 then
		Story_Event("THIRD_INTERDICTOR_KILLED")
		
	elseif interdictors_killed == 4 then
		Story_Event("LAST_INTERDICTOR_KILLED")
	end
end

function Prox_Empire_Detected (prox_obj, trigger_obj)
	--this sets up lose event if player is detected by scouts or Leia
	if TestValid(trigger_obj) and not (trigger_obj.Is_In_Nebula() or trigger_obj.Is_In_Ion_Storm()) and not leia_received_transmission and not flag_leia_at_sattelite then
		prox_obj.Cancel_Event_Object_In_Range(Prox_Empire_Detected)
		
		--MessageBox("Empire discovered!  Mission Failed.")
		--rebel_player.Retreat()
		Story_Event("EMPIRE_SPOTTED")	
		prox_obj.Hyperspace_Away()
		
		flag_princess_escaped = true
		prox_obj.Cancel_Event_Object_In_Range(Prox_Empire_Detected)
		
		--ScriptExit()
	end
end

---------------------------------------------------------------------------------------------
--player has won, start ending cinematic
--------------------------------------------------------------------------
function Ending_Cinematic()
	
		--MessageBox("player has won...trigger ending cinematic")
		--make everyone hold their fire 
		empire_unit_list = Find_All_Objects_Of_Type(empire_player)
		rebel_unit_list = Find_All_Objects_Of_Type(rebel_player)
		leia.Suspend_Locomotor(true)
		
		for i, empire_unit in pairs(empire_unit_list) do
			empire_unit.Set_Selectable(false)
			empire_unit.Prevent_Opportunity_Fire(true)
			empire_unit.Prevent_All_Fire(true)
		end
		
		for i, rebel_unit in pairs(rebel_unit_list) do
			rebel_unit.Prevent_Opportunity_Fire(true)
			rebel_unit.Prevent_All_Fire(true)
			if rebel_unit.Get_Type() ~= Find_Object_Type("Tantive_IV") then
				rebel_unit.Despawn()
			end
		end
		
		--Start_Cinematic_Camera()
		
		Cancel_Fast_Forward() 
	
		-- Lock out controls for cinematic

		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
	
		end_cine_goto = Find_Hint("GENERIC_MARKER_SPACE", "end-cine-goto")
		
		leia = Find_First_Object(leia_unit_name)
		
		ending_reveal = FogOfWar.Reveal_All(empire_player)
		
		Start_Cinematic_Camera()
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(leia, 400, 6, 0, 1, 0, 0, 0)
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(leia, 0, 0, 0, 0, leia, 0, 0) 
		-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(leia, 12, 600, 12, 60, 1, 0, 0, 0) 
		
		Story_Event("PRINCESS_CAPTURED_WITH_INFO")
		--MessageBox("cue first ending cinematic speech line")
		Story_Event("CUE_M10_ENDING_DIALOG_OFFICER_01")
		--Imperial Officer: The ship has been neutralized. 
end


---------------------------------------------------------------------------------------
-- setting up ending cine lua callbacks 
---------------------------------------------------------------------------------------

--turn off cinematic camera safety stuff here
function State_Empire_A04M010_Win_For_Empire(message)
	if message == OnEnter then
		End_Cinematic_Camera()
	end
end











--flags the pirate asteroid base when vader says to destroy them
function State_M10_Clear_The_Sector_Dialog_Remove_Text(message)
	if message == OnEnter then
		--MessageBox("flagging pirate base here") 
		if TestValid(pirate_base) then
			pirate_base.Highlight(true)
			Add_Radar_Blip(pirate_base, "blip_pirate_base")
		end
	end
end















--feeds back from XML once all the secondary dialog is disabled...
--warps princess leia away
function State_Princess_Warps_Away(message)
	if message == OnEnter then
		leia = Find_First_Object(leia_unit_name)
		if TestValid(leia) then
			--MessageBox("leia's now hyperspacing away")
			leia.Hyperspace_Away()
		end
	end
end








function Story_Mode_Service()

	if not flag_fudge_delay then
		return
	end

	if c and not leia.Are_Engines_Online() and not flag_engines_offline then
		--MessageBox("leia's engines now off line")
		flag_engines_offline = true
		leia.Override_Max_Speed(.05)
		leia.Prevent_Opportunity_Fire(true)
		leia.Prevent_All_Fire(true)
		
	end

	if not flag_interdictor_active and flag_fudge_delay then
		interdictor_table = Find_All_Objects_Of_Type("Interdictor_Cruiser")
		for i,interdictor in pairs(interdictor_table) do
			if TestValid(interdictor) and interdictor.Is_Ability_Active("INTERDICT") then
				flag_interdictor_active = true
				--MessageBox("player has interdictor active")
			end
		end
	end
	
	if flag_interdictor_active and flag_fudge_delay and not flag_princess_escaped and TestValid(leia) then
         interdictor_table = Find_All_Objects_Of_Type("Interdictor_Cruiser")
         any_interdictor_active = false
         
         for i,interdictor in pairs(interdictor_table) do
             if TestValid(interdictor) and interdictor.Is_Ability_Active("INTERDICT") then
                 any_interdictor_active = true
		 flag_tantive_vulnerable = true
		 flag_tantive_invulnerable = false
                 --MessageBox("any_interdictor_active = true")
             end
         end
         
         flag_interdictor_active = any_interdictor_active
         if not flag_interdictor_active then
		flag_tantive_invulnerable = true
		flag_tantive_vulnerable = false
			--MessageBox("player has no interdictors active")
         end
	end

	if flag_tantive_vulnerable and not leia.Make_Invulnerable(false) and flag_okay_for_Leia_to_escape and not flag_leia_captured then
		leia.Make_Invulnerable(false)
	end

	if flag_tantive_invulnerable and not leia.Make_Invulnerable(true) and flag_okay_for_Leia_to_escape and not flag_leia_captured then
		leia.Make_Invulnerable(true)
	end




-- checks if its cool for Leia to warp out
	if flag_okay_for_Leia_to_escape and not flag_interdictor_active and not flag_leia_captured and not flag_princess_escaped then
		--MessageBox("player has no interdictor active...leia escapes")
		
		Story_Event("PRINCESS_ESCAPED")
		flag_princess_escaped = true
	end

	
	-- See if Leia's ship got tractored
	if TestValid(leia) and leia.Is_Under_Effects_Of_Ability("Tractor_Beam") and not flag_leia_captured then
		if leia_received_transmission then
			--MessageBox("Got her! You win.")
			--Story_Event("PRINCESS_CAPTURED_WITH_INFO")
			flag_leia_captured = true
			leia.Make_Invulnerable(false)
			leia.Take_Damage(10000, "HP_Tantive_IV_Engines")
			Ending_Cinematic()
			
		else
			--MessageBox("Too early...She had no info.")
			Story_Event("PRINCESS_CAPTURED_WITHOUT_INFO")
		end
		leia.Make_Invulnerable(true)
		--ScriptExit()
	end
	
	if not TestValid(interdictor_1) and not flag_interdictor01_killed and flag_fudge_delay then
		flag_interdictor01_killed = true
		interdictors_killed = interdictors_killed +1
		--MessageBox("Interdictor 01 killed")
		Play_Interdictor_Message ()
	end
	
	if not TestValid(interdictor_2) and not flag_interdictor02_killed and flag_fudge_delay  then
		flag_interdictor02_killed = true
		interdictors_killed = interdictors_killed +1
		--MessageBox("Interdictor 02 killed")
		Play_Interdictor_Message ()
	end
	
	if not TestValid(interdictor_3) and not flag_interdictor03_killed and flag_fudge_delay  then
		flag_interdictor03_killed = true
		interdictors_killed = interdictors_killed +1
		--MessageBox("Interdictor 03 killed")
		Play_Interdictor_Message ()
	end
	
	if not TestValid(interdictor_4) and not flag_interdictor04_killed and flag_fudge_delay  then
		flag_interdictor04_killed = true
		interdictors_killed = interdictors_killed +1
		--MessageBox("Interdictor 04 killed")
		Play_Interdictor_Message ()
	end
	
	if scouts_arrived and not flag_scouts_attacked and not leia_arrived then
	
		for i,unit in pairs(scout_list) do
             if unit.Get_Hull() < 1.0 then
				Story_Event("SCOUTS_ATTACKED")
				--MessageBox("scouts attacked")
				flag_scouts_attacked = true

             end
        end
	end
	
	if leia_arrived and not flag_leia_attacked and not leia_received_transmission then
		if leia.Get_Shield() < 1.0 or leia.Get_Hull() < 1.0 then
			leia.Make_Invulnerable(true)
			leia.Hyperspace_Away()
			Story_Event("SCOUTS_ATTACKED")
			--MessageBox("Leia attacked")
			flag_leia_attacked = true
        end
	end
	
	--play a vader line when pirate base is first attacked
	if TestValid(pirate_base) then
		
			if (pirate_base.Get_Shield() < .99) and not flag_pirate_base_attacked then
				Story_Event("VADER_TALKS_ABOUT_SCOUTS_HURRY_UP")
				flag_pirate_base_attacked = true 
				pirate_reveal = FogOfWar.Reveal_All(empire_player) 
				
				--put all pirates back under AI control
				guard_table = Find_All_Objects_With_Hint("guard")
				for i,unit in pairs(guard_table) do
					unit.Prevent_AI_Usage(false)
				end
			end
	end
	
	if flag_leia_captured then
		rebel_unit_list_ending_ceinamtic = Find_All_Objects_Of_Type(rebel_player)
		for i, rebel_unit in pairs(rebel_unit_list_ending_ceinamtic) do
			if rebel_unit.Get_Type() ~= Find_Object_Type("Tantive_IV") then
			   rebel_unit.Despawn()
			end
		end
	end	
end