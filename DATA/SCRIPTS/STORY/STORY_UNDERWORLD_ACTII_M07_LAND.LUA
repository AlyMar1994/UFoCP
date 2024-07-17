-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M07_LAND.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M07_LAND.lua $
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
require("PGSpawnUnits")
require("PGStateMachine")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	StoryModeEvents = 
	{
		Underworld_A02M07_Begin = State_Underworld_A02M07_Begin,
		Underworld_A02M07_Speech_Line_00_Remove_Text = State_Underworld_A02M07_Speech_Line_00_Remove_Text,
		Underworld_A02M07_Speech_Line_01_Remove_Text = State_Underworld_A02M07_Speech_Line_01_Remove_Text,
		Underworld_A02M07_Speech_Line_02_Remove_Text = State_Underworld_A02M07_Speech_Line_02_Remove_Text,
		Underworld_A02M07_Speech_Line_03_Remove_Text = State_Underworld_A02M07_Speech_Line_03_Remove_Text,
		Underworld_A02M07_Speech_Line_04_Remove_Text = State_Underworld_A02M07_Speech_Line_04_Remove_Text,
		Underworld_A02M07_Speech_Line_05_Remove_Text = State_Underworld_A02M07_Speech_Line_05_Remove_Text,
		Underworld_A02M07_Speech_Line_06_Remove_Text = State_Underworld_A02M07_Speech_Line_06_Remove_Text,
		Underworld_A02M07_Speech_Line_07_Remove_Text = State_Underworld_A02M07_Speech_Line_07_Remove_Text,
		Underworld_A02M07_Speech_Line_08_Remove_Text = State_Underworld_A02M07_Speech_Line_08_Remove_Text,
		Underworld_A02M07_Speech_Line_09_Remove_Text = State_Underworld_A02M07_Speech_Line_09_Remove_Text,
		Underworld_A02M07_Speech_Line_10_Remove_Text = State_Underworld_A02M07_Speech_Line_10_Remove_Text,
		Underworld_A02M07_Speech_Line_11_Remove_Text = State_Underworld_A02M07_Speech_Line_11_Remove_Text,
		Underworld_A02M07_Speech_Line_12_Remove_Text = State_Underworld_A02M07_Speech_Line_12_Remove_Text,
		Underworld_A02M07_Speech_Line_13_Remove_Text = State_Underworld_A02M07_Speech_Line_13_Remove_Text,
		Underworld_A02M07_Speech_Line_14_Remove_Text = State_Underworld_A02M07_Speech_Line_14_Remove_Text,
		Underworld_A02M07_Speech_Line_15_Remove_Text = State_Underworld_A02M07_Speech_Line_15_Remove_Text,
		Underworld_A02M07_Speech_Line_16_Remove_Text = State_Underworld_A02M07_Speech_Line_16_Remove_Text,
		Underworld_A02M07_Speech_Line_17_Remove_Text = State_Underworld_A02M07_Speech_Line_17_Remove_Text,
		Underworld_A02M07_Speech_Line_18_Remove_Text = State_Underworld_A02M07_Speech_Line_18_Remove_Text,
		Underworld_A02M07_Speech_Line_20_Remove_Text = State_Underworld_A02M07_Speech_Line_20_Remove_Text,
		Underworld_A02M07_Speech_Line_21_Remove_Text = State_Underworld_A02M07_Speech_Line_21_Remove_Text,
		Underworld_A02M07_Speech_Line_22_Remove_Text = State_Underworld_A02M07_Speech_Line_22_Remove_Text,
		Underworld_A02M07_Speech_Line_24_Remove_Text = State_Underworld_A02M07_Speech_Line_24_Remove_Text,
		Underworld_A02M07_Speech_Line_25_Remove_Text = State_Underworld_A02M07_Speech_Line_25_Remove_Text,
		Underworld_A02M07_Speech_Line_26_Remove_Text = State_Underworld_A02M07_Speech_Line_26_Remove_Text,
		Underworld_A02M07_Speech_Line_27_Remove_Text = State_Underworld_A02M07_Speech_Line_27_Remove_Text,
		Underworld_A02M07_Speech_Line_28_Remove_Text = State_Underworld_A02M07_Speech_Line_28_Remove_Text,
		UM07_VaderCine_Choking_SFX_Over = State_UM07_VaderCine_Choking_SFX_Over,
		Underworld_A02M07_Speech_Line_29_Remove_Text = State_Underworld_A02M07_Speech_Line_29_Remove_Text,
		Underworld_A02M07_Speech_Line_30_Remove_Text = State_Underworld_A02M07_Speech_Line_30_Remove_Text,
		Underworld_A02M07_Speech_Line_31_Remove_Text = State_Underworld_A02M07_Speech_Line_31_Remove_Text,
		Underworld_A02M07_Speech_Line_32_Remove_Text = State_Underworld_A02M07_Speech_Line_32_Remove_Text,
		Underworld_A02M07_Speech_Line_33_Remove_Text = State_Underworld_A02M07_Speech_Line_33_Remove_Text,
		Underworld_A02M07_Speech_Line_34_Remove_Text = State_Underworld_A02M07_Speech_Line_34_Remove_Text,
		Underworld_A02M07_Speech_Line_35_Remove_Text = State_Underworld_A02M07_Speech_Line_35_Remove_Text,
		Underworld_A02M07_Speech_Line_36_Remove_Text = State_Underworld_A02M07_Speech_Line_36_Remove_Text,
		
	}
	
	
	empire_reinforcement_list_0 = {
		"Imperial_Stormtrooper_Squad",
	}
	
	empire_reinforcement_list_1 = {
		"Imperial_Heavy_Scout_Squad"
	}
	
	empire_reinforcement_list_2 = {
		"Imperial_Heavy_Scout_Squad"
	}
	
	empire_reinforcement_list_3 = {
		"Imperial_Armor_Group"
	}
	
	reinforcement_table_list = {
		empire_reinforcement_list_0,
		empire_reinforcement_list_1,
		empire_reinforcement_list_2,
		empire_reinforcement_list_3
	}
	
	--jdg cheat flag to skip intro cine
	flag_skip_intro = false
	flag_no_enemy_reinforcements = false	
	
	underworld = Find_Player("Underworld")
	empire = Find_Player("Empire")
	rebel = Find_Player("Rebel")
	neutral = Find_Player("Neutral")
	hostile = Find_Player("Hostile")
	
	mission_started = false
	
	droids_returned = 0
	current_droids_alive = 5
	droid_warning = false
	droid_objective_achieved = false
	
	var_empire_reinforcement_timer = 90
	
	outposts_tripped = 0
	outpost_objective_achieved = false
	
	objectives_achieved = 0
	final_objective_triggered = false
	
	vader_landed = false
	
	reinforcement_table = 0
	reinforce_countdown = -1
	reinforced_once = false
	reinforced_units = 0
	
	empire_map_reveal = nil
	
	end_cinematic_started = false
	create_droid_lost_message = true
	
	cloud_city_cars = {}
	cloud_cars_in_use = {}
	
	outpost_list = {}
	outposts_discovered = {}
	
	bool_Gas_Droid00_Spawned = false
	bool_Gas_Droid01_Spawned = false
	bool_Gas_Droid02_Spawned = false
	bool_Gas_Droid03_Spawned = false
	bool_Gas_Droid04_Spawned = false
	
	
	--jdg
	bool_first_security_outpost = true
	
	gas_droid_full = {}
end

function State_Underworld_A02M07_Begin (message)
	if message == OnEnter then
		JoeMessage("######################################UM07 START*************************")
		
		tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
		urai = Find_First_Object("URAI_FEN")
		ig88 = Find_First_Object("IG-88")
		empire_map_reveal = FogOfWar.Reveal_All(empire)
		
		cin_trooper_0 = Find_Hint("STORMTROOPER","cintrooper0")
		cin_trooper_1 = Find_Hint("STORMTROOPER","cintrooper1")
		cin_trooper_0.Suspend_Locomotor(true)
		cin_trooper_0.Prevent_All_Fire(true)
		cin_trooper_1.Suspend_Locomotor(true)
		cin_trooper_1.Prevent_All_Fire(true)

		reinforce_1 = Find_Hint("REINFORCEMENT_POINT_PLUS1_CAP","reinforce1")
		reinforce_2 = Find_Hint("REINFORCEMENT_POINT_PLUS2_CAP","reinforce2")
		reinforce_3 = Find_Hint("REINFORCEMENT_POINT_PLUS3_CAP","reinforce3")
		reinforce_4 = Find_Hint("REINFORCEMENT_POINT_PLUS4_CAP","reinforce4")
		
		point_guard_list = Find_All_Objects_With_Hint("pointguard")
		for i, point_guard in pairs(point_guard_list) do
			point_guard.Prevent_AI_Usage(true)
			--point_guard.Guard_Target(point_guard.Get_Position())
		end
		
		refinery01 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery01")
		refinery02 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery02")
		refinery03 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery03")
		refinery04 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery04")
		refinery05 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery05")
		refinery06 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery06")
		refinery07 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery07")
		refinery08 = Find_Hint("UM07_CLOUDCITY_REFINERY","refinery08")		
		
		--set refineries into idle anims
		refinery_list = Find_All_Objects_Of_Type("UM07_CLOUDCITY_REFINERY")
		for i, refinery in pairs(refinery_list) do
			refinery.Play_Animation("Cinematic", true, 0) --Cinematic_00 – full state
			refinery.Set_Cannot_Be_Killed(true)
			--refinery.Highlight(true)
		end		
		--List of the refineries animation states
		--Cinematic_00 – full state
		--Cinematic_01 – draining animation
		--Cinematic_02 – empty state
		--Cinematic_03 – filling state
		
		--turbo-laser definition stuff
		turbo_power = Find_Hint("POWER_GENERATOR_E","turbo-power")
		
		outpost1 = Find_Hint("PROP_BESPIN_BUILDING_A","outpost01")
		outpost2 = Find_Hint("PROP_BESPIN_BUILDING_A","outpost02")
		outpost3 = Find_Hint("PROP_BESPIN_BUILDING_A","outpost03")
		outpost4 = Find_Hint("PROP_BESPIN_BUILDING_A","outpost04")
		
		outpost_list[1] = outpost1
		outpost_list[2] = outpost2
		outpost_list[3] = outpost3
		outpost_list[4] = outpost4
		
		
						
		tyber_shuttle = Find_Hint("STORY_TRIGGER_ZONE_00","shuttleland")
		
		Register_Prox(refinery01, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery02, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery03, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery04, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery05, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery06, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery07, PROX_Gas_Refinery, 75, underworld)
		Register_Prox(refinery08, PROX_Gas_Refinery, 75, underworld)
		
		server = Find_Hint("DROID_INTERFACE_STATION","server")
		Register_Prox(server, PROX_Bespin_Server, 50, underworld)
		
		Register_Prox(outpost1, PROX_Guard_Outpost, 100, underworld)
		Register_Prox(outpost2, PROX_Guard_Outpost, 100, underworld)
		Register_Prox(outpost3, PROX_Guard_Outpost, 100, underworld)
		Register_Prox(outpost4, PROX_Guard_Outpost, 100, underworld)
		
		Register_Prox(tyber_shuttle, PROX_Droid_Return, 95, underworld)
		Register_Prox(tyber_shuttle, PROX_Hero_Return, 300, underworld)
		
		server_prox_obj = Find_Hint("STORY_TRIGGER_ZONE_00","serverprox")
		Register_Prox(server_prox_obj, PROX_Server_Notification, 175, underworld)
		
		--hide all the preplaced flyover anim objects
		cloud_city_cars = Find_All_Objects_Of_Type("UM07_CLOUD_CITY_FLYOVER")
		for i, cloud_city_car in pairs(cloud_city_cars) do
			cloud_city_car.Hide(true)
		end
		
		Create_Thread("Thread_Cloud_Car_Flyovers")
		
		
		--making the terminals invulneralbe to prevnet A class bugs when they get destroyed.
		terminal_list = Find_All_Objects_Of_Type("UM07_INTERFACE_NODE")	
		for i, terminal in pairs(terminal_list) do
			terminal.Set_Selectable(false)
			terminal.Make_Invulnerable(true)
			terminal.Set_Cannot_Be_Killed(true)
			
			--MessageBox("terminal set to invulnerable")
		end

		
		if flag_skip_intro == false then
			current_cinematic_thread = Create_Thread("Intro_Cinematic")
			
		else
			--stuff that has to happen even if cine is skipped 
			shuttle_land_loc = Find_Hint("STORY_TRIGGER_ZONE_00","shuttleland")
			tyber_temp_loc = Find_Hint("STORY_TRIGGER_ZONE_00","temploc")
			unit_spawn_loc = Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn")
			tyber_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","tybergoto0")
			tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
			urai_kill_spot = Find_Hint("STORY_TRIGGER_ZONE_00","uraikill")


			if TestValid(tyber) then
				tyber.Teleport_And_Face(tyber_goto_0)
				tyber.Prevent_All_Fire(true)
				--MessageBox("Tyber Reinforcement found, teleporting")
			else
				MessageBox("No Tyber Reinforcement found, spawning and teleporting")
				--tyber_spawn = Spawn_Unit(Find_Object_Type("TYBER_ZANN_PASSENGER"), tyber_temp_loc, underworld)
				tyber_spawn = Spawn_Unit(Find_Object_Type("TYBER_ZANN_PASSENGER"), tyber_goto_0, underworld)
				tyber = tyber_spawn[1]
				tyber.Prevent_All_Fire(true)
			end
			
			urai_spawn = Spawn_From_Reinforcement_Pool(Find_Object_Type("Urai_Fen_Team"), urai_kill_spot, underworld)
			urai = urai_spawn[1]
			
			spawn_ig88 = Spawn_Unit(Find_Object_Type("IG-88"), Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"), underworld)
			spawn_ig88[1].Teleport_And_Face(Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"))
			ig_88 = spawn_ig88[1]
	
	
			droid_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto0")
			droid_goto_1 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto1")
			droid_goto_2 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto2")
			droid_goto_3 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto3")
			droid_goto_4 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto4")
			
			Create_Thread("Spawn_Gas_Droid", droid_goto_0)
			Create_Thread("Spawn_Gas_Droid", droid_goto_1)
			Create_Thread("Spawn_Gas_Droid", droid_goto_2)
			Create_Thread("Spawn_Gas_Droid", droid_goto_3)
			Create_Thread("Spawn_Gas_Droid", droid_goto_4)
			
			
			Fade_Screen_In(2)
			--MessageBox("Exit_Cinematic")
			Create_Thread("Exit_Cinematic")
			Master_Volume_Restore() 
			
			
			
			--Create_Thread("Thread_DeathMonitor_TurboPower")
			
		end
	
	end
end



function Thread_DeathMonitor_TurboPower()
	while TestValid(turbo_power) do
		Sleep(3)
	end
	
	turbo_laser_list  = Find_All_Objects_Of_Type("E_GROUND_TURBOLASER_TOWER")
	for i, turbo_laser in pairs(turbo_laser_list) do
		turbo_laser.Prevent_All_Fire(true)
	end
end


















function Reinforce_Empire_Units()
	--function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)
	while (true) do
		empire_reinforcement_loc_list = {}
		reinforcement_table = 0
		if TestValid(reinforce_1) then
			if reinforce_1.Get_Owner().Get_Faction_Name() == "EMPIRE" then
				table.insert(empire_reinforcement_loc_list, reinforce_1)
				reinforcement_table = reinforcement_table + 1
			end
		end
		if TestValid(reinforce_2) then
			if reinforce_2.Get_Owner().Get_Faction_Name() == "EMPIRE" then
				table.insert(empire_reinforcement_loc_list, reinforce_2)
				reinforcement_table = reinforcement_table + 1
			end
		end
		if TestValid(reinforce_3) then
			if reinforce_3.Get_Owner().Get_Faction_Name() == "EMPIRE" then
				table.insert(empire_reinforcement_loc_list, reinforce_3)
				reinforcement_table = reinforcement_table + 1
			end
		end
		if TestValid(reinforce_4) then
			if reinforce_4.Get_Owner().Get_Faction_Name() == "EMPIRE" then
				table.insert(empire_reinforcement_loc_list, reinforce_4)
				reinforcement_table = reinforcement_table + 1
			end
		end
		--MessageBox("Empire controlls %d reinforcement points", reinforcement_table)
		if reinforcement_table <= 0 then
			MessageBox("Empire controlls no reinforcement points...breaking out of loop")
			break
		end
		
		if reinforcement_table > 0 then
			reinforce_loc_num = GameRandom(1, reinforcement_table)
			reinforcement_location = empire_reinforcement_loc_list[reinforce_loc_num]
			
			--current_list = reinforcement_table_list[GameRandom(1, 4)]
			
			--MessageBox("current reinforced_units  is %d", reinforced_units)
			
			if reinforced_units <= 6 then
					current_list = reinforcement_table_list[GameRandom(1, 1)]
					ReinforceList(current_list, reinforcement_location, empire, false, true, true, Callback_Hunt_Underworld)

			elseif reinforced_units <= 12 and  reinforced_units > 6 then
				current_list = reinforcement_table_list[GameRandom(1, 2)]
				ReinforceList(current_list, reinforcement_location, empire, false, true, true, Callback_Hunt_Underworld)
				var_empire_reinforcement_timer = 60

			elseif reinforced_units <= 18 and  reinforced_units > 12 then
				current_list = reinforcement_table_list[GameRandom(1, 3)]
				ReinforceList(current_list, reinforcement_location, empire, false, true, true, Callback_Hunt_Underworld)
			elseif reinforced_units <= 24 and  reinforced_units > 18 then
				current_list = reinforcement_table_list[GameRandom(1, 4)]
				ReinforceList(current_list, reinforcement_location, empire, false, true, true, Callback_Hunt_Underworld)
				
			end		
			
			--reinforce_countdown = 400
			reinforced_units = reinforced_units + 1
			Sleep(var_empire_reinforcement_timer)
		end
	end
end

function Garrison_Prox(unit_list)
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			if unit.Is_Category("Infantry") and unit.Get_Owner().Get_Faction_Name() == "EMPIRE" then
				--MessageBox("Attaching Prox to %s!", unit.Get_Type().Get_Name())
				Register_Prox(unit, PROX_Juggernaut_Load, 250, empire)
			end
			if unit.Get_Type().Get_Name() == "HAV_JUGGERNAUT" then
				unit.Suspend_Locomotor(true)
				Create_Thread("Move_Jug", unit)					
				Register_Attacked_Event(unit, Juggernaut_Attacked_Callback)
			end
		end
	end
end

function Move_Jug(juggernaut)
	garrison_list = juggernaut.Get_Garrisoned_Units()
	garrison_count = table.getn(garrison_list)
	if garrison_count >= 3 then
		juggernaut.Suspend_Locomotor(false)
		Create_Thread("Hunt_Underworld", juggernaut)
		--MessageBox("Hunting Underworld!  Total Garrisons = %d", garrison_count)
	else
		--MessageBox("Not enough garrisons to hunt!  Total Garrisons = %d", garrison_count)
		Sleep(5)
		Create_Thread("Move_Jug", juggernaut)
	end
end

function Juggernaut_Attacked_Callback(fell_under_attack, most_deadly_enemy, victim)
	--MessageBox("Juggernaut Attacked!")
	victim_garrison_list = victim.Get_Garrisoned_Units()
	victim_garrison_count = table.getn(victim_garrison_list)
	if victim_garrison_count > 0 then
		for k, unit in pairs(victim_garrison_list) do
			if TestValid(unit) then
				unit.Leave_Garrison()
				--unit.Attack_Move(most_deadly_enemy[1].Get_Position())
			end
		end
	end
end

function Callback_Hunt_Underworld(new_list)
	for k, unit in pairs(new_list) do
		if TestValid(unit) then
			Create_Thread("Hunt_Underworld", unit)
		end
	end
end

function Hunt_Underworld(attacker)
	
	while TestValid(attacker) and attacker.Get_Owner() ~= underworld do
		closest_enemy = Find_Nearest(attacker, underworld, true)	
		if TestValid(closest_enemy) then
			attacker.Attack_Move(closest_enemy)
		end
		Sleep(5)
	end
end

function Story_Mode_Service()

	if not droid_objective_achieved and droids_returned >= 8 then
		droid_objective_achieved = true
		--MessageBox("All 8 Droids returned.")
		Story_Event("TRIGGER_MISSION_07_DROIDS_RETURNED")
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_22")
		--Urai Fen: Tyber, we've collected enough gas.  All droids are returning to the shuttle.
		objectives_achieved = objectives_achieved + 1
		
		--GAS_COLLECTION_DROID
		gas_droids_list = Find_All_Objects_Of_Type("GAS_COLLECTION_DROID")
		for i, gas_droid in pairs(gas_droids_list) do
			Create_Thread("Thread_Droids_Return_To_Shuttle", gas_droid)
		end
		
		
	end
	
	if not outpost_objective_achieved and outposts_tripped >= 4 then
		outpost_objective_achieved = true
		--MessageBox("All Outposts Visited.")
		Story_Event("TRIGGER_MISSION_07_EVIDENCE_PLANTED")
		
		objectives_achieved = objectives_achieved + 1
	end
	
	if not final_objective_triggered and objectives_achieved >= 3 then
		final_objective_triggered = true
		--MessageBox("3 objectives triggered.")
		
		Story_Event("TRIGGER_MISSION_07_FINAL_OBJECTIVE")
	end
	
	if mission_started and not end_cinematic_started then
		if not TestValid(tyber) then
			Story_Event("TYBER_KILLED")
		end
		if not TestValid(ig88) then
			Story_Event("IG88_KILLED")
		end
		if not TestValid(urai) then
			Story_Event("URAI_KILLED")
		end
	
		droids_list = Find_All_Objects_Of_Type("GAS_COLLECTION_DROID")
		--full_droids_list = Find_All_Objects_Of_Type("GAS_COLLECTION_DROID_FULL")
		
		current_droids_count = table.getn(droids_list)
		if current_droids_count < current_droids_alive then
			--Story_Event("TEXT_UW_ACT02_M07_19")
			if not droid_objective_achieved then
            if create_droid_lost_message then
			    Create_Thread("Droid_Lost_Message")
            end
			end
		end
		
		if not droid_objective_achieved and current_droids_alive <= 2 and not droid_warning then
			droid_warning = true
			Story_Event("TEXT_SPEECH_UW_ACT02_M07_20")
		end
		if not droid_objective_achieved and current_droids_alive == 0 and not droid_objective_achieved then
			Story_Event("TEXT_SPEECH_UW_ACT02_M07_21")
			Story_Event("ALL_DROIDS_DEAD")
		end
	end
	
	if not vader_landed and objectives_achieved == 2 then
		vader_landed = true
		Sleep(10)
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_24")
		Create_Thread("Reinforce_Vader")
	end
	
	if objectives_achieved == 3 then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_30")
	end
					
	tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
	urai = Find_First_Object("URAI_FEN")
	ig88 = Find_First_Object("IG-88")
end

function Thread_Droids_Return_To_Shuttle(local_droid)
	if TestValid(local_droid) then
		local_droid.Set_Selectable(false)
		BlockOnCommand(local_droid.Move_To(unit_spawn_loc))
		local_droid.Despawn()
		
	end
end

function Droid_Lost_Message()
    create_droid_lost_message = false
	Sleep(1)
	
	droids_list = Find_All_Objects_Of_Type("GAS_COLLECTION_DROID")
	--full_droids_list = Find_All_Objects_Of_Type("GAS_COLLECTION_DROID_FULL")
	current_droids_count = table.getn(droids_list)
	if current_droids_count < current_droids_alive then
		Story_Event("TEXT_UW_ACT02_M07_19")
	end
	
	current_droids_alive = current_droids_count
    create_droid_lost_message = true
end

function Reinforce_Vader()
	Sleep (10)
	Fade_Screen_Out(1)
	Create_Thread("Vader_Midtro")
end

function State_Underworld_A02M07_Speech_Line_24_Remove_Text(message)
	if message == OnEnter then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_25")
	end
end

function PROX_Gas_Refinery(prox_obj, trigger_obj)
	if not droid_objective_achieved then
		if trigger_obj.Get_Type().Get_Name() == "GAS_COLLECTION_DROID"  then 
			if gas_droid_full[trigger_obj] then
				return
			end
			
			  prox_obj.Cancel_Event_Object_In_Range(PROX_Gas_Refinery)
			  --MessageBox("Droid tripped Refinery prox event.")
			  
			prox_obj.Highlight(false)
			Create_Thread("Remove_Refinery_Blip", prox_obj)
			
			Create_Thread("Regenerate_Refinery_Gas", prox_obj) 
			Story_Event("TEXT_SPEECH_UW_ACT02_M07_15")
			--Gas Cargo Droid: Acquiring gas…
			local thread_info = {}
			thread_info[1] = trigger_obj
			thread_info[2] = prox_obj
			
			Create_Thread("Fill_Droid_Up", thread_info)
		end
	end
end

function Fill_Droid_Up(thread_info)
	if not droid_objective_achieved then
		local droid = thread_info[1]
		local refinery = thread_info[2]
		
		droid.Set_Cannot_Be_Killed(true)
		droid.Set_Selectable(false)
		--Sleep(6)
		--play refinery filling up anim here 
		--List of the refineries animation states 
			--Cinematic_00 – full state
			--Cinematic_01 – draining animation
			--Cinematic_02 – empty state
			--Cinematic_03 – filling state
			--BlockOnCommand(refinery.Play_Animation("Cinematic", false, 1))
			--Sleep(6)
			--Play_Refinery_Empties_Animation(refinery)
			--Play_Droid_Fills_Animation(droid)
			
			Create_Thread("Thread_Play_Refinery_Empties_Animation", refinery)
			Create_Thread("Thread_Play_Droid_Fills_Animation", droid)
		
		--if TestValid(droid) then
			--full_droid = Spawn_Unit(Find_Object_Type("GAS_COLLECTION_DROID_FULL"), droid, underworld)
			--full_droid[1].Teleport_And_Face(droid)
			--droid.Despawn()
			--refinery.Play_Animation("Cinematic", true, 2)
			--Story_Event("TEXT_SPEECH_UW_ACT02_M07_16")
		--end
	end
end

function Thread_Play_Refinery_Empties_Animation(local_refinery)
	--local_refinery.Play_Animation("Cinematic", false, 1)
	BlockOnCommand(local_refinery.Play_Animation("Cinematic", false, 1)) 
	
	if TestValid(local_refinery) then
		local_refinery.Play_Animation("Cinematic", true, 2)
	end
end

function Thread_Play_Droid_Fills_Animation(local_droid)
	BlockOnCommand(local_droid.Play_Animation("Cinematic", false, 4)) --should be anim of bot filling up with gas
	
	if TestValid(local_droid) then
		local_droid.Play_Animation("Cinematic", false, 1) -- should be anim of idle with gas
		local_droid.Set_Cannot_Be_Killed(false)
		local_droid.Set_Selectable(true)
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_16")
		
		gas_droid_full[local_droid] = true
	end
end

function Remove_Refinery_Blip(refinery)
	if refinery == refinery01 then
		Remove_Radar_Blip("refinery1_blip")
	end
	if refinery == refinery02 then
		Remove_Radar_Blip("refinery2_blip")
	end
	if refinery == refinery03 then
		Remove_Radar_Blip("refinery3_blip")
	end
	if refinery == refinery04 then
		Remove_Radar_Blip("refinery4_blip")
	end
	if refinery == refinery05 then
		Remove_Radar_Blip("refinery5_blip")
	end
	if refinery == refinery06 then
		Remove_Radar_Blip("refinery6_blip")
	end
	if refinery == refinery07 then
		Remove_Radar_Blip("refinery7_blip")
	end
	if refinery == refinery08 then
		Remove_Radar_Blip("refinery8_blip")
	end
end

function Add_Refinery_Blip(refinery)
	if refinery == refinery01 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery1_blip")
	end
	if refinery == refinery02 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery2_blip")
	end
	if refinery == refinery03 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery3_blip")
	end
	if refinery == refinery04 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery4_blip")
	end
	if refinery == refinery05 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery5_blip")
	end
	if refinery == refinery06 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery6_blip")
	end
	if refinery == refinery07 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery7_blip")
	end
	if refinery == refinery08 then
		refinery.Highlight(true)
		--Add_Radar_Blip(refinery, "refinery8_blip")
	end
end

function Regenerate_Refinery_Gas(refinery)
	--Sleep(300)		
	
	Sleep(30)		
	
		--List of the refineries animation states
		--Cinematic_00 – full state
		--Cinematic_01 – draining animation
		--Cinematic_02 – empty state
		--Cinematic_03 – filling state
		
	BlockOnCommand(refinery.Play_Animation("Cinematic", false, 3)) --Cinematic_03 – filling state 
	refinery.Play_Animation("Cinematic", true, 0) --Cinematic_00 – full state
	
	Create_Thread("Add_Refinery_Blip", refinery)
	Register_Prox(refinery, PROX_Gas_Refinery, 75, underworld)
end

function PROX_Droid_Return(prox_obj, trigger_obj)
	if not droid_objective_achieved then
		if trigger_obj.Get_Type().Get_Name() == "GAS_COLLECTION_DROID"  then
			if not gas_droid_full[trigger_obj] then
				return
			end
		
			prox_obj.Cancel_Event_Object_In_Range(PROX_Droid_Return)
			
			trigger_obj.Set_Selectable(false)
			Story_Event("TEXT_SPEECH_UW_ACT02_M07_17")
			  --Gas Cargo Droid: Transferring gas…
			  --MessageBox("Droid tripped shuttle prox event, droids returned = %d", droids_returned)
			  Create_Thread("Gas_Droid_Returned", trigger_obj)        
			end
			
			gas_droid_full[trigger_obj] = false
	end
end

function Gas_Droid_Returned(full_droid)
	full_droid.Set_Cannot_Be_Killed(true)
	--MessageBox("function Gas_Droid_Returned(full_droid) HIT!!")
	--Sleep(6)
	
	if TestValid(full_droid) then
		--empty_droid = Spawn_Unit(Find_Object_Type("GAS_COLLECTION_DROID"), full_droid, underworld)
		--empty_droid[1].Teleport_And_Face(full_droid)
		--full_droid.Despawn()
		BlockOnCommand(full_droid.Play_Animation("Cinematic", false, 5)) --should be anim of bot emptying the gas
      full_droid.Play_Animation("Cinematic", true, 3)  --should be move anim with no gas
		full_droid.Set_Selectable(true)
		
		droids_returned = droids_returned + 1
		
		if droids_returned == 1 then
			--MessageBox("droids_returned == 1")
			Story_Event("UM07_SEVEN_CONTAINERS_LEFT")
		elseif droids_returned == 2 then
			Story_Event("UM07_SIX_CONTAINERS_LEFT")
		elseif droids_returned == 3 then
			Story_Event("UM07_FIVE_CONTAINERS_LEFT")
		elseif droids_returned == 4 then
			Story_Event("UM07_FOUR_CONTAINERS_LEFT")
		elseif droids_returned == 5 then
			Story_Event("UM07_THREE_CONTAINERS_LEFT")
		elseif droids_returned == 6 then
			Story_Event("UM07_TWO_CONTAINERS_LEFT")
		elseif droids_returned == 7 then
			Story_Event("UM07_ONE_CONTAINER_LEFT")
		elseif droids_returned == 8 then
			
		end
		
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_18")
		Register_Prox(tyber_shuttle, PROX_Droid_Return, 95, underworld)
	end
end

function PROX_Server_Notification(prox_obj, trigger_obj)
	--if trigger_obj.Get_Type().Get_Name() == "IG-88"  then 
	if trigger_obj.Get_Owner() == underworld then
		prox_obj.Cancel_Event_Object_In_Range(PROX_Server_Notification)
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_12")
		
		server = Find_Hint("DROID_INTERFACE_STATION","server")
		server.Highlight(true)
		Add_Radar_Blip(server, "server_blip")
		FogOfWar.Reveal(underworld, server, 250,250)
	end
end

function PROX_Bespin_Server(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "IG-88"  then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Bespin_Server)
        --MessageBox("IG-88 tripped Server prox event.")
        
        Story_Event("TEXT_SPEECH_UW_ACT02_M07_13")
        --ig88.Suspend_Locomotor(true)
        Create_Thread("IG88_Acquire_Data", prox_obj)
	end
end

function IG88_Acquire_Data(server)
	--Sleep(10)
	if TestValid(ig88) then
		server_flag = Find_Hint("MARKER_GENERIC_YELLOW","server-flag")	
		
		ig88.Set_Cannot_Be_Killed(true)
		ig88.Set_Selectable(false)
		

		if not TestValid(server_flag) then
			MessageBox("not TestValid(server_flag)")
		else
			BlockOnCommand(ig88.Move_To(server_flag))
			ig88.Turn_To_Face(server)
		end
		
		server.Highlight(false)
		Remove_Radar_Blip("server_blip")
	    
		Sleep(1)
		Story_Event("TRIGGER_MISSION_07_SERVER_HACKED")
		Sleep(1)
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_14")
		ig88.Set_Cannot_Be_Killed(false)
		ig88.Set_Selectable(true)
	    
		objectives_achieved = objectives_achieved + 1
	end
end

function PROX_Guard_Outpost(prox_obj, trigger_obj)
	--MessageBox("Prox Tripped by: %s", trigger_obj.Get_Type().Get_Name())
	if trigger_obj.Get_Type().Get_Name() == "TYBER_ZANN_PASSENGER"  then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Guard_Outpost)
		
		outposts_discovered[prox_obj] = true
		
		local thread_info = {}
		thread_info[1] = trigger_obj
		thread_info[2] = prox_obj
		Create_Thread("Thread_Guard_Outpost", thread_info)
		
		if bool_first_security_outpost == false then
			prox_obj.Highlight(false)
		end
		
	end
end

function Thread_Guard_Outpost(thread_info)
	local local_tyber = thread_info[1]
	local local_outpost = thread_info[2]
	
	if local_outpost == outpost1 then
		terminal_flag= Find_Hint("MARKER_GENERIC_YELLOW","outpost01-flag")	
		outpost_console = Find_Hint("MARKER_GENERIC_GREEN","outpost01-console")
	elseif local_outpost == outpost2 then
		terminal_flag= Find_Hint("MARKER_GENERIC_YELLOW","outpost02-flag")
		outpost_console = Find_Hint("MARKER_GENERIC_GREEN","outpost02-console")
	elseif local_outpost == outpost3 then
		terminal_flag= Find_Hint("MARKER_GENERIC_YELLOW","outpost03-flag")
		outpost_console = Find_Hint("MARKER_GENERIC_GREEN","outpost03-console")
	else
		terminal_flag= Find_Hint("MARKER_GENERIC_YELLOW","outpost04-flag")
		outpost_console = Find_Hint("MARKER_GENERIC_GREEN","outpost04-console")
	end
	
	if bool_first_security_outpost == true then
		bool_first_security_outpost = false
		--MessageBox("Story_Event(UM07_TYBER_IDENTIFIES_GUARD_OUTPOSTS)")
		Story_Event("UM07_TYBER_IDENTIFIES_GUARD_OUTPOSTS")
	end
	
	

	--prox_obj.Highlight(false)
	--Create_Thread("Remove_Outpost_Blip", prox_obj)
	local_tyber.Set_Cannot_Be_Killed(true)
	local_tyber.Set_Selectable(false)
	
	if not TestValid(local_tyber) then
		MessageBox("not local_tyber")
	end
	
	--find nearest interface node
	terminal = Find_Nearest(local_tyber, "UM07_INTERFACE_NODE")	
	--terminal_flag= Find_Nearest(local_tyber, "UM07_INTERFACE_NODE_FLAG")	
	--terminal = Find_Nearest(local_tyber, empire)	
	--if not TestValid(terminal) then
	--	MessageBox("not TestValid(terminal)")
	--else
		BlockOnCommand(local_tyber.Move_To(terminal_flag))
		--BlockOnCommand(local_tyber.Move_To(terminal))
		--BlockOnCommand(local_tyber.Turn_To_Face(terminal))
		BlockOnCommand(local_tyber.Turn_To_Face(outpost_console))
		BlockOnCommand(local_tyber.Play_Animation("Cinematic", false, 0)) --Cinematic_00 – tyber planting evidence anim
	--end
	
	
	
	

	--Sleep(5)
	outposts_tripped = outposts_tripped + 1
	if outposts_tripped == 1 then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_08")
		Sleep(3)
		Story_Event("UM07_ADD_OBJECTIVE_TYBER_HACKS_GUARD_OUTPOSTS")
	elseif outposts_tripped == 2 then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_09")
		Sleep(1)
		Story_Event("UM07_TYBER_IDENTIFIES_GUARD_OUTPOSTS_UPDATE_OBJECTIVE_01")
	elseif outposts_tripped == 3 then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_10")
		Sleep(1)
		Story_Event("UM07_TYBER_IDENTIFIES_GUARD_OUTPOSTS_UPDATE_OBJECTIVE_02")
	elseif outposts_tripped == 4 then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_11")
	end
	
	local_tyber.Set_Cannot_Be_Killed(false)
	local_tyber.Set_Selectable(true)
	
	if outposts_tripped == 1 then
	--outpost_list = Find_All_Objects_Of_Type("PROP_BESPIN_BUILDING_A")
		for i, outpost in pairs(outpost_list) do
			if TestValid(outpost) and outposts_discovered[outpost] ~= true then
				outpost.Highlight(true, 100)
				Add_Radar_Blip(outpost, "outpost_blip")
			end
		end
		
		Sleep(10)
		
		for i, outpost in pairs(outpost_list) do
			--if TestValid(outpost) and outposts_discovered[outpost] ~= true then
			if TestValid(outpost) then
				Remove_Radar_Blip("outpost_blip")
			end
		end
	end
		
end

function PROX_Hero_Return(prox_obj, trigger_obj)
	if final_objective_triggered then
		if trigger_obj.Get_Type().Get_Name() == "TYBER_ZANN_PASSENGER" or
		   trigger_obj.Get_Type().Get_Name() == "URAI_FEN" or 
		   trigger_obj.Get_Type().Get_Name() == "IG-88" then
				if TestValid (tyber) then
					tyber_dist = tyber.Get_Distance(prox_obj)
				end
				if TestValid (urai) then
					urai_dist = urai.Get_Distance(prox_obj)
				end
				if TestValid (ig88) then
					ig88_dist = ig88.Get_Distance(prox_obj)
				end
				
				--MessageBox("Hero Prox triggered. tyber_dist = %d, urai_dist = %d, ig88_dist = %d.", tyber_dist, urai_dist, ig88_dist)
				
				if tyber_dist <= 275 and
				   urai_dist <= 275 and
				   ig88_dist <= 275 then
						prox_obj.Cancel_Event_Object_In_Range(PROX_Hero_Return)
						--MessageBox("All Heroes in range! Sending Victory Trigger!")
						Story_Event("TRIGGER_MISSION_07_HEROES_AT_SHUTTLE")
						Create_Thread("End_Cinematic")
				end				
		end
	end
end

function Spawn_Gas_Droid(obj)
	spawn_droid = Spawn_Unit(Find_Object_Type("GAS_COLLECTION_DROID"), Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"), underworld)
	spawn_droid[1].Teleport_And_Face(Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"))
	droid = spawn_droid[1]
	
	
	
	droid.Move_To(obj)
	
	
end

function PROX_Droid_Reached_Dest(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "GAS_COLLECTION_DROID" then
		prox_obj.Cancel_Event_Object_In_Range(PROX_Droid_Reached_Dest)
		
		Create_Thread("Thread_Droid_Reached_Dest", trigger_obj)
		
	end
end

function Thread_Droid_Reached_Dest(droid)
	droid.Stop()
	BlockOnCommand(droid.Turn_To_Face(Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn")))
	
	BlockOnCommand(droid.Play_Animation("Cinematic", false, 0)) --should be idle anim of bot with no gas
	droid.Play_Animation("Cinematic", true, 0) --should be idle anim of bot with no gas
end

-- ##########################################################################################
--	Cinematic functions
-- ##########################################################################################

function Intro_Cinematic()
	shuttle_land_loc = Find_Hint("STORY_TRIGGER_ZONE_00","shuttleland")
	tyber_temp_loc = Find_Hint("STORY_TRIGGER_ZONE_00","temploc")
	unit_spawn_loc = Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn")
	tyber_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","tybergoto0")
	tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
	
	
	
	if TestValid(tyber) then
		tyber.Teleport_And_Face(tyber_temp_loc)
		tyber.Prevent_All_Fire(true)
		--MessageBox("Tyber Reinforcement found, teleporting")
	else
		MessageBox("No Tyber Reinforcement found, spawning and teleporting")
		tyber_spawn = Spawn_Unit(Find_Object_Type("TYBER_ZANN_PASSENGER"), tyber_temp_loc, underworld)
		tyber = tyber_spawn[1]
		tyber.Prevent_All_Fire(true)
	end
	
	
	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	Fade_Screen_In(2)
	
	Cancel_Fast_Forward()
	
	-- ***********Opening Shot***************
	
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)
	opening_cinematic_transport = Create_Cinematic_Transport("Shuttle_Tyderium_Landing_Cinematic", underworld.Get_ID(), shuttle_land_loc, 60, 1, 0, 20, 1)
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	--Set_Cinematic_Camera_Key(transport, 400, 90, 0, 1, transport, 0, 1)
	Set_Cinematic_Camera_Key(shuttle_land_loc, 3000, 8, 120, 1, 0, 0, 1)
	--Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(opening_cinematic_transport, 0, 0, 0, 0, opening_cinematic_transport, 0, 1)
	
	Transition_Cinematic_Camera_Key(shuttle_land_loc, 9, 400, 15, 185, 1, 0, 0, 1)
	
	Sleep(9)
	
	cin_trooper_0 = Find_Hint("STORMTROOPER","cintrooper0")
	tyber.Teleport_And_Face(unit_spawn_loc)
	urai_spawn = Spawn_From_Reinforcement_Pool(Find_Object_Type("Urai_Fen_Team"), tyber_temp_loc, underworld)
	urai = urai_spawn[1]
	urai.Suspend_Locomotor(true)
	Allow_Localized_SFX(false)
	urai.Activate_Ability("STEALTH", true)
	
	Transition_Cinematic_Camera_Key(shuttle_land_loc, 0, 400, 40, -45, 1, 0, 1, 1)
	Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, tyber, 0, 0)
	tyber.Move_To(tyber_goto_0)
	Transition_Cinematic_Camera_Key(tyber_goto_0, 6, 450, 25, -90, 1, 0, 1, 1)
	Sleep(3)
	tyber.Turn_To_Face(unit_spawn_loc)
	Allow_Localized_SFX(true)
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_36")
	
	droid_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto0")
	droid_goto_1 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto1")
	droid_goto_2 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto2")
	droid_goto_3 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto3")
	droid_goto_4 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto4")
	
	Register_Prox(droid_goto_0, PROX_Droid_Reached_Dest, 5, underworld)
	Register_Prox(droid_goto_1, PROX_Droid_Reached_Dest, 5, underworld)
	Register_Prox(droid_goto_2, PROX_Droid_Reached_Dest, 5, underworld)
	Register_Prox(droid_goto_3, PROX_Droid_Reached_Dest, 5, underworld)
	Register_Prox(droid_goto_4, PROX_Droid_Reached_Dest, 5, underworld)
	
	Create_Thread("Spawn_Gas_Droid", droid_goto_4)
	bool_Gas_Droid04_Spawned = true
	Sleep(2)
	
	trooper_goto = Find_Hint("STORY_TRIGGER_ZONE_00","troopergoto")
	cin_trooper_0.Suspend_Locomotor(false)
	cin_trooper_0.Move_To(trooper_goto)
	
	Create_Thread("Spawn_Gas_Droid", droid_goto_3)
	bool_Gas_Droid03_Spawned = true
	Sleep(2)
	
	Sleep(2)
	
	tyber.Turn_To_Face(cin_trooper_0)
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_00")
	
	Create_Thread("Spawn_Gas_Droid", droid_goto_2)
	bool_Gas_Droid02_Spawned = true
	Sleep(2)
	Create_Thread("Spawn_Gas_Droid", droid_goto_1)
	bool_Gas_Droid01_Spawned = true
	Sleep(2)
	spawn_ig88 = Spawn_Unit(Find_Object_Type("IG-88"), Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"), underworld)
	spawn_ig88[1].Teleport_And_Face(Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"))
	ig_88 = spawn_ig88[1]
	
	ig_88.Prevent_All_Fire(true)
	ig_88.Move_To(Find_Hint("STORY_TRIGGER_ZONE_00","ig88goto"))
	Sleep(2)
	Create_Thread("Spawn_Gas_Droid", droid_goto_0)
	bool_Gas_Droid00_Spawned = true
	Sleep(1)
	ig_88.Turn_To_Face(tyber)
	
end

function State_Underworld_A02M07_Speech_Line_00_Remove_Text(message)
	if message == OnEnter then
		
		--MessageBox("State_Underworld_A02M07_Speech_Line_00_Remove_Text  HIT!!")
		Transition_Cinematic_Camera_Key(cin_trooper_0, 0, 100, 15, 180, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_01")
		--TYBER ZANN: You don’t need to see my identification.
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on tyber
	end
end

function State_Underworld_A02M07_Speech_Line_01_Remove_Text(message)
	if message == OnEnter then
		
		--MessageBox("State_Underworld_A02M07_Speech_Line_01_Remove_Text  HIT!!")
		Transition_Cinematic_Camera_Key(tyber, 0, 100, 15, 0, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(cin_trooper_0, 0, 0, 0, 0, 0, 0, 0, 0)
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_02")
		--STORMTROOPER: This one thinks he’s a Jedi.  And why wouldn’t I need to see your identification?
	end
end

function State_Underworld_A02M07_Speech_Line_02_Remove_Text(message)
	if message == OnEnter then
		
		--Transition_Cinematic_Camera_Key(tyber, 0, 100, 15, 180, 1, 0, 1, 0)
		--Transition_Cinematic_Target_Key(cin_trooper_0, 0, 0, 0, 0, 0, 0, 0, 0)
		--MessageBox("State_Underworld_A02M07_Speech_Line_02_Remove_Text  HIT!!")
		
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_03")
		--TYBER ZANN: Because you're dead.  
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on tyber
		
		urai_kill_spot = Find_Hint("STORY_TRIGGER_ZONE_00","uraikill")
		urai.Prevent_All_Fire(true)
		urai.Hide(true)
		urai.Teleport_And_Face(urai_kill_spot)
	end
end

function State_Underworld_A02M07_Speech_Line_03_Remove_Text(message)
	if message == OnEnter then
		
		--Transition_Cinematic_Camera_Key(tyber, 0, 100, 15, 180, 1, 0, 1, 0)
		--Transition_Cinematic_Target_Key(cin_trooper_0, 0, 0, 0, 0, 0, 0, 0, 0)
		
		--Story_Event("TEXT_SPEECH_UW_ACT02_M07_03")
		--Sleep(.5)
		urai.Play_Animation("Attack", false, 1)
		urai.Hide(false)
		urai.Activate_Ability("STEALTH", false)
		Sleep(.30)
		cin_trooper_0.Turn_To_Face(urai)		
		Sleep(.45)
		if TestValid(cin_trooper_0) then
			cin_trooper_0.Take_Damage(50000)
		end

		if TestValid(cin_trooper_1) then
			cin_trooper_1.Suspend_Locomotor(false)
			cin_trooper_1.Prevent_All_Fire(false)
		end
		tyber.Prevent_All_Fire(false)
		
		if TestValid(tyber) and TestValid(cin_trooper_1) then
			tyber.Attack_Move(cin_trooper_1)
		end
		
		Sleep(3)
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_04")
		Transition_Cinematic_Camera_Key(tyber, 0, 100, 15, 0, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
		Sleep(1)
		BlockOnCommand( tyber.Turn_To_Face(urai))
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on tyber
	end
end

function State_Underworld_A02M07_Speech_Line_04_Remove_Text(message)
	if message == OnEnter then
	--Urai Fen: Each Tibanna gas collection facility is surrounded by four refineries.  
	--I will need to escort the gas droids to the refineries and they will procure the gas.  
	--We will need to return eight full droids for this mission to be a success.
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_05")
		--Transition_Cinematic_Camera_Key(urai, 5, 100, 15, 0, 1, 0, 1, 0)
		--Transition_Cinematic_Target_Key(urai, 3, 0, 0, 0, 0, 0, 0, 0)
		
		urai.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on urai
		
		--Sleep(1)
		refinery_flyover = Find_Hint("STORY_TRIGGER_ZONE_00", "refineryflyover")
		Transition_Cinematic_Camera_Key(refinery_flyover, 6, 1000, 15, 180, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(refinery_flyover, 10, 0, 0, 0, 0, 0, 0, 0)
		
		Sleep(3.5)
		Transition_Cinematic_Camera_Key(refinery_flyover, 6, 1000, 15, 90, 1, 0, 1, 0)
	end
end

function State_Underworld_A02M07_Speech_Line_05_Remove_Text(message)
	if message == OnEnter then
		Transition_Cinematic_Camera_Key(ig88, 0, 100, 15, 180, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(ig88, 0, 0, 0, 0, 0, 0, 0, 0)
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_06")
		--IG-88: I'll find the needed planetary security codes by hacking into Bespin's central server cluster. It should only take a few nanoseconds. 
	end
end

function State_Underworld_A02M07_Speech_Line_06_Remove_Text(message)
	if message == OnEnter then
		Transition_Cinematic_Camera_Key(tyber, 0, 100, 15, 0, 1, 0, 1, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
		
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_07")
		--Tyber Zann: In order to make this look like a Black Sun operation, 
		--I'll need to sneak into the four security outposts and plant information that leaves no doubt that Xizor alone was behind the theft of the Tibanna gas.
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on tyber
	end
end

function State_Underworld_A02M07_Speech_Line_07_Remove_Text(message)
	if message == OnEnter then
	
		Create_Thread("Exit_Cinematic")
		
	end
end

function Exit_Cinematic()
	--MessageBox("Exit_Cinematic HIT!")
	current_cinematic_thread = nil
	
	urai.Suspend_Locomotor(false)
	urai.Prevent_All_Fire(false)
	ig_88.Prevent_All_Fire(false)
		
	Transition_To_Tactical_Camera(3)
	Sleep(2)	
	Letter_Box_Out(1)
	Sleep(1)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Suspend_AI(0)
	
	point_guard_list = Find_All_Objects_With_Hint("pointguard")
	for i, point_guard in pairs(point_guard_list) do
		point_guard.Prevent_AI_Usage(true)
		point_guard.Guard_Target(point_guard.Get_Position())
	end
	
	
	
	mission_started = true
	
	
	refinery_list = Find_All_Objects_Of_Type("UM07_CLOUDCITY_REFINERY")
	for i, refinery in pairs(refinery_list) do
		refinery.Highlight(true)
		Add_Radar_Blip(refinery, "refinery_blip")
	end	
	
	Sleep(30)
	
	for i, refinery in pairs(refinery_list) do
		Remove_Radar_Blip("refinery_blip")
	end	

	Sleep(10)
	if flag_no_enemy_reinforcements == false then
		Create_Thread("Reinforce_Empire_Units")
	end
end

function Story_Handle_Esc()
	if current_cinematic_thread ~= nil then
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil
		Create_Thread("End_Camera")
		Story_Event("UM07_ESCAPEKEY_PREVENT_INTRO_DIALOG_AI_NOTIFICATION")
	end
end

function End_Camera()
	Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()

	--set up actors final positions here
	shuttle_land_loc = Find_Hint("STORY_TRIGGER_ZONE_00","shuttleland")
	tyber_temp_loc = Find_Hint("STORY_TRIGGER_ZONE_00","temploc")
	unit_spawn_loc = Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn")
	tyber_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","tybergoto0")
	tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
	urai_kill_spot = Find_Hint("STORY_TRIGGER_ZONE_00","uraikill")
	
	--manipulate opening shuttle here...
	if TestValid(opening_cinematic_transport) then
		opening_cinematic_transport.Despawn()
	end
	
	opening_cinematic_transport = Create_Cinematic_Transport("Shuttle_Tyderium_Landing_Cinematic", underworld.Get_ID(), shuttle_land_loc, 60, 1, 1, 20, 1)
	
	cin_trooper_0 = Find_Hint("STORMTROOPER","cintrooper0")
	if TestValid(cin_trooper_0) then
		cin_trooper_0.Despawn()
	end
	
	cin_trooper_1 = Find_Hint("STORMTROOPER","cintrooper1")
	if TestValid(cin_trooper_1) then
		cin_trooper_1.Despawn()
	end


	if TestValid(tyber) then
		tyber.Teleport_And_Face(tyber_goto_0)
		tyber.Prevent_All_Fire(false)
		--MessageBox("Tyber Reinforcement found, teleporting")
	else
		MessageBox("No Tyber Reinforcement found, spawning and teleporting")
		--tyber_spawn = Spawn_Unit(Find_Object_Type("TYBER_ZANN_PASSENGER"), tyber_temp_loc, underworld)
		tyber_spawn = Spawn_Unit(Find_Object_Type("TYBER_ZANN_PASSENGER"), tyber_goto_0, underworld)
		tyber = tyber_spawn[1]
		tyber.Prevent_All_Fire(true)
	end
	
	if not TestValid(urai) then
		urai_spawn = Spawn_From_Reinforcement_Pool(Find_Object_Type("Urai_Fen_Team"), urai_kill_spot, underworld)
		urai = urai_spawn[1]
	end
		
		
	
	urai.Hide(false)
	urai.Teleport_And_Face(urai_kill_spot)
	urai.Activate_Ability("STEALTH", false)
	
	
	if not TestValid(ig_88) then
		spawn_ig88 = Spawn_Unit(Find_Object_Type("IG-88"), Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"), underworld)
		spawn_ig88[1].Teleport_And_Face(Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn"))
		ig_88 = spawn_ig88[1]
	end
	
	ig_88.Move_To(Find_Hint("STORY_TRIGGER_ZONE_00","ig88goto"))


	droid_goto_0 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto0")
	droid_goto_1 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto1")
	droid_goto_2 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto2")
	droid_goto_3 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto3")
	droid_goto_4 = Find_Hint("STORY_TRIGGER_ZONE_00","droidgoto4")
	
	
	if bool_Gas_Droid04_Spawned == false then
		Create_Thread("Spawn_Gas_Droid", droid_goto_4)
		bool_Gas_Droid04_Spawned = true
		Register_Prox(droid_goto_4, PROX_Droid_Reached_Dest, 5, underworld)
	end
	if bool_Gas_Droid03_Spawned == false then
		Create_Thread("Spawn_Gas_Droid", droid_goto_3)
		bool_Gas_Droid03_Spawned = true
		Register_Prox(droid_goto_3, PROX_Droid_Reached_Dest, 5, underworld)
	end
	if bool_Gas_Droid02_Spawned == false then
		Create_Thread("Spawn_Gas_Droid", droid_goto_2)
		bool_Gas_Droid02_Spawned = true
		Register_Prox(droid_goto_2, PROX_Droid_Reached_Dest, 5, underworld)
	end
	if bool_Gas_Droid01_Spawned == false then
		Create_Thread("Spawn_Gas_Droid", droid_goto_1)
		bool_Gas_Droid01_Spawned = true
		Register_Prox(droid_goto_1, PROX_Droid_Reached_Dest, 5, underworld)
	end
	if bool_Gas_Droid00_Spawned == false then
		Create_Thread("Spawn_Gas_Droid", droid_goto_0)
		bool_Gas_Droid00_Spawned = true
		Register_Prox(droid_goto_0, PROX_Droid_Reached_Dest, 5, underworld)
	end

	
	
	
	Fade_Screen_In(2)
	--MessageBox("Exit_Cinematic")
	Create_Thread("Exit_Cinematic")

	
	
	
	--Create_Thread("Thread_DeathMonitor_TurboPower")

	Lock_Controls(0)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	Suspend_AI(0)
	
	Weather_Audio_Pause(false)
	Allow_Localized_SFX(true)
	Resume_Mode_Based_Music()

	Transition_To_Tactical_Camera(2)
	Letter_Box_Out(2)
	Sleep(2)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Suspend_AI(0)
	
end

function Vader_Midtro()
	vader_shuttle_land_loc = Find_Hint("STORY_TRIGGER_ZONE_00","vaderland")
	vader_guard_spawn_loc = Find_Hint("STORY_TRIGGER_ZONE_00","vaderguardspawn")
	vader_spawn_0 = Find_Hint("STORY_TRIGGER_ZONE_00","vaderspawn0")
	vader_spawn_1 = Find_Hint("STORY_TRIGGER_ZONE_00","vaderspawn1")
	commander_goto = Find_Hint("STORY_TRIGGER_ZONE_00","commandergoto")
	vader_goto = Find_Hint("STORY_TRIGGER_ZONE_00","vadergoto")
	
	--imperial guard definitions
	imp_guard01_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard01")
	imp_guard02_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard02")
	imp_guard03_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard03")
	imp_guard04_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard04")
	imp_guard05_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard05")
	imp_guard06_spawn_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard06")
	
	imp_guard01_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard01-teleport")
	imp_guard02_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard02-teleport")
	imp_guard03_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard03-teleport")
	imp_guard04_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard04-teleport")
	imp_guard05_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard05-teleport")
	imp_guard06_teleport_loc = Find_Hint("MARKER_GENERIC_GREEN","imp-guard06-teleport")
	
	imp_guard01_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard01_spawn_loc, neutral)
	imp_guard01 = imp_guard01_list[1]
	imp_guard01.Teleport_And_Face(imp_guard01_spawn_loc)
	imp_guard01.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	imp_guard02_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard02_spawn_loc, neutral)
	imp_guard02 = imp_guard02_list[1]
	imp_guard02.Teleport_And_Face(imp_guard02_spawn_loc)
	imp_guard02.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	imp_guard03_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard03_spawn_loc, neutral)
	imp_guard03 = imp_guard03_list[1]
	imp_guard03.Teleport_And_Face(imp_guard03_spawn_loc)
	imp_guard03.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	imp_guard04_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard04_spawn_loc, neutral)
	imp_guard04 = imp_guard04_list[1]
	imp_guard04.Teleport_And_Face(imp_guard04_spawn_loc)
	imp_guard04.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	imp_guard05_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard05_spawn_loc, neutral)
	imp_guard05 = imp_guard05_list[1]
	imp_guard05.Teleport_And_Face(imp_guard05_spawn_loc)
	imp_guard05.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	imp_guard06_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), imp_guard06_spawn_loc, neutral)
	imp_guard06 = imp_guard06_list[1]
	imp_guard06.Teleport_And_Face(imp_guard06_spawn_loc)
	imp_guard06.Suspend_Locomotor(true)
	imp_guard01.Prevent_AI_Usage(true)
	imp_guard01.Prevent_Opportunity_Fire(true)
	
	
	
	cine_field_commander_list = Spawn_Unit(Find_Object_Type("GENERIC_FIELD_COMMANDER_EMPIRE"), vader_guard_spawn_loc, neutral)
	cine_field_commander = cine_field_commander_list[1]
	cine_field_commander.Make_Invulnerable(true)
	cine_field_commander.Teleport_And_Face(vader_guard_spawn_loc)
	
	-- Turn off opportunity fire for all units.
	empire_list = Find_All_Objects_Of_Type(empire)
	underworld_list = Find_All_Objects_Of_Type(underworld)
	
	for k, unit in pairs(empire_list) do
		if TestValid(unit) and unit ~= cine_field_commander then
			unit.Suspend_Locomotor(true)
			unit.Prevent_All_Fire(true)
		end
	end
	
	for k, unit in pairs(underworld_list) do
		if TestValid(unit) then
			unit.Suspend_Locomotor(true)
			unit.Prevent_All_Fire(true)
		end
	end
	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	Fade_Screen_In(2)
	
	Cancel_Fast_Forward()
	
	-- ***********Opening Shot***************
	
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)
	vader_transport = Create_Cinematic_Transport("Shuttle_Tyderium_Landing_Cinematic", empire.Get_ID(), vader_shuttle_land_loc, -85, 1, 0, 20, 1)
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(vader_transport, 1800, 60, 180, 1, 0, 0, 1)
	--Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(vader_spawn_0, 0, 0, 0, 0, vader_spawn_0, 0, 1)
	
	Transition_Cinematic_Camera_Key(vader_spawn_0, 13, 200, 25, 100, 1, 0, 0, 1)
	Transition_Cinematic_Target_Key(vader_guard_spawn_loc, 7, 0, 0, 0, 0, vader_spawn_0, 0, 1)
	Sleep(7)
	vader_list = Spawn_Unit(Find_Object_Type("DARTH_VADER"), vader_spawn_0, neutral)
	vader = vader_list[1]
	vader.Prevent_AI_Usage(true)
	vader.Prevent_Opportunity_Fire(true)
	vader.Move_To(vader_goto)
	cine_field_commander.Move_To(commander_goto)
	Sleep(2.5)
	
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_26")
end
	
function State_Underworld_A02M07_Speech_Line_26_Remove_Text(message)
	if message == OnEnter then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_27")
	end
end

function State_Underworld_A02M07_Speech_Line_27_Remove_Text(message)
	if message == OnEnter then
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_28")
		--FIELD COMMANDER: Sir, we're in trying to capture them as we speak, but they…

	end
end



function State_Underworld_A02M07_Speech_Line_28_Remove_Text(message)
	if message == OnEnter then
		vader.Play_Animation("Choke", false)
		cine_field_commander.Play_Animation("Choke_Die", false)
		Sleep(0.25)
		
		Story_Event("UM07_VaderCine_Start_Choking_SFX_AI_NOTIFICATION")
		
	end
end

function State_UM07_VaderCine_Choking_SFX_Over(message)
	if message == OnEnter then
		cine_field_commander.Make_Invulnerable(false)
		cine_field_commander.Take_Damage(50000)
		Story_Event("TEXT_SPEECH_UW_ACT02_M07_29")
		--DARTH VADER: I'm severely displeased with your incompetance.  I will see to these thieves myself.
	end
end

function State_Underworld_A02M07_Speech_Line_29_Remove_Text(message)
	if message == OnEnter then		
		Fade_Screen_Out(1)
		Sleep(1)
		
		
		
		
		
		
		--[[vader.Prevent_AI_Usage(false)
		vader.Prevent_Opportunity_Fire(false)
		vader.Teleport_And_Face(vader_spawn_1)
		Create_Thread("Hunt_Underworld", vader)
		
		imp_guard01.Teleport_And_Face(imp_guard01_teleport_loc)
		imp_guard01.Suspend_Locomotor(false)
		imp_guard01.Prevent_AI_Usage(false)
		imp_guard01.Prevent_Opportunity_Fire(false)
		imp_guard01.Guard_Target(vader)
		

		imp_guard02.Teleport_And_Face(imp_guard02_teleport_loc)
		imp_guard02.Suspend_Locomotor(false)
		imp_guard02.Prevent_AI_Usage(false)
		imp_guard02.Prevent_Opportunity_Fire(false)
		imp_guard02.Guard_Target(vader)
		

		imp_guard03.Teleport_And_Face(imp_guard03_teleport_loc)
		imp_guard03.Suspend_Locomotor(false)
		imp_guard03.Prevent_AI_Usage(false)
		imp_guard03.Prevent_Opportunity_Fire(false)
		imp_guard03.Guard_Target(vader)
		

		imp_guard04.Teleport_And_Face(imp_guard04_teleport_loc)
		imp_guard04.Suspend_Locomotor(false)
		imp_guard04.Prevent_AI_Usage(false)
		imp_guard04.Prevent_Opportunity_Fire(false)
		imp_guard04.Guard_Target(vader)
		

		imp_guard05.Teleport_And_Face(imp_guard05_teleport_loc)
		imp_guard05.Suspend_Locomotor(false)
		imp_guard05.Prevent_AI_Usage(false)
		imp_guard05.Prevent_Opportunity_Fire(false)
		imp_guard05.Guard_Target(vader)
		

		imp_guard06.Teleport_And_Face(imp_guard06_teleport_loc)
		imp_guard06.Suspend_Locomotor(false)
		imp_guard06.Prevent_AI_Usage(false)
		imp_guard06.Prevent_Opportunity_Fire(false)
		imp_guard06.Guard_Target(vader)]]
			
		-- Turn on opportunity fire for all units.
		empire_list = Find_All_Objects_Of_Type(empire)
		underworld_list = Find_All_Objects_Of_Type(underworld)
		
		for k, unit in pairs(empire_list) do
			if TestValid(unit) then
				unit.Suspend_Locomotor(false)
				unit.Prevent_All_Fire(false)
			end
		end
		
		for k, unit in pairs(underworld_list) do
			if TestValid(unit) then
				unit.Suspend_Locomotor(false)
				unit.Prevent_All_Fire(false)
			end
		end
		
		Point_Camera_At(vader)
		
		Fade_Screen_In(1)
		Transition_To_Tactical_Camera(0)
		Letter_Box_Out(0)
		Lock_Controls(0)
		End_Cinematic_Camera()
		Suspend_AI(0)	
		
		Create_Thread("Thread_Vader_Leaves_Landing_Area")
		
		Sleep(1)
		
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard01)
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard02)
		
		
		Sleep(1)
		
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard03)
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard04)
		
		
		Sleep(1)
		
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard05)
		Create_Thread("Thread_Unit_Leaves_Landing_Area", imp_guard06)
		
	end
end



function Thread_Vader_Leaves_Landing_Area()
	despawn_flag = Find_Hint("MARKER_GENERIC_PURPLE", "vader-despawn")
	
	vader.Suspend_Locomotor(false)
	BlockOnCommand(vader.Move_To(despawn_flag))
	vader.Despawn()
	
	Sleep(2)
	
	Create_Thread("Thread_Vader_Enters_Play_Area")
end

function Thread_Vader_Enters_Play_Area()
	--Sleep(3)
	respawn_flag = Find_Hint("MARKER_GENERIC_PURPLE", "vader-respawn")
	
	ref_type = Find_Object_Type("Darth_Vader")
	vaderlist = Spawn_Unit(ref_type, respawn_flag, empire)
	new_vader = vaderlist[1]
	
	Create_Thread("Hunt_Underworld", new_vader)
end

function Thread_Unit_Leaves_Landing_Area(local_unit)
	despawn_flag = Find_Hint("MARKER_GENERIC_PURPLE", "vader-despawn")
	
	local_unit.Suspend_Locomotor(false)
	BlockOnCommand(local_unit.Move_To(despawn_flag))
	local_unit.Despawn()
	
	Sleep(2)
	
	Create_Thread("Thread_Unit_Enters_Play_Area")
end

function Thread_Unit_Enters_Play_Area() 
	--Sleep(3)
	respawn_flag = Find_Hint("MARKER_GENERIC_PURPLE", "vader-respawn")
	
	local imp_guard_list = Spawn_Unit(Find_Object_Type("UM05_ADEPTONE"), respawn_flag, empire)
	local imp_guard = imp_guard_list[1]
	
	if TestValid(new_vader) then
		imp_guard.Guard_Target(new_vader)
	else
		Create_Thread("Hunt_Underworld", imp_guard)
	end
end



function End_Cinematic()
	
	end_cinematic_started = true
	-- lockout player control & AI
	Allow_Localized_SFX(false)
	Suspend_AI(1)
	Lock_Controls(1)
		
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)
	
	Start_Cinematic_Camera()
	
	Cancel_Fast_Forward()
	-- Despawn relevent units
	
	if new_vader then
		new_vader.Despawn()
	end
	
	-- Disable the other objects for the final cinematic
	Do_End_Cinematic_Cleanup()
	
	tyber_end_loc = Find_Hint("STORY_TRIGGER_ZONE_00", "tyberendloc")
	urai_end_loc = Find_Hint("STORY_TRIGGER_ZONE_00", "uraiendloc")
	ig88_end_loc = Find_Hint("STORY_TRIGGER_ZONE_00", "ig88endloc")
	
	tyberlist = Spawn_Unit(Find_Object_Type("Tyber_Zann"), tyber_end_loc, underworld)
	cin_tyber = tyberlist[1]
	urailist = Spawn_Unit(Find_Object_Type("Urai_Fen"), urai_end_loc, underworld)
	cin_urai = urailist[1]
	ig88list = Spawn_Unit(Find_Object_Type("IG-88"), ig88_end_loc, underworld)
	cin_ig88 = ig88list[1]
	
	cin_tyber.In_End_Cinematic(true)
	cin_urai.In_End_Cinematic(true)
	cin_ig88.In_End_Cinematic(true)
			
	cin_tyber.Teleport_And_Face(tyber_end_loc)
	cin_urai.Teleport_And_Face(urai_end_loc)
	cin_ig88.Teleport_And_Face(ig88_end_loc)
	
	unitspawn = Find_Hint("STORY_TRIGGER_ZONE_00","unitspawn")
	cin_tyber.Move_To(unitspawn)
	cin_urai.Move_To(unitspawn)
	cin_ig88.Move_To(unitspawn)
	
	Fade_Screen_In(1)
	
	Set_Cinematic_Camera_Key(shuttle_land_loc, 400, 35, 270, 1, 0, 1, 1)
	Set_Cinematic_Target_Key(cin_tyber, 0, 0, 0, 0, cin_tyber, 0, 1)
	
	Transition_Cinematic_Camera_Key(shuttle_land_loc, 9, 500, 25, 0, 1, 0, 1, 1)
	Transition_Cinematic_Target_Key(opening_cinematic_transport, 5, 0, 0, 0, 1, opening_cinematic_transport, 1, 1)
	
	Sleep(7)
	if TestValid(opening_cinematic_transport) then
		opening_cinematic_transport.Play_Animation("Takeoff",false)
	end
	cin_tyber.Despawn()
	cin_urai.Despawn()
	cin_ig88.Despawn()
	Sleep(7)
	
	Fade_Screen_Out(2)
	Sleep(1)
	
	-- spawn a new vader at the right location
	final_vader_start_loc = Find_Hint("STORY_TRIGGER_ZONE_00", "vaderendcin")
	ref_type = Find_Object_Type("Darth_Vader")
	vaderlist = Spawn_Unit(ref_type, final_vader_start_loc, empire)
	vader = vaderlist[1]
	vader.In_End_Cinematic(true)
	
	-- spawn dialog stormtrooper
	final_trooper1_loc = Find_Hint("STORY_TRIGGER_ZONE_00", "trooperendcin")
	stref_type = Find_Object_Type("DIALOGUE_STORMTROOPER")
	finaltrooperlist1 = Spawn_Unit(stref_type, final_trooper1_loc, empire)
	finaltrooper1 = finaltrooperlist1[1]
	finaltrooper1.In_End_Cinematic(true)
	
	end_trooper_goto = Find_Hint("STORY_TRIGGER_ZONE_00", "endtroopergoto")
	finaltrooper1.Move_To(end_trooper_goto)
	vader.Turn_To_Face(finaltrooper1)
	
	Fade_Screen_In(2)
	
	Transition_Cinematic_Camera_Key(vader, 0, 200, 15, 80, 1, 0, 1, 1)
	Transition_Cinematic_Target_Key(vader, 0, 0, 0, 0, 1, vader, 1, 1)
	Transition_Cinematic_Camera_Key(vader, 10, 100, 15, 80, 1, 0, 1, 1)
	Sleep(3)
	finaltrooper1.Play_Animation("Attention",true)
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_31")
	
end

function State_Underworld_A02M07_Speech_Line_31_Remove_Text(message)
	if message == OnEnter then
	
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_32")
	
	end
end

function State_Underworld_A02M07_Speech_Line_32_Remove_Text(message)
	if message == OnEnter then
	
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_33")
	
	end
end

function State_Underworld_A02M07_Speech_Line_33_Remove_Text(message)
	if message == OnEnter then
	
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_34")
	
	end
end

function State_Underworld_A02M07_Speech_Line_34_Remove_Text(message)
	if message == OnEnter then
	
	Story_Event("TEXT_SPEECH_UW_ACT02_M07_35")
	
	end
end

function State_Underworld_A02M07_Speech_Line_35_Remove_Text(message)
	if message == OnEnter then
			
	Fade_Screen_In(1)
	Transition_To_Tactical_Camera(0)
	Letter_Box_Out(0)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Suspend_AI(0)
		
	Story_Event("VICTORY_TRIGGER")
	--MessageBox("Victory message sent!")
	
	end
end

-- ##########################################################################################
-- ##################FLYOVER(S) CONTROLLER AND SCRIPTS###########################################
-- ##########################################################################################

function Thread_Cloud_Car_Flyovers()
	--see how many flyovers there currently are
	--MessageBox("function Thread_Cloud_Car_Flyovers() HIT!")
	Sleep(5)
	local flyover_max = 0
	for i, cloud_city_car in pairs(cloud_city_cars) do
		flyover_max = flyover_max + 1
	end
	if flyover_max == 0 then
		JoeMessage("No flyovers found...aborting thread")
		return
	end
		
	while (true) do
		
		--now pick a random flyover to play
		local flyover_roll = GameRandom.Free_Random(1, flyover_max)
		
		while cloud_cars_in_use[cloud_city_cars[flyover_roll]] do
			--MessageBox("Cloud car in use")
			flyover_roll = GameRandom.Free_Random(1, flyover_max)
			Sleep(3)
		end
		
		Create_Thread("Thread_Flyover_Animation", cloud_city_cars[flyover_roll])
		
		Sleep(1)
	end
		
end


function Thread_Flyover_Animation(cloud_car)

	cloud_cars_in_use[cloud_car] = true
	
	cloud_car.Hide(false)
	--MessageBox("BlockOnCommand(cloud_car.Play_Animation")
	BlockOnCommand(cloud_car.Play_Animation("Cinematic", false, 0))
	cloud_car.Hide(true)

	cloud_cars_in_use[cloud_car] = false

end


-- ##########################################################################################
function JoeMessage(...)
	--JoeMessage("current current_spawn_times  is %d", current_spawn_times)
	_CustomScriptMessage("JoeLog.txt", string.format(unpack(arg)))
end