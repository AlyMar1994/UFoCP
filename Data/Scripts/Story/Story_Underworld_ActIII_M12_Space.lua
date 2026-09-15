-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActIII_M12_SPACE.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActIII_M12_SPACE.lua $
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

require("PGStoryMode")
require("JGS_FunctionLib") -- added library of commonly used functions

function Definitions()
	bool_skip_intro = false

	StoryModeEvents =
	{
		Underworld_A03M12_Begin = State_Underworld_A03M12_Begin,
		--UM12_ADD_OBJECTIVE_Defeat_The_Empire = State_UM12_ADD_OBJECTIVE_Defeat_The_Empire,
		UM12_ADD_OBJECTIVE_Defeat_The_Rebels = State_UM12_ADD_OBJECTIVE_Defeat_The_Rebels,
		UM12_DIALOG_Intro_Dialog_Line_01_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_01_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_02_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_02_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_03_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_03_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_04_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_04_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_05_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_05_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_06_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_06_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_07_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_07_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_08_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_08_Remove_Text,
		UM12_DIALOG_Intro_Dialog_Line_09_Remove_Text = State_UM12_DIALOG_Intro_Dialog_Line_09_Remove_Text,
		UM12_Bring_In_SuperStarDestroyer = State_UM12_Bring_In_SuperStarDestroyer,
		UM12_DIALOG_SuperStarDestroyer_Has_Arrived_Remove_Movie = State_UM12_DIALOG_SuperStarDestroyer_Has_Arrived_Remove_Movie,
		UM12_REMOVE_OBJECTIVE_Help_Rebels = State_UM12_REMOVE_OBJECTIVE_Help_Rebels,

	}

	rebel_shiptype_list = {
		--"A_WING_SQUADRON",
		--"B-WING_SQUADRON",
		"REBEL_X-WING_SQUADRON",
		--"Y-WING_SQUADRON",
		"CALAMARI_CRUISER",
		"ALLIANCE_ASSAULT_FRIGATE",
		"CORELLIAN_CORVETTE",
		"CORELLIAN_GUNBOAT",
		"MARAUDER_MISSILE_CRUISER",
		"MC30_FRIGATE",
		"NEBULON_B_FRIGATE"
	}


	empire_shiptype_list = {

		"ACCLAMATOR_ASSAULT_SHIP",
		"BROADSIDE_CLASS_CRUISER",
		"INTERDICTOR_CRUISER",
		"STAR_DESTROYER",
		"TARTAN_PATROL_CRUISER",
		"VICTORY_DESTROYER",
	}

	acclamator_hardpoint_list = {
		"HP_Acclamator_Weapon_FL",
		"HP_Acclamator_Weapon_FR",
		"HP_Acclamator_Weapon_FC",
		"HP_Acclamator_Weapon_BL",
		"HP_Acclamator_Weapon_BR",
		"HP_Acclamator_Weapon_BC",
		"HP_Acclamator_Fighter_Bay"
	}

	interdictor_hardpoint_list = {
		"HP_Interdictor_Weapon_01",
		"HP_Interdictor_Weapon_02",
		"HP_Interdictor_Weapon_03",
		"HP_Interdictor_Weapon_04",
		"HP_Interdictor_GravWell_01",
		"HP_Interdictor_Shields_01",
	}

	stardestroyer_hardpoint_list = {
		"HP_Star_Destroyer_Weapon_FL",
		"HP_Star_Destroyer_Weapon_FR",
		"HP_Star_Destroyer_Weapon_BL",
		"HP_Star_Destroyer_Weapon_BR",
		"HP_Star_Destroyer_Weapon_ML",
		"HP_Star_Destroyer_Weapon_MR",
		"HP_Star_Destroyer_Shield_Generator",
		"HP_Star_Destroyer_Tractor_Beam",
		"HP_Star_Destroyer_Fighter_Bay"
	}

	victory_hardpoint_list = {

		"HP_Victory_Weapon_01",
		"HP_Victory_Weapon_02",
		"HP_Victory_Weapon_03",
		"HP_Victory_Shields_01",
		"HP_Victory_Fighter_Bay"
	}

	empire_super_stardestroyer = {}

	rebel_reinforce_list = {}
	empire_reinforce_list = {}
	rebel_entryflag_list = {}

	--defining constants here
	const_max_tie_scout_health = 70
	const_max_broadside_health = 650
	const_max_tartan_health = 500
	const_acclamator_popcap_value = 3
	const_broadside_popcap_value = 2
	const_interdictor_popcap_value = 3
	const_stardestroyer_popcap_value = 4
	const_tartan_popcap_value = 2
	const_victorydestroyer_popcap_value = 3
	const_max_popcap = 20
	esc_pressed = false

	num_current_popcap = 0
	num_shuttles_destroyed = 2

	--long list of bools
	bool_sy01_hf01_taken = false
	bool_sy01_hf02_taken = false
	bool_sy01_hf03_taken = false
	bool_sy01_hf04_taken = false

	bool_sy02_hf01_taken = false
	bool_sy02_hf02_taken = false

	bool_sy03_hf01_taken = false
	bool_sy03_hf02_taken = false

	bool_sy04_hf01_taken = false

	bool_sy05_hf01_taken = false

	bool_sy01_full = false
	bool_sy02_full = false
	bool_sy03_full = false
	bool_sy04_full = false
	bool_sy05_full = false



	bool_shuttle01_being_expended = false
	bool_shuttle02_being_expended = false
	bool_shuttle03_being_expended = false
	bool_capturing_starbase01 = false
	bool_capturing_starbase02 = false
	bool_capturing_starbase03 = false
	bool_capturing_eclipse = false
	bool_eclipse_captured = false
	bool_first_shot_fired = false

	bool_starbase01_active = true
	bool_starbase02_active = true
	bool_starbase03_active = true

	bool_rebels_attacking = true
	bool_rebels_are_friends = true

	bool_okay_to_reinforce_empire = true

	shuttles_in_use = {}
	starbase_in_use = {}
	escort_list = {}
	escort_location_list = {}

	uw_reveal = nil

end




function State_Underworld_A03M12_Begin(message)
	if message == OnEnter then
		JoeMessage("******************************STARTING NEW MISSION******************************")
		--GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)

		--player definitions
		neutral_player = Find_Player("Neutral")
		empire_player = Find_Player("Empire")
		rebel_player = Find_Player("Rebel")
		underworld_player = Find_Player("Underworld")

		uw_reveal = FogOfWar.Reveal_All(underworld_player)

		underworld_player.Make_Ally(rebel_player)
		rebel_player.Make_Ally(underworld_player)

		--making the eclipse not a target of opportunity
		eclipse = Find_First_Object("ECLIPSE_SUPER_STAR_DESTROYER")
		eclipse.Change_Owner(empire_player)
		eclipse.Prevent_Opportunity_Fire(true)
		--eclipse.Highlight(true)
		Add_Radar_Blip(eclipse, "eclipse_blip")
		eclipse.Set_Cannot_Be_Killed(true)


		--making the shipyards not targets of opportunity
		shipyard_list = Find_All_Objects_Of_Type("EMPIRE_DOCK_DESTROYABLE")
		for i, shipyard in pairs(shipyard_list) do
			shipyard.Prevent_Opportunity_Fire(true)
		end

		--defining the 3 empire starbases here
		starbase_01 = Find_Hint("UM12_STAR_BASE", "starbase01")
		starbase_02 = Find_Hint("UM12_STAR_BASE", "starbase02")
		starbase_03 = Find_Hint("UM12_STAR_BASE", "starbase03")

		--##############################################
		rebel_hero = Find_Hint("MILLENNIUM_FALCON", "rebel-hero")
		--cannot be killed until given the objective
		rebel_hero.Set_Cannot_Be_Killed(true)
		rebel_hero.Make_Invulnerable(true)
		rebel_hero.Prevent_AI_Usage(true)
		rebel_hero.Hide(true)
		rebel_hero.Suspend_Locomotor(true)

		rebel_hero_location = rebel_hero.Get_Position()

		--defining han's escorts here

		escort_list[1] = Find_Hint("NEBULON_B_FRIGATE", "escort01")
		escort_list[2] = Find_Hint("NEBULON_B_FRIGATE", "escort02")
		escort_list[3] = Find_Hint("CALAMARI_CRUISER", "escort03")
		escort_list[4] = Find_Hint("CALAMARI_CRUISER", "escort04")

		escort_location_list[1] = escort_list[1].Get_Position()
		escort_location_list[2] = escort_list[2].Get_Position()
		escort_location_list[3] = escort_list[3].Get_Position()
		escort_location_list[4] = escort_list[4].Get_Position()

		for i, escort in pairs(escort_list) do
			escort.Set_Cannot_Be_Killed(true)
			escort.Prevent_AI_Usage(true)
			escort.Hide(true)
			escort.Suspend_Locomotor(true)
		end


		--entry flag definitions - empire
		entryflag_empire01 = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-empire01")

		--entry flag definitions - rebel
		rebel_entryflag_list[1] = Find_Hint("MARKER_GENERIC_GREEN", "entryflag-rebel-starbase01")
		rebel_entryflag_list[2] = Find_Hint("MARKER_GENERIC_GREEN", "entryflag-rebel-starbase02")
		rebel_entryflag_list[3] = Find_Hint("MARKER_GENERIC_GREEN", "entryflag-rebel-starbase03")

		--shipyard definitions
		shipyard01 = Find_Hint("EMPIRE_DOCK_DESTROYABLE", "shipyard01")
		shipyard02 = Find_Hint("EMPIRE_DOCK_DESTROYABLE", "shipyard02")
		shipyard03 = Find_Hint("EMPIRE_DOCK_DESTROYABLE", "shipyard03")
		shipyard04 = Find_Hint("EMPIRE_DOCK_DESTROYABLE", "shipyard04")
		shipyard05 = Find_Hint("EMPIRE_DOCK_DESTROYABLE", "shipyard05")

		if not shipyard01 then
			DebugMessage("not shipyard01")
		end

		if not shipyard02 then
			DebugMessage("not shipyard02")
		end

		--healing "bays" definintions
		sy01_healbay01 = Find_Hint("UM12_MARKER_HEALING", "sy01-healbay01")
		sy01_healbay02 = Find_Hint("UM12_MARKER_HEALING", "sy01-healbay02")
		sy01_healbay03 = Find_Hint("UM12_MARKER_HEALING", "sy01-healbay03")
		sy01_healbay04 = Find_Hint("UM12_MARKER_HEALING", "sy01-healbay04")

		sy02_healbay01 = Find_Hint("UM12_MARKER_HEALING", "sy02-healbay01")
		sy02_healbay02 = Find_Hint("UM12_MARKER_HEALING", "sy02-healbay02")

		sy03_healbay01 = Find_Hint("UM12_MARKER_HEALING", "sy03-healbay01")
		sy03_healbay02 = Find_Hint("UM12_MARKER_HEALING", "sy03-healbay02")

		sy04_healbay01 = Find_Hint("UM12_MARKER_HEALING", "sy04-healbay01")

		sy05_healbay01 = Find_Hint("UM12_MARKER_HEALING", "sy05-healbay01")


		--defining "mission critical" units here
		tyber_start_spot = Find_Hint("MARKER_GENERIC_BLUE", "peacebringer-startspot")
		if not TestValid(tyber_start_spot) then
			DebugMessage("no tyber_start_spot")
		end
		tyber = Find_First_Object("THE_PEACEBRINGER")
		if TestValid(tyber) then
			tyber.Teleport_And_Face(tyber_start_spot)
		else
			tyber_spawn = Spawn_From_Reinforcement_Pool(Find_Object_Type("TYBER_ZANN_TEAM_CAMPAIGN"), tyber_start_spot, underworld_player)
			tyber = tyber_spawn
			--tyber = Find_First_Object("THE_PEACEBRINGER")

			if TestValid (tyber) then


				tyber.Teleport_And_Face(tyber_start_spot)
				--tyber.Prevent_Opportunity_Fire(true)
				--tyber.Prevent_All_Fire(true)
				--tyber.Set_Cannot_Be_Killed(true)
			else
				DebugMessage("No Tyber!! Fool")
				Spawn_Unit(Find_Object_Type("THE_PEACEBRINGER"), tyber_start_spot, underworld_player)
				tyber = Find_First_Object("THE_PEACEBRINGER")
				tyber.Teleport_And_Face(tyber_start_spot)
				--tyber.Prevent_Opportunity_Fire(true)
				--tyber.Prevent_All_Fire(true)
				--tyber.Set_Cannot_Be_Killed(true)
			end
		end

		shuttle01 = Find_Hint("UM12_BOARDING_SHUTTLE", "shuttle01")
		shuttle02 = Find_Hint("UNDERWORLD_PIRATE_IPV", "shuttle02")
		shuttle03 = Find_Hint("UNDERWORLD_PIRATE_IPV", "shuttle03")

		--setting up prox events on the shuttles to track when they reach the
		--eclipse or a starbase
		Register_Prox(shuttle01, PROX_Boarding_Shuttles, 500, empire_player)
		shuttle01.Highlight(true)
		--Register_Prox(shuttle02, PROX_Boarding_Shuttles, 500, empire_player)
		--Register_Prox(shuttle03, PROX_Boarding_Shuttles, 500, empire_player)


		--this is a setup for the opening cinematic
		underworld_ship_list = Find_All_Objects_Of_Type(underworld_player)
		for i, underworld_ship in pairs(underworld_ship_list) do
			underworld_ship.Prevent_Opportunity_Fire(true)
			underworld_ship.Prevent_All_Fire(true)
			underworld_ship.Stop()
		end

		--put pointguards on guard duty
		pointguard_list = Find_All_Objects_With_Hint("pointguard")
		for i, pointguard in pairs(pointguard_list) do
			if TestValid(pointguard) then
				pointguard.Prevent_AI_Usage(true)
				pointguard.Guard_Target(pointguard.Get_Position())
			end
		end



		if bool_skip_intro == false then
			current_cinematic_thread = Create_Thread("Thread_Opening_Cinematic")
		else
			--fill in needed stuff here
			rebel_hero.Hide(false)
			rebel_hero.Prevent_AI_Usage(false)
			rebel_hero.Prevent_Opportunity_Fire(false)
			rebel_hero.Prevent_All_Fire(false)
			rebel_hero.Suspend_Locomotor(false)

			for i, escort in pairs(escort_list) do
				escort.Set_Cannot_Be_Killed(false)
				escort.Prevent_AI_Usage(false)
				escort.Suspend_Locomotor(false)
				escort.Hide(false)
				escort.Prevent_AI_Usage(false)
			end

			Point_Camera_At(tyber)
			--DebugMessage("A really cool opening cinematic goes here...you'd be super impressed.")

			Sleep(1)
			End_Cinematic_Camera()
			Letter_Box_Out(1)
			Lock_Controls(0)
			Suspend_AI(0)
			Fade_Screen_In(1)
			Story_Event("UM12_GIVE_STARTING_OBJECTIVES")

			uw_reveal = FogOfWar.Reveal_All(underworld_player)

			Create_Thread("Thread_DeathMonitor_TyberZann")
			Create_Thread("Thread_DeathMonitor_BoardingShuttle01")
			--Create_Thread("Thread_DeathMonitor_BoardingShuttle02")
			--Create_Thread("Thread_DeathMonitor_BoardingShuttle03")

			starbase_01.Highlight(true, 250)
			Add_Radar_Blip(starbase_01, "starbase_01_blip")
			starbase_02.Highlight(true, 250)
			Add_Radar_Blip(starbase_02, "starbase_02_blip")
			starbase_03.Highlight(true, 250)
			Add_Radar_Blip(starbase_03, "starbase_03_blip")

			Create_Thread("Thread_DeathMonitor_Starbase01")
			Create_Thread("Thread_DeathMonitor_Starbase02")
			Create_Thread("Thread_DeathMonitor_Starbase03")
			Create_Thread("Thread_DeathMonitor_Starbases")

			Create_Thread("Thread_DeathMonitor_Shipyard01")
			Create_Thread("Thread_DeathMonitor_Shipyard02")
			Create_Thread("Thread_DeathMonitor_Shipyard03")
			Create_Thread("Thread_DeathMonitor_Shipyard04")
			Create_Thread("Thread_DeathMonitor_Shipyard05")


			Create_Thread("Thread_Empire_Units_Arrive")
			Create_Thread("Thread_Rebel_Units_Arrive")

			Sleep(10)

			Create_Thread("Thread_Give_Opening_Hint")

		end
	end
end

function Thread_Opening_Cinematic()
	Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()
	Cancel_Fast_Forward()
	Sleep(1)

	Story_Event("UM12_CUE_INTRO_DIALOG_LINE_01")

	--show the eclipse here
	--Point_Camera_At(eclipse)
	intro_camera_start = Find_Hint("MARKER_GENERIC_RED", "intro-camera-start")
	intro_look_start = Find_Hint("MARKER_GENERIC_RED", "introstart")
	intro_camera_move01 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-move01")

	if not esc_pressed then
		Transition_Cinematic_Camera_Key(intro_camera_start, 0, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(intro_look_start, 0, 0, 0, 0, 0, 0, 0, 0)

		Transition_Cinematic_Camera_Key(intro_camera_move01, 10, 0, 0, 0, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(intro_camera_move01, 7, 0, 0, 0, 0, 0, 0, 0)
	end

	--Sleep(1)
	Fade_Screen_In(1)
end

function State_UM12_DIALOG_Intro_Dialog_Line_01_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Tyber Zann: That is the most glorious thing I have ever seen, Urai, once we take control of her we will�"
		--TEXT_SPEECH_UW_ACT03_M12_34

		--do camera stuff here
		--zoom down length of the eclipse to show her off.




		--cue'ing the line "Urai Fen: Tyber, we are tracking several in-bound fleets!"
		--TEXT_SPEECH_UW_ACT03_M12_35
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_02")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_02_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Urai Fen: Tyber, we are tracking several in-bound fleets!"
		--TEXT_SPEECH_UW_ACT03_M12_35

		--cue'ing the line "Tyber Zann: It's probably the remains of the Imperial fleet attempting to repair and regroup here -"
		--TEXT_SPEECH_UW_ACT03_M12_36
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_03")
		Create_Thread("Thread_Empire_Units_Arrive")

		--Sleep(2)

		--show an injured imperial fleet coming in
		intro_camera_cut01 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-cut01")
		intro_look_cut01 = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-empire01")
		intro_camera_cut01_move01 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-cut01-move01")

		if not esc_pressed then
			Transition_Cinematic_Camera_Key(intro_look_cut01, 0, 800, 15, 75, 1, 0, 0, 0)
			Transition_Cinematic_Target_Key(intro_look_cut01, 0, 0, 0, -100, 0, 0, 0, 0)

			Transition_Cinematic_Camera_Key(intro_look_cut01, 10, 800, 20, 100, 1, 0, 0, 0)
		end


	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_03_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Tyber Zann: It's probably the remains of the Imperial fleet attempting to repair and regroup here -"
		--TEXT_SPEECH_UW_ACT03_M12_36




		--cue'ing the line "Urai Fen: There are multiple Alliance signatures as well. "
		--TEXT_SPEECH_UW_ACT03_M12_37
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_04")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_04_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Urai Fen: There are multiple Alliance signatures as well."
		--TEXT_SPEECH_UW_ACT03_M12_37

		--show the rebel commander hyperspacing in near tyber here
		intro_camera_cut02 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-cut02")
		intro_look_cut02 = Find_Hint("MARKER_GENERIC_RED", "intro-look-cut02")
		intro_camera_cut02_move01 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-cut02-move01")

		if not esc_pressed then
			Transition_Cinematic_Camera_Key(tyber, 0, 1000, 20, 110, 1, 0, 0, 0)
			Transition_Cinematic_Target_Key(intro_look_cut02, 0, 0, 0, -200, 0, 0, 0, 0)

			Transition_Cinematic_Camera_Key(tyber, 8, 900, 30, 120, 1, 0, 0, 0)
		end


		--current_cinematic_thread = nil

		--rebel_hero.Prevent_AI_Usage(true)
		rebel_hero.Hide(false)
		rebel_hero.Prevent_Opportunity_Fire(true)
		rebel_hero.Prevent_All_Fire(true)
		--rebel_hero.Suspend_Locomotor(false)
		rebel_hero.Cinematic_Hyperspace_In(1)




		if TestValid(escort_list[1]) then
			escort_list[1].Hide(false)
			escort_list[1].Prevent_Opportunity_Fire(true)
			escort_list[1].Prevent_All_Fire(true)
			escort_list[1].Cinematic_Hyperspace_In(10)
		end

		if TestValid(escort_list[2]) then
			escort_list[2].Hide(false)
			escort_list[2].Prevent_Opportunity_Fire(true)
			escort_list[2].Prevent_All_Fire(true)
			escort_list[2].Cinematic_Hyperspace_In(30)
		end

		if TestValid(escort_list[3]) then
			escort_list[3].Hide(false)
			escort_list[3].Prevent_Opportunity_Fire(true)
			escort_list[3].Prevent_All_Fire(true)
			escort_list[3].Cinematic_Hyperspace_In(50)
		end

		if TestValid(escort_list[4]) then
			escort_list[4].Hide(false)
			escort_list[4].Prevent_Opportunity_Fire(true)
			escort_list[4].Prevent_All_Fire(true)
			escort_list[4].Cinematic_Hyperspace_In(60)
		end

		--current_cinematic_thread = 1


		--Transition_Cinematic_Camera_Key(intro_camera_cut02_move01, 1, 0, 0, 0, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(rebel_hero, 1, 0, 0, 0, 0, 0, 0, 0)

		--Cinematic_Zoom(2, .02)

		--cue'ing the line "Rebel Commander: Unidentified ships, what is your purpose in this sector?! "
		--TEXT_SPEECH_UW_ACT03_M12_39
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_05")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_05_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Rebel Commander: Unidentified ships, what is your purpose in this sector?! "
		--TEXT_SPEECH_UW_ACT03_M12_39

		intro_camera_cut03 = Find_Hint("MARKER_GENERIC_RED", "intro-camera-cut03")

		--Transition_Cinematic_Camera_Key(intro_camera_cut03, 0, 0, 0, 0, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(tyber, 0, 0, 0, 0, 0, 0, 0, 0)

		--back to tyber here


		--cue'ing the line "Tyber Zann: We heard of the Alliance's glorious victory at Endor, and have come to help." "
		--TEXT_SPEECH_UW_ACT03_M12_40
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_06")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_06_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Tyber Zann: We heard of the Alliance's glorious victory at Endor, and have come to help." "
		--TEXT_SPEECH_UW_ACT03_M12_40

		--close up on rebel commander here
		--rebel_hero.Stop()
		--rebel_hero.Suspend_Locomotor(true)

		if not esc_pressed then
			rebel_hero.Move_To(tyber)
			Transition_Cinematic_Target_Key(rebel_hero, 3, 0, 0, 0, 0, rebel_hero, 0, 0)
			Transition_Cinematic_Camera_Key(tyber, 8, 900, 50, 120, 1, 0, 0, 0)

			for i, escort in pairs(escort_list) do
				escort.Stop()
			end
		end

		hancloseup_cameramove = Find_Hint("MARKER_GENERIC_RED", "han-closeup-cameramove")

		--Transition_Cinematic_Camera_Key(rebel_hero, 0, 40, 40, 10, 0, 0, 0, 0)
		--Transition_Cinematic_Target_Key(rebel_hero, 0, 0, 0, 0, 0, 0, 0, 0)

		--Transition_Cinematic_Camera_Key(hancloseup_cameramove, 5, 40, 40, 10, 0, 0, 0, 0)


		--cue'ing the line "Rebel Commander: Help us destroy the Eclipse, and you will be well rewarded by the Alliance. "
		--TEXT_SPEECH_UW_ACT03_M12_41
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_07")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_07_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Rebel Commander: Help us destroy the Eclipse, and you will be well rewarded by the Alliance. "
		--TEXT_SPEECH_UW_ACT03_M12_41

		--cue'ing the line "Tyber Zann: Looks like there's a few starbases between us and the Eclipse, focus your attacks there."
		--TEXT_SPEECH_UW_ACT03_M12_42
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_08")

		--flyover of the Imperial starbases here
		--starbase_01
		if not esc_pressed then
			Transition_Cinematic_Camera_Key(starbase_01, 0, 2500, 1200, 50, 0, 0, 0, 0)
			Transition_Cinematic_Target_Key(starbase_01, 0, 0, 0, 0, 0, 0, 0, 0)
			Sleep(0.5)
			starbase_01.Highlight(true, 250)
			Add_Radar_Blip(starbase_01, "starbase_01_blip")
		end

		Sleep(1)

		if not esc_pressed then
			Transition_Cinematic_Camera_Key(starbase_02, 2, 2500, 1200, 50, 0, 0, 0, 0)
			Transition_Cinematic_Target_Key(starbase_02, 2, 0, 0, 0, 0, 0, 0, 0)
			Sleep(0.5)
			starbase_02.Highlight(true, 250)
			Add_Radar_Blip(starbase_02, "starbase_02_blip")
		end

		Sleep(2)

		if not esc_pressed then
			Transition_Cinematic_Camera_Key(starbase_03, 2, 2500, 1200, 50, 0, 0, 0, 0)
			Transition_Cinematic_Target_Key(starbase_03, 2, 0, 0, 0, 0, 0, 0, 0)
			Sleep(0.5)
			starbase_03.Highlight(true, 250)
			Add_Radar_Blip(starbase_03, "starbase_03_blip")
		end

		Sleep(1)



	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_08_Remove_Text(message)
	if message == OnEnter then
		--just finished the line "Tyber Zann: Looks like there's a few starbases between us and the Eclipse, focus your attacks there."
		--TEXT_SPEECH_UW_ACT03_M12_42

		--leave cinematic here
		--Fade_Screen_Out(0)
		Suspend_AI(1)
		--Lock_Controls(1)
		Letter_Box_In(0)
		--Start_Cinematic_Camera()
		--Sleep(1)


		--cue'ing the line "Rebel Commander: Agreed."
		--TEXT_SPEECH_UW_ACT03_M12_43
		Story_Event("UM12_CUE_INTRO_DIALOG_LINE_09")
	end
end

function State_UM12_DIALOG_Intro_Dialog_Line_09_Remove_Text(message)
	if message == OnEnter then
	Thread.Kill(current_cinematic_thread)
	current_cinematic_thread = nil
	Create_Thread("End_Camera")
	end
end


function Story_Handle_Esc()
	if current_cinematic_thread ~= nil then
		esc_pressed = true
		Thread.Kill(current_cinematic_thread)
		current_cinematic_thread = nil
		Create_Thread("End_Camera")
		Story_Event("UM12_ESCAPEKEY_PREVENT_INTRO_DIALOG_AI_NOTIFICATION")
	end
end

function End_Camera()
	Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()

	underworld_ship_list = Find_All_Objects_Of_Type(underworld_player)
	for i, underworld_ship in pairs(underworld_ship_list) do
		underworld_ship.Prevent_Opportunity_Fire(false)
		underworld_ship.Prevent_All_Fire(false)
		underworld_ship.Stop()
	end




	rebel_hero.Despawn()


	new_hero_list= Spawn_Unit(Find_Object_Type("MILLENNIUM_FALCON"), rebel_hero_location, rebel_player)
	rebel_hero = new_hero_list[1]
	rebel_hero.Set_Cannot_Be_Killed(true)
	rebel_hero.Make_Invulnerable(true)

	for i, escort in pairs(escort_list) do
		escort.Despawn()
		--escort.Prevent_AI_Usage(false)
		--escort.Suspend_Locomotor(false)
		--escort.Hide(false)
		--escort.Teleport(escort_location_list[i])
		--Create_Thread("Thread_Rebel_Reinforcement_Orders", escort)

		--escort.Cinematic_Hyperspace_In(1)
	end

	escort_list = {}

	new_escort_list1= Spawn_Unit(Find_Object_Type("NEBULON_B_FRIGATE"), escort_location_list[1], rebel_player)
	escort_list[1] = new_escort_list1[1]

	new_escort_list2= Spawn_Unit(Find_Object_Type("NEBULON_B_FRIGATE"), escort_location_list[2], rebel_player)
	escort_list[2] = new_escort_list2[1]

	new_escort_list3= Spawn_Unit(Find_Object_Type("CALAMARI_CRUISER"), escort_location_list[3], rebel_player)
	escort_list[3] = new_escort_list3[1]

	new_escort_list4= Spawn_Unit(Find_Object_Type("CALAMARI_CRUISER"), escort_location_list[4], rebel_player)
	escort_list[4] = new_escort_list4[1]

	for i, escort in pairs(escort_list) do
		Create_Thread("Thread_Rebel_Reinforcement_Orders", escort)
	end










	Point_Camera_At(tyber)
	Transition_To_Tactical_Camera(5)
	Sleep(5)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Letter_Box_Out(0)
	Suspend_AI(0)

	Weather_Audio_Pause(false)
	Allow_Localized_SFX(true)
	Resume_Mode_Based_Music()


	Fade_Screen_In(0)
	Transition_To_Tactical_Camera(2)
	Letter_Box_Out(2)
	Sleep(2)
	Lock_Controls(0)
	End_Cinematic_Camera()
	Suspend_AI(0)

	Story_Event("UM12_GIVE_STARTING_OBJECTIVES")

	uw_reveal = FogOfWar.Reveal_All(underworld_player)

	Create_Thread("Thread_DeathMonitor_TyberZann")
	Create_Thread("Thread_DeathMonitor_BoardingShuttle01")
	--Create_Thread("Thread_DeathMonitor_BoardingShuttle02")
	--Create_Thread("Thread_DeathMonitor_BoardingShuttle03")

	starbase_01.Highlight(true, 250)
	Add_Radar_Blip(starbase_01, "starbase_01_blip")
	starbase_02.Highlight(true, 250)
	Add_Radar_Blip(starbase_02, "starbase_02_blip")
	starbase_03.Highlight(true, 250)
	Add_Radar_Blip(starbase_03, "starbase_03_blip")

	Create_Thread("Thread_DeathMonitor_Starbase01")
	Create_Thread("Thread_DeathMonitor_Starbase02")
	Create_Thread("Thread_DeathMonitor_Starbase03")
	Create_Thread("Thread_DeathMonitor_Starbases")

	Create_Thread("Thread_DeathMonitor_Shipyard01")
	Create_Thread("Thread_DeathMonitor_Shipyard02")
	Create_Thread("Thread_DeathMonitor_Shipyard03")
	Create_Thread("Thread_DeathMonitor_Shipyard04")
	Create_Thread("Thread_DeathMonitor_Shipyard05")


	Create_Thread("Thread_Empire_Units_Arrive")
	Create_Thread("Thread_Rebel_Units_Arrive")

	Sleep(10)

	Create_Thread("Thread_Give_Opening_Hint")

end

function Thread_Give_Opening_Hint()
	local flag_hint_01_valid = true
	local flag_hint_02_valid = true
	local flag_hint_03_valid = true

	while (true) do
		local hint_timer = 60
		local hint_number = GameRandom.Free_Random(2, 3)
		JoeMessage("current hint_number  is %d", hint_number)
		if hint_number == 1 then
			--check to see if any starbases are still alive and not under your control
			if bool_starbase01_active == true or bool_starbase01_active == true or bool_starbase01_active == true then
				Story_Event("UM12_GIVE_HINT_01_BOARDING_SHUTTLES")
			else
				hint_timer = 1
				flag_hint_01_valid = false
			end


		elseif hint_number == 2 then
			--check to see if there are still shipyards
			shipyard_list = Find_All_Objects_Of_Type("EMPIRE_DOCK_DESTROYABLE")
			local flag_all_shipyards_destroyed = true
			for i, shipyard in pairs(shipyard_list) do
				if TestValid(shipyard) then
					flag_all_shipyards_destroyed = false
				end
			end

			if flag_all_shipyards_destroyed == false then
				Story_Event("UM12_GIVE_HINT_02_EMPIRE_REPAIRING")
			else
				hint_timer = 1
				flag_hint_02_valid = false
			end



		else
			--check to see if player is still friends with rebels
			if bool_rebels_are_friends == true then
				Story_Event("UM12_GIVE_HINT_03_USE_THE_REBELS")
			else
				hint_timer = 1
				flag_hint_03_valid = false
			end
		end

		if flag_hint_01_valid == false and flag_hint_02_valid == false and flag_hint_03_valid == false then
			break
		end

		Sleep(hint_timer)
	end
end


function State_UM12_ADD_OBJECTIVE_Defeat_The_Rebels(message)
	if message == OnEnter then
		--player has been given objective to destroy the rebel hero...mark him
		--and start monitoring his health
		if TestValid(rebel_hero) then
			rebel_hero.Highlight(true)
			Add_Radar_Blip(rebel_hero, "rebel_hero_blip")
			rebel_hero.Set_Cannot_Be_Killed(false)
			rebel_hero.Make_Invulnerable(false)

			underworld_player.Make_Enemy(rebel_player)
			rebel_player.Make_Enemy(underworld_player)

			bool_rebels_are_friends = false

			Create_Thread("Thread_DeathMonitor_RebelHero")
		else
			DebugMessage("Cannot find Rebel hero...aborting.  Tell Dan Etter immediately")
		end
	end
end

function State_UM12_REMOVE_OBJECTIVE_Help_Rebels(message)
	if message == OnEnter then
		--see if there are still space stations and that you dont control them
		if bool_starbase01_active == true or bool_starbase01_active == true or bool_starbase01_active == true then
				Story_Event("UM12_CHANGE_SPACE_STATION_OBJECTIVE")
		end
	end
end




function State_UM12_Bring_In_SuperStarDestroyer(message)
	if message == OnEnter then
		DebugMessage("Eclipse weapon goes offline here")

		--make sure there's no attack target
		while eclipse.Has_Attack_Target() == true do
			Sleep(0.25)
		end

		if TestValid(eclipse) then
			eclipse.Force_Ability_Recharge("SUPER_LASER", 10000.0) --Put the ability on recharge with a 10000 second timer
		end



		Story_Event("UM12_SUPER_STARDESTROYER_ENTERS_STAGE_LEFT")
		Sleep(3)
		--bring in the super-star destroyer now...make it attack the eclipse

		stardestroyer_list = {
		"STAR_DESTROYER",
	}


		entryflag_eclipse01 = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-eclipse01")
		entryflag_eclipse02 = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-eclipse02")
		entryflag_eclipse03 = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-eclipse03")



		ReinforceList(stardestroyer_list, entryflag_eclipse01, empire_player, false, true, true, Callback_Empire_StarDestroyer01_Arrives)
		ReinforceList(stardestroyer_list, entryflag_eclipse02, empire_player, false, true, true, Callback_Empire_StarDestroyer02_Arrives)
		ReinforceList(stardestroyer_list, entryflag_eclipse03, empire_player, false, true, true, Callback_Empire_StarDestroyer03_Arrives)

		--turning over all pointguards to AI control
		for i, pointguard in pairs(pointguard_list) do
			if TestValid(pointguard) then
				pointguard.Prevent_AI_Usage(false)
			end
		end




	end
end


function State_UM12_DIALOG_SuperStarDestroyer_Has_Arrived_Remove_Movie(message)
	if message == OnEnter then
		empire_super_stardestroyer[1] = "UM12_SUPER_STAR_DESTROYER"
		entryflag_eclipse = Find_Hint("MARKER_GENERIC_YELLOW", "entryflag-eclipse")
		ReinforceList(empire_super_stardestroyer, entryflag_eclipse, empire_player, false, true, true, Callback_Empire_SuperStarDestroyer_Arrives)
		--Create_Thread("Thread_Monitor_Eclipse_FiringStatus")

		Sleep(225)
		Story_Event("UM12_SUPERLASER_COMES_BACK_ONLINE_AI_NOTIFICATION")

		if TestValid(eclipse) then
			eclipse.Force_Ability_Recharge("SUPER_LASER", 10.0) --Put the ability back to a 10 second timer
		end
	end
end


























--*******************************************************************************
--******jdg below are the scripts and stuff to bring in both empire and rebel units during
--******the mission.  There are also scipts to make the "damaged" empire ships dock
--******at the shipyards, heal, and then go back out and fight.
--*******************************************************************************
function Thread_Rebel_Units_Arrive()
	while(bool_rebels_attacking == true) do
		--random pick of how many units in the incoming force
		local num_list_total = GameRandom(3,5)

		--random pick of group composition
		for i=1,num_list_total do
			rebel_reinforce_list[i] = rebel_shiptype_list[GameRandom(1,6)]
		end

		--do a quick querry on how many entry locations are currently allowed
		local top_end = 0
		for i, entryflag in pairs(rebel_entryflag_list) do
			top_end = top_end + 1
		end
		DebugMessage("top_end is %d", top_end)
		--random pick of entry location
		local roll_entryflag = GameRandom(1,top_end)

		if (bool_rebels_attacking == true) then
			if not TestValid(rebel_entryflag_list[roll_entryflag]) then
				DebugMessage("cannot find rebel entry flag")
			else
				ReinforceList(rebel_reinforce_list, rebel_entryflag_list[roll_entryflag], rebel_player, false, true, false, Callback_Rebel_Reinforcements)
			end
		end
		Sleep(30)
	end
end


function Callback_Rebel_Reinforcements(new_list)
	DebugMessage("Callback_Rebel_Reinforcements HIT!")
	Create_Thread("Thread_Rebel_Reinforcements", new_list)
end

function Thread_Rebel_Reinforcements(reinforce_list)
	DebugMessage("Thread_Rebel_Reinforcements HIT!")
	for i, rebel_ship in pairs(reinforce_list) do
		if TestValid(rebel_ship) then
			Create_Thread("Thread_Rebel_Reinforcement_Orders", rebel_ship)
		end
	end
end

function Thread_Rebel_Reinforcement_Orders(rebel_ship)

	while TestValid(rebel_ship) do
		--JoeMessage("Thread_Rebel_Reinforcement_Orders HIT!")

		if (bool_rebels_attacking == false) then
			Sleep(1)
			rebel_ship.Hyperspace_Away()
			return
		end

		if TestValid(eclipse) and eclipse.Get_Owner().Get_Faction_Name() == "UNDERWORLD" then
			if TestValid(eclipse) and TestValid(rebel_ship) then
				rebel_ship.Attack_Target(eclipse)
				rebel_ship.Prevent_AI_Usage(false)
				--JoeMessage("rebel_ship.Attack_Move(eclipse) HIT!")
				break
			end

		end

		local my_nearest_starbase = Find_Nearest(rebel_ship, "UM12_STAR_BASE")
		if TestValid(rebel_ship) and TestValid(my_nearest_starbase) then
			rebel_ship.Attack_Target(my_nearest_starbase)
			--JoeMessage("rebel_ship.Attack_Move(my_nearest_starbase) HIT!")
		elseif TestValid(rebel_ship) then
			rebel_ship.Prevent_AI_Usage(false)
			--JoeMessage("rebel_ship.Prevent_AI_Usage(false) HIT!")
			break
		end


		Sleep(20)
	end
end




function Thread_Empire_Units_Arrive()
	while(bool_okay_to_reinforce_empire == true) do
		--pick how many units in the incoming force
		local num_list_total = GameRandom(1,2)

		for i=1,num_list_total do
			empire_reinforce_list[i] = empire_shiptype_list[GameRandom(1,6)]
		end

		--local num_this_lists_popcap_value = Get_Popcap_Value(empire_reinforce_list)

		--while ((num_this_lists_popcap_value + num_current_popcap) >= const_max_popcap)  do
		--	Sleep (5)
		--end

		--if ((num_this_lists_popcap_value + num_current_popcap) < const_max_popcap) then
			ReinforceList(empire_reinforce_list, entryflag_empire01, empire_player, false, true, false, Callback_Empire_Ships_Arrive_Damaged)
		--	num_current_popcap = num_current_popcap + num_this_lists_popcap_value
			JoeMessage("new pop count (after reinforcing) is %d", num_current_popcap)
		--else
		--	DebugMessage("current pop cap too high, not reinforcing")
		--end
		Sleep(30)
	end
end

function Get_Popcap_Value(reinforce_list)
	local pop_cap_value = 0
	for i, empire_ship in pairs(reinforce_list) do
		if empire_ship == "ACCLAMATOR_ASSAULT_SHIP" then
			pop_cap_value = pop_cap_value + const_acclamator_popcap_value

		elseif empire_ship == "BROADSIDE_CLASS_CRUISER" then
			pop_cap_value = pop_cap_value + const_broadside_popcap_value

		elseif empire_ship == "INTERDICTOR_CRUISER" then
			pop_cap_value = pop_cap_value + const_interdictor_popcap_value

		elseif empire_ship == "STAR_DESTROYER" then
			pop_cap_value = pop_cap_value + const_stardestroyer_popcap_value

		elseif empire_ship == "TARTAN_PATROL_CRUISER" then
			pop_cap_value = pop_cap_value + const_tartan_popcap_value

		elseif empire_ship == "VICTORY_DESTROYER" then
			pop_cap_value = pop_cap_value + const_victorydestroyer_popcap_value
		end
	end

	JoeMessage("current pop_cap_value of incoming empire list is %d", pop_cap_value)
	return pop_cap_value
end

function Callback_Empire_Ships_Arrive_Damaged(new_list)
	Create_Thread("Thread_Empire_Ships_Arrive_Damaged", new_list)
end

function Thread_Empire_Ships_Arrive_Damaged(new_list)

	for i, empire_ship in pairs(new_list) do
		if TestValid(empire_ship) then
			empire_ship.Set_Cannot_Be_Killed(true)
			if empire_ship.Get_Type().Get_Name() == "ACCLAMATOR_ASSAULT_SHIP" then
				--pick how many hardpoint to destroy
				local number_of_hps_to_destroy = GameRandom(4,7)
				local number_of_hps_destroyed = 0

				while (number_of_hps_to_destroy > number_of_hps_destroyed) do
					hp_to_destroy = GameRandom(1,7)
					empire_ship.Take_Damage(100000, acclamator_hardpoint_list[hp_to_destroy])
					number_of_hps_destroyed = number_of_hps_destroyed + 1
				end

			elseif empire_ship.Get_Type().Get_Name() == "BROADSIDE_CLASS_CRUISER" then
				--no hard points need to do something else
				max_health = const_max_broadside_health
				local damage_weight = GameRandom(12,12)
				local damage_amount = max_health * damage_weight * 0.1

				empire_ship.Take_Damage(damage_amount)

			elseif empire_ship.Get_Type().Get_Name() == "INTERDICTOR_CRUISER" then
				--pick how many hardpoint to destroy
				local number_of_hps_to_destroy = GameRandom(3,6)
				local number_of_hps_destroyed = 0

				while (number_of_hps_to_destroy > number_of_hps_destroyed) do
					hp_to_destroy = GameRandom(1,6)
					empire_ship.Take_Damage(100000, interdictor_hardpoint_list[hp_to_destroy])
					number_of_hps_destroyed = number_of_hps_destroyed + 1
				end

			elseif empire_ship.Get_Type().Get_Name() == "STAR_DESTROYER" then
				--its a stardestroyer, now blow off a few hardpoints
				--pick how many hardpoint to destroy
				local number_of_hps_to_destroy = GameRandom(5,9)
				local number_of_hps_destroyed = 0

				while (number_of_hps_to_destroy > number_of_hps_destroyed) do
					hp_to_destroy = GameRandom(1,9)
					empire_ship.Take_Damage(100000, stardestroyer_hardpoint_list[hp_to_destroy])
					number_of_hps_destroyed = number_of_hps_destroyed + 1
				end

			elseif empire_ship.Get_Type().Get_Name() == "TARTAN_PATROL_CRUISER" then
				--no hard points need to do something else
				max_health = const_max_tartan_health
				local damage_weight = GameRandom(22,22)
				local damage_amount = max_health * damage_weight * 0.1

				empire_ship.Take_Damage(damage_amount)

			elseif empire_ship.Get_Type().Get_Name() == "VICTORY_DESTROYER" then
				--pick how many hardpoint to destroy
				local number_of_hps_to_destroy = GameRandom(2,5)
				local number_of_hps_destroyed = 0

				while (number_of_hps_to_destroy > number_of_hps_destroyed) do
					hp_to_destroy = GameRandom(1,5)
					empire_ship.Take_Damage(100000, victory_hardpoint_list[hp_to_destroy])
					number_of_hps_destroyed = number_of_hps_destroyed + 1
				end
			end

			Create_Thread("Thread_Empire_Ships_Dock_to_Heal", empire_ship)
			--Create_Thread("Thread_PopCap_Death_Monitor", empire_ship)
		end

		empire_ship.Set_Cannot_Be_Killed(false)
	end

	empire_reinforce_list = {}
end

function Thread_PopCap_Death_Monitor(empire_ship)
	local deadship_popcap_value = 0
	if TestValid(empire_ship) then
		if empire_ship.Get_Type().Get_Name() == "ACCLAMATOR_ASSAULT_SHIP" then
			deadship_popcap_value = const_acclamator_popcap_value
		elseif empire_ship.Get_Type().Get_Name() == "BROADSIDE_CLASS_CRUISER" then
			deadship_popcap_value = const_broadside_popcap_value
		elseif empire_ship.Get_Type().Get_Name() == "INTERDICTOR_CRUISER" then
			deadship_popcap_value = const_interdictor_popcap_value
		elseif empire_ship.Get_Type().Get_Name() == "STAR_DESTROYER" then
			deadship_popcap_value = const_stardestroyer_popcap_value
		elseif empire_ship.Get_Type().Get_Name() == "TARTAN_PATROL_CRUISER" then
			deadship_popcap_value = const_tartan_popcap_value
		elseif empire_ship.Get_Type().Get_Name() == "VICTORY_DESTROYER" then
			deadship_popcap_value = const_victorydestroyer_popcap_value
		end

		empire_ship.Set_Cannot_Be_Killed(false)

		while TestValid(empire_ship) do
			Sleep(3)
		end

		num_current_popcap = num_current_popcap - deadship_popcap_value
		JoeMessage("empire ship dead, popcap value is %d", deadship_popcap_value)
		JoeMessage("empire ship dead, current popcap value is %d", num_current_popcap)
	end

end

function Thread_Empire_Ships_Dock_to_Heal(damaged_ship)
	--Sleep(3)
	if TestValid(damaged_ship) then
		if (damaged_ship.Get_Hull() < 1) then
			local bay_number = Find_First_Open_Bay()
			local shipyard_number = nil

			if bay_number == sy01_healbay01 or  bay_number == sy01_healbay02 or
				bay_number == sy01_healbay03 or bay_number == sy01_healbay04 then
				shipyard_number = shipyard01
			elseif bay_nuber == sy02_healbay01 or bay_number == sy02_healbay02 then
				shipyard_number = shipyard02
			elseif bay_number == sy03_healbay01 or bay_number == sy03_healbay02 then
				shipyard_number = shipyard03
			elseif bay_number == sy04_healbay01 then
				shipyard_number = shipyard04
			elseif bay_number == sy05_healbay01 then
				shipyard_number = shipyard05
			end

			if (bay_number == nil) then
				--there are no open bays...go fight
				damaged_ship.Prevent_AI_Usage(false)

			elseif TestValid (damaged_ship) then
				damaged_ship.Move_To(bay_number.Get_Position())
				Register_Prox(bay_number, Prox_FAKE_Heal_Big_Ships, 200, damaged_ship)

				damaged_ship_info_list = {}
				damaged_ship_info_list[1] = damaged_ship
				damaged_ship_info_list[2] = bay_number
				damaged_ship_info_list[3] = shipyard_number

				Create_Thread("Thread_Monitor_Healing", damaged_ship_info_list)

			else
				Heal_Bay_Is_Now_Clear(bay_number)
			end
		end

	end
end

function Prox_FAKE_Heal_Big_Ships(prox_obj, trigger_obj)

	if trigger_obj.Get_Type().Get_Name() == "ACCLAMATOR_ASSAULT_SHIP"
		or trigger_obj.Get_Type().Get_Name() == "INTERDICTOR_CRUISER"
		or trigger_obj.Get_Type().Get_Name() == "STAR_DESTROYER"
		or trigger_obj.Get_Type().Get_Name() == "VICTORY_DESTROYER" then
			prox_obj.Cancel_Event_Object_In_Range(Prox_FAKE_Heal_Big_Ships)

			local thread_info = {}
			thread_info[1] = trigger_obj
			thread_info[2] = prox_obj
			Create_Thread("Thread_FAKE_Heal_Big_Ships", thread_info)
			DebugMessage("Prox_FAKE_Heal_Big_Ships hit")
		end
end

function Thread_FAKE_Heal_Big_Ships (thread_info)
	local big_ship = thread_info[1]
	local my_bay_number = thread_info[2]
	if TestValid(big_ship) then
		big_ship.Stop()
	end

	Sleep(15)

	if TestValid(big_ship) then
		DebugMessage("Thread_FAKE_Heal_Big_Ships hit")
		local ship_loc = big_ship.Get_Position()
		local healed_ship = Create_Generic_Object(big_ship.Get_Type().Get_Name(),ship_loc,empire_player)
		healed_ship.Teleport_And_Face(big_ship)
		big_ship.Despawn()
	end

	Heal_Bay_Is_Now_Clear(my_bay_number)
end

function Find_First_Open_Bay()

	if TestValid(shipyard01) and (bool_sy01_hf01_taken == false) then
		bool_sy01_hf01_taken = true
		JoeMessage("bool_sy01_hf01_taken = true")
		return sy01_healbay01
	elseif TestValid(shipyard01) and (bool_sy01_hf02_taken == false) then
		bool_sy01_hf02_taken = true
		JoeMessage("bool_sy01_hf02_taken = true")
		return sy01_healbay02
	elseif TestValid(shipyard01) and (bool_sy01_hf03_taken == false) then
		bool_sy01_hf03_taken = true
		JoeMessage("bool_sy01_hf03_taken = true")
		return sy01_healbay03
	elseif TestValid(shipyard01) and (bool_sy01_hf04_taken == false) then
		bool_sy01_hf04_taken = true
		JoeMessage("bool_sy01_hf04_taken = true")
		return sy01_healbay04
	elseif TestValid(shipyard02) and (bool_sy02_hf01_taken == false) then
		bool_sy02_hf01_taken = true
		JoeMessage("bool_sy02_hf01_taken = true")
		return sy02_healbay01
	elseif TestValid(shipyard02) and (bool_sy02_hf02_taken == false) then
		bool_sy02_hf02_taken = true
		JoeMessage("bool_sy02_hf02_taken = true")
		return sy02_healbay02
	elseif TestValid(shipyard03) and (bool_sy03_hf01_taken == false) then
		bool_sy03_hf01_taken = true
		JoeMessage("bool_sy03_hf01_taken = true")
		return sy03_healbay01
	elseif TestValid(shipyard03) and (bool_sy03_hf02_taken == false) then
		bool_sy03_hf02_taken = true
		JoeMessage("bool_sy03_hf02_taken = true")
		return sy03_healbay02
	elseif TestValid(shipyard04) and (bool_sy04_hf01_taken == false) then
		bool_sy04_hf01_taken = true
		JoeMessage("bool_sy04_hf01_taken = true")
		return sy04_healbay01
	elseif TestValid(shipyard05) and (bool_sy05_hf01_taken == false) then
		bool_sy05_hf01_taken = true
		JoeMessage("bool_sy05_hf01_taken = true")
		return sy05_healbay01
	else
		JoeMessage("damaged ship cannot find any open healbays")
		return nil
	end

end

function Thread_Monitor_Healing(info_list)

	local damaged_ship = info_list[1]
	local my_bay_number = info_list[2]
	local my_shipyard_number = info_list[3]

	--damaged_ship.Stop()
	while TestValid(damaged_ship) and (damaged_ship.Get_Hull() < 1) do
		if not TestValid(my_shipyard_number) then
			break
		end
		Sleep(1)
	end
	--ship is healed...releasing to the AI
	if TestValid(damaged_ship) then
		damaged_ship.Prevent_AI_Usage(false)
	end

	--give clearance for next ship to use your healing bay
	if TestValid(my_shipyard_number) then
		Heal_Bay_Is_Now_Clear(my_bay_number)
	end
end




function Heal_Bay_Is_Now_Clear(heal_bay)
	if (heal_bay == sy01_healbay01) then
		bool_sy01_hf01_taken = false
		JoeMessage("bool_sy01_hf01_taken = false")
		return
	elseif (heal_bay == sy01_healbay02) then
		bool_sy01_hf02_taken = false
		JoeMessage("bool_sy01_hf02_taken = false")
		return
	elseif (heal_bay == sy01_healbay03) then
		bool_sy01_hf03_taken = false
		JoeMessage("bool_sy01_hf03_taken = false")
		return
	elseif (heal_bay == sy01_healbay04) then
		bool_sy01_hf04_taken = false
		JoeMessage("bool_sy01_hf04_taken = false")
		return
	elseif (heal_bay == sy02_healbay01) then
		bool_sy02_hf01_taken = false
		JoeMessage("bool_sy02_hf01_taken = false")
		return
	elseif (heal_bay == sy02_healbay02) then
		bool_sy02_hf02_taken = false
		JoeMessage("bool_sy02_hf02_taken = false")
		return
	elseif (heal_bay == sy03_healbay01) then
		bool_sy03_hf01_taken = false
		JoeMessage("bool_sy03_hf01_taken = false")
		return
	elseif (heal_bay == sy03_healbay02) then
		bool_sy03_hf02_taken = false
		JoeMessage("bool_sy03_hf02_taken = false")
		return
	elseif (heal_bay == sy04_healbay01) then
		bool_sy04_hf01_taken = false
		JoeMessage("bool_sy04_hf01_taken = false")
		return
	elseif (heal_bay == sy05_healbay01) then
		bool_sy05_hf01_taken = false
		JoeMessage("bool_sy05_hf01_taken = false")
		return
	end

end

--*******************************************************************************
--******jdg below are the scripts and prox events used to capture/destroy the starbases
--******and the Eclipse
--*******************************************************************************
function PROX_Boarding_Shuttles(prox_obj, trigger_obj)
	--if shuttles_in_use[prox_obj] then
	--	return
	--end

	--if starbase_in_use[trigger_obj] then
	--	return
	--end

	--if trigger_obj.Get_Type().Get_Name() == "EMPIRE_STAR_BASE_5" then
		--starbase_in_use[trigger_obj] = true
		--shuttles_in_use[prox_obj] = true


		--if trigger_obj == starbase_01 and bool_capturing_starbase01 == true then
		--	return
		--elseif trigger_obj == starbase_01 then
		--	bool_capturing_starbase01 = true
		--	Create_Thread("Thread_Shuttle_Approaching_Starbase01", prox_obj)
		--	prox_obj.Cancel_Event_Object_In_Range(PROX_Boarding_Shuttles)
		--	return
		--end

		--if trigger_obj == starbase_02 and bool_capturing_starbase02 == true then
		--	return
		--elseif trigger_obj == starbase_02 then
		--	bool_capturing_starbase02 = true
		--	Create_Thread("Thread_Shuttle_Approaching_Starbase02", prox_obj)
		--	prox_obj.Cancel_Event_Object_In_Range(PROX_Boarding_Shuttles)
		--	return
		--end

		--if trigger_obj == starbase_03 and bool_capturing_starbase03 == true then
		--	return
		--elseif trigger_obj == starbase_03 then
		--	bool_capturing_starbase03 = true
		--	Create_Thread("Thread_Shuttle_Approaching_Starbase03", prox_obj)
		--	prox_obj.Cancel_Event_Object_In_Range(PROX_Boarding_Shuttles)
		--	return
		--end


	if trigger_obj.Get_Type().Get_Name() == "ECLIPSE_SUPER_STAR_DESTROYER" then

		--shuttles_in_use[prox_obj] = true

		local thread_info = {}
		thread_info[1] = prox_obj
		thread_info[2] = trigger_obj
		if bool_capturing_eclipse == false then
			bool_capturing_eclipse = true
			Create_Thread("Thread_Shuttle_Approaching_Eclipse", thread_info)
			prox_obj.Cancel_Event_Object_In_Range(PROX_Boarding_Shuttles)
		end
	end
end

function Thread_Shuttle_Approaching_Starbase01(shuttle)

	if shuttle == shuttle01 then
		bool_shuttle01_being_expended = true
	elseif shuttle == shuttle02 then
		bool_shuttle02_being_expended = true
	elseif shuttle == shuttle03 then
		bool_shuttle03_being_expended = true
	end

	Story_Event("UM12_SHUTTLE_APPROACHING_STARBASE")

	--set the shuttle invulnerable and send it at the starbase to fake a boarding
	shuttle.Set_Cannot_Be_Killed(true)
	shuttle.Prevent_AI_Usage(true)
	shuttle.Set_Selectable(false)
	shuttle.Move_To(starbase_01)
	Sleep(8)
	shuttle.Despawn()

	local random_starbase_event = GameRandom(1,2)
	if random_starbase_event == 1 then
		Sleep(10)
		if TestValid(starbase_01) then
			Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
			Sleep(5)
			starbase_01.Take_Damage(100000)
		end
	else
		Sleep(10)
		if TestValid(starbase_01) then
			Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
			Sleep(2)
			starbase_01.Change_Owner(underworld_player)
			--remove radar blips here
			starbase_01.Highlight(false)
			Remove_Radar_Blip("starbase_01_blip")
		end
	end
end

function Thread_Shuttle_Approaching_Starbase02(shuttle)

	if shuttle == shuttle01 then
		bool_shuttle01_being_expended = true
	elseif shuttle == shuttle02 then
		bool_shuttle02_being_expended = true
	elseif shuttle == shuttle03 then
		bool_shuttle03_being_expended = true
	end

	Story_Event("UM12_SHUTTLE_APPROACHING_STARBASE")

	--set the shuttle invulnerable and send it at the starbase to fake a boarding
	shuttle.Set_Cannot_Be_Killed(true)
	shuttle.Prevent_AI_Usage(true)
	shuttle.Set_Selectable(false)
	shuttle.Move_To(starbase_02)
	Sleep(8)
	shuttle.Despawn()

	local random_starbase_event = GameRandom(1,2)
	if random_starbase_event == 1 then
		Sleep(10)
		if TestValid(starbase_02) then
			Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
			Sleep(5)
			starbase_02.Take_Damage(100000)
		end
	else
		Sleep(10)
		if TestValid(starbase_02) then
			Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
			Sleep(2)
			starbase_02.Change_Owner(underworld_player)
			--remove radar blips here
			starbase_02.Highlight(false)
			Remove_Radar_Blip("starbase_02_blip")
		end
	end
end

function Thread_Shuttle_Approaching_Starbase03(shuttle)

	if shuttle == shuttle01 then
		bool_shuttle01_being_expended = true
	elseif shuttle == shuttle02 then
		bool_shuttle02_being_expended = true
	elseif shuttle == shuttle03 then
		bool_shuttle03_being_expended = true
	end

	Story_Event("UM12_SHUTTLE_APPROACHING_STARBASE")

	--set the shuttle invulnerable and send it at the starbase to fake a boarding
	shuttle.Set_Cannot_Be_Killed(true)
	shuttle.Prevent_AI_Usage(true)
	shuttle.Set_Selectable(false)
	shuttle.Move_To(starbase_03)
	Sleep(8)
	shuttle.Despawn()

	local random_starbase_event = GameRandom(1,2)
	if random_starbase_event == 1 then
		Sleep(10)
		if TestValid(starbase_03) then
			Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
			Sleep(5)
			starbase_03.Take_Damage(100000)
		end
	else
		Sleep(10)
		if TestValid(starbase_03) then
			Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
			Sleep(2)
			starbase_03.Change_Owner(underworld_player)
			--remove radar blips here
			starbase_03.Highlight(false)
			Remove_Radar_Blip("starbase_03_blip")
		end
	end
end

















function Thread_Shuttle_Approaching_Starbase(thread_info)
	ThreadValue.Set("starbase", thread_info[2])
    ThreadValue.Set("shuttle", thread_info[1])

    starbase = ThreadValue.Get("starbase");
    shuttle = ThreadValue.Get("shuttle");

	if shuttle == shuttle01 then
		bool_shuttle01_being_expended = true
	elseif shuttle == shuttle02 then
		bool_shuttle02_being_expended = true
	elseif shuttle == shuttle03 then
		bool_shuttle03_being_expended = true
	end

	Story_Event("UM12_SHUTTLE_APPROACHING_STARBASE")

	--set the shuttle invulnerable and send it at the starbase to fake a boarding
	shuttle.Set_Cannot_Be_Killed(true)
	shuttle.Prevent_AI_Usage(true)
	shuttle.Set_Selectable(false)
	shuttle.Move_To(starbase)
	Sleep(8)
	shuttle.Despawn()

	if starbase == starbase_01 then
		local random_starbase_01_event = GameRandom(1,2)
		if random_starbase_01_event == 1 then
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
				Sleep(5)
				starbase.Take_Damage(100000)
			end
		else
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
				Sleep(2)
				starbase.Change_Owner(underworld_player)
				--remove radar blips here
				starbase_01.Highlight(false)
				Remove_Radar_Blip("starbase_01_blip")
			end
		end
	elseif starbase == starbase_02 then
		local random_starbase_02_event = GameRandom(1,2)
		if random_starbase_02_event == 1 then
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
				Sleep(5)
				starbase.Take_Damage(100000)
			end
		else
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
				Sleep(2)
				starbase.Change_Owner(underworld_player)
				--remove radar blips here
				starbase_02.Highlight(false)
				Remove_Radar_Blip("starbase_02_blip")
			end
		end
	elseif starbase == starbase_03 then
		local random_starbase_03_event = GameRandom(1,2)
		if random_starbase_03_event == 1 then
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_DESTROYS_STARBASE")
				Sleep(5)
				starbase.Take_Damage(100000)
			end
		else
			Sleep(10)
			if TestValid(starbase) then
				Story_Event("UM12_SHUTTLE_CAPTURES_STARBASE")
				Sleep(2)
				starbase.Change_Owner(underworld_player)
				--remove radar blips here
				starbase_03.Highlight(false)
				Remove_Radar_Blip("starbase_03_blip")
			end
		end
	end
end




function Thread_Shuttle_Approaching_Eclipse(thread_info)
	local shuttle = thread_info[1]
	local eclipse = thread_info[2]



	Story_Event("UM12_SHUTTLE_APPROACHING_THE_ECLIPSE")

	shuttle.Set_Cannot_Be_Killed(true)
	shuttle.Prevent_AI_Usage(true)
	shuttle.Set_Selectable(false)
	shuttle.Move_To(eclipse)
	Sleep(8)
	shuttle.Despawn()

	Sleep(15)
	if TestValid(eclipse) then
		Story_Event("UM12_SHUTTLE_CAPTURES_ECLIPSE")
		Sleep(2)
		eclipse.Change_Owner(underworld_player)
		eclipse.Prevent_Opportunity_Fire(false)
		--remove radar blips here
		--eclipse.Highlight(false)
		Remove_Radar_Blip("eclipse_blip")
		bool_eclipse_captured = true
		eclipse.Set_Cannot_Be_Killed(false)

		Create_Thread("Thread_Monitor_Eclipse_FiringStatus")
		Create_Thread("Thread_DeathMonitor_Eclipse")

	end

	Sleep(180)


end







function Thread_Monitor_Eclipse_FiringStatus()
	if TestValid(eclipse) then
		while not eclipse.Is_Ability_Ready("SUPER_LASER") do
			Sleep(1)
		end


		while bool_first_shot_fired == false do
			if eclipse.Has_Attack_Target() == true then
				DebugMessage("Player is firing the Eclipse")
				target = eclipse.Get_Attack_Target()
				--if target == empire_super_stardestroyer[1] then
				--if target.Get_Type().Get_Name() == "UM12_SUPER_STAR_DESTROYER" then
				--if target.Get_Type().Get_Name() == "Executor_Super_Star_Destroyer" then
					Create_Thread("Thread_Midtro_Cinematic_Eclipse_Fires", target)
					bool_first_shot_fired = true
					break
				--else
					--DebugMessage("detected fire event ... not registering super star destroyer")
				--end
			end

			Sleep(1)
		end

	end
end

function Thread_Midtro_Cinematic_Eclipse_Fires(target)
	if not TestValid(eclipse) or not TestValid(target) then
		DebugMessage("UM12 Midtro is missing key objects...aborting...let Joe G know immediately!")
	end
	target.Set_Cannot_Be_Killed(true)

	Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()
	Cancel_Fast_Forward()
	Sleep(0.25)

	midtro_camera_start = Find_Hint("MARKER_GENERIC_RED", "midtro-camera-start")
	midtro_look_start = Find_Hint("MARKER_GENERIC_RED", "midtro-look-start")

	midtro_camera_move01 = Find_Hint("MARKER_GENERIC_RED", "midtro-camera-move01")

	Fade_Screen_In(0.25)
	Transition_Cinematic_Camera_Key(midtro_camera_move01, 0, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(midtro_look_start, 0, 0, 0, 0, 0, 0, 0, 0)

	Transition_Cinematic_Camera_Key(target, 10, 2000, 25, -135, 1, target, 0, 0)

	Sleep(2.5)

	target.Set_Cannot_Be_Killed(false)
	--Transition_Cinematic_Camera_Key(target, 5, 1300, 1300, 100, 0, target, 0, 0)
	Transition_Cinematic_Target_Key(target, 4, 0, 0, 0, 0, target, 0, 0)




	Sleep(8)
	End_Cinematic_Camera()
	Letter_Box_Out(1)
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(1)
end













function Callback_Empire_SuperStarDestroyer_Arrives(new_list)
	Create_Thread("Thread_Empire_SuperStarDestroyer_Arrives", new_list)
	bool_okay_to_reinforce_empire = false
end

function Thread_Empire_SuperStarDestroyer_Arrives(new_list)
	super_destroyer = new_list[1]
	if not TestValid(super_destroyer) then
		MessagBox("cannot find super star destroyer")
	end

	if TestValid(eclipse) and TestValid(super_destroyer) then

		--super_destroyer.Attack_Move(eclipse)
		--super_destroyer.Attack_Target(eclipse)
		--mark the destroyer and start monitoring its status
		super_destroyer.Highlight(true, 100)
		Add_Radar_Blip(super_destroyer, "super_destroyer_blip")

		Create_Thread("Thread_DeathMonitor_SuperStarDestroyer", super_destroyer)

		local goto_flag = Find_Hint("MARKER_GENERIC_GREEN", "goto-superstardestroyer")
		BlockOnCommand(super_destroyer.Move_To(goto_flag))
		DebugMessage("super_destroyer.Attack_Target(eclipse)")
		super_destroyer.Attack_Target(eclipse)

		block_table = {}
	end
end





function Callback_Empire_StarDestroyer01_Arrives(new_list)
	local goto_flag = Find_Hint("MARKER_GENERIC_GREEN", "goto-stardestroyer01")
	destroyer = new_list[1]

	local thread_info = {}
	thread_info[1] = destroyer
	thread_info[2] = goto_flag
	Create_Thread("Thread_Empire_StarDestroyer_Arrives", thread_info)
end

function Callback_Empire_StarDestroyer02_Arrives(new_list)
	local goto_flag = Find_Hint("MARKER_GENERIC_GREEN", "goto-stardestroyer02")
	destroyer = new_list[1]

	local thread_info = {}
	thread_info[1] = destroyer
	thread_info[2] = goto_flag
	Create_Thread("Thread_Empire_StarDestroyer_Arrives", thread_info)
end

function Callback_Empire_StarDestroyer03_Arrives(new_list)
	local goto_flag = Find_Hint("MARKER_GENERIC_GREEN", "goto-stardestroyer03")
	destroyer = new_list[1]

	local thread_info = {}
	thread_info[1] = destroyer
	thread_info[2] = goto_flag
	Create_Thread("Thread_Empire_StarDestroyer_Arrives", thread_info)
end


function Thread_Empire_StarDestroyer_Arrives(thread_info)
	destroyer = thread_info[1]
	goto_flag = thread_info[2]

	BlockOnCommand(destroyer.Move_To(goto_flag))
	DebugMessage("Destroyer in position...releasing to AI")
	--destroyer.Prevent_AI_Usage(false)
	--destroyer.Guard_Target(goto_flag.Get_Position())
	if TestValid(destroyer) and TestValid(eclipse) then
		destroyer.Attack_Target(eclipse)
	end
end







--*******************************************************************************
--****** Cinematics
--*******************************************************************************























--*******************************************************************************
--*******************     DEATH MONITORS       **********************************
--*******************************************************************************
function Thread_DeathMonitor_TyberZann()
	while TestValid(tyber) do
		Sleep(3)
	end

	Story_Event("UM12_PLAYER_LOSES_TYBER_KILLED")
end

function Thread_DeathMonitor_BoardingShuttle01()
	while TestValid(shuttle01) do
		Sleep(1)
	end

	if bool_capturing_eclipse == true then
		return
	end

	if bool_shuttle01_being_expended == true then
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_EXPENDED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_EXPENDED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_EXPENDED")
		end

	else
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_DESTROYED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_DESTROYED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_DESTROYED")
		end
	end
end

function Thread_DeathMonitor_BoardingShuttle02()
	while TestValid(shuttle02) do
		Sleep(1)
	end

	if bool_capturing_eclipse == true then
		return
	end

	if bool_shuttle02_being_expended == true then
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_EXPENDED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_EXPENDED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_EXPENDED")
		end

	else
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_DESTROYED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_DESTROYED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_DESTROYED")
		end
	end
end

function Thread_DeathMonitor_BoardingShuttle03()
	while TestValid(shuttle03) do
		Sleep(1)
	end

	if bool_capturing_eclipse == true then
		return
	end

	if bool_shuttle03_being_expended == true then
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_EXPENDED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_EXPENDED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_EXPENDED")
		end

	else
		num_shuttles_destroyed = num_shuttles_destroyed + 1
		if num_shuttles_destroyed == 1 then
			Story_Event("UM12_ONE_SHUTTLE_DESTROYED")
		elseif num_shuttles_destroyed == 2 then
			Story_Event("UM12_TWO_SHUTTLES_DESTROYED")
		else
			Story_Event("UM12_PLAYER_LOSES_ALL_SHUTTLES_DESTROYED")
		end
	end


end

function Thread_DeathMonitor_Starbase01()
	while TestValid(starbase_01) and (starbase_01.Get_Owner() ~= underworld_player) do
		Sleep(3)
	end

	bool_starbase01_active = false
	DebugMessage("bool_starbase01_active = false")
end

function Thread_DeathMonitor_Starbase02()
	while TestValid(starbase_02) and (starbase_02.Get_Owner() ~= underworld_player) do
		Sleep(3)
	end

	bool_starbase02_active = false
	DebugMessage("bool_starbase02_active = false")
end

function Thread_DeathMonitor_Starbase03()
	while TestValid(starbase_03) and (starbase_03.Get_Owner() ~= underworld_player) do
		Sleep(3)
	end

	bool_starbase03_active = false
	DebugMessage("bool_starbase03_active = false")
end

function Thread_DeathMonitor_Starbases()
	while (bool_starbase01_active == true) or (bool_starbase02_active == true) or (bool_starbase03_active == true) do
		Sleep(3)
	end

	if bool_capturing_eclipse == true then
		Story_Event("UM12_STARBASE_OBJECTIVE_COMPLETE_NO_REBELS")
	else
		Story_Event("UM12_STARBASE_OBJECTIVE_COMPLETE_WITH_REBELS")
	end
end

function Thread_DeathMonitor_Shipyard01()
	while TestValid(shipyard01) do
		Sleep(1)
	end

	--shipyard is dead...delete correspoding heal flags
	if TestValid(sy01_healbay01) then
		sy01_healbay01.Despawn()
	end

	if TestValid(sy01_healbay02) then
		sy01_healbay02.Despawn()
	end

	if TestValid(sy01_healbay03) then
		sy01_healbay03.Despawn()
	end

	if TestValid(sy01_healbay04) then
		sy01_healbay04.Despawn()
	end
end

function Thread_DeathMonitor_Shipyard02()
	while TestValid(shipyard02) do
		Sleep(1)
	end

	--shipyard is dead...delete correspoding heal flags
	if TestValid(sy02_healbay01) then
		sy02_healbay01.Despawn()
	end

	if TestValid(sy02_healbay02) then
		sy02_healbay02.Despawn()
	end

end

function Thread_DeathMonitor_Shipyard03()
	while TestValid(shipyard03) do
		Sleep(1)
	end

	--shipyard is dead...delete correspoding heal flags
	if TestValid(sy03_healbay01) then
		sy03_healbay01.Despawn()
	end

	if TestValid(sy03_healbay02) then
		sy03_healbay02.Despawn()
	end

end

function Thread_DeathMonitor_Shipyard04()
	while TestValid(shipyard04) do
		Sleep(1)
	end

	--shipyard is dead...delete correspoding heal flags
	if TestValid(sy04_healbay01) then
		sy04_healbay01.Despawn()
	end

end

function Thread_DeathMonitor_Shipyard05()
	while TestValid(shipyard05) do
		Sleep(1)
	end

	--shipyard is dead...delete correspoding heal flags
	if TestValid(sy05_healbay01) then
		sy05_healbay01.Despawn()
	end

end


function Thread_DeathMonitor_Shipyards()

	while(true) do
		local all_shipyards_destroyed = true
		shipyard_list = Find_All_Objects_Of_Type("EMPIRE_DOCK_DESTROYABLE")
		for i, shipyard in pairs(shipyard_list) do
			if TestValid(shipyard) then
				all_shipyards_destroyed = false
			end
		end

		if all_shipyards_destroyed == true then
			--all shipyards are destroyed...complete the objective
			Story_Event("UM12_SHIPYARD_OBJECTIVE_COMPLETE")
		end

		Sleep(5)
	end
end

function Thread_DeathMonitor_RebelHero()
	while TestValid(rebel_hero) do
		Sleep(3)
	end


	bool_rebels_attacking = false
	--rebel hero destroyed, complete the objective
	Story_Event("UM12_OBJECTIVE_COMPLETE_DESTROY_REBEL_HERO")

	Sleep(5)


	rebel_forces = Find_All_Objects_Of_Type(rebel_player)
	for i, rebel in pairs(rebel_forces) do
		if TestValid(rebel) then
			if rebel.Is_Category("Fighter") or
				rebel.Is_Category("Corvette") or
				rebel.Is_Category("Frigate") or
				rebel.Is_Category("Capital") then
					if rebel.Get_Type().Get_Name() == "DUMMY_BARRAGE_TARGET" then
						--do nothing
					else
						rebel.Hyperspace_Away()
					end
			end
		end
	end
end



function Thread_DeathMonitor_Eclipse()
	--put health warning here


	while TestValid(eclipse) do
		local eclipse_current_health = eclipse.Get_Hull()
		DebugMessage("eclipse_current_health is %d", eclipse_current_health)
		if TestValid(eclipse) and eclipse_current_health < 0.9 then
			DebugMessage("current eclipse_current_health  is %d", eclipse_current_health)
			Story_Event("UM12_ECLIPSE_BEING_ATTACKED")
			break
		end

		Sleep(3)
	end

	while TestValid(eclipse) do
		DebugMessage("Thread_DeathMonitor_Eclipse entering into wait mode.")
		Sleep(3)
	end

	Story_Event("UM12_PLAYER_LOSES_ECLIPSE_DESTROYED")
end

function Thread_DeathMonitor_SuperStarDestroyer(destroyer)
	while TestValid(destroyer) do
		Sleep(3)
	end

	--super star destroyer has been killed, clear objective
	Story_Event("UM12_OBJECTIVE_COMPLETE_DESTROY_SUPER_STAR_DESTROYER")
	DebugMessage("Super Star Destroyer dead...Rebels retreat...player wins!")
end


function JoeMessage(...)
	--JoeMessage("current current_spawn_times  is %d", current_spawn_times)
	_CustomScriptMessage("JoeLog.txt", string.format(unpack(arg)))
end
