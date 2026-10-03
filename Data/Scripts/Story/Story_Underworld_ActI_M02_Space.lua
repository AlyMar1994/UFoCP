-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActI_M02_SPACE.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActI_M02_SPACE.lua $
--
--    Original Author: Jeff_Stewart
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

require("JGS_FunctionLib") -- added library of commonly used functions
require("PGSpawnUnits")
require("PGStoryMode")

function Definitions()
	StoryModeEvents = 
	{
		Underworld_M02_Begin = State_Underworld_A01M02_Begin
	}
	
	bandit = {}
	bandit[1] = nil
	attack1 = {}
	attack1[1] = nil
	
	rebel_assault_01 =
	{
		"Rebel_X-Wing_Squadron",
		"Rebel_X-Wing_Squadron",
		"Rebel_X-Wing_Squadron",
		"CORELLIAN_CORVETTE"
	}
		
	pirate_scavengers_01 = 
	{
		"Pirate_Fighter_Squadron",
		"Pirate_Fighter_Squadron",
		"Pirate_Fighter_Squadron",
		"Pirate_Fighter_Squadron",
		"Pirate_Fighter_Squadron"
	}
	
	imperial_scouts_01 = 
	{
		"TIE_Bomber_Squadron",
		"TIE_Bomber_Squadron",
		"TIE_Scout_Squadron",
		"TIE_Scout_Squadron",
		"TIE_Scout_Squadron",
		"TIE_Scout_Squadron"
	}
	
	imperial_scouts_02 = 
	{
		"Tartan_Patrol_Cruiser",
		"Tartan_Patrol_Cruiser",
		"Tartan_Patrol_Cruiser",
		"Tartan_Patrol_Cruiser"	
	}
	
	imperial_fleet_01 = 
	{
		"Victory_Destroyer",
		"Victory_Destroyer",
		"Victory_Destroyer",
		"Generic_Star_Destroyer"
	}
end

function State_Underworld_A01M02_Begin(message)
	if message == OnEnter then
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)	
		Initialize_Mission_Variables()
		Initialize_Cinematic_Variables()
		current_cine_id = Create_Thread("CINE_Start_Mission")
		
	elseif message == OnUpdate then
		if not VictoryStarted and not DefeatStarted then
			if DefeatCondition_TyberDead then
				DefeatStarted = true
				Create_Thread("EndMissionDefeat")
			end
			if VictoryCondition_CapturedBoxes then
				VictoryStarted = true
				Create_Thread("EndMissionVictory")
			end
			if bandit_active then
				if TestValid(bandit[1]) then
					if bandit[1].Get_Hull() < 0.05 then
						Remove_Radar_Blip("bandit_radar")
						bandit_active = false
						bandit[1].Set_Cannot_Be_Killed(false)
						black_box_final = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", bandit[1].Get_Position(), rebel_player)
						black_box_flag = Create_Generic_Object("STORY_TRIGGER_ZONE", bandit[1].Get_Position(), rebel_player)
						Register_Prox(black_box_flag, Prox_Obtain_Blackbox, 150, underworld_player)
						Reveal_Black_Box()
						bandit[1].Take_Damage(10000)
						
						Story_Event("PIRATE_DROPPED_POD")

					end
				end
			end
		end
	end
end

function Initialize_Mission_Variables()

	VictoryStarted = false
	DefeatStarted = false
	DefeatCondition_TyberDead = false
	VictoryCondition_CapturedBoxes = false
	
	empire_has_arrived = false
	bandit_active = false
	primary_dialog_on = false
	rebel_dialog = false
	
	rebel_player = Find_Player("Rebel")
	neutral_player = Find_Player("Neutral")
	empire_player = Find_Player("Empire")
	underworld_player = Find_Player("Underworld")
	pirate_player = Find_Player("Pirates")
	if TestValid(pirate_player) then
		pirate_player.Enable_As_Actor()
	end
	if TestValid(empire_player) then
		empire_player.Enable_As_Actor()
	end
	
	boxes_remaining = 4
	box_spotting_remaining = 4
	rebel_spawn_location = 0
	rebel_spawn_count = 10
	bandit_move = nil
	spawn_marker = nil
	spawn_marker2 = nil
		
	radar_01 = Find_Hint("STORY_TRIGGER_ZONE", "radar01")
	radar_02 = Find_Hint("STORY_TRIGGER_ZONE", "radar02")
	radar_03 = Find_Hint("STORY_TRIGGER_ZONE", "radar03")
	radar_04 = Find_Hint("STORY_TRIGGER_ZONE", "radar04")
	radar_05 = Find_Hint("STORY_TRIGGER_ZONE", "radar05")
	radar_06 = Find_Hint("STORY_TRIGGER_ZONE", "radar06")
			
	marker_rebel_first_encounter = Find_Hint("STORY_TRIGGER_ZONE", "rebelfirst")

	tyber_zann = Find_First_Object("TYBER_ZANN_PASSENGER")
	if TestValid(tyber_zann) then
		tyber_zann_craft = tyber_zann.Get_Parent_Object()
		Register_Death_Event(tyber_zann, Tyber_Zann_Destroyed)
	end
	
	Spawn_Black_Boxes()

	missile_01 = Find_Hint("REBEL_DEFENSE_SATELLITE_MISSILE","missile01")
	missile_02 = Find_Hint("REBEL_DEFENSE_SATELLITE_MISSILE","missile02")
	missile_03 = Find_Hint("REBEL_DEFENSE_SATELLITE_MISSILE","missile03")
	missile_04 = Find_Hint("REBEL_DEFENSE_SATELLITE_MISSILE","missile04")
	
	Register_Prox(missile_01, Prox_Missile_Defense, 1200, underworld_player)
	Register_Prox(missile_02, Prox_Missile_Defense, 1200, underworld_player)
	Register_Prox(missile_03, Prox_Missile_Defense, 1200, underworld_player)
	Register_Prox(missile_04, Prox_Missile_Defense, 1200, underworld_player)

	marker_pirate_arrival = Find_Hint("STORY_TRIGGER_ZONE", "piratearrival")
	marker_empire_retreat = Find_Hint("STORY_TRIGGER_ZONE", "empireretreat")
	marker_rebel_spawn_empire = Find_Hint("STORY_TRIGGER_ZONE", "rebelspawne")
	marker_rebel_spawn_pirate = Find_Hint("STORY_TRIGGER_ZONE", "rebelspawnp")
	marker_executor_left = Find_Hint("STORY_TRIGGER_ZONE", "executorleft")
	marker_executor_right = Find_Hint("STORY_TRIGGER_ZONE", "executorright")
	rebel_backup_marker_1 = Find_Hint("STORY_TRIGGER_ZONE", "rebelbackup1")
	rebel_backup_marker_2 = Find_Hint("STORY_TRIGGER_ZONE", "rebelbackup2")

	Register_Prox(marker_pirate_arrival, Prox_Pirate_Arrival, 1200, underworld_player)
	Register_Prox(marker_empire_retreat, Prox_Empire_Arrival, 1200, underworld_player)

	disabled_imperial_vessel_01 = Find_First_Object("ACCLAMATOR_ASSAULT_SHIP")
	if TestValid(disabled_imperial_vessel_01) then
		disabled_imperial_vessel_01.Prevent_AI_Usage(true)
		disabled_imperial_vessel_01.Prevent_Opportunity_Fire(true)
		disabled_imperial_vessel_01.Suspend_Locomotor(true)
		disabled_imperial_vessel_01.Prevent_All_Fire(true)
		disabled_imperial_vessel_01.Change_Owner(rebel_player)
	end
end

function Initialize_Cinematic_Variables()
	camtarget = Find_Hint("ATTACKER ENTRY POSITION", "camtarget")
	reconstart = Find_Hint("STORY_TRIGGER_ZONE", "reconstart")
	reconend = Find_Hint("STORY_TRIGGER_ZONE", "reconend")
	introattack1 = Find_Hint("STORY_TRIGGER_ZONE", "introattack1")
	CINE_Intro_Active = false
end

---------------------------------------------------------------------------------
-- COMMON FUNCTIONS

function Spawn_Black_Boxes()
	local second_location = GameRandom(1,2)
	local third_location = GameRandom(1,2)
	
	black_box_01 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_04, rebel_player)
	black_box_04 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_05, rebel_player)
	if (second_location == 1) then
		black_box_02 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_03, rebel_player)
		black_box_02_location = radar_03
	elseif (second_location == 2) then
		black_box_02 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_06, rebel_player)
		black_box_02_location = radar_06
	end
	if (third_location == 1) then
		black_box_03 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_01, rebel_player)
		black_box_03_location = radar_01
	else
		black_box_03 = Create_Generic_Object("UM01_DEATH_STAR_BLACK_BOX", radar_02, rebel_player)
		black_box_03_location = radar_02
	end
	
	black_box_01.Hide(true)
	black_box_02.Hide(true)
	black_box_03.Hide(true)
	black_box_04.Hide(true)

	black_box_01.Set_Cannot_Be_Killed(true)
	black_box_02.Set_Cannot_Be_Killed(true)
	black_box_03.Set_Cannot_Be_Killed(true)
	black_box_04.Set_Cannot_Be_Killed(true)
	black_box_01.Make_Invulnerable(true)
	black_box_02.Make_Invulnerable(true)
	black_box_03.Make_Invulnerable(true)
	black_box_04.Make_Invulnerable(true)

	Register_Prox(radar_04, Prox_Obtain_Blackbox, 150, underworld_player)
	Register_Prox(radar_05, Prox_Obtain_Blackbox, 150, underworld_player)
	Register_Prox(black_box_02_location, Prox_Obtain_Blackbox, 150, underworld_player)
	Register_Prox(black_box_03_location, Prox_Obtain_Blackbox, 150, underworld_player)

	Register_Prox(radar_04, Prox_Spotted_Blackbox, 800, underworld_player)
	Register_Prox(radar_05, Prox_Spotted_Blackbox, 800, underworld_player)
	Register_Prox(black_box_02_location, Prox_Spotted_Blackbox, 800, underworld_player)
	Register_Prox(black_box_03_location, Prox_Spotted_Blackbox, 800, underworld_player)
end

function Reveal_Black_Box()
	if TestValid(tyber_zann) then
		local black_box_object = Find_Nearest(tyber_zann, "UM01_DEATH_STAR_BLACK_BOX")
		if TestValid(black_box_object) then
			Add_Radar_Blip(black_box_object, "box_radar")
			black_box_object.Highlight(true)
			fog_id = FogOfWar.Reveal(underworld_player, black_box_object, 250, 250)
		end
	end
end

function Primary_Dialog_Off()
	Sleep(5)
	primary_dialog_on = false
end

function Prox_Empire_Arrival(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Empire_Arrival)
	
	if not empire_has_arrived then
	
		imperial_scouts = SpawnList(imperial_scouts_01, prox_obj.Get_Position(), empire_player, false, true)
		local imperial_scouts_tartans = SpawnList(imperial_scouts_02, prox_obj.Get_Position(), neutral_player, false, true)
		
		for i, unit in pairs (imperial_scouts_tartans) do
			if TestValid(unit) then
				unit.Move_To(prox_obj.Get_Position())
			end
		end
		
		local closest_enemy = Find_Nearest(prox_obj, underworld_player, true)
		if TestValid(closest_enemy) then
			for i,unit in pairs(imperial_scouts) do
				if TestValid(unit) then
					unit.Attack_Move(closest_enemy)
				end
			end
		end
		if TestValid(disabled_imperial_vessel_01) then
			disabled_imperial_vessel_01.Change_Owner(empire_player)
		end
		primary_dialog_on = true
		Story_Event("IMPERIAL_ENCOUNTER")
		Create_Thread("Primary_Dialog_Off")
		Create_Thread("Empire_AI_Control")
	
	end
end

function Empire_AI_Control()
	if not VictoryStarted and not DefeatStarted then
		Sleep(10)
		if not empire_has_arrived then
			local empire_ai_list = Find_All_Objects_Of_Type(empire_player)
			for i, unit in pairs(empire_ai_list) do
				if TestValid(unit) then
					unit.Prevent_AI_Usage(false)
				end
			end
		
			local tartan_list = Find_All_Objects_Of_Type("Tartan_Patrol_Cruiser")
			for i, unit in pairs (tartan_list) do
				if TestValid(unit) then
					unit.Change_Owner(underworld_player)
					underworld_player.Select_Object(unit)
				end
			end
			
			Sleep(15)
						
			if not empire_has_arrived then
				Create_Thread("Rebel_Scouts_Engaged", marker_rebel_spawn_empire.Get_Position())
			end
			
		else
			local empire_ai_list = Find_All_Objects_Of_Type(empire_player)
			for i, unit in pairs(empire_ai_list) do
				if TestValid(unit) then
					unit.Prevent_AI_Usage(false)
				end
			end
		end
	end
end

function Prox_Pirate_Arrival(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Pirate_Arrival)
	
	if not empire_has_arrived then
	
		pirate_scavengers = SpawnList(pirate_scavengers_01, prox_obj.Get_Position(), pirate_player, false, true)
		local closest_enemy = Find_Nearest(prox_obj, underworld_player, true)	
		if TestValid(closest_enemy) then
			for i,unit in pairs(pirate_scavengers) do
				if TestValid(unit) then
					unit.Attack_Move(closest_enemy)
				end
			end
		end
		primary_dialog_on = true
		Story_Event("PIRATE_ENCOUNTER")
		Create_Thread("Primary_Dialog_Off")
		Create_Thread("Pirate_AI_Control")
	
	end
end

function Pirate_AI_Control()
	if not VictoryStarted and not DefeatStarted then
		Sleep(10)
		local pirate_ai_list = Find_All_Objects_Of_Type(pirate_player)
		for i, unit in pairs(pirate_ai_list) do
			unit.Prevent_AI_Usage(false)
		end
		if not empire_has_arrived then
			Create_Thread("Rebel_Scouts_Engaged", marker_rebel_spawn_pirate.Get_Position())
		end
	end
end

function Prox_Spotted_Blackbox(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Spotted_Blackbox)
	fog_id = FogOfWar.Reveal(underworld_player, prox_obj, 250, 250)
	Remove_Radar_Blip("box_radar")
	Add_Radar_Blip(prox_obj, "box_radar")
	if box_spotting_remaining == 4 then
		primary_dialog_on = true
		Story_Event("CHATTER_07")
		Create_Thread("Primary_Dialog_Off")
	elseif box_spotting_remaining == 3 then
		if not primary_dialog_on then
			primary_dialog_on = true
			Story_Event("CHATTER_08")
			Create_Thread("Primary_Dialog_Off")
		end
	elseif box_spotting_remaining == 2 then
		if not primary_dialog_on then
			primary_dialog_on = true
			Story_Event("CHATTER_09")
			Create_Thread("Primary_Dialog_Off")
		end
	elseif box_spotting_remaining == 1 then
		
		bandit_active = true
		
		prox_obj.Cancel_Event_Object_In_Range(Prox_Obtain_Blackbox)
		Remove_Radar_Blip("box_radar")

		bandit = Spawn_Unit(Find_Object_Type("UM01_MERCHANT_FREIGHTER"), prox_obj.Get_Position(), pirate_player)
		bandit[1].Highlight(true)
		Add_Radar_Blip(bandit[1], "bandit_radar")
		bandit[1].Prevent_AI_Usage(true)
		bandit[1].Teleport_And_Face(prox_obj)
		bandit[1].Cinematic_Hyperspace_In(1)
		bandit[1].Make_Invulnerable(true)
		bandit[1].Set_Cannot_Be_Killed(true)
		bandit_move = introattack1.Get_Position()
		
		Register_Prox(introattack1, Prox_Change_Bandit_Course, 50, pirate_player)
		
		Story_Event("FINAL_ENCOUNTER")
		
		Create_Thread("Empire_Fleet_Arrival")
	end
	box_spotting_remaining = box_spotting_remaining - 1
end

function Prox_Change_Bandit_Course(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Change_Bandit_Course)
	bandit_move = spawn_marker.Get_Position()
end

function Timer_Move_Bandit()
	if TestValid(bandit[1]) then
		bandit[1].Move_To(bandit_move)
		Register_Timer(Timer_Move_Bandit,5)
	end
end

function Empire_Fleet_Arrival()
	if not VictoryStarted and not DefeatStarted then
		
		Register_Timer(Timer_Move_Bandit,1)
		
		if TestValid(disabled_imperial_vessel_01) then
			disabled_imperial_vessel_01.Change_Owner(empire_player)
		end
		
		tyber_zann_craft.Make_Invulnerable(true)
		tyber_zann_craft.Set_Cannot_Be_Killed(true)
		empire_has_arrived = true
		
		Sleep(1)
		
		nearest_black_box = Find_Nearest(bandit[1], "UM01_DEATH_STAR_BLACK_BOX")
		if TestValid(nearest_black_box) then
			nearest_black_box.Set_Cannot_Be_Killed(false)
			nearest_black_box.Make_Invulnerable(false)
			nearest_black_box.Take_Damage(10000)
		end
		
		Sleep(6)
		
		-- Time for midtro cinematic stuff.
		Suspend_AI(1)
		Lock_Controls(1)
		Cancel_Fast_Forward()
		Fade_Screen_Out(1)
		Sleep(1)
				
		-- Find out which side of the battlefield the player is on.
		local left_distance = tyber_zann.Get_Distance(marker_executor_left)
		local right_distance = tyber_zann.Get_Distance(marker_executor_right)
		if left_distance < right_distance then
			spawn_marker = marker_executor_left
			spawn_marker2 = marker_executor_right
		else
			spawn_marker = marker_executor_right
			spawn_marker2 = marker_executor_left
		end
		
		-- Spawn the Empire fleet.
		imperial_fleet_list = SpawnList(imperial_fleet_01, spawn_marker.Get_Position(), empire_player, true, true)
				
		-- Spawn the Rebel backup.
		rebel_assault_01_list = SpawnList(rebel_assault_01, rebel_backup_marker_1.Get_Position(), rebel_player, true, true)
		rebel_backup_02_list = SpawnList(rebel_assault_01, rebel_backup_marker_2.Get_Position(), rebel_player, true, true)
		
		FogOfWar.Reveal_All(underworld_player)

		Start_Cinematic_Camera()
		
		Set_Cinematic_Camera_Key(spawn_marker.Get_Position(), 0, -1000, 800, 0, 0, 1, 0)
		Set_Cinematic_Target_Key(spawn_marker.Get_Position(), 0, 0, 0, 0, 0, 0, 0)
		
		Fade_Screen_In(2)
		Transition_Cinematic_Camera_Key(tyber_zann.Get_Position(), 3, 0, -2000, 1600, 0, 0, 0, 0)

-- DEBUG: Call the dialog for announcing Empire arrival here. We'll need to separate it for timing purposes.
		Sleep(3)
		
		Transition_To_Tactical_Camera(5)
		Sleep(5)
		
		End_Cinematic_Camera()
		Letter_Box_Out(0)	
		Lock_Controls(0)
		Suspend_AI(0)
		tyber_zann_craft.Make_Invulnerable(false)
		tyber_zann_craft.Set_Cannot_Be_Killed(false)
		bandit[1].Make_Invulnerable(false)
		
	end
end

function Prox_Missile_Defense(prox_obj, trigger_obj)
	missile_01.Cancel_Event_Object_In_Range(Prox_Missile_Defense)
	missile_02.Cancel_Event_Object_In_Range(Prox_Missile_Defense)
	missile_03.Cancel_Event_Object_In_Range(Prox_Missile_Defense)
	missile_04.Cancel_Event_Object_In_Range(Prox_Missile_Defense)
	if not primary_dialog_on then
		primary_dialog_on = true
		Story_Event("REBEL_SATELLITES_SPOTTED")
		Create_Thread("Primary_Dialog_Off")
	end
end

function Prox_Obtain_Blackbox(prox_obj,trigger_obj)
	if (trigger_obj == tyber_zann_craft) then
		prox_obj.Cancel_Event_Object_In_Range(Prox_Obtain_Blackbox)
	
		boxes_remaining = boxes_remaining - 1
		nearest_black_box = Find_Nearest(prox_obj, "UM01_DEATH_STAR_BLACK_BOX")
		if TestValid(nearest_black_box) then
			nearest_black_box.Set_Cannot_Be_Killed(false)
			nearest_black_box.Make_Invulnerable(false)
			nearest_black_box.Take_Damage(10000)
		end
		fog_id.Undo_Reveal()
		Remove_Radar_Blip("box_radar")
		if boxes_remaining == 3 then
			Story_Event("UM02_HINT_POD_01")
		elseif boxes_remaining == 2 then
			Story_Event("UM02_HINT_POD_02")
		elseif boxes_remaining == 1 then
			Story_Event("UM02_HINT_POD_03")
		elseif boxes_remaining < 1 then
			Story_Event("UM02_HINT_POD_04")
			VictoryCondition_CapturedBoxes = true
		end
	end
end

function Rebel_Scouts_Engaged(engage_location)
	
	-- Bring in the backup squad at the prox_obj location.

	rebel_backup = SpawnList(rebel_assault_01, engage_location, rebel_player, true, true)
	for i, unit in pairs (rebel_backup) do
		unit.Cinematic_Hyperspace_In(1)
	end
	if not rebel_dialog then
		rebel_dialog = true
		primary_dialog_on = true
		Story_Event("REBEL_ENCOUNTER_01")
		Create_Thread("Primary_Dialog_Off")
		Create_Thread("Rebel_Encounter_Done")
	end
end

function Rebel_Encounter_Done()
	Sleep(15)
	if not primary_dialog_on then
		primary_dialog_on = true
		Story_Event("REBEL_ENCOUNTER_DONE")
		Create_Thread("Primary_Dialog_Off")
	end
end

---------------------------------------------------------------------------------
-- INTRO CINEMATIC

function CINE_Start_Mission()
	
	CINE_Intro_Active = true
	
	Cancel_Fast_Forward()	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()	
		
	recon = Create_Generic_Object("SKIPRAY_BLASTBOAT", reconstart.Get_Position(), underworld_player)
	if TestValid(recon) then
		recon.Move_To(reconend)
	end
	--Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)

	Set_Cinematic_Camera_Key(recon, 0, 90, 40, 0, recon, 1, 0)
	Set_Cinematic_Target_Key(recon, 0, 0, 0, 0, recon, 0, 0)
	Transition_Cinematic_Camera_Key(recon, 13, 0, 0, 40, 0, recon, 1, 0)
	Transition_Cinematic_Target_Key(recon, 7, 0, 0, 0, 0, recon, 0, 0)

	Letter_Box_In(0)
	Fade_Screen_In(2)	
	Sleep(3)
	
	Story_Event("CHATTER_00")
	Sleep(6)

	Set_Cinematic_Camera_Key(tyber_zann_craft.Get_Position(), 0, 200, -175, 0, tyber_zann_craft, 0, 0)
	Set_Cinematic_Target_Key(tyber_zann_craft.Get_Position(), 0, 0, 0, 0, tyber_zann_craft, 0, 0)	
	Story_Event("CHATTER_01")
	Sleep(8)

	Set_Cinematic_Camera_Key(tyber_zann_craft.Get_Position(), 275, 15, 90, 1, tyber_zann_craft, 0, 0)
	Set_Cinematic_Target_Key(tyber_zann_craft.Get_Position(), 0, 0, 0, 0, tyber_zann_craft, 0, 0)	
	Story_Event("CHATTER_03")
	Sleep(4)	
	
	attack1 = Create_Generic_Object("CORELLIAN_CORVETTE", introattack1.Get_Position(), neutral_player)
	attack1.Teleport_And_Face(introattack1)
	Set_Cinematic_Camera_Key(attack1, 300, -15, 145, 1, attack1, 1, 0)
	Set_Cinematic_Target_Key(attack1, 20, 0, -25, 0, attack1, 0, 0)
	Transition_Cinematic_Camera_Key(attack1, 6, 350, 15, 125, 1, attack1, 1, 0)
	Transition_Cinematic_Target_Key(attack1, 6, 10, 0, 35, 0, attack1, 0, 0)
	Story_Event("CHATTER_04")
	Sleep(2)
	
	Story_Event("CHATTER_05")
	Sleep(5)
	
	Set_Cinematic_Camera_Key(camtarget, -150, -150, 140, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(attack1, 0, 0, 0, 0, attack1, 0, 0)
	Story_Event("CHATTER_06")
	Sleep(1.5)
	
	attack1.Change_Owner(rebel_player)
	Sleep(1.5)
	
	Fade_Screen_Out(1)
	Sleep(1)

	Create_Thread("IntroCineCleanup")
end

function Story_Handle_Esc()
	if CINE_Intro_Active then 
		CINE_Intro_Active = false
		Thread.Kill(current_cine_id)
		Create_Thread("IntroCineCleanup")
	end
end

function IntroCineCleanup()

	current_cine_id = nil

	Story_Event("UM02_INTROCINE_DONE")

	black_box_01.Hide(false)
	black_box_02.Hide(false)
	black_box_03.Hide(false)
	black_box_03.Hide(false)

	Reveal_Black_Box()
	
	if TestValid(recon) then
		recon.Despawn()
	end
	
	if not TestValid(attack1) then
		attack1 = Create_Generic_Object("CORELLIAN_CORVETTE", introattack1.Get_Position(), rebel_player)
		attack1.Teleport_And_Face(introattack1)
		if TestValid(attack1) then
			attack1.Attack_Move(camtarget.Get_Position())
			attack1.Prevent_AI_Usage(false)
		end
	end
	
	unit_list = SpawnList(rebel_assault_01, marker_rebel_first_encounter, rebel_player, true, true)
	for i,unit in pairs (unit_list) do
		if TestValid(unit) then
			unit.Attack_Move(camtarget.Get_Position())
		end
	end

	if TestValid(attack1) then
		attack1.Change_Owner(rebel_player)
	end
	
	Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()
	Allow_Localized_SFX(true)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(1)
	Sleep(1)
	
	CINE_Intro_Active = false
	Story_Event("UM02_HINT_BLACKBOX")
end

---------------------------------------------------------------------------------
-- VICTORY AND DEFEAT

function EndMissionVictory()
	Cancel_Fast_Forward()
	primary_dialog_on = true
	Story_Event("UM02_ENDCINE_BEGIN")
	Sleep(2)
	
	Suspend_AI(1)
	Lock_Controls(1)
	--Fade_Screen_Out(1)
	--Sleep(1)
	Start_Cinematic_Camera()	
	Letter_Box_In(1)
	--Fade_Screen_In(1)

	Sleep(1)
	
	--Fade_Screen_Out(1)
	--Sleep(1)
	--End_Cinematic_Camera()
	--Letter_Box_Out(0)	
	--Lock_Controls(0)
	--Suspend_AI(0)
	--Fade_Screen_In(1)
	--Sleep(1)
	
	Story_Event("CHATTER_10")
	Sleep(4)
	
	GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 1)	

	Story_Event("UM02_ENDMISSION_VICTORY")
end

function EndMissionDefeat()
	Cancel_Fast_Forward() 

	GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 1)	

	Suspend_AI(1)
	Lock_Controls(1)
	--Fade_Screen_Out(1)
	--Sleep(1)
	--Letter_Box_In(0)
	--Start_Cinematic_Camera()	
	--Fade_Screen_In(1)
	--Sleep(1)

	--MessageBox("Insert Game Defeat Cinematic Here")

	--Sleep(1)
	--Fade_Screen_Out(1)
	--End_Cinematic_Camera()
	--Letter_Box_Out(.5)	
	--Lock_Controls(0)
	--Suspend_AI(0)
	--Sleep(1)
	--Fade_Screen_In(1)
	--Sleep(1)
	Story_Event("UM02_ENDMISSION_DEFEAT")
end

function Tyber_Zann_Destroyed()
	DefeatCondition_TyberDead = true
end

