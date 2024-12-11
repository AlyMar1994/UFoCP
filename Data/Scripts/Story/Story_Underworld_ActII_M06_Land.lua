-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M06_LAND.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M06_LAND.lua $
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
		Underworld_A02M06_Begin = State_Underworld_A02M06_Begin,
		UM06_DIALOG_IntroCine_Line07_Remove_Text = State_UM06_DIALOG_IntroCine_Line07_Remove_Text,
		Underworld_A02M06_Victory_Trigger = State_Underworld_A02M06_Victory_Trigger,
		UM06_OBJECTIVE_ADD_Destroy_Prison01_PowerGenerator = State_OBJECTIVE_ADD_Destroy_Prison01_PowerGenerator,
		UM06_DIALOG_NightSister_Greets_Tyber_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line2_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line2_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line3_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line3_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line4_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line4_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line5_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line5_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line6_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line6_Remove_Text,
		UM06_DIALOG_NightSister_Greets_Tyber_Line7_Remove_Text = State_UM06_DIALOG_NightSister_Greets_Tyber_Line7_Remove_Text,
		UM06_OBJECTIVE_ADD_Destroy_Singing_Mountains_Nightsister_Prison = State_UM06_OBJECTIVE_ADD_Destroy_Singing_Mountains_Nightsister_Prison,
		UM06_OBJECTIVE_ADD_Destroy_Prison02 = State_UM06_OBJECTIVE_ADD_Destroy_Prison02,
		UM06_OBJECTIVE_ADD_Destroy_Prison03 = State_UM06_OBJECTIVE_ADD_Destroy_Prison03,
		UM06_OBJECTIVE_ADD_Destroy_Governors_Quarters = State_UM06_OBJECTIVE_ADD_Destroy_Governors_Quarters,
		UM06_DIALOG_Silri_Meets_Tyber_Line01_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line01_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line02_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line02_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line03_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line03_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line04_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line04_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line05_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line05_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line06_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line06_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line07_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line07_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line08_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line08_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line09_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line09_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line10_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line10_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line11_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line11_Remove_Text,
		UM06_DIALOG_Silri_Meets_Tyber_Line12_Remove_Text = State_UM06_DIALOG_Silri_Meets_Tyber_Line12_Remove_Text,
		UM06_DIALOG_Finale_Line01_Remove_Text = State_UM06_DIALOG_Finale_Line01_Remove_Text,
		UM06_DIALOG_Finale_Line02_Remove_Text = State_UM06_DIALOG_Finale_Line02_Remove_Text,
		UM06_DIALOG_Finale_Line03_Remove_Text = State_UM06_DIALOG_Finale_Line03_Remove_Text,
		UM06_DIALOG_Finale_Line04_Remove_Text = State_UM06_DIALOG_Finale_Line04_Remove_Text,
		UM06_DIALOG_Finale_Line05_Remove_Text = State_UM06_DIALOG_Finale_Line05_Remove_Text,
		UM06_DIALOG_Finale_Line06_Remove_Text = State_UM06_DIALOG_Finale_Line06_Remove_Text,
		
	}
	
	empire_prison01_list = {
		"DARK_TROOPER_PHASEIII"
		,"DARK_TROOPER_PHASEIII"
		,"DARK_TROOPER_PHASEIII"
	}
	
	empire_prison03_list01 = {
		"IMPERIAL_ARTILLERY_CORP"
		,"IMPERIAL_HEAVY_SCOUT_SQUAD"
	}
	
	empire_prison03_list02 = {
		"IMPERIAL_STORMTROOPER_SQUAD"
		,"IMPERIAL_STORMTROOPER_SQUAD"
	}
	
	possible_prisoners_list = {
		"UM06_Prisoner_Geonosian", 
		"UM06_Prisoner_Rebel_Infantry",
		"UM06_Prisoner_Rebel_Tank_Buster",
		"UM06_Prisoner_Pirate_Soldier",
		"UM06_Prisoner_Pirate_PLEX",
		"UM06_Prisoner_Ewok",
		"UM06_Prisoner_Gungan",
		"UM06_Prisoner_Wookie",
		"UM06_Prisoner_Jawa_Scout",
		"UM06_Prisoner_Mon_Calamari_Civ",
		"UM06_Prisoner_Bothan_Civ",
	}
	
	forced_prisoner_list = {
		"UM06_Prisoner_Ewok_Handler"
	}
	
	prisoner_spawn_list = {}
	
	
	--jdg cheat flags
	flag_skip_intro = false	
	underworld = Find_Player("Underworld")
	empire = Find_Player("Empire")
	rebel = Find_Player("Rebel")
	neutral = Find_Player("Neutral")
	hostile = Find_Player("Hostile")
	
	--landing_transport = Find_Object_Type("MILLENNIUM_FALCON_LANDING")
	--spawn_troops = true
	
	--gate_down = false
	--jug_prox_gate = false
	
	prison_2_power_down = false
	prison_2_power_identified = false
	
	singing_tripped = true
	frenzied_tripped = true
	misty_tripped = true
	
	governors_quarters_identified = false
	victory_triggered = false
	
	group1_rancor_location_list = {}
	group2_rancor_location_list = {}
	group3_rancor_location_list = {}
	group4_rancor_location_list = {}
	flag_group1rancors_guarding = true
	flag_group2rancors_guarding = true
	flag_group3rancors_guarding = true
	flag_group4rancors_guarding = true
	flag_governor_dead = false
	flag_flyguard01_to_ai = false
	
	flag_okay_to_reinforce = true
	flag_first_imperial_reinforcement = true
	
	flag_p3_prox_tripped = false
	flag_first_river_crossing = true
	
	flag_uplink_01_destroyed = false
	flag_uplink_02_destroyed = false
	flag_uplink_03_destroyed = false
	
	group01_rancor_reveal_list = {}
	guardtower_reveal_list = {}
	turbotower_reveal_list = {}
	governors_house_reveal = nil
	
	rancors_in_use = {}
	sisters_in_use = {}
	
	empire_reinforce_list = {}
	
	const_highlight_timer = 5
	
	pointguard_list = {}
	gate_pointguard_list = {}
	parked_vehicle_list = {}
	group1_rancors = {}
	group2_rancors = {}
	group3_rancors = {}
	group4_rancors = {}
	prison01_turrets_list = {}
	prison3_turret_list = {}
	silris_guards = {}
	
	
end

function State_Underworld_A02M06_Begin (message)
	if message == OnEnter then
		--imperial_shuttle = Create_Cinematic_Transport("Imperial_Landing_Craft_Landing_Cinematic", empire.Get_ID(), Emp_Shuttle_Land_Pos, 180, 1, 0.25, 20, 1)
		--rebel_shuttle1 = Create_Cinematic_Transport("Gallofree_Transport_Landing", rebel_player.Get_ID(), transport1_loc, 0, 1, 0.25, 15, 0)
		
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		empire.Make_Ally(hostile)
	
		rebel_reveal = FogOfWar.Reveal_All(rebel)
		empire_reveal = FogOfWar.Reveal_All(empire)
		--uw_reveal = FogOfWar.Reveal_All(underworld)
		
		landing_spot = Find_Hint("STORY_TRIGGER_ZONE_00", "landingflag")
		camera_loc1 = Find_Hint("STORY_TRIGGER_ZONE_00", "introcine1")
		tyber_spawn = Find_Hint("STORY_TRIGGER_ZONE_00", "tyberspawn")
		urai_spawn = Find_Hint("STORY_TRIGGER_ZONE_00", "uraispawn")
		tyber_goto1 = Find_Hint("STORY_TRIGGER_ZONE_00", "tybergoto1")
		urai_goto1 = Find_Hint("STORY_TRIGGER_ZONE_00", "uraigoto1")

		sister_goto1 = Find_Hint("STORY_TRIGGER_ZONE_00", "sistergoto")
		
		singing_prison = Find_First_Object("Imperial_Prison_Dathomir_Singing_Mountain")
		frenzied_prison = Find_First_Object("Imperial_Prison_Dathomir_Frenzied_River")
		misty_prison = Find_First_Object("Imperial_Prison_Dathomir_Misty_Falls")
		
		singing_tripped = false
		frenzied_tripped = false
		misty_tripped = false
		
		gate_pos_flag = Find_Hint("STORY_TRIGGER_ZONE_00", "gateloc")
		gate_goto = Find_Hint("STORY_TRIGGER_ZONE_00", "gategoto")
		gate_loc = gate_pos_flag.Get_Position()
		
		
		gate = Create_Generic_Object ("EMPIRE_GATE_LARGE", gate_loc, empire)
		gate.Teleport_And_Face(gate_pos_flag)
		gate.Make_Invulnerable(true)
		gate.Set_Cannot_Be_Killed(true)

		--Create_Thread("Thread_Death_Monitor_Gate")
		
		--put pointguards on guard duty
		gate_pointguard_list = Find_All_Objects_With_Hint("gate-pointguard")
		for i, gate_pointguard in pairs(gate_pointguard_list) do
			if TestValid(gate_pointguard) then
				gate_pointguard.Prevent_AI_Usage(true)
				--pointguard.Guard_Target(pointguard.Get_Position())
				gate_pointguard.Prevent_All_Fire(true)
				gate_pointguard.Prevent_Opportunity_Fire(true)
			end
		end
		
		--disable the trucks and stuff
		parked_vehicle_list = Find_All_Objects_With_Hint("parked")
		for i,parked_vehicle in pairs(parked_vehicle_list) do
			parked_vehicle.Prevent_AI_Usage(true)
			parked_vehicle.Prevent_All_Fire(true)
			parked_vehicle.Prevent_Opportunity_Fire(true)
		end
		
		Create_Thread("Thread_Monitor_Parked_Vehicles_Status")
		
		trooper_spawn = Find_Hint("STORY_TRIGGER_ZONE_00", "trooperspawn")
		
		
		rancor_spawn_flag = Find_Hint("MARKER_GENERIC_BLUE", "group01-rancor-spawn")
		group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
		for k, rancor1 in pairs(group1_rancors) do
			if TestValid(rancor1) then
				rancor1.Prevent_Opportunity_Fire(true)
				--rancor1.Hide(true)
				

				Register_Prox(rancor1, PROX_RancorGroup1_vs_Tyber_and_Urai, 75, underworld)
				
				--define rancor starting positons here
				group1_rancor_location_list[k] = rancor1.Get_Position()
				rancor1.Teleport(rancor_spawn_flag)	
			end
		end
		
		group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
		for k, rancor2 in pairs(group2_rancors) do
			if TestValid(rancor2) then
				rancor2.Prevent_Opportunity_Fire(true)
				Register_Prox(rancor2, PROX_RancorGroup2_vs_Tyber_and_Urai, 75, underworld)
				
				--define rancor starting positons here
				group2_rancor_location_list[k] = rancor2.Get_Position()
			end
		end
		
		group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
		for k, rancor3 in pairs(group3_rancors) do
			if TestValid(rancor3) then
				rancor3.Prevent_Opportunity_Fire(true)
				Register_Prox(rancor3, PROX_RancorGroup3_vs_Tyber_and_Urai, 75, underworld)
				
				--define rancor starting positons here
				group3_rancor_location_list[k] = rancor3.Get_Position()
			end
		end
		
		group4_rancors = Find_All_Objects_With_Hint("group4-rancor")
		for k, rancor4 in pairs(group4_rancors) do
			if TestValid(rancor4) then
				rancor4.Prevent_Opportunity_Fire(true)
				Register_Prox(rancor4, PROX_RancorGroup4_vs_Tyber_and_Urai, 75, underworld)
				
				--define rancor starting positons here
				group4_rancor_location_list[k] = rancor4.Get_Position()
			end
		end
		
		--Create_Thread("Thread_Group1Rancors_Start_Guarding")
		Create_Thread("Thread_Group2Rancors_Start_Guarding")
		Create_Thread("Thread_Group3Rancors_Start_Guarding")
		Create_Thread("Thread_Group4Rancors_Start_Guarding")
		
		--guard towers need to reveal stealthed units
		guardtower_list = Find_All_Objects_Of_Type("PROP_GUARD_TOWER")
		for i, guardtower in pairs(guardtower_list) do
			if TestValid(guardtower) then
				Register_Prox(guardtower, PROX_Reveal_Stealth, 200, underworld)
			end
		end
		
		prison_1_power = Find_Hint("POWER_GENERATOR_E", "p1-power")
		prison_2_power = Find_Hint("POWER_GENERATOR_E", "prison2power")
		prison_3_power = Find_Hint("POWER_GENERATOR_E", "prison3power")
		governors_power = Find_Hint("POWER_GENERATOR_E", "governors-power")

		prison_2_power_identified = true
		
		governors_quarters = Find_Hint("UM06_GOVERNORS_QUARTERS", "governorquarters")
		if TestValid (governors_quarters) then
			governors_quarters_identified = true
		else
			JoeMessage("UM06 Cannot find Governor's Quarters...aborting mission")
			ScriptExit()
		end

		--jdg new definitions
		proxflag_guardtower_hint = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-guardtower-hint")
		Register_Prox(proxflag_guardtower_hint, PROX_Give_GuardTower_Hint, 100, underworld)
		
		proxflag_rancor_hint = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-rancor-hint")
		Register_Prox(proxflag_rancor_hint, PROX_Give_Rancor_Hint, 100, underworld)
		
		proxflag_hint_backpath = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-hint-backpath")
		Register_Prox(proxflag_hint_backpath, PROX_Give_Backpath_Hint, 100, underworld)
		
		proxflag_dialog_prison01_frontdoor = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-dialog-prison01-frontdoor")
		Register_Prox(proxflag_dialog_prison01_frontdoor, PROX_Dialog_Prison01_Frontdoor, 250, underworld)
		
		proxflag_dialog_prison02_frontdoor = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-dialog-prison02-frontdoor")
		Register_Prox(proxflag_dialog_prison02_frontdoor, PROX_Dialog_Prison02_Frontdoor, 100, underworld)
		
		proxflag_dialog_governors_house = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-dialog-governors-house")
		Register_Prox(proxflag_dialog_governors_house, PROX_Dialog_Governors_House, 100, underworld)
		
		prison01_academy = Find_Hint("UM06_OFFICERS_QUARTERS", "prison01academy")
		prison01_uplinkspawnspot = Find_Hint("MARKER_GENERIC_BLUE", "p1uplink-spawnspot")
		
		prison01_uplink_goto01 = Find_Hint("MARKER_GENERIC_BLUE", "uplinkgoto01")
		prison01_uplink_goto02 = Find_Hint("MARKER_GENERIC_BLUE", "uplinkgoto02")
		prison01_uplink_goto03 = Find_Hint("MARKER_GENERIC_BLUE", "uplinkgoto03")
		
		if not TestValid(proxflag_dialog_governors_house) then
			JoeMessage("not proxflag_dialog_governors_house")
		end
		
		proxflag_spawn_at_governors_house = Find_Hint("MARKER_GENERIC_PURPLE", "prox-spawn-guards")
		Register_Prox(proxflag_spawn_at_governors_house, PROX_Spawn_at_Governors_House, 100, underworld)
		
		--stuff for prison 01 backpath patrols
		--backpath_guard01 = Find_All_Objects_With_Hint("backpath-guard01")
		--backpath_guard02 = Find_All_Objects_With_Hint("backpath-guard02")
		--backpath_guard03 = Find_All_Objects_With_Hint("backpath-guard03")
		--backpath_guard04 = Find_All_Objects_With_Hint("backpath-guard04")
		
		--backpath_spot01 = Find_Hint("MARKER_GENERIC_BLUE", "backpath-spot01")
		--backpath_spot02 = Find_Hint("MARKER_GENERIC_BLUE", "backpath-spot02")
		--backpath_spot03 = Find_Hint("MARKER_GENERIC_BLUE", "backpath-spot03")
		
		--Create_Thread("Thread_Prison01Guard01_Backpath_Patrols")
		--Create_Thread("Thread_Prison01Guard02_Backpath_Patrols")
		--Create_Thread("Thread_Prison01Guard03_Backpath_Patrols")
		--Create_Thread("Thread_Prison01Guard04_Backpath_Patrols")
		
		--PRISON 01 LZ STUFF
		--prison01_transport_lz = Find_Hint("MARKER_GENERIC_YELLOW", "prison01-transport-lz")
		transport_lz = Find_Hint("MARKER_GENERIC_YELLOW", "transport-lz")
		--prison01_transport_platform = Find_Hint("EMPIRE_LANDING_PLATFORM_2X", "prison01-transport-platform")
		transport_spawnflag = Find_Hint("MARKER_GENERIC_YELLOW", "transport-spawnflag")
		
		uplink_station = Find_Hint("UPLINK_STATION", "uplink-station")
		uplink_station02 = Find_Hint("UPLINK_STATION", "uplink-station02")
		uplink_station03 = Find_Hint("UPLINK_STATION", "uplink-station03")
		
		--prison03 lz stuff
		proxflag_player_crossing_river = Find_Hint("MARKER_GENERIC_PURPLE", "proxflag-player-crossing-river")
		prison03_lz01 = Find_Hint("MARKER_GENERIC_YELLOW", "landing-empire-shuttle01")
		prison03_lz02 = Find_Hint("MARKER_GENERIC_YELLOW", "landing-empire-shuttle01")
		
		Register_Prox(proxflag_player_crossing_river, PROX_Player_Crossing_River, 100, underworld)
		
		--prison02 stuff
		-- make prison02 turbo lasers indestructable
		prison_2_turbolaser_list = Find_All_Objects_With_Hint("prison2turbolaser")
		for i, turbolaser in pairs(prison_2_turbolaser_list) do
			if TestValid(turbolaser) then
				turbolaser.Make_Invulnerable(true)
			end
		end
		
		--put pointguards on guard duty
		pointguard_list = Find_All_Objects_With_Hint("pointguard")
		for i, pointguard in pairs(pointguard_list) do
			if TestValid(pointguard) then
				pointguard.Prevent_AI_Usage(true)
				pointguard.Guard_Target(pointguard.Get_Position())
			end
		end
		
		--turn silri into a "prop" for now
		silri = Find_Hint("SILRI", "silri") 
		if TestValid(silri) then
			silri.Suspend_Locomotor(true)
			silri.Prevent_AI_Usage(true)
			silri.Prevent_All_Fire(true)
			silri.Make_Invulnerable(true)
			silri.Set_Cannot_Be_Killed(true)
			silri.Prevent_Opportunity_Fire(true)
		else
			--MessageBox("UMO6 cannot find Silri...aborting mission...tell Joe Gernert immediately")
			JoeMessage("UMO6 cannot find Silri...aborting mission...tell Joe Gernert immediately")
			ScriptExit()
		end
		
		--definitions for mines/powerups
		--refueling_pump01 = Find_Hint("REFUELING_PUMP", "mine01")
		--Create_Thread("Death_Monitor_Pump01")
		
		mine_list = Find_All_Objects_Of_Type("EMPIRE_GROUND_MINING_FACILITY")
		for i, mine in pairs(mine_list) do
			if TestValid(mine) then
				Create_Thread("Death_Monitor_Mine", mine)
			end
		end
		
		
		
		prison01_turrets_list = Find_All_Objects_With_Hint("p1-turret")
		prison3_turret_list = Find_All_Objects_With_Hint("p3-turret")
		silris_guards = Find_All_Objects_With_Hint("silri-pointguard")
		
		Create_Thread("Death_Monitor_Prison1_Power")
		Create_Thread("Death_Monitor_Prison2_Power")
		Create_Thread("Death_Monitor_Prison3_Power")
		Create_Thread("Death_Monitor_Governors_Power")
		
		--defining flightpath waypoints here
		--flightpath_01 = {}
		--flightpath_01[1]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01a")
		--flightpath_01[2]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01b")
		--flightpath_01[3]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01c")
		--flightpath_01[4]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01d")
		--flightpath_01[5]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01e")
		--flightpath_01[6]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01f")
		--flightpath_01[7]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01g")
		--flightpath_01[8]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01h")
		--flightpath_01[9]= Find_Hint("MARKER_GENERIC_YELLOW", "flightpath-01i")
		
		--for i, waypoint in pairs(flightpath_01) do
		--	if TestValid(waypoint) then
		--		Register_Prox(waypoint, PROX_Flightpath_01, 100, empire)
		--	end
		--end
		
		--flyguard01_list = Find_All_Objects_With_Hint("flyguard-01")
		--for i, flyguard01 in pairs(flyguard01_list) do
		--	if TestValid(flyguard01) then
		--		Register_Prox(flyguard01, PROX_Encountered_Heroes, 200, underworld)
		--	end
		--end
		
		--defining stuff for spawning guys out of prison01 barracks 
		prison01_barracks = Find_Hint("E_GROUND_BARRACKS", "p01-barracks")
		prison01_barracks_spawn = Find_Hint("MARKER_GENERIC_YELLOW", "p01-barracks-spawn")

		
		
		
		if flag_skip_intro == false then
			current_cinematic_thread = Create_Thread("Intro_Cinematic")
		else
			--fill in stuff needed even if intro is skipped.
			tyber_list = Spawn_Unit(Find_Object_Type("UM06_TYBER_ZANN"), tyber_goto1, underworld)
			urai_list = Spawn_Unit(Find_Object_Type("URAI_FEN"), urai_goto1, underworld)
			
			underworld.Give_Money(10000)
			
			
			tyber = Find_First_Object("UM06_TYBER_ZANN")
			urai = urai_list[1]
			
			tyber.Prevent_AI_Usage(true)
			urai.Prevent_AI_Usage(true)
			
			tyber.Turn_To_Face(urai_goto1)
			urai.Turn_To_Face(tyber_goto1)
			
			Point_Camera_At(tyber)
			
			--Transition_To_Tactical_Camera(2)
			--Sleep(2)	
			Lock_Controls(0)
			End_Cinematic_Camera()
			Letter_Box_Out(0)	
			Suspend_AI(0)
			
			Create_Thread("Thread_Group1Rancors_Start_Guarding")
			Create_Thread("Death_Monitor_Tyber")
			Create_Thread("Death_Monitor_Urai")
			Weather_Audio_Pause(false)
			Allow_Localized_SFX(true)
			Resume_Mode_Based_Music()
			Fade_Screen_In(1)
			Master_Volume_Restore() 
			
			
			
		end
	end
end

function Death_Monitor_Mine(local_mine)
	while TestValid(local_mine) do
		Sleep(3)
	end
	
	Story_Event("UM06_MINING_FACILITY_DESTROYED_AI_NOTIFICATION")
	underworld.Give_Money(5000)
end

function Story_Handle_Esc()
	if current_cinematic_thread ~= nil then
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil
		Create_Thread("End_Camera")
		Story_Event("UM06_ESCAPEKEY_PREVENT_INTRO_DIALOG_AI_NOTIFICATION")
	end
end

function End_Camera()
	Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()

	--gotta do some manipulation of starting transport shuttle
	if TestValid(openin_cine_transport) then
		openin_cine_transport.Despawn()

	end
	
	--now spawn in a pre-landed one
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)
	openin_cine_transport = Create_Cinematic_Transport("UM06_Landing_Shuttle", underworld.Get_ID(), landing_spot, 60, 1, 1, 20, 1)

	if not TestValid(tyber) then
		tyber_list = Spawn_Unit(Find_Object_Type("UM06_TYBER_ZANN"), tyber_goto1, underworld)
		tyber = Find_First_Object("UM06_TYBER_ZANN")
	end
	if not TestValid(urai) then
		urai_list = Spawn_Unit(Find_Object_Type("URAI_FEN"), urai_goto1, underworld)
		urai = urai_list[1]
	end
	
	--underworld.Give_Money(10000)
	
	
	
	
	
	tyber.Prevent_AI_Usage(true)
	urai.Prevent_AI_Usage(true)
	
	tyber.Teleport_And_Face(tyber_goto1)
	urai.Teleport_And_Face(urai_goto1)
	
	tyber.Turn_To_Face(urai_goto1)
	urai.Turn_To_Face(tyber_goto1)
	
	Point_Camera_At(tyber)

	--Transition_To_Tactical_Camera(2)
	--Sleep(2)	
	Lock_Controls(0)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	Suspend_AI(0)
	
	Create_Thread("Thread_Group1Rancors_Start_Guarding")
	
	Weather_Audio_Pause(false)
	Allow_Localized_SFX(true)
	Resume_Mode_Based_Music()
	--Fade_Screen_In(1)
	--Master_Volume_Restore() 
			
			
			
	Transition_To_Tactical_Camera(2)
	Letter_Box_Out(2)
	Sleep(2)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Suspend_AI(0)
	
	--Sleep(5)
	Create_Thread("Death_Monitor_Tyber")
	Create_Thread("Death_Monitor_Urai")
	Story_Event("UM06_Re_Enable_Victory_AI_NOTIFICATION")
	
end



function PROX_Encountered_Heroes(prox_obj, trigger_obj) --JET_PACK
	--trigger_type = trigger_obj.Get_Type().Get_Name()
	--if trigger_type == "UM06_TYBER_ZANN" or trigger_type == "URAI_FEN" or trigger_type == "UM06_Night_Sister" or trigger_type == "PRISONER_NIGHT_SISTER"  then
	if trigger_obj.Get_Owner() == underworld then
		--see if they are in stealth
		 if not trigger_obj.Is_Ability_Active("STEALTH") then
		--release him to the ai
			for i, flyguard01 in pairs(flyguard01_list) do
				if TestValid(flyguard01) then
					flyguard01.Cancel_Event_Object_In_Range(PROX_Encountered_Heroes)
					--flyguard01.Prevent_AI_Usage(false)
					flyguard01.Attack_Move(trigger_obj)
				end
			end
			
			--MessageBox("Fly guard should now attack heroes")
			flag_flyguard01_to_ai = true
			
			--cancel all prox events on waypoints
			for i, waypoint in pairs(flightpath_01) do
			if TestValid(waypoint) then
					waypoint.Cancel_Event_Object_In_Range(PROX_Flightpath_01)
				end
			end
			
			return
		end
	end
end
	
	
function PROX_Flightpath_01(prox_obj, trigger_obj) --JET_PACK
	trigger_type = trigger_obj.Get_Type().Get_Name()
	if trigger_type == "DARK_TROOPER_PHASEIII" then
		if prox_obj == flightpath_01[1] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[2])
			else
				trigger_obj.Move_To(flightpath_01[2])
			end
			return
		elseif prox_obj == flightpath_01[2] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[3])
			else
				trigger_obj.Move_To(flightpath_01[3])
			end
			return
		elseif prox_obj == flightpath_01[3] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[4])
			else
				trigger_obj.Move_To(flightpath_01[4])
			end
			return
		elseif prox_obj == flightpath_01[4] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[5])
			else
				trigger_obj.Move_To(flightpath_01[5])
			end
			return
		elseif prox_obj == flightpath_01[5] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[6])
			else
				trigger_obj.Move_To(flightpath_01[6])
			end
			return
		elseif prox_obj == flightpath_01[6] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[7])
			else
				trigger_obj.Move_To(flightpath_01[7])
			end
			return
		elseif prox_obj == flightpath_01[7] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[8])
			else
				trigger_obj.Move_To(flightpath_01[8])
			end
			return
		elseif prox_obj == flightpath_01[8] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[9])
			else
				trigger_obj.Move_To(flightpath_01[9])
			end
			return
		elseif prox_obj == flightpath_01[9] and not flag_flyguard01_to_ai then
			if trigger_obj.Is_Ability_Ready("JET_PACK") then
				trigger_obj.Activate_Ability("JET_PACK", flightpath_01[1])
			else
				trigger_obj.Move_To(flightpath_01[1])
			end
			return
		end
	end

end


function Thread_Group1Rancors_Start_Guarding()
	while (true) do
		if (flag_group1rancors_guarding == true) then
			local counter_rancors = 0
			--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
			
			for i, rancor in pairs(group1_rancors) do
				if TestValid(rancor) then
					counter_rancors = counter_rancors + 1
					if not rancor.Has_Attack_Target() then
						rancor.Guard_Target(group1_rancor_location_list[i])
					end
				end
			end
			
			if counter_rancors == 0 then
				--MessageBox("All Rancors Dead")
				break
			end
		end
		Sleep(15)
	end
end

function Thread_Group2Rancors_Start_Guarding()
	while (true) do
		if (flag_group2rancors_guarding == true) then
			local counter_rancors = 0
			--group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
			
			for i, rancor in pairs(group2_rancors) do
				if TestValid(rancor) then
					counter_rancors = counter_rancors + 1
					rancor.Guard_Target(group2_rancor_location_list[i])

				end
			end
			
			if counter_rancors == 0 then
				--MessageBox("All Rancors Dead")
				break
			end
		end
		Sleep(15)
	end
	
end

function Thread_Group3Rancors_Start_Guarding()
	while (true) do
		if (flag_group3rancors_guarding == true) then
			local counter_rancors = 0
			--group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
			
			for i, rancor in pairs(group3_rancors) do
				if TestValid(rancor) then
					counter_rancors = counter_rancors + 1
					rancor.Guard_Target(group3_rancor_location_list[i])

				end
			end
			
			if counter_rancors == 0 then
				--MessageBox("All Rancors Dead")
				break
			end
		end
		Sleep(15)
	end
	
end

function Thread_Group4Rancors_Start_Guarding()
	while (true) do
		if (flag_group4rancors_guarding == true) then
			local counter_rancors = 0
			--group4_rancors = Find_All_Objects_With_Hint("group4-rancor")
			
			for i, rancor in pairs(group4_rancors) do
				if TestValid(rancor) then
					counter_rancors = counter_rancors + 1
					rancor.Guard_Target(group4_rancor_location_list[i])

				end
			end
			
			if counter_rancors == 0 then
				--MessageBox("All Rancors Dead")
				break
			end
		end
		Sleep(15)
	end
	
end

function PROX_RancorGroup1_vs_Tyber_and_Urai(prox_obj, trigger_obj)
	local flag_message_given = false
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
        --check to see if Tyber and Urai are in stealth
        if not trigger_obj.Is_Ability_Active("STEALTH") then
        
			--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
			
			for i, rancor in pairs(group1_rancors) do
				if TestValid(rancor) then
					rancor.Cancel_Event_Object_In_Range(PROX_RancorGroup1_vs_Tyber_and_Urai)

				end
			end
			
			if flag_message_given == false then
				--MessageBox("Rancors have detected NON-STEALTHED unit...attacking")
				flag_message_given = true
				flag_group1rancors_guarding = false
			end
			--ALL RANCORS ATTACK		
			Create_Thread("Thread_Group1Rancors_Attack_Heroes", trigger_obj)
		end
	end
end

function Thread_Group1Rancors_Attack_Heroes(first_target)

	if first_target == tyber then
		second_target = urai
	else
		second_target = tyber
	end

	while TestValid(first_target) and not first_target.Is_Ability_Active("STEALTH")  do
		--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
		for i, rancor in pairs(group1_rancors) do
			if TestValid(rancor) then
				if TestValid (first_target) then
					rancor.Attack_Target(first_target)
				end

			end
		end
		Sleep(5)
	end
	
	--do a distance check here
	local distance_to_second_target = second_target.Get_Distance(first_target)
	local max_distance_allowed = 100
	
	if TestValid(first_target) and TestValid(second_target) then
		if ( max_distance_allowed > distance_to_second_target) then
		
			while TestValid(second_target) and not second_target.Is_Ability_Active("STEALTH") do
				--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
				for i, rancor in pairs(group1_rancors) do
					if TestValid(rancor) then
						if TestValid (second_target) then
							rancor.Attack_Target(second_target)
						end

					end
				end
				Sleep(5)
			end
		end
	else
		return --everyone is dead...exit and wait for mission loss events to take over
	end
	
	--MessageBox("Rancors returning to initial positions")
	flag_group1rancors_guarding = true
	
	--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
	for i, rancor in pairs(group1_rancors) do
		if TestValid(rancor) then
			rancor.Guard_Target(group1_rancor_location_list[i])
			Register_Prox(rancor, PROX_RancorGroup1_vs_Tyber_and_Urai, 75, underworld)

		end
	end
end

function PROX_RancorGroup2_vs_Tyber_and_Urai(prox_obj, trigger_obj)
	local flag_message_given = false
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
        --check to see if Tyber and Urai are in stealth
        if not trigger_obj.Is_Ability_Active("STEALTH") then
        
			--group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
			
			for i, rancor in pairs(group2_rancors) do
				if TestValid(rancor) then
					rancor.Cancel_Event_Object_In_Range(PROX_RancorGroup2_vs_Tyber_and_Urai)

				end
			end
			
			if flag_message_given == false then
				--MessageBox("Rancors have detected NON-STEALTHED unit...attacking")
				flag_message_given = true
				flag_group2rancors_guarding = false
			end
			--ALL RANCORS ATTACK
			Create_Thread("Thread_Group2Rancors_Attack_Heroes", trigger_obj)
		end
	end
end

function Thread_Group2Rancors_Attack_Heroes(first_target)

	if first_target == tyber then
		second_target = urai
	else
		second_target = tyber
	end

	while TestValid(first_target) and not first_target.Is_Ability_Active("STEALTH")  do
		--group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
		for i, rancor in pairs(group2_rancors) do
			if TestValid(rancor) and TestValid (first_target) then
				rancor.Attack_Target(first_target)
				--Sleep(0.5)

			end
		end
		Sleep(5)
	end
	
	--do a distance check here
	if TestValid(first_target) and TestValid(second_target) then
	
		local distance_to_second_target = second_target.Get_Distance(first_target)
		local max_distance_allowed = 100
		
		if ( max_distance_allowed > distance_to_second_target) then
		
			while TestValid(second_target) and not second_target.Is_Ability_Active("STEALTH") do
				--group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
				for i, rancor in pairs(group2_rancors) do
					if TestValid(rancor) and TestValid (second_target) then
						rancor.Attack_Target(second_target)
						--Sleep(0.5)

					end
				end
				Sleep(5)
			end
		
		end
	else
		return --everyone is dead...exit and wait for mission loss events to take over
	end
	
	--MessageBox("Rancors returning to initial positions")
	flag_group2rancors_guarding = true
	--group2_rancors = Find_All_Objects_With_Hint("group2-rancor")
	for i, rancor in pairs(group2_rancors) do
		if TestValid(rancor) then
			rancor.Guard_Target(group2_rancor_location_list[i])
			Register_Prox(rancor, PROX_RancorGroup2_vs_Tyber_and_Urai, 75, underworld)
	
		end
	end

end

function PROX_RancorGroup3_vs_Tyber_and_Urai(prox_obj, trigger_obj)
	local flag_message_given = false
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
        --check to see if Tyber and Urai are in stealth
        if not trigger_obj.Is_Ability_Active("STEALTH") then
        
			--group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
			
			for i, rancor in pairs(group3_rancors) do
				if TestValid(rancor) then
					rancor.Cancel_Event_Object_In_Range(PROX_RancorGroup3_vs_Tyber_and_Urai)
	
				end
			end
			
			if flag_message_given == false then
				--MessageBox("Rancors have detected NON-STEALTHED unit...attacking")
				flag_message_given = true
				flag_group3rancors_guarding = false
			end
			--ALL RANCORS ATTACK
			Create_Thread("Thread_Group3Rancors_Attack_Heroes", trigger_obj)
		end
	end
end

function Thread_Group3Rancors_Attack_Heroes(first_target)

	if first_target == tyber then
		second_target = urai
	else
		second_target = tyber
	end

	while TestValid(first_target) and not first_target.Is_Ability_Active("STEALTH")  do
		--group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
		for i, rancor in pairs(group3_rancors) do
			if TestValid(rancor) and TestValid (first_target) then
				rancor.Attack_Target(first_target)
				--Sleep(0.5)

			end
		end
		Sleep(5)
	end
	
	--do a distance check here
	if TestValid(first_target) and TestValid(second_target) then
	
		local distance_to_second_target = second_target.Get_Distance(first_target)
		local max_distance_allowed = 100
		
		if ( max_distance_allowed > distance_to_second_target) then
		
			while TestValid(second_target) and not second_target.Is_Ability_Active("STEALTH") do
				--group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
				for i, rancor in pairs(group3_rancors) do
					if TestValid(rancor) and TestValid (second_target) then
						rancor.Attack_Target(second_target)
						--Sleep(0.5)

					end
				end
				Sleep(5)
			end
		
		end
	else
		return --everyone is dead...exit and wait for mission loss events to take over
	end
	
	--MessageBox("Rancors returning to initial positions")
	flag_group3rancors_guarding = true
	--group3_rancors = Find_All_Objects_With_Hint("group3-rancor")
	for i, rancor in pairs(group3_rancors) do
		if TestValid(rancor) then
			rancor.Guard_Target(group3_rancor_location_list[i])
			Register_Prox(rancor, PROX_RancorGroup3_vs_Tyber_and_Urai, 75, underworld)

		end
	end

end

function PROX_RancorGroup4_vs_Tyber_and_Urai(prox_obj, trigger_obj)
	local flag_message_given = false
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
        --check to see if Tyber and Urai are in stealth
        if not trigger_obj.Is_Ability_Active("STEALTH") then
        
			--group4_rancors = Find_All_Objects_With_Hint("group4-rancor")
			
			for i, rancor in pairs(group4_rancors) do
				if TestValid(rancor) then
					rancor.Cancel_Event_Object_In_Range(PROX_RancorGroup4_vs_Tyber_and_Urai)

				end
			end
			
			if flag_message_given == false then
				--MessageBox("Rancors have detected NON-STEALTHED unit...attacking")
				flag_message_given = true
				flag_group4rancors_guarding = false
			end
			--ALL RANCORS ATTACK
			Create_Thread("Thread_Group4Rancors_Attack_Heroes", trigger_obj)
		end
	end
end

function Thread_Group4Rancors_Attack_Heroes(first_target)

	if first_target == tyber then
		second_target = urai
	else
		second_target = tyber
	end

	while TestValid(first_target) and not first_target.Is_Ability_Active("STEALTH")  do
		--group4_rancors = Find_All_Objects_With_Hint("group4-rancor")
		for i, rancor in pairs(group4_rancors) do
			if TestValid(rancor) and TestValid (first_target) then
				rancor.Attack_Target(first_target)
				--Sleep(0.5)

			end
		end
		Sleep(5)
	end
	
	--do a distance check here
	if TestValid(first_target) and TestValid(second_target) then
	
		local distance_to_second_target = second_target.Get_Distance(first_target)
		local max_distance_allowed = 100
		
		if ( max_distance_allowed > distance_to_second_target) then
		
			while TestValid(second_target) and not second_target.Is_Ability_Active("STEALTH") do
				--group4_rancors = Find_All_Objects_With_Hint("group3-rancor")
				for i, rancor in pairs(group4_rancors) do
					if TestValid(rancor) and TestValid (second_target) then
						rancor.Attack_Target(second_target)
						--Sleep(0.5)

					end
				end
				Sleep(5)
			end
		
		end
	else
		return --everyone is dead...exit and wait for mission loss events to take over
	end
	
	--MessageBox("Rancors returning to initial positions")
	flag_group4rancors_guarding = true
	--group4_rancors = Find_All_Objects_With_Hint("group4-rancor")
	for i, rancor in pairs(group4_rancors) do
		if TestValid(rancor) then
			rancor.Guard_Target(group4_rancor_location_list[i])
			Register_Prox(rancor, PROX_RancorGroup4_vs_Tyber_and_Urai, 75, underworld)

		end
	end

end


function PROX_Give_GuardTower_Hint(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Give_GuardTower_Hint)
		
		Story_Event("UM06_GIVE_GUARDTOWER_HINT")
		--HINT: The guard towers will reveal stealthed units.
		guardtower01 = Find_Hint("PROP_GUARD_TOWER", "guardtower01")
		
		if TestValid(guardtower01) then
			Create_Thread("Thread_Highlight_Guardtower01", guardtower01)
		end
	end
end

function Thread_Highlight_Guardtower01(guardtower)

	if TestValid(guardtower) then
		guardtower.Highlight(true, 50)
	end
	
	Sleep(10)
	
	if TestValid(guardtower) then
		guardtower.Highlight(false)
	end
	
	
end



function PROX_Give_Rancor_Hint(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Give_Rancor_Hint)
	  
		--HINT: Use Tyber and Urai's Personal Cloaking Fields to sneak past the rancors.
		Story_Event("UM06_GIVE_RANCOR_HINT")
	  
		tyber.Stop()
		urai.Stop()
		
		--reveal around the group1 rancors here
		--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
		for i, rancor in pairs(group1_rancors) do
			if TestValid(rancor) then
				group01_rancor_reveal_list[i] = FogOfWar.Reveal(underworld, rancor, 250,250)

			end
		end

	end
end

function PROX_Give_Backpath_Hint(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Give_Backpath_Hint)
	  
		--Tyber Zann: Looks like this little path leads right into the back of the prison complex.
		if TestValid(singing_prison) then
			Story_Event("UM06_GIVE_BACKPATH_HINT")
		end

	end
end

function PROX_Dialog_Prison01_Frontdoor(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Dialog_Prison01_Frontdoor)
	  
		if TestValid(prison_1_power) and TestValid(singing_prison) then
			--Tyber Zann: Looks like this little path leads right into the back of the prison complex.
			Story_Event("UM06_CUEDIALOG_PRISON01_FRONTDOOR")
			
			--flag prison01 towers here
			--Sleep(4)
			--highlight_prison01_towers()
			Create_Thread("Thread_Highlight_Prison01_Towers")
		end
		

	end
end


function PROX_Dialog_Prison02_Frontdoor(prox_obj, trigger_obj)
	--if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
	if trigger_obj.Get_Owner() == underworld then
		prox_obj.Cancel_Event_Object_In_Range(PROX_Dialog_Prison02_Frontdoor)
	  
		if TestValid(prison_2_power) then
		
			--TEXT_SPEECH_UW_ACT02_M06_42
			--Urai Fen: Those guns will eat us alive if we don't disable them first.
			Story_Event("UM06_CUEDIALOG_PRISON02_FRONTDOOR")
			
			tyber.Stop()
			urai.Stop()
			
			--reveal the turbolaser towers here
			--prison_2_turbolaser_list = Find_All_Objects_With_Hint("prison2turbolaser") 
			for k, turbolaser in pairs(prison_2_turbolaser_list) do
				if TestValid(turbolaser) then
					turbotower_reveal_list[k] = FogOfWar.Reveal(underworld, turbolaser, 250,250)

				end
			end
			
			--radarblip the dam here
			Add_Radar_Blip(prison_2_power, "prison_2_power_radarblip")
		end

	end
end

function PROX_Dialog_Governors_House(prox_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld then
	--if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" 
	--or trigger_obj.Get_Type().Get_Name() == "SILRI" then 
		prox_obj.Cancel_Event_Object_In_Range(PROX_Dialog_Governors_House)
	  
		
		--TEXT_SPEECH_UW_ACT02_M06_21
		--Silri: That is the Imperial Governor’s stronghold.  Once he’s dead, the Empire will likely evacuate Dathomir.  
		--They can’t take us by force, and they won’t surprise us again.
		Story_Event("UM06_CUEDIALOG_GOVERNORS_HOUSE")
		
		tyber.Stop()
		urai.Stop()
		silri.Stop()
		
		governors_house_reveal = FogOfWar.Reveal(underworld, governors_quarters, 500,500)
	

	end
end


function PROX_Player_Crossing_River(prox_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld then
		prox_obj.Cancel_Event_Object_In_Range(PROX_Player_Crossing_River)
		--land the shuttles at prison 03 
		--MessageBox("p3 prox tripped...")
		
		
		Create_Thread("Thread_Player_Crossing_River")
		flag_p3_prox_tripped = true
	end
end

function Thread_Player_Crossing_River()
	while (TestValid(uplink_station) or TestValid(uplink_station02) or TestValid(uplink_station03)) do
		--MessageBox("p3 prox tripped...landing shuttles")
		if flag_first_river_crossing == true then
			flag_first_river_crossing = false
			ReinforceList(empire_prison03_list01, prison03_lz01, empire, true, true, true)
			ReinforceList(empire_prison03_list02, prison03_lz02, empire, true, true, true)
		else
			ReinforceList(empire_prison03_list01, prison03_lz01, empire, true, true, false)
			ReinforceList(empire_prison03_list02, prison03_lz02, empire, true, true, false)
		end
		Sleep(90)
	end
end


function PROX_Spawn_at_Governors_House(prox_obj, trigger_obj)
	--if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" 
	--or trigger_obj.Get_Type().Get_Name() == "SILRI" then 
	if trigger_obj.Get_Owner() == underworld then
			
			prox_obj.Cancel_Event_Object_In_Range(PROX_Spawn_at_Governors_House)
		
			Create_Thread("Thread_Spawn_at_Governors_House")
	end
end

function Thread_Spawn_at_Governors_House()
	local spawn_times = 0
	local spawn_max = 3
	while TestValid(governors_quarters) do
		governor_spawnspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-governor-spawn")
	
		spawned_guard_list = Spawn_Unit(Find_Object_Type("IMPERIAL_GUARD_COMPANY"), governor_spawnspot, empire)
		Create_Thread("Find_And_Attack",spawned_guard_list)
		spawn_times = spawn_times + 1
		if spawn_times >= spawn_max then
			break
		end
	
		Sleep(10)
	end
end


function PROX_Reveal_Stealth(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "UM06_TYBER_ZANN" or trigger_obj.Get_Type().Get_Name() == "URAI_FEN" then 
		if trigger_obj.Is_Ability_Active("STEALTH") then
			--turn off stealth
			trigger_obj.Activate_Ability("STEALTH", false)
		end
	end
end



function Thread_Highlight_Prison01_Towers()
	prison01_tower_list = Find_All_Objects_With_Hint("p1-tower") 
	for i, guardtower in pairs(prison01_tower_list) do
		if TestValid(guardtower) then
			guardtower.Highlight(true, 50)
			Add_Radar_Blip(guardtower, "somename_".. i)
			--reveal around the group1 rancors here
			guardtower_reveal_list[i] = FogOfWar.Reveal(underworld, guardtower, 250,250)
		
		end
	end
	
	Sleep(10)
	
	for i, guardtower in pairs(prison01_tower_list) do
		if TestValid(guardtower) then
			guardtower.Highlight(false)
			Remove_Radar_Blip("somename_".. i)
		end
	end
	
	
end

function State_OBJECTIVE_ADD_Destroy_Prison01_PowerGenerator(message)
	if message == OnEnter then
	
		if TestValid(prison_1_power) then
			prison_1_power.Highlight(true)
			Add_Radar_Blip(prison_1_power, "radar_blip_prison_1_power")
			--Create_Thread("Death_Monitor_Prison1_Power")
		else
			--MessageBox("Cannot find Prison_1_power...tell Dan Etter Immediately.")
		end
	
	
	end
end

function State_UM06_OBJECTIVE_ADD_Destroy_Singing_Mountains_Nightsister_Prison(message)
	if message == OnEnter then
		if TestValid(singing_prison) then 
			singing_prison.Highlight(true, 50)
			Add_Radar_Blip(singing_prison, "radar_blip_singing_prison")
			--Create_Thread("Death_Monitor_Prison1_Power")
		else
			--MessageBox("Cannot find singing_prison...tell Dan Etter Immediately.")
		end
	end
end

function State_UM06_OBJECTIVE_ADD_Destroy_Prison02(message)
	if message == OnEnter then
		if TestValid(frenzied_prison) then 
			frenzied_prison.Highlight(true, 50)
			Add_Radar_Blip(frenzied_prison, "radar_blip_frenzied_prison")
		else
			JoeMessage("Cannot find frenzied_prison...tell Dan Etter Immediately.")
		end
	end
end



function State_UM06_OBJECTIVE_ADD_Destroy_Prison03(message)
	if message == OnEnter then
		if TestValid(misty_prison) then 
			misty_prison.Highlight(true, 50)
			Add_Radar_Blip(misty_prison, "radar_blip_misty_prison")
		else
			JoeMessage("Cannot find misty_prison...tell Dan Etter Immediately.")
		end
	end
end



function State_UM06_OBJECTIVE_ADD_Destroy_Governors_Quarters(message)
	if message == OnEnter then
		if TestValid(governors_quarters) then 
			governors_quarters.Highlight(true, 50)
			Add_Radar_Blip(governors_quarters, "radar_blip_gov_quarters")
		else
			JoeMessage("Cannot find governors_quarters...tell Dan Etter Immediately.")
		end
	end
end




function State_Underworld_A02M06_Victory_Trigger(message)
	if message == OnEnter then
		--MessageBox("Governors Quarters destroyed!  Trigger Victory!")
	end
end

function Story_Mode_Service()
	--MessageBox("State Hit!")
	if not TestValid(prison_2_power) then
		if not prison_2_power_down and prison_2_power_identified then
			prison_2_power_down = true
			Create_Thread("Prison_2_Power_Down")
			--paddlewheel.Play_Animation("Idle",false)
		end
	end
	if not TestValid(singing_prison) and not singing_tripped then
		singing_tripped = true
		--MessageBox("Singing prison destroyed!  Sending Message!")
		Story_Event("TRIGGER_MISSION_06_SINGING")
		Create_Thread("Thread_Cinematic_Tyber_Meets_Sisters")
		
		gate.Make_Invulnerable(false)
		gate.Set_Cannot_Be_Killed(false)
		Create_Thread("Thread_Death_Monitor_Gate")
	end
	if not TestValid(frenzied_prison) and not frenzied_tripped then
		frenzied_tripped = true
		--MessageBox("Frenzied prison destroyed!  Sending Message!")
		Story_Event("TRIGGER_MISSION_06_FRENZIED")
		Create_Thread("Thread_Spawn_Prison02_Sisters")
		Create_Thread("Thread_Cinematic_Tyber_Meets_Silri")
	end
	if not TestValid(misty_prison) and not misty_tripped then
		misty_tripped = true
		--MessageBox("Misty prison destroyed!  Sending Message!")
		Story_Event("TRIGGER_MISSION_06_MISTY")
		Create_Thread("Thread_Spawn_Prison03_Sisters")
		Create_Thread("Thread_Spawn_Prisoners", 3) --the "2" param tells which prison to spawn at
	end
	if not TestValid(governors_quarters) and governors_quarters_identified and not victory_triggered then
		victory_triggered = true
		--MessageBox("Governors Quarters destroyed!  Sending Message!")
		--Story_Event("TRIGGER_MISSION_06_VICTORY")
		Create_Thread("Thread_Cinematic_Finale")
	end
end

function Thread_Spawn_Prison02_Sisters()

	prison02_sister_spawnspot = Find_Hint("MARKER_GENERIC_BLUE", "prison02-sisterspawn")
	
	prison02_sister01_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison02-sister01goto")
	prison02_sister02_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison02-sister02goto")
	prison02_sister03_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison02-sister03goto")
	
	p2sister1_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison02_sister_spawnspot, underworld)
	
	for i,sister in pairs(p2sister1_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison02_sister01_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)
	
	p2sister2_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison02_sister_spawnspot, underworld)
	
	for i,sister in pairs(p2sister2_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison02_sister02_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)
	
	p2sister3_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison02_sister_spawnspot, underworld)
	
	for i,sister in pairs(p2sister3_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison02_sister03_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)

end


function Thread_Spawn_Prison03_Sisters()

	prison03_sister_spawnspot = Find_Hint("MARKER_GENERIC_BLUE", "prison03-sisterspawn")
	
	prison03_sister01_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison03-sister01goto")
	prison03_sister02_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison03-sister02goto")
	prison03_sister03_goto = Find_Hint("MARKER_GENERIC_BLUE", "prison03-sister03goto")
	
	p3sister1_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison03_sister_spawnspot, underworld)
	
	for i,sister in pairs(p3sister1_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison03_sister01_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)
	
	p3sister2_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison03_sister_spawnspot, underworld)
	
	for i,sister in pairs(p3sister2_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison03_sister02_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)
	
	p3sister3_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), prison03_sister_spawnspot, underworld)
	
	for i,sister in pairs(p3sister3_list) do
		--sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(prison03_sister03_goto)
		Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
	end
	
	Sleep(0.5)
	
	Create_Thread("Thread_Highlight_Nightsisters")

end

function Prison_2_Power_Down()
	if prison_2_power_down then
		prison_2_turret_list = Find_All_Objects_With_Hint("prison2turret")
		--prison_2_turbolaser_list = Find_All_Objects_With_Hint("prison2turbolaser")
		
		for k, turret in pairs(prison_2_turret_list) do
			if TestValid(turret) then
				--MessageBox("Turret faction switched to neutral!")
				turret.Change_Owner(neutral)

			end
		end
		
		for k, turbolaser in pairs(prison_2_turbolaser_list) do
			if TestValid(turbolaser) then
				--MessageBox("turbolaser faction switched to neutral!")
				turbolaser.Change_Owner(neutral)
			end
		end
	end
end







function PROX_Rancor_NightSister(prox_obj, trigger_obj)
	


	if trigger_obj.Get_Type().Get_Name() == "RANCOR_DARK_ALLY"  then 
        
		if rancors_in_use[trigger_obj] then
			return
		end
        
		rancors_in_use[trigger_obj] = true
		
		if sisters_in_use[prox_obj] then
			prox_obj.Cancel_Event_Object_In_Range(PROX_Rancor_NightSister)
			return
		end
		sisters_in_use[prox_obj] = true
		
		prox_obj.Cancel_Event_Object_In_Range(PROX_Rancor_NightSister)
		--MessageBox("Night Sister tripped Rancor prox event.")
		prox_obj.Make_Invulnerable(true)
		trigger_obj.Make_Invulnerable(true)
	  --current_sister = prox_obj
		local thread_info = {}
		thread_info[1] = prox_obj
		thread_info[2] = trigger_obj
		  
		Create_Thread("Mount_Rancor", thread_info)
	end
end

function Mount_Rancor(thread_info)
    ThreadValue.Set("rancor", thread_info[2])
    ThreadValue.Set("current_sister", thread_info[1])

    rancor = ThreadValue.Get("rancor");
    current_sister = ThreadValue.Get("current_sister");

	--MessageBox("Night Sister moving to rancor.")
	if TestValid(rancor) then
		--MessageBox("rancor is valid.")
		if TestValid(current_sister) then
			--MessageBox("Night Sister is valid.")
			rancor.Stop()
			rancor_loc = rancor.Get_Position()
            BlockOnCommand(current_sister.Move_To(rancor_loc))
			
            rancor = ThreadValue.Get("rancor");
            current_sister = ThreadValue.Get("current_sister");

			current_sister.Despawn()
			
			night_sister = Create_Generic_Object("UM06_Night_Sister",rancor_loc,underworld)
			if TestValid(night_sister) then
				night_sister.Teleport_And_Face(rancor)
			else
				JoeMessage("night_sister coming back not valid")
			end
			
			rancor.Despawn()
		end
	end
end






-- ##########################################################################################
--	Cinematic functions
-- ##########################################################################################
function Thread_Cinematic_Finale()
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	
	Cancel_Fast_Forward()
	
	Sleep(0.5)
	
	--Entering_Cinematic()
	
	
	
	finale_tyber_startspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-tyberspot")
	finale_urai_startspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-uraispot")
	finale_silri_startspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-silrispot")
	finale_cuddles_startspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-cuddlesspot")
	governor_spawnspot = Find_Hint("MARKER_GENERIC_BLUE", "finale-governor-spawn")
	governor_goto = Find_Hint("MARKER_GENERIC_BLUE", "finale-governor-goto")
	
	tyber.Teleport_And_Face(finale_tyber_startspot)
	urai.Teleport_And_Face(finale_urai_startspot)
	silri.Teleport_And_Face(finale_silri_startspot)
	
	tyber.In_End_Cinematic(true)
	urai.In_End_Cinematic(true)
	silri.In_End_Cinematic(true)
	
	--get rid of any remaining imperial guards for a clean cinematic
	--pointguard_list = Find_All_Objects_With_Hint("pointguard")
	for i, pointguard in pairs(pointguard_list) do
		if TestValid(pointguard) then
			pointguard.Despawn()

			
		end
	end
	
	cuddles = Find_First_Object("Cuddles_The_Rancor")
	if not TestValid(cuddles) then
		--MessageBox("not registering cuddles")
	else
		cuddles.Stop()
		Sleep(1)
		cuddles.Teleport_And_Face(finale_cuddles_startspot)
		cuddles.Suspend_Locomotor(true)
		cuddles.Prevent_AI_Usage(true)
		cuddles.Prevent_All_Fire(true)
		cuddles.Make_Invulnerable(true)
		cuddles.Prevent_Opportunity_Fire(true)
		cuddles.In_End_Cinematic(true)
	end
	
	Do_End_Cinematic_Cleanup()
	
	--tyber.Suspend_Locomotor(true)
	tyber.Prevent_AI_Usage(true)
	tyber.Prevent_All_Fire(true)
	tyber.Make_Invulnerable(true)
	tyber.Prevent_Opportunity_Fire(true)
	
	--urai.Suspend_Locomotor(true)
	urai.Prevent_AI_Usage(true)
	urai.Prevent_All_Fire(true)
	urai.Make_Invulnerable(true)
	urai.Prevent_Opportunity_Fire(true)
	
	silri.Suspend_Locomotor(false)
	silri.Prevent_AI_Usage(true)
	silri.Prevent_All_Fire(false)
	silri.Make_Invulnerable(true)
	silri.Prevent_Opportunity_Fire(true)
	silri.Change_Owner(underworld)
	
	governor_list = Spawn_Unit(Find_Object_Type("GENERIC_FIELD_COMMANDER_EMPIRE"), governor_spawnspot, empire)
	governor = governor_list[1]
	
	governor.Prevent_All_Fire(true)
	governor.Make_Invulnerable(true)
	governor.Prevent_Opportunity_Fire(true)
	
	Create_Thread("Death_Monitor_Governor", governor)
	Create_Thread("Governor_Runs_Out")
	
	silri.Attack_Target(governor)

	finale_camera_start = Find_Hint("MARKER_GENERIC_RED", "finale-camera-start")
	finale_target_start = Find_Hint("MARKER_GENERIC_RED", "finale-camera-target")
	finale_camera_move01 = Find_Hint("MARKER_GENERIC_RED", "finale-camera-move01")
	
	
	Transition_Cinematic_Camera_Key(finale_camera_start, 0, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(finale_target_start, 0, 0, 0, 0, 0, 0, 0, 0)
	
	Transition_Cinematic_Camera_Key(finale_camera_move01, 5, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(0.5)
	Fade_Screen_In(1)
	
	Story_Event("UM06_CUE_FINALE_CONVERSATION")
	--TEXT_SPEECH_UW_ACT02_M06_22
	--Imperial Governor: Wait, please! You can ransom me! 
	--I have high-ranking friends! I've a family and they need me. 
	--I can help you, send a message to powerful people!
	
	
end

function Governor_Runs_Out()
	
	if not TestValid(governor) then
		JoeMessage("UM06 no governor ... tell Joe G immediately")
	else
		BlockOnCommand(governor.Move_To(governor_goto))
		if TestValid(governor) and TestValid(silri) then
			governor.Turn_To_Face(silri)
			governor.Make_Invulnerable(false)
			governor.Prevent_Opportunity_Fire(false)
		end
		
	end
end


function State_UM06_DIALOG_Finale_Line01_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_FINALE_CONVERSATION_LINE2")
		--TEXT_SPEECH_UW_ACT02_M06_23
		--Silri: You quartered in four bloody pieces sends a better message.
		
		Transition_Cinematic_Target_Key(silri, 1, 0, 0, 0, 0, silri, 0, 0)
	end
end

function State_UM06_DIALOG_Finale_Line02_Remove_Text (message)
	if message == OnEnter then
		if TestValid(governor) then
			governor.Turn_To_Face(silri)
		end
	
		while (flag_governor_dead == false) do
			Sleep(1)
		end
		
		Sleep(2)
		
		finale_camera_tyber = Find_Hint("MARKER_GENERIC_RED", "finale-camera-tyber")
		
		Transition_Cinematic_Camera_Key(finale_camera_tyber, 0, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
		
		Story_Event("UM06_CUE_FINALE_CONVERSATION_LINE3")
		--TEXT_SPEECH_UW_ACT02_M06_24
		--Tyber Zann: There - you have your revenge, you know what you must do now.
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on tyber
	end
end

function State_UM06_DIALOG_Finale_Line03_Remove_Text (message)
	if message == OnEnter then
		
		Transition_Cinematic_Target_Key(silri, 0, 0, 0, 10, 0, 0, 0, 0)
		silri.Turn_To_Face(tyber)
		Sleep(1)
		
		Story_Event("UM06_CUE_FINALE_CONVERSATION_LINE4")
		--TEXT_SPEECH_UW_ACT02_M06_25
		--Silri: I will honor our bargain.
		
		silri.Play_Animation("Cinematic", false, 0) --Cinematic_00 – silri talk anim
	end
end

function State_UM06_DIALOG_Finale_Line04_Remove_Text (message)
	if message == OnEnter then
		
		finale_camera_penultimate = Find_Hint("MARKER_GENERIC_RED", "finale-show-tyber-and-urai")
		--Transition_Cinematic_Camera_Key(finale_camera_penultimate, 1, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(urai, 0, 0, 0, 10, 0, 0, 0, 0)
		
		finale_camera_final = Find_Hint("MARKER_GENERIC_RED", "finale-camera-final")
		finale_target_final = Find_Hint("MARKER_GENERIC_RED", "finale-target-final")
		Transition_Cinematic_Target_Key(finale_target_final, 3, 0, 0, 15, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(finale_camera_final, 3, 0, 0, 0, 0, 0, 0, 0)
		
		urai.Turn_To_Face(tyber)
		Story_Event("UM06_CUE_FINALE_CONVERSATION_LINE5")
		--TEXT_SPEECH_UW_ACT02_M06_26
		--Urai Fen: This is a mistake Tyber.  
		--She will betray you as soon as she gets what she wants.
		
		urai.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on urai
		
		Sleep(0.5)
		tyber.Turn_To_Face(urai)
		
		
		
			
	end
end

function State_UM06_DIALOG_Finale_Line05_Remove_Text (message)
	if message == OnEnter then
		
		
		
		--Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
		
		Story_Event("UM06_CUE_FINALE_CONVERSATION_LINE6")
		--TEXT_SPEECH_UW_ACT02_M06_27
		--Tyber Zann: We have to chance it - she can access the artifact, 
		--and I need to know what it contains before I use it to get past the Imperial forces and complete my plans.  
		--We can deal with her until then.  Afterwards, you can kill her.
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
	end
end











function State_UM06_DIALOG_Finale_Line06_Remove_Text (message)
	if message == OnEnter then

		Fade_Screen_Out(0.5)
		Sleep(1)

		Fade_Screen_In(0.5)
		End_Cinematic_Camera()
		--Lock_Controls(0)
		Letter_Box_Out(0)
		Sleep(1)
		Story_Event("TRIGGER_MISSION_06_VICTORY")	
	end
end




function Thread_Cinematic_Tyber_Meets_Silri()
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	
	Cancel_Fast_Forward()
	
	
	Entering_Cinematic()
	
	Create_Thread("Thread_Spawn_Prisoners", 2) --the "2" param tells which prison to spawn at
	
	
	Sleep(0.5)
	
	--delete silri's guards if still present
	--silris_guards = Find_All_Objects_With_Hint("silri-pointguard")
	for i, pointguard in pairs(silris_guards) do
		if TestValid(pointguard) then
			pointguard.Despawn()

		end
	end
	
	silrimidtro_camera_start = Find_Hint("MARKER_GENERIC_RED", "midtro01-showsilri-camerastart")
	silrimidtro_target_start = Find_Hint("MARKER_GENERIC_RED", "silrimidtro-cameratarget")
	
	silrimidtro_camera_move01 = Find_Hint("MARKER_GENERIC_RED", "silri-midtro-shot01-cameramove")
	
	silrimidtro_tyber_startspot = Find_Hint("MARKER_GENERIC_BLUE", "silri-midtro-tyberstart")
	silrimidtro_urai_startspot = Find_Hint("MARKER_GENERIC_BLUE", "silri-midtro-uraistart")
	
	silrimidtro_tyber_gotospot = Find_Hint("MARKER_GENERIC_BLUE", "silrimidtro-tyberspot")
	silrimidtro_urai_gotospot = Find_Hint("MARKER_GENERIC_BLUE", "silrimidtro-uraispot")
	
	tyber.Teleport_And_Face(silrimidtro_tyber_startspot)
	urai.Teleport_And_Face(silrimidtro_urai_startspot)
	
	
	
	
	Create_Thread("Tyber_Moves_To_Meet_Silri")
	Create_Thread("Urai_Moves_To_Meet_Silri")
	
	--tyber.Suspend_Locomotor(true)
	tyber.Prevent_AI_Usage(true)
	tyber.Prevent_All_Fire(true)
	tyber.Make_Invulnerable(true)
	tyber.Prevent_Opportunity_Fire(true)
	
	--urai.Suspend_Locomotor(true)
	urai.Prevent_AI_Usage(true)
	urai.Prevent_All_Fire(true)
	urai.Make_Invulnerable(true)
	urai.Prevent_Opportunity_Fire(true)
	
	Transition_Cinematic_Camera_Key(silrimidtro_camera_start, 0, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(silri, 0, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(0.5)
	Fade_Screen_In(1)
	silri.Change_Owner(underworld)
	
	
	
	Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION")
	--TEXT_SPEECH_UW_ACT02_M06_07
	--Silri: I'm your close friend. It's terrible to see me locked in this cell. 
	--Open the door for your friend.
	
	Sleep(0.5)
	silri.Play_Animation("Cinematic", false, 1) --Cinematic_01 – silri doing force-mind-control arm swipe anim
	
	--close up on Silri, pan to show urai and tyber running up
	
	Sleep(1)
	Transition_Cinematic_Camera_Key(silrimidtro_camera_move01, 0, 0, 0, 5, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(urai, 0, 0, 0, 0, 0, urai, 0, 0)
	
	
end



function State_UM06_DIALOG_Silri_Meets_Tyber_Line01_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE2")
		--TEXT_SPEECH_UW_ACT02_M06_08
		--Tyber Zann: Urai, if she tries that Jedi mind control again, shoot her.  
		--You must be Silri.  You will find both of us far from weak minded, witch.  
		--Everything has a cost and opening that door has a high one.
		
		
		
		silrimidtro_camera_tyber = Find_Hint("MARKER_GENERIC_RED", "silrimidtro-show-tyber")
		
		--close up of Tyber
		Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
		

	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line02_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE3")
		--TEXT_SPEECH_UW_ACT02_M06_09
		--Silri: When I'm free of this cell you'll be the second one I kill, no matter what the cost. 
		--No one taunts me and gets away with it!
		
		silri.Play_Animation("Cinematic", true, 0) --Cinematic_00 – silri talk anim
		
		--close up of Silri
		silrimidtro_camera_silri = Find_Hint("MARKER_GENERIC_RED", "silrimidtro-cameratarget")
		Transition_Cinematic_Camera_Key(silrimidtro_camera_silri, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(silri, 0, 0, 0, 10, 0, 0, 0, 0)
		
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line03_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE4")
		--TEXT_SPEECH_UW_ACT02_M06_10
		--Tyber Zann: Now now, I never said I wouldn't let you out, I said I didn't have a reason to…yet.  
		--Do you know what this is? 
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
		
		--close up of Tyber
		Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
		
		
		Sleep(2.5)
		tyber.Play_Animation("Cinematic", false, 1) --Cinematic_01 – tyber presenting the artifact
		
		Sleep(2)
		
		tyber.Play_Animation("idle", false, 1)
		
		
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line04_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE5")
		--TEXT_SPEECH_UW_ACT02_M06_11
		--Silri: You hold a Sith creation, and it's very ancient.  Where did you get it? 
		
		silri.Play_Animation("Cinematic", false, 0) --Cinematic_00 – silri talk anim
		
		--close up of Silri
		Transition_Cinematic_Camera_Key(silrimidtro_camera_move01, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(silrimidtro_camera_move01, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line05_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE6")
		--TEXT_SPEECH_UW_ACT02_M06_12
		--Tyber Zann: That doesn't matter.  Can you access it?
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
		
		--close up of Tyber -- stay at old shot
		--Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line06_Remove_Text (message)
	if message == OnEnter then
	
		tyber.Play_Animation("idle", false, 1)
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE7")
		--TEXT_SPEECH_UW_ACT02_M06_13
		--Silri: I could, given time.  
		--But the cost of that is worth more than just my freedom.
		
		silri.Play_Animation("Cinematic", false, 0) --Cinematic_00 – silri talk anim
		
		--close up of Silri
		Transition_Cinematic_Camera_Key(silrimidtro_camera_silri, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(silri, 0, 0, 0, 10, 0, 0, 0, 0)
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line07_Remove_Text (message)
	if message == OnEnter then
	
		silri.Play_Animation("idle", false, 1)
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE8")
		--TEXT_SPEECH_UW_ACT02_M06_16
		--Tyber Zann: What do you want?
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
		
		--close up of Tyber
		Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line08_Remove_Text (message)
	if message == OnEnter then
	
		tyber.Play_Animation("idle", false, 1)
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE9")
		--TEXT_SPEECH_UW_ACT02_M06_17
		--Silri: I want to be freed of this cell. 
		--I want to get off this planet to gather the resources I need to open your bauble. 
		--I also want one other thing.
		
		silri.Play_Animation("Cinematic", false, 0) --Cinematic_00 – silri talk anim
		
		--over shoulder shot of Silri -- target tyber
		Transition_Cinematic_Camera_Key(silrimidtro_camera_move01, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line09_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE10")
		--TEXT_SPEECH_UW_ACT02_M06_18
		--Urai Fen: Do not trust her Tyber. 
		--I see the force crackling through her body and reaching out 
		--to touch you even as we speak.
		
		--close up of Urai
		--silrimidtro_camera_urai = Find_Hint("MARKER_GENERIC_RED", "silrimidtro-show-urai")
		Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(urai, 0, 0, 0, 10, 0, 0, 0, 0)
		
		urai.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on urai

	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line10_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE11")
		--TEXT_SPEECH_UW_ACT02_M06_19
		--Tyber Zann: Urai, you just continue managing our forces and watching my back - 
		--I'll do the rest. Your terms are acceptable. 
		--Know this, witch, if you ever cross me or hinder my plans, 
		--I'll kill you and this entire world without a thought. 
		--You'll get no second chances and be allowed no mistakes. 
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
		
		--stay on same shot
		--Transition_Cinematic_Camera_Key(silrimidtro_camera_tyber, 0, 0, 0, 5, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(tyber, 1, 0, 0, 10, 0, 0, 0, 0)
		
		--tyber.Turn_To_Face(urai)
		--Sleep(1)
		--tyber.Turn_To_Face(silri)
			
	end
end

function State_UM06_DIALOG_Silri_Meets_Tyber_Line11_Remove_Text (message)
	if message == OnEnter then
		
		Story_Event("UM06_CUE_SILRI_INTRO_CONVERSATION_LINE12")
		--TEXT_SPEECH_UW_ACT02_M06_20
		--Silri: Understood, now release me from this cell!
		
		silri.Play_Animation("Cinematic", false, 0) --Cinematic_00 – silri talk anim
		
		--target back to silri -- over the shoulder shot
		Transition_Cinematic_Camera_Key(silrimidtro_camera_move01, 0, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end

function Tyber_Moves_To_Meet_Silri()
	if not TestValid(tyber) then
		JoeMessage("Silri Midtro cannot find tyber...aborting mission...tell Joe G immediately!")
		ScriptExit()
	end
	
	BlockOnCommand(tyber.Move_To(silrimidtro_tyber_gotospot))
	BlockOnCommand(tyber.Turn_To_Face(silri))	
	tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
end

function Urai_Moves_To_Meet_Silri()
	if not TestValid(urai) then
		JoeMessage("Silri Midtro cannot find urai...aborting mission...tell Joe G immediately!")
		ScriptExit()
	end
	
	BlockOnCommand(urai.Move_To(silrimidtro_urai_gotospot))
	urai.Turn_To_Face(silri)	
end








--this takes us out of the silri-into cinematic
function State_UM06_DIALOG_Silri_Meets_Tyber_Line12_Remove_Text (message)
	if message == OnEnter then
		Fade_Screen_Out(1)
		Sleep(1)
		
		Leaving_Cinematic()
	
		tyber.Suspend_Locomotor(false)
		tyber.Prevent_All_Fire(false)
		tyber.Make_Invulnerable(false)
		tyber.Prevent_Opportunity_Fire(false)
		
		urai.Suspend_Locomotor(false)
		urai.Prevent_All_Fire(false)
		urai.Make_Invulnerable(false)
		urai.Prevent_Opportunity_Fire(false)
		
		silri_teleport_spot = Find_Hint("MARKER_GENERIC_BLUE", "silri-teleport")
		silri.Teleport_And_Face(silri_teleport_spot)
		
		silri.Suspend_Locomotor(false)
		silri.Prevent_All_Fire(false)
		silri.Make_Invulnerable(false)
		silri.Set_Cannot_Be_Killed(false)
		silri.Prevent_Opportunity_Fire(false)
		
			 
		Create_Thread("Death_Monitor_Silri")
		
		Point_Camera_At(tyber)
	
		Lock_Controls(0)
		End_Cinematic_Camera()
		Letter_Box_Out(0)	
		Suspend_AI(0)
		Fade_Screen_In(1)
		
		Create_Thread("Thread_Highlight_Nightsisters")
		--Create_Thread("Thread_Prison_Transports")
		
		
		
	end
end











function Thread_Cinematic_Tyber_Meets_Sisters()
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	
	Cancel_Fast_Forward()
	
	Sleep(0.5)
	
	Entering_Cinematic()
	
	tyber_startspot = Find_Hint("MARKER_GENERIC_BLUE", "midtro01-tyber")
	urai_startspot = Find_Hint("MARKER_GENERIC_BLUE", "midtro01-urai")
	sister_spawnspot = Find_Hint("MARKER_GENERIC_BLUE", "midtro01-sister-spawn")
	sister1_gotospot = Find_Hint("MARKER_GENERIC_BLUE", "midtro01-sistergoto")
	
	
	
	midtro01_camera_start = Find_Hint("MARKER_GENERIC_RED", "midtro01-camerastart")
	midtro01_target_start = Find_Hint("MARKER_GENERIC_RED", "midtro01-cameralook-01")
	
	--set up first shot
	tyber.Teleport_And_Face(tyber_startspot)
	urai.Teleport_And_Face(urai_startspot)
	
	tyber.Stop()
	urai.Stop()
	
	Sleep(1)
	
	
	
	tyber.Suspend_Locomotor(true)
	tyber.Prevent_AI_Usage(true)
	tyber.Prevent_All_Fire(true)
	tyber.Make_Invulnerable(true)
	tyber.Prevent_Opportunity_Fire(true)
	
	urai.Suspend_Locomotor(true)
	urai.Prevent_AI_Usage(true)
	urai.Prevent_All_Fire(true)
	urai.Make_Invulnerable(true)
	urai.Prevent_Opportunity_Fire(true)
	
	--silris_guards = Find_All_Objects_With_Hint("silri-pointguard")
	for i, pointguard in pairs(silris_guards) do
		if TestValid(pointguard) then
			pointguard.Enable_Dynamic_LOD(false)
		end
	end
	
	--spawn in a bunch of misc prsioners here
	Create_Thread("Thread_Spawn_Prisoners", 1) --the "1" param tells which prison to spawn at
	
	--spawn some night sisters
	sister1_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), sister_spawnspot, underworld)
	Create_Thread("Thread_Spawn_Remaining_Prison01_Sisters")
	
	
	Transition_Cinematic_Camera_Key(midtro01_camera_start, 0, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(midtro01_target_start, 0, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(0.5)
	Fade_Screen_In(1)
	
	
	sister01 = sister1_list[1]
	sister01.Prevent_AI_Usage(true)
	sister01.Prevent_All_Fire(true)
	sister01.Make_Invulnerable(true)
	sister01.Prevent_Opportunity_Fire(true)
	BlockOnCommand(sister01.Move_To(sister1_gotospot))
	
	Sleep(1)
	
	Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION")
	--TEXT_SPEECH_UW_ACT02_M06_38
	--Night Sister: Why have you freed us?
	
end

function Thread_Spawn_Prisoners(prison)
	if prison == 1 then
		--MessageBox("Thread_Spawn_Prisoners prison == 1")
		spawn_flag01 = Find_Hint("MARKER_GENERIC_YELLOW", "prison01-prisoner-spawn01")
		spawn_flag02 = Find_Hint("MARKER_GENERIC_YELLOW", "prison01-prisoner-spawn02")
		spawn_flag03 = Find_Hint("MARKER_GENERIC_YELLOW", "prison01-prisoner-spawn03")
	elseif prison == 2 then
		--MessageBox("Thread_Spawn_Prisoners prison == 2")
		spawn_flag01 = Find_Hint("MARKER_GENERIC_YELLOW", "prison02-prisoner-spawn01")
		spawn_flag02 = Find_Hint("MARKER_GENERIC_YELLOW", "prison02-prisoner-spawn02")
		spawn_flag03 = Find_Hint("MARKER_GENERIC_YELLOW", "prison02-prisoner-spawn03")
	else
		--MessageBox("Thread_Spawn_Prisoners prison == other")
		spawn_flag01 = Find_Hint("MARKER_GENERIC_YELLOW", "prison03-prisoner-spawn01")
		spawn_flag02 = Find_Hint("MARKER_GENERIC_YELLOW", "prison03-prisoner-spawn02")
		spawn_flag03 = Find_Hint("MARKER_GENERIC_YELLOW", "prison03-prisoner-spawn03")
	end
	
	ewok_handler01 = Spawn_Unit(Find_Object_Type("UM06_PRISONER_EWOK_HANDLER"), spawn_flag01, underworld)
	ewok_handler02 = Spawn_Unit(Find_Object_Type("UM06_PRISONER_EWOK_HANDLER"), spawn_flag02, underworld)
	ewok_handler03 = Spawn_Unit(Find_Object_Type("UM06_PRISONER_EWOK_HANDLER"), spawn_flag03, underworld)
	
	prison01_prisoner_gotospot = Find_Hint("MARKER_GENERIC_YELLOW", "prison01-prisoner-goto")
	prison02_prisoner_gotospot = Find_Hint("MARKER_GENERIC_YELLOW", "prison02-prisoner-goto")
	prison03_prisoner_gotospot = Find_Hint("MARKER_GENERIC_YELLOW", "prison03-prisoner-goto")
	
	if prison == 1 then
		--Create_Thread("Thread_Prison01_Prisoners_Emerge", spawned_prisoner)
		for i, ewok_handler in pairs(ewok_handler01) do
			ewok_handler.Move_To(prison01_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler02) do
			ewok_handler.Move_To(prison01_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler03) do
			ewok_handler.Move_To(prison01_prisoner_gotospot)
		end
	elseif prison == 2 then
		--Create_Thread("Thread_Prison02_Prisoners_Emerge", spawned_prisoner)
		for i, ewok_handler in pairs(ewok_handler01) do
			ewok_handler.Move_To(prison02_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler02) do
			ewok_handler.Move_To(prison02_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler03) do
			ewok_handler.Move_To(prison02_prisoner_gotospot)
		end
	else
		--Create_Thread("Thread_Prison03_Prisoners_Emerge", spawned_prisoner)
		for i, ewok_handler in pairs(ewok_handler01) do
			ewok_handler.Move_To(prison03_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler02)do
			ewok_handler.Move_To(prison03_prisoner_gotospot)
		end
		
		for i, ewok_handler in pairs(ewok_handler03) do
			ewok_handler.Move_To(prison03_prisoner_gotospot)
		end
	end

	--random pick of how many prisoners to spawn
	local num_list_total = GameRandom(4,5)
	
	--verify how many prisoner choices you have
	local top_end = 0
	for i, possible_prisoners in pairs(possible_prisoners_list) do
		top_end = top_end + 1
	end
	
	if top_end == 0 then
		return -- list is empty...abort
	end
	
	--random pick of group composition
	for i=1,num_list_total do

		prisoner = possible_prisoners_list[GameRandom(1,top_end)]

			--random pick of spawn location
		local roll_spawnflag = GameRandom(1,3)
		if roll_spawnflag == 1 then
			--prisoner_list = SpawnList(prisoner_spawn_list, spawn_flag01, underworld, false, true)
			spawned_prisoner = Spawn_Unit(Find_Object_Type(prisoner), spawn_flag01, underworld)
		elseif roll_spawnflag == 2 then
			spawned_prisoner = Spawn_Unit(Find_Object_Type(prisoner), spawn_flag02, underworld)
		else
			spawned_prisoner = Spawn_Unit(Find_Object_Type(prisoner), spawn_flag03, underworld)
		end
		
		
		
		if prison == 1 then
			--Create_Thread("Thread_Prison01_Prisoners_Emerge", spawned_prisoner)
			for i, prisoner in pairs(spawned_prisoner) do
				prisoner.Move_To(prison01_prisoner_gotospot)
			end
		elseif prison == 2 then
			--Create_Thread("Thread_Prison02_Prisoners_Emerge", spawned_prisoner)
			for i, prisoner in pairs(spawned_prisoner) do
				prisoner.Move_To(prison02_prisoner_gotospot)
			end
		else
			--Create_Thread("Thread_Prison03_Prisoners_Emerge", spawned_prisoner)
			for i, prisoner in pairs(spawned_prisoner) do
				prisoner.Move_To(prison03_prisoner_gotospot)
			end
		end
		
		Sleep(0.25)
		
		
		
	end
	
		

end



function Thread_Spawn_Remaining_Prison01_Sisters()
	sister2_gotospot = Find_Hint("MARKER_GENERIC_BLUE", "sister2-goto")
	sister3_gotospot = Find_Hint("MARKER_GENERIC_BLUE", "sister3-goto")

	Sleep(1)
	sister2_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), sister_spawnspot, underworld)
	for i,sister in pairs(sister2_list) do
		sister.Prevent_AI_Usage(true)
		sister.Prevent_All_Fire(true)
		sister.Make_Invulnerable(true)
		sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(sister2_gotospot)
	end
	Sleep(1)
	sister3_list = Spawn_Unit(Find_Object_Type("PRISONER_NIGHT_SISTER"), sister_spawnspot, underworld)
	for i,sister in pairs(sister3_list) do
		sister.Prevent_AI_Usage(true)
		sister.Prevent_All_Fire(true)
		sister.Make_Invulnerable(true)
		sister.Prevent_Opportunity_Fire(true)
		sister.Move_To(sister3_gotospot)
	end
	Sleep(0.5)
	
	

end


function State_UM06_DIALOG_NightSister_Greets_Tyber_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("close-up of Tyber")
		
		camera_show_tyber = Find_Hint("MARKER_GENERIC_RED", "midtro01-camera-tyber")
		
		Transition_Cinematic_Camera_Key(camera_show_tyber, 0, 5, 0, 0, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
				
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE2")
		--TEXT_SPEECH_UW_ACT02_M06_54
		--Tyber Zann: Do you know what this artifact is? 
		--I can reward you greatly if you can unlock it.
		
		--XXX
		tyber.Play_Animation("Cinematic", false, 1) --Cinematic_01 – tyber presenting the artifact
		
		Sleep(2.25)
		
		tyber.Play_Animation("idle", false, 1)
	end
end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line2_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("pull out to show both tyber and the night sisters")
		midtro01_camera_nightsister= Find_Hint("MARKER_GENERIC_RED", "midtro01-camera-nightsister")
		
		cine_sister = sister1_list[1]
		
		Transition_Cinematic_Camera_Key(midtro01_camera_nightsister, 0, 5, 0, 0, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(sister1_gotospot, 0, 0, 0, 15, 0, sister1_gotospot, 0, 0)
		
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE3")
		--TEXT_SPEECH_UW_ACT02_M06_55
		--Nightsister: The object is ancient and its power to resist our intrusion is potent. 
		--Only the strongest among us could possibly have any success in opening it and revealing the secrets inside.
		
		cine_sister.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on the nightsister
		
	end
end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line3_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("close up of tyber #2")
		
		Transition_Cinematic_Camera_Key(camera_show_tyber, 0, 5, 0, 0, 1, 0, 0, 0)
		--Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 5, 0, tyber, 0, 0)
		Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 10, 0, 0, 0, 0)
		
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE4")
		--TEXT_SPEECH_UW_ACT02_M06_56
		--Tyber Zann: Where is this woman you speak of? I have no time to waste on this world!
		
		tyber.Play_Animation("Cinematic", false, 2) --Cinematic_02 – talk anim on the tyber
		
	end
end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line4_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("show silri in her cage here")
		
		show_silri_camera_start = Find_Hint("MARKER_GENERIC_RED", "midtro01-showsilri-camerastart")
		show_silri_camera_move = Find_Hint("MARKER_GENERIC_RED", "midtro01-showsilri-cameramove")
		
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE5")
		--TEXT_SPEECH_UW_ACT02_M06_57
		--Nightsister: Silri can be found in the Frenzied River Prison to the north. 
		--The Imperial Governor placed her in a cage and broadcast her imprisonment planet wide. 
		--It was supposed to put fear in our hearts, that the same thing could happen to us. 
		--It didn't work. 
		--We rebelled and that's when more of us were imprisoned all over the planet. 
		--The Empire has much to pay for.
		Fade_Screen_Out(0.25)
		Sleep(.5)
		
		Transition_Cinematic_Camera_Key(show_silri_camera_start, 0, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(silri, 0, 0, 0, 0, 0, 0, 0, 0)
		
		Fade_Screen_In(1)
		
		Transition_Cinematic_Camera_Key(show_silri_camera_move, 10, 0, 0, 0, 0, 0, 0, 0)
		
	end
end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line5_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("close up of urai")
		
		midtro01_camera_urai= Find_Hint("MARKER_GENERIC_RED", "midtro01-camera-urai")
		
		Transition_Cinematic_Camera_Key(midtro01_camera_urai, 0, 0, 0, 30, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(urai, 0, 0, 0, 5, 1, urai, 0, 0)
			
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE6")
		--TEXT_SPEECH_UW_ACT02_M06_40
		--Urai Fen: Help us, and we will free your sisters in every prison on the planet.
		
		urai.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on urai
		
	end
end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line6_Remove_Text (message)
	if message == OnEnter then
		--do camera switch here
		--MessageBox("quick shot of rancor then back to tyber")
		
		Transition_Cinematic_Camera_Key(midtro01_camera_nightsister, 0, 5, 0, 0, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(sister1_gotospot, 0, 0, 0, 15, 0, sister1_gotospot, 0, 0)
		
		Story_Event("UM06_CUE_NIGHT_SISTER_INTRO_CONVERSATION_LINE7")
		--TEXT_SPEECH_UW_ACT02_M06_41
		--Nightsister: The Empire will pay for wrongfully imprisoning us.  
		--Bring us to rancor and we will bring the Imperial forces to their knees.
		
		--reveal around the group1 rancors here
		Create_Thread("Thread_Highlight_Group1_Rancor")
		
		
		cine_sister.Play_Animation("Cinematic", false, 0) --Cinematic_00 – talk anim on the nightsister
		

	end
end

function Thread_Highlight_Group1_Rancor()
	--group1_rancors = Find_All_Objects_With_Hint("group1-rancor")
	for i, rancor in pairs(group1_rancors) do
		if TestValid(rancor) then
			group01_rancor_reveal_list[i] = FogOfWar.Reveal(underworld, rancor, 250,250)
			
			Add_Radar_Blip(rancor, "group1_rancor_blip")

		end
	end
	
	Sleep(10)
	
	for i, rancor in pairs(group1_rancors) do
		if TestValid(rancor) then
			Remove_Radar_Blip("group1_rancor_blip")
		end
	end

end

function State_UM06_DIALOG_NightSister_Greets_Tyber_Line7_Remove_Text (message)
	if message == OnEnter then
		--leave cinematic here
		
		
		
		Leaving_Cinematic()
		
		tyber.Suspend_Locomotor(false)
		tyber.Prevent_AI_Usage(false)
		tyber.Prevent_All_Fire(false)
		tyber.Make_Invulnerable(false)
		tyber.Prevent_Opportunity_Fire(false)
		
		urai.Suspend_Locomotor(false)
		urai.Prevent_AI_Usage(false)
		urai.Prevent_All_Fire(false)
		urai.Make_Invulnerable(false)
		urai.Prevent_Opportunity_Fire(false)
		

		
		for i,sister in pairs(sister1_list) do
			sister.Prevent_AI_Usage(false)
			sister.Prevent_All_Fire(false)
			sister.Make_Invulnerable(false)
			sister.Prevent_Opportunity_Fire(false)
			Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
		end
		
		for i,sister in pairs(sister2_list) do
			sister.Prevent_AI_Usage(false)
			sister.Prevent_All_Fire(false)
			sister.Make_Invulnerable(false)
			sister.Prevent_Opportunity_Fire(false)
			Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
		end
		
		for i,sister in pairs(sister3_list) do
			sister.Prevent_AI_Usage(false)
			sister.Prevent_All_Fire(false)
			sister.Make_Invulnerable(false)
			sister.Prevent_Opportunity_Fire(false)
			Register_Prox(sister, PROX_Rancor_NightSister, 75, hostile)
		end
		
	
		
		--put silri's guards on pointguard duty
		
		for i, pointguard in pairs(silris_guards) do
			if TestValid(pointguard) then
				pointguard.Prevent_AI_Usage(true)
				pointguard.Guard_Target(pointguard.Get_Position())
				pointguard.Enable_Dynamic_LOD(true)

			end
		end
		

		
		Point_Camera_At(tyber)
		
		Lock_Controls(0)
		End_Cinematic_Camera()
		Letter_Box_Out(0)	
		Suspend_AI(0)
		Fade_Screen_In(1)
		
		 -- highlight the nightsisters
		Create_Thread("Thread_Highlight_Nightsisters")
		
		if TestValid(prison01_barracks) then
			Create_Thread("Thread_Prison01_Barracks_Reacts")
		end
		
		
		Story_Event("UM06_ADD_OBJECTIVE_MOUNT_RANCOR_AI_NOTIFICATION")
		
		Create_Thread("Thread_Monitor_for_Rancor_Riders")
		
		
	
		
		
		
	end
end

function Thread_Monitor_for_Rancor_Riders()
	while (true) do
		rancor_rider = Find_First_Object("UM06_Night_Sister")
		if not TestValid(rancor_rider) then
			Sleep(3)
		else
			break
		end
		Sleep(1)
	end
	
	Story_Event("UM06_COMPLETE_OBJECTIVE_MOUNT_RANCOR_AI_NOTIFICATION")
	

end



function Thread_Prison01_Barracks_Reacts()
	local spawn_times = 0
	local spawn_max = 5
	while TestValid(prison01_barracks) do
	
		spawned_trooper_list = Spawn_Unit(Find_Object_Type("IMPERIAL_MEDIUM_STORMTROOPER_SQUAD"), prison01_barracks_spawn, empire)
		Create_Thread("Find_And_Attack",spawned_trooper_list)
		spawn_times = spawn_times + 1
		if spawn_times >= spawn_max then
			break
		end
	
		Sleep(10)
	end
end


function Thread_Prison_Transports()
	while (TestValid(uplink_station) or TestValid(uplink_station02) or TestValid(uplink_station03)) do
		--ReinforceList(empire_prison01_list, prison01_transport_lz, empire, false, true, true, Find_And_Attack)
		
		if flag_okay_to_reinforce == true and flag_p3_prox_tripped == false then
			
			Story_Event("UM06_GIVE_UPLINK_HINT")
			if flag_first_imperial_reinforcement == true then
				Sleep(0.5) 
				Story_Event("UM06_ADD_OBJECTIVE_DESTROY_THE_UPLINK_STATIONS_AI_NOTIFICATION")
				flag_first_imperial_reinforcement = false
			end
			Create_Thread("Thread_Highlight_Uplink_Stations")
			rebel_shuttle1 = Create_Cinematic_Transport("Shuttle_Tyderium_Landing", empire.Get_ID(), transport_lz, -90, 1, 0.25, 10, 0)
			Sleep(5) 
			--spawn in units here
			trooper_list1 = Spawn_Unit(Find_Object_Type("DARK_TROOPER_PHASEIII"), transport_spawnflag, empire)
			trooper_list2 = Spawn_Unit(Find_Object_Type("DARK_TROOPER_PHASEIII"), transport_spawnflag, empire)
			trooper_list3 = Spawn_Unit(Find_Object_Type("DARK_TROOPER_PHASEIII"), transport_spawnflag, empire)
			
			Create_Thread("Find_And_Attack",trooper_list1)
			Create_Thread("Find_And_Attack",trooper_list2)
			Create_Thread("Find_And_Attack",trooper_list3)
			
			empire_reinforce_list = {}
			
			empire_reinforce_list[1] = trooper_list1[1]
			empire_reinforce_list[2] = trooper_list2[1]
			empire_reinforce_list[3] = trooper_list3[1]
			
			Create_Thread("Thread_Death_Monitor_Empire_Reinforce",empire_reinforce_list)
			
			flag_okay_to_reinforce = false
		end
		
		Sleep(3)
	end
	

	
	
end

function Thread_Highlight_Uplink_Stations()
	--uplink_station
	--uplink_station02
	
	if TestValid(uplink_station) then
		Add_Radar_Blip(uplink_station, "uplink_station_radarblip")
	end
	
	if TestValid(uplink_station02) then
		Add_Radar_Blip(uplink_station02, "uplink_station02_radarblip")
	end
	
	if TestValid(uplink_station03) then
		Add_Radar_Blip(uplink_station03, "uplink_station03_radarblip")
	end
	
	Sleep(10)
	
	if TestValid(uplink_station) then
		Remove_Radar_Blip("uplink_station_radarblip")
	end
	
	if TestValid(uplink_station02) then
		Remove_Radar_Blip("uplink_station02_radarblip")
	end
	
	if TestValid(uplink_station03) then
		Remove_Radar_Blip("uplink_station03_radarblip")
	end
end

function Thread_Death_Monitor_Empire_Reinforce(reinforce_list)
	while (true) do
		local spawned_troopers_dead = true
		for i, unit in pairs(reinforce_list) do
			if TestValid(unit) then
				spawned_troopers_dead = false
			end
		end
		
		if spawned_troopers_dead == true then
			--JoeMessage("Reinforced empire troops dead...bring in new ones")
			Sleep(30)
			flag_okay_to_reinforce = true
			break
		end

		Sleep(3)
	end
end

function Find_And_Attack(attack_list)

	-- find the closest underworld unit and have the newly reinforced units attack it!
	closest_target = Find_Nearest(transport_lz, underworld, true)

	
			
			
	for i, unit in pairs(attack_list) do
		if TestValid(unit) then
			--if unit.Is_Ability_Ready("JET_PACK") then
			--	unit.Activate_Ability("JET_PACK", closest_target)
			--else
				unit.Attack_Move(closest_target)
			--end
			
			unit.Prevent_AI_Usage(false)
		end
	end

end



function Thread_Highlight_Nightsisters()
	night_sisters_list = Find_All_Objects_Of_Type("PRISONER_NIGHT_SISTER")
	
	for i, night_sister in pairs(night_sisters_list) do
		if TestValid(night_sister) then
			night_sister.Highlight_Small(true, -50)
		end
	end
	
	--Sleep(const_highlight_timer)
	
	--for i, night_sister in pairs(night_sisters_list) do
		--if TestValid(night_sister) then
			--night_sister.Highlight_Small(false)
		--end
	--end
end


function Intro_Cinematic()

	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	Fade_Screen_In(2)
	
	Cancel_Fast_Forward()
	
	Story_Event("UM06_CUE_INTRO_DIALOG")
	
	-- ***********Opening Shot***************
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camera_loc1, 450, 35, 220, 1, 1, 1, 0)
	--Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(landing_spot, 0, 0, 500, 0, 1, 0, 0)
	
	Transition_Cinematic_Camera_Key(camera_loc1, 30, 150, 40, 130, 1, 1, 1, 0)
	
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)
	openin_cine_transport = Create_Cinematic_Transport("UM06_Landing_Shuttle", underworld.Get_ID(), landing_spot, 60, 1, 0, 20, 1)
	openin_cine_transport.Set_Selectable(false)
	
	Transition_Cinematic_Target_Key(landing_spot, 5, 0, 0, 0, 0, 0, 0, 0)
	
		
	Sleep(7)
	
	
	-- ***********Shot of Tyber & Urai moving to cliff***************
	
	tyber_list = Spawn_Unit(Find_Object_Type("UM06_TYBER_ZANN"), tyber_spawn, underworld)
	urai_list = Spawn_Unit(Find_Object_Type("URAI_FEN"), urai_spawn, underworld)
	
	tyber = Find_First_Object("UM06_TYBER_ZANN")
	urai = urai_list[1]
	
	tyber.Move_To(tyber_goto1.Get_Position())
	urai.Move_To(urai_goto1.Get_Position())
	
	Create_Thread("Thread_Intro_Group1Rancors_Emerge")
	
	Sleep(1)
	
	intro_camera_move01 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-move01")
	
	--Set_Cinematic_Camera_Key(tyber, 200, 25, -50, 1, tyber, 0, 0)
	Transition_Cinematic_Target_Key(tyber, 6, 25, 0, 0, 0, tyber, 0, 0)
	
	--Transition_Cinematic_Camera_Key(intro_camera_move01, 5, 0, 0, 0, 0, 0, 0, 0)
	--Transition_Cinematic_Camera_Key(camera_loc1, 10, 125, 19, 150, 1, 1, 1, 0)
	
	Sleep(6)
	
	tyber.Stop()
	urai.Stop()
	Sleep(.5)
	tyber.Turn_To_Face(urai)
	urai.Turn_To_Face(tyber)
	
	Sleep(5)
	
	
	
end




function State_UM06_DIALOG_IntroCine_Line07_Remove_Text (message)
	if message == OnEnter then
		--end of intro cinematic
		current_cinematic_thread = nil 
		Point_Camera_At(tyber)
	
		Create_Thread("Death_Monitor_Tyber")
		Create_Thread("Death_Monitor_Urai")
		
		Transition_To_Tactical_Camera(2)
		Sleep(2)
		Lock_Controls(0)
		End_Cinematic_Camera()
		Letter_Box_Out(0)	
		Suspend_AI(0)
		--Fade_Screen_In(1)
		
		Create_Thread("Thread_Group1Rancors_Start_Guarding")
		Allow_Localized_SFX(true)
	
	end
end

function Entering_Cinematic()
		--fudge to make sure night sisters stay put
	empire_units_list = Find_All_Objects_Of_Type(empire)
	for i,empire_unit in pairs(empire_units_list) do
		empire_unit.Prevent_AI_Usage(true)
		empire_unit.Prevent_All_Fire(true)
		empire_unit.Make_Invulnerable(true)
		empire_unit.Prevent_Opportunity_Fire(true)
		--empire_unit.Hide(true)
	end
end

function Leaving_Cinematic()
	empire_units_list = Find_All_Objects_Of_Type(empire)
	for i,empire_unit in pairs(empire_units_list) do
		empire_unit.Prevent_All_Fire(false)
		empire_unit.Make_Invulnerable(false)
		empire_unit.Prevent_Opportunity_Fire(false)
	end
	
	--removal_list = {}
	--re-disable the trucks and stuff
	--parked_vehicle_list = Find_All_Objects_With_Hint("parked")
	for i,parked_vehicle in pairs(parked_vehicle_list) do
		if TestValid(parked_vehicle) then
			parked_vehicle.Prevent_AI_Usage(true)
			parked_vehicle.Prevent_All_Fire(true)
			parked_vehicle.Prevent_Opportunity_Fire(true)
		--else
			--table.insert(removal_list, parked_vehicle)
			--parked_vehicle_list[parked_vehicle] = nil
		end
	end
	
	--for i,dead_vehicle in pairs(removal_list) do
	--	parked_vehicle_list[dead_vehicle] = nil
	--end	
	
	--put pointguards back on guard duty
	--pointguard_list = Find_All_Objects_With_Hint("pointguard")
	for i, pointguard in pairs(pointguard_list) do
		if TestValid(pointguard) then
			pointguard.Prevent_AI_Usage(true)
			pointguard.Guard_Target(pointguard.Get_Position())

		end
	end
end




function Thread_Intro_Group1Rancors_Emerge()
	
	for i, rancor in pairs(group1_rancors) do
		if TestValid(rancor) then
			rancor.Move_To(group1_rancor_location_list[i]) 
		end
	end
		

end



--***********************************************************

function Death_Monitor_Tyber()
	while TestValid(tyber) do
		Sleep(3)
	end
	
	Story_Event("UM06_TYBER_KILLED")
end

function Death_Monitor_Urai()
	while TestValid(urai) do
		Sleep(3)
	end
	
	Story_Event("UM06_URAI_KILLED")
end

function Death_Monitor_Silri()
	while TestValid(silri) do
		Sleep(3)
	end
	
	Story_Event("UM06_SILRI_KILLED")
end

function Death_Monitor_Governor(governor)
	while TestValid(governor) do
		Sleep(1)
	end
	
	flag_governor_dead = true
end

function Thread_DeathMonitor_UplinkStation01()
	while TestValid(uplink_station) do
		Sleep(3)
	end
	
	--MessageBox("Thread_DeathMonitor_UplinkStation01")
	--flag_uplink_01_destroyed = true
	Story_Event("UM06_UPLINKSTATION_DESTOYED")
end

function Thread_DeathMonitor_UplinkStation02()
	while TestValid(uplink_station02) do
		Sleep(3)
	end
	--MessageBox("Thread_DeathMonitor_UplinkStation02")
	--flag_uplink_02_destroyed = true
	Story_Event("UM06_UPLINKSTATION_DESTOYED")
end

function Thread_DeathMonitor_UplinkStation03()
	while TestValid(uplink_station03) do
		Sleep(3)
	end
	
	--MessageBox("Thread_DeathMonitor_UplinkStation03")
	--flag_uplink_03_destroyed = true
	Story_Event("UM06_UPLINKSTATION_DESTOYED")
end

function Thread_DeathMonitor_UplinkStations()
	while TestValid(uplink_station) or TestValid(uplink_station02) or TestValid(uplink_station03) do
		Sleep(3)
	end
	
	--MessageBox("UM06_COMPLETE_OBJECTIVE_DESTROY_THE_UPLINK_STATIONS_AI_NOTIFICATION")
	Story_Event("UM06_COMPLETE_OBJECTIVE_DESTROY_THE_UPLINK_STATIONS_AI_NOTIFICATION")

end

function Thread_Death_Monitor_Gate()
	while TestValid(gate) do
		Sleep(3)
	end
	
	--gate_pointguard_list = Find_All_Objects_With_Hint("gate-pointguard")
	for i, gate_pointguard in pairs(gate_pointguard_list) do
		if TestValid(gate_pointguard) then
			gate_pointguard.Guard_Target(gate_pointguard.Get_Position())
			gate_pointguard.Prevent_All_Fire(false)
			gate_pointguard.Prevent_Opportunity_Fire(false)

		end
	end
	
	Create_Thread("Thread_Prison_Transports")
	
	if TestValid(uplink_station) then
		--MessageBox("Thread_DeathMonitor_UplinkStation01")
		Create_Thread("Thread_DeathMonitor_UplinkStation01")
	end
	
	if TestValid(uplink_station02) then
		--MessageBox("Thread_DeathMonitor_UplinkStation02")
		Create_Thread("Thread_DeathMonitor_UplinkStation02")
	end
	
	if TestValid(uplink_station03) then
		--MessageBox("Thread_DeathMonitor_UplinkStation03")
		Create_Thread("Thread_DeathMonitor_UplinkStation03")
	end
	
	Create_Thread("Thread_DeathMonitor_UplinkStations")
end





function Death_Monitor_Prison1_Power() 
	while TestValid(prison_1_power) do
		Sleep(3)
	end
	
	Story_Event("UM06_PRISON01_POWER_DESTROYED")
	
	--take prison01 turrets off-line
	
	for k, turret in pairs(prison01_turrets_list) do
		if TestValid(turret) then
			--MessageBox("Turret faction switched to neutral!")
			turret.Change_Owner(neutral)

		end
	end
	
	--spawn some guys out of the nearby uplink station
	if TestValid(prison01_academy) then
	
		guard01_list = Spawn_Unit(Find_Object_Type("IMPERIAL_GUARD_NON_AI"), prison01_uplinkspawnspot, empire)
		guard01_list[1].Guard_Target(prison01_uplink_goto01)
		Sleep(0.5)
		
		guard02_list = Spawn_Unit(Find_Object_Type("IMPERIAL_GUARD_NON_AI"), prison01_uplinkspawnspot, empire)
		guard02_list[1].Guard_Target(prison01_uplink_goto02)
		Sleep(0.5)
		
		
		guard03_list = Spawn_Unit(Find_Object_Type("IMPERIAL_GUARD_NON_AI"), prison01_uplinkspawnspot, empire)
		guard03_list[1].Guard_Target(prison01_uplink_goto03)
			
	end
end

function Death_Monitor_Prison2_Power() 
	while TestValid(prison_2_power) do
		Sleep(3)
	end
	
	Story_Event("UM06_PRISON02_POWER_DESTROYED")
	
end



function Death_Monitor_Prison3_Power() 
	while TestValid(prison_3_power) do
		Sleep(3)
	end
	
	--turn off p3-turrets
	
	for i, prison3_turret in pairs(prison3_turret_list) do
		if TestValid(prison3_turret) then
			prison3_turret.Change_Owner(neutral)

		end
	end
	
	Story_Event("UM06_PRISON03_POWER_DESTROYED")
	
end

function Death_Monitor_Governors_Power() 
	while TestValid(governors_power) do
		Sleep(3)
	end
	
	--turn off p3-turrets
	governors_turret_list = Find_All_Objects_With_Hint("gov-turret") 
	for i, governors_turret in pairs(governors_turret_list) do
		if TestValid(governors_turret) then
			governors_turret.Change_Owner(neutral)
		end
	end
	
	Story_Event("UM06_GOVERNOR_POWER_DESTROYED")
	
end


function Thread_Prison01Guard01_Backpath_Patrols()

	--Check ownership before issuing orders (might well have been bribed)
	while (true) do
		for i, guard01 in pairs(backpath_guard01) do
			--if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
				--BlockOnCommand(guard01.Move_To(backpath_spot01))
			--end
			
			if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
				guard01.Attack_Move(backpath_spot01)
			end
		end
		
		Sleep(15)
		
		for i, guard01 in pairs(backpath_guard01) do
			--if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard01.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
				guard01.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
		for i, guard01 in pairs(backpath_guard01) do
			--if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard01.Move_To(backpath_spot03))
			--end
			
			if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
				guard01.Attack_Move(backpath_spot03)
			end
		end
		
		Sleep(15)
		
		for i, guard01 in pairs(backpath_guard01) do
			--if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard01.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard01) and not guard01.Get_Owner().Is_Human() then
				guard01.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
	end
end

function Thread_Prison01Guard02_Backpath_Patrols()
	--Check ownership before issuing orders (might well have been bribed)
	while (true) do
		for i, guard02 in pairs(backpath_guard02) do
			--if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard02.Move_To(backpath_spot03))
			--end
			
			if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
				guard02.Attack_Move(backpath_spot03)
			end
		end
		
		Sleep(15)
		
		for i, guard02 in pairs(backpath_guard02) do
			--if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard02.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
				guard02.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
		for i, guard02 in pairs(backpath_guard02) do
			--if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard02.Move_To(backpath_spot01))
			--end
			
			if TestValid(guard02) then
				guard02.Attack_Move(backpath_spot01)
			end
		end
		
		Sleep(15)
		
		for i, guard02 in pairs(backpath_guard02) do
			--if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard02.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard02) and not guard02.Get_Owner().Is_Human() then
				guard02.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
	end
end

function Thread_Prison01Guard03_Backpath_Patrols()
	--Check ownership before issuing orders (might well have been bribed)
	while (true) do
		for i, guard03 in pairs(backpath_guard03) do
			--if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard03.Move_To(backpath_spot01))
			--end
			
			if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
				guard03.Attack_Move(backpath_spot01)
			end
		end
		
		Sleep(15)
		
		for i, guard03 in pairs(backpath_guard03) do
			--if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard03.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
				guard03.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
		for i, guard03 in pairs(backpath_guard03) do
			--if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard03.Move_To(backpath_spot03))
			--end
			
			if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
				guard03.Attack_Move(backpath_spot03)
			end
		end
		
		Sleep(15)
		
		for i, guard03 in pairs(backpath_guard03) do
			--if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard03.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard03) and not guard03.Get_Owner().Is_Human() then
				guard03.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
	end
end

function Thread_Prison01Guard04_Backpath_Patrols()
	--Check ownership before issuing orders (might well have been bribed)
	while (true) do
		for i, guard04 in pairs(backpath_guard04) do
			--if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard04.Move_To(backpath_spot03))
			--end
			
			if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
				guard04.Attack_Move(backpath_spot03)
			end
		end
		
		Sleep(15)
		
		for i, guard04 in pairs(backpath_guard04) do
			--if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard04.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
				guard04.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
		for i, guard04 in pairs(backpath_guard04) do
			--if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard04.Move_To(backpath_spot01))
			--end
			
			if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
				guard04.Attack_Move(backpath_spot01)
			end
		end
		
		Sleep(15)
		
		for i, guard04 in pairs(backpath_guard04) do
			--if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
			--	BlockOnCommand(guard04.Move_To(backpath_spot02))
			--end
			
			if TestValid(guard04) and not guard04.Get_Owner().Is_Human() then
				guard04.Attack_Move(backpath_spot02)
			end
		end
		
		Sleep(15)
		
	end
end

function Thread_Monitor_Parked_Vehicles_Status()
	while (true) do
		local bool_parked_cars _exist = false
		
		--parked_vehicle_list = Find_All_Objects_With_Hint("parked")
		for i,parked_vehicle in pairs(parked_vehicle_list) do
			if TestValid(parked_vehicle) then
				bool_parked_cars  = true
					if parked_vehicle.Get_Owner().Is_Human() then
						parked_vehicle.Prevent_All_Fire(false)
						parked_vehicle.Prevent_Opportunity_Fire(false)
					end

			end
		end
		
		if bool_parked_cars == false then
			return
		end
		
		Sleep(5)
		
	end
end








function JoeMessage(...)
	--JoeMessage("current current_spawn_times  is %d", current_spawn_times)

	_CustomScriptMessage("JoeLog.txt", string.format(unpack(arg)))

end