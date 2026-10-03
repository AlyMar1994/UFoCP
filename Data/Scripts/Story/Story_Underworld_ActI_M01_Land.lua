-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActI_M01_LAND.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActI_M01_LAND.lua $
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
		Underworld_A01M01_Begin = State_Underworld_A01M01_Begin,
		Prolog_Intro_Dialog_00_Speech_Done = State_Prolog_Intro_Dialog_00_Speech_Done,
		Prolog_Intro_Dialog_01_Speech_Done = State_Prolog_Intro_Dialog_01_Speech_Done,
		Prolog_Intro_Dialog_02_Speech_Done = State_Prolog_Intro_Dialog_02_Speech_Done,
		Prolog_Intro_Dialog_02A_Speech_Done = State_Prolog_Intro_Dialog_02A_Speech_Done,
		Prolog_Intro_Dialog_New_00_Speech_Done = State_Prolog_Intro_Dialog_New_00_Speech_Done,
		Prolog_Intro_Dialog_New_01_Speech_Done = State_Prolog_Intro_Dialog_New_01_Speech_Done,
		Prolog_Intro_Dialog_New_02_Speech_Done = State_Prolog_Intro_Dialog_New_02_Speech_Done,
		Prolog_Intro_Dialog_New_03_Speech_Done = State_Prolog_Intro_Dialog_New_03_Speech_Done,
		Prolog_Intro_Dialog_New_04_Speech_Done = State_Prolog_Intro_Dialog_New_04_Speech_Done,
		Prolog_Intro_Dialog_New_05_Speech_Done = State_Prolog_Intro_Dialog_New_05_Speech_Done,
		Prolog_Intro_Dialog_New_06_Speech_Done = State_Prolog_Intro_Dialog_New_06_Speech_Done,
		Prolog_Intro_Dialog_New_07_Speech_Done = State_Prolog_Intro_Dialog_New_07_Speech_Done,
		Prolog_Intro_Dialog_New_08_Speech_Done = State_Prolog_Intro_Dialog_New_08_Speech_Done,
		Prolog_Intro_Dialog_New_09_Speech_Done = State_Prolog_Intro_Dialog_New_09_Speech_Done,
		Prolog_Intro_Dialog_New_10_Speech_Done = State_Prolog_Intro_Dialog_New_10_Speech_Done,
		Prolog_Intro_Dialog_New_11_Speech_Done = State_Prolog_Intro_Dialog_New_11_Speech_Done,
		Prolog_Intro_Dialog_New_12_Speech_Done = State_Prolog_Intro_Dialog_New_12_Speech_Done,
		Prolog_Intro_Dialog_New_13_Speech_Done = State_Prolog_Intro_Dialog_New_13_Speech_Done,
		Prolog_Intro_Dialog_03_Speech_Done = State_Prolog_Intro_Dialog_03_Speech_Done,
		Prolog_Intro_Dialog_04_Speech_Done = State_Prolog_Intro_Dialog_04_Speech_Done,
		Prolog_Intro_Dialog_05_Speech_Done = State_Prolog_Intro_Dialog_05_Speech_Done,
		Prolog_Intro_Dialog_06_Speech_Done = State_Prolog_Intro_Dialog_06_Speech_Done,
		Prolog_Intro_Dialog_07_Speech_Done = State_Prolog_Intro_Dialog_07_Speech_Done,
		Prolog_Intro_Dialog_08_Speech_Done = State_Prolog_Intro_Dialog_08_Speech_Done,
		Prolog_Midtro_Dialog_09_Speech_Done = State_Prolog_Midtro_Dialog_09_Speech_Done,
		Prolog_Midtro_Dialog_10_Speech_Done = State_Prolog_Midtro_Dialog_10_Speech_Done,
		Prolog_Midtro_Dialog_11_Speech_Done = State_Prolog_Midtro_Dialog_11_Speech_Done,
		Prolog_End_Dialog_12_Speech_Done = State_Prolog_End_Dialog_12_Speech_Done,
		Prolog_End_Dialog_13_Speech_Done = State_Prolog_End_Dialog_13_Speech_Done,
		Prolog_End_Dialog_14_Speech_Done = State_Prolog_End_Dialog_14_Speech_Done,
		Prolog_End_Dialog_15_Speech_Done = State_Prolog_End_Dialog_15_Speech_Done,
		Prolog_End_Dialog_16_Speech_Done = State_Prolog_End_Dialog_16_Speech_Done,
		Prolog_End_Dialog_17_Speech_Done = State_Prolog_End_Dialog_17_Speech_Done,
		Prolog_End_Dialog_18_Speech_Done = State_Prolog_End_Dialog_18_Speech_Done,
		Prolog_End_Dialog_19_Speech_Done = State_Prolog_End_Dialog_19_Speech_Done,
		Prolog_Chatter_Dialog_20_Speech_Done = State_Prolog_Chatter_Dialog_20_Speech_Done,
		Prolog_Chatter_Dialog_21_Speech_Done = State_Prolog_Chatter_Dialog_21_Speech_Done,
		Prolog_Chatter_Dialog_22_Speech_Done = State_Prolog_Chatter_Dialog_22_Speech_Done,
		Prolog_Chatter_Dialog_23_Speech_Done = State_Prolog_Chatter_Dialog_23_Speech_Done,
		Prolog_Chatter_Dialog_24_Speech_Done = State_Prolog_Chatter_Dialog_24_Speech_Done,
		Prolog_Chatter_Dialog_25_Speech_Done = State_Prolog_Chatter_Dialog_25_Speech_Done,
		Prolog_Chatter_Dialog_26_Speech_Done = State_Prolog_Chatter_Dialog_26_Speech_Done,
		Prolog_Chatter_Dialog_27_Speech_Done = State_Prolog_Chatter_Dialog_27_Speech_Done,
		Prolog_Chatter_Dialog_28_Speech_Done = State_Prolog_Chatter_Dialog_28_Speech_Done,
		Prolog_Chatter_Dialog_29_Speech_Done = State_Prolog_Chatter_Dialog_29_Speech_Done,
		Prolog_Chatter_Dialog_30_Speech_Done = State_Prolog_Chatter_Dialog_30_Speech_Done,
		Prolog_Chatter_Dialog_31_Speech_Done = State_Prolog_Chatter_Dialog_31_Speech_Done,
		Prolog_Chatter_Dialog_32_Speech_Done = State_Prolog_Chatter_Dialog_32_Speech_Done,
		Prolog_Chatter_Dialog_33_Speech_Done = State_Prolog_Chatter_Dialog_33_Speech_Done,
		Prolog_Chatter_Dialog_34_Speech_Done = State_Prolog_Chatter_Dialog_34_Speech_Done,
		Prolog_Chatter_Dialog_35_Speech_Done = State_Prolog_Chatter_Dialog_35_Speech_Done,
		Prolog_Chatter_Dialog_36_Speech_Done = State_Prolog_Chatter_Dialog_36_Speech_Done,
		Prolog_Chatter_Dialog_37_Speech_Done = State_Prolog_Chatter_Dialog_37_Speech_Done,
		Prolog_Chatter_Dialog_38_Speech_Done = State_Prolog_Chatter_Dialog_38_Speech_Done,
		Prolog_Chatter_Dialog_39_Speech_Done = State_Prolog_Chatter_Dialog_39_Speech_Done,
		Prolog_Intro_Dialog_40_Speech_Done = State_Prolog_Intro_Dialog_40_Speech_Done,
		Prolog_Intro_Dialog_41_Speech_Done = State_Prolog_Intro_Dialog_41_Speech_Done,
		Prolog_Intro_Dialog_42_Speech_Done = State_Prolog_Intro_Dialog_42_Speech_Done,
		Prolog_Chatter_Dialog_43_Speech_Done = State_Prolog_Chatter_Dialog_43_Speech_Done,
		Prolog_Chatter_Dialog_44_Speech_Done = State_Prolog_Chatter_Dialog_44_Speech_Done,
		Prolog_Chatter_Dialog_45_Speech_Done = State_Prolog_Chatter_Dialog_45_Speech_Done,
		Prolog_Chatter_Dialog_61_Speech_Done = State_Prolog_Chatter_Dialog_61_Speech_Done,
		Prolog_Chatter_Dialog_62_Speech_Done = State_Prolog_Chatter_Dialog_62_Speech_Done,
		Prolog_Chatter_Dialog_63_Speech_Done = State_Prolog_Chatter_Dialog_63_Speech_Done
	}
end

function State_Underworld_A01M01_Begin(message)
	if message == OnEnter then
		-- begin xml kickback flags
			State_Prolog_Intro_Dialog_00_Done = false
			State_Prolog_Intro_Dialog_01_Done = false
			State_Prolog_Intro_Dialog_02_Done = false
			State_Prolog_Intro_Dialog_02A_Done = false
			State_Prolog_Intro_Dialog_New_00_Done = false
			State_Prolog_Intro_Dialog_New_01_Done = false
			State_Prolog_Intro_Dialog_New_02_Done = false
			State_Prolog_Intro_Dialog_New_03_Done = false
			State_Prolog_Intro_Dialog_New_04_Done = false
			State_Prolog_Intro_Dialog_New_05_Done = false
			State_Prolog_Intro_Dialog_New_06_Done = false
			State_Prolog_Intro_Dialog_New_07_Done = false
			State_Prolog_Intro_Dialog_New_08_Done = false
			State_Prolog_Intro_Dialog_New_09_Done = false
			State_Prolog_Intro_Dialog_New_10_Done = false
			State_Prolog_Intro_Dialog_New_11_Done = false
			State_Prolog_Intro_Dialog_New_12_Done = false
			State_Prolog_Intro_Dialog_New_13_Done = false
			State_Prolog_Intro_Dialog_03_Done = false
			State_Prolog_Intro_Dialog_04_Done = false
			State_Prolog_Intro_Dialog_05_Done = false
			State_Prolog_Intro_Dialog_06_Done = false
			State_Prolog_Intro_Dialog_07_Done = false
			State_Prolog_Intro_Dialog_08_Done = false
			State_Prolog_Midtro_Dialog_09_Done = false
			State_Prolog_Midtro_Dialog_10_Done = false
			State_Prolog_Midtro_Dialog_11_Done = false
			State_Prolog_End_Dialog_12_Done = false
			State_Prolog_End_Dialog_13_Done = false
			State_Prolog_End_Dialog_14_Done = false
			State_Prolog_End_Dialog_15_Done = false
			State_Prolog_End_Dialog_16_Done = false
			State_Prolog_End_Dialog_17_Done = false
			State_Prolog_End_Dialog_18_Done = false
			State_Prolog_End_Dialog_19_Done = false
			State_Prolog_Chatter_Dialog_20_Done = false
			State_Prolog_Chatter_Dialog_21_Done = false
			State_Prolog_Chatter_Dialog_22_Done = false
			State_Prolog_Chatter_Dialog_23_Done = false
			State_Prolog_Chatter_Dialog_24_Done = false
			State_Prolog_Chatter_Dialog_25_Done = false
			State_Prolog_Chatter_Dialog_26_Done = false
			State_Prolog_Chatter_Dialog_27_Done = false
			State_Prolog_Chatter_Dialog_28_Done = false
			State_Prolog_Chatter_Dialog_29_Done = false
			State_Prolog_Chatter_Dialog_30_Done = false
			State_Prolog_Chatter_Dialog_31_Done = false
			State_Prolog_Chatter_Dialog_32_Done = false
			State_Prolog_Chatter_Dialog_33_Done = false
			State_Prolog_Chatter_Dialog_34_Done = false
			State_Prolog_Chatter_Dialog_35_Done = false
			State_Prolog_Chatter_Dialog_36_Done = false
			State_Prolog_Chatter_Dialog_37_Done = false
			State_Prolog_Chatter_Dialog_38_Done = false
			State_Prolog_Chatter_Dialog_39_Done = false
			State_Prolog_Intro_Dialog_40_Done = false
			State_Prolog_Intro_Dialog_41_Done = false
			State_Prolog_Intro_Dialog_42_Done = false
			State_Prolog_Chatter_Dialog_43_Done = false
			State_Prolog_Chatter_Dialog_44_Done = false
			State_Prolog_Chatter_Dialog_45_Done = false
			State_Prolog_Chatter_Dialog_61_Done = false
			State_Prolog_Chatter_Dialog_62_Done = false
			State_Prolog_Chatter_Dialog_63_Done = false
		-- end xml kickback flags
		
		--MessageBox("Loaded")
		neutral_player = Find_Player("Neutral")
		hutt_player = Find_Player("Hutts")
		pirate_player = Find_Player("Pirates")
		empire_player = Find_Player("Empire")
		hostile_player = Find_Player("Hostile")
		underworld_player = Find_Player("Underworld")
		
		Speech_5 = false
		Speech_6 = false
		enddeadguys = false
		landing_falcon = nil
		han_solo = nil
		chewbacca = nil
	
		wookies = nil
		guards = nil
		workers = nil
		rioters1 = nil
		rioters2 = nil
		guards1 = nil
		rioters3 = nil
		rioters4 = nil
		guards2 = nil
		rioters5 = nil
		rioters7 = nil
		guards4 = nil
		rioters9 = nil
		rioters0 = nil
		guards5 = nil
		riotersb = nil
		riotersd = nil
		guards6 = nil
		darkguys1 = nil
		darkguys2 = nil
		darkguys3 = nil
		darkguys4 = nil
		prisoner5 = nil
		prisoner5b = nil
		prisoner6 = nil
		prisoner6b = nil
		
		door9 = Find_Hint("UM05_MOVING_DOOR", "door9")
		falcon_gear1 = Find_Hint("UMP_SMALL_GEAR", "falcongear1")
		falcon_gear2 = Find_Hint("UMP_SMALL_GEAR", "falcongear2")
		falcon_gear3 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear3")
		falcon_gear4 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear4")
		falcon_gear5 = Find_Hint("UMP_SMALL_GEAR", "falcongear5")
		falcon_gear6 = Find_Hint("UMP_SMALL_GEAR", "falcongear6")
		falcon_gear7 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear7")
		falcon_gear8 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear8")
		falcon_gear9 = Find_Hint("UMP_SMALL_GEAR", "falcongear9")
		falcon_gear10 = Find_Hint("UMP_SMALL_GEAR", "falcongear10")
		falcon_gear11 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear11")
		falcon_gear12 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear12")
		falcon_gear20 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear20")
		falcon_gear21 = Find_Hint("PROP_URBAN_ANTENNA", "falcongear21")
		falcon_gear22 = Find_Hint("PROP_URBAN_BLOCK_A_MISSION11", "falcongear22")
		falcon_gear23 = Find_Hint("UMP_SMALL_RAMP", "falcongear23")
		falcon_gear24 = Find_Hint("UMP_SMALL_RAMP", "falcongear24")
		falcon_gear25 = Find_Hint("UMP_SMALL_RAMP", "falcongear25")
		falcon_gear26 = Find_Hint("UMP_SMALL_RAMP", "falcongear26")
		
		falcon_gear1.Hide(true)	
		falcon_gear2.Hide(true)	
		falcon_gear3.Hide(true)	
		falcon_gear4.Hide(true)	
		falcon_gear5.Hide(true)	
		falcon_gear6.Hide(true)	
		falcon_gear7.Hide(true)	
		falcon_gear8.Hide(true)	
		falcon_gear9.Hide(true)	
		falcon_gear10.Hide(true)	
		falcon_gear11.Hide(true)	
		falcon_gear12.Hide(true)	
		falcon_gear20.Hide(true)	
		falcon_gear21.Hide(true)	
		falcon_gear22.Hide(true)	
		falcon_gear23.Hide(true)	
		falcon_gear24.Hide(true)	
		falcon_gear25.Hide(true)	
		falcon_gear26.Hide(true)	
		
		prisoners5 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "prisoners5")
		prisoners6 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "prisoners6")
		urairunto = Find_Hint("STORY_TRIGGER_ZONE","urai-runto")
		
		riotsfxhigh1 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxhigh1")
		riotsfxhigh2 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxhigh2")
		riotsfxhigh3 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxhigh3")
		riotsfxhigh4 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxhigh4")
		riotsfxlow1 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxlow1")
		riotsfxlow2 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxlow2")
		riotsfxlow3 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxlow3")
		riotsfxlow4 = Find_Hint("STORY_TRIGGER_ZONE","riotsfxlow4")
		
		uraikiller = Find_Hint("STORY_TRIGGER_ZONE_01","uraikiller")
		
		prisoner_table1 = {}
		prisoner_table2 = {}
		prisonspawn1 = Find_Hint("STORY_TRIGGER_ZONE", "prisonspawn1")
		prisonspawn2 = Find_Hint("STORY_TRIGGER_ZONE", "prisonspawn2")
		
		riotgoto = Find_Hint("STORY_TRIGGER_ZONE","midcine-riotersgoto")
				
		pad2 = Find_Hint("STORY_TRIGGER_ZONE", "pad2")
		pad3 = Find_Hint("STORY_TRIGGER_ZONE", "pad3")
		
		atst1 = Find_Hint("AT_ST_WALKER", "atst1")
		
		bribed = Find_Hint("STORY_TRIGGER_ZONE_01","bribed")
		bribeguys = Spawn_Unit(Find_Object_Type("IMPERIAL_MEDIUM_STORMTROOPER_SQUAD"), bribed.Get_Position(), empire_player)
		for k, unit in pairs(bribeguys) do
			if TestValid(unit) then
				unit.Prevent_All_Fire(true)
				unit.Make_Invulnerable(true)
				unit.Suspend_Locomotor(true)
			end
		end
		
		consolefirst = Find_Hint("UMP_INTERFACE_NODE", "consolefirst")
		cinedoor1 = Find_Hint("UMP_MOVING_DOOR", "cinedoor1")
		Register_Death_Event(consolefirst, Open_CineDoor1)
		first1 = Find_Hint("URBAN_HUMAN_CIV_TEAM","first1")
		first2 = Find_Hint("URBAN_HUMAN_CIV_TEAM","first2")

		cinedoor2 = Find_Hint("UMP_MOVING_DOOR", "cinedoor2")
		
		console1 = Find_Hint("UMP_INTERFACE_NODE", "console1")
		door1 = Find_Hint("UMP_MOVING_DOOR", "door1")
		Register_Death_Event(console1, Open_Door_1)
		
		console2 = Find_Hint("UMP_INTERFACE_NODE", "console2")
		door2 = Find_Hint("UMP_MOVING_DOOR", "door2")
		Register_Death_Event(console2, Open_Door_2)
		
		console5 = Find_Hint("UMP_INTERFACE_NODE", "console5")
		door5 = Find_Hint("UMP_MOVING_DOOR", "door5")
		Register_Death_Event(console5, Open_Door_5)
		console6 = Find_Hint("UMP_INTERFACE_NODE", "console6")
		door6 = Find_Hint("UMP_MOVING_DOOR", "door6")
		Register_Death_Event(console6, Open_Door_6)
		console7 = Find_Hint("UMP_INTERFACE_NODE", "console7")
		door7 = Find_Hint("UMP_MOVING_DOOR", "door7")
		Register_Death_Event(console7, Open_Door_7)
		
		
		-- Register prox events for battle chatter and game events
		uraistand = Find_Hint("STORY_TRIGGER_ZONE","uraistand")
		
		hintspice = Find_Hint("STORY_TRIGGER_ZONE","hintmoney")
		spice = Find_Hint("STORY_TRIGGER_ZONE","freemoney")
				
		hintworkers = Find_Hint("STORY_TRIGGER_ZONE","freeworkers")
		guards0 = Find_Hint("STORMTROOPER_TEAM","guards0")
		workers = Find_Hint("URBAN_HUMAN_CIV_TEAM","workers")
		wookies = Find_Hint("WOOKIE_TEAM","wookies")
				
		falcon = Find_Hint("STORY_TRIGGER_ZONE","falcon")
		
		endgame = Find_Hint("STORY_TRIGGER_ZONE","endgame")
	
		rioters1 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters1")
		rioters2 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters2")
		guards1 = Find_Hint("STORMTROOPER_TEAM", "guards1")
		riot1 = Find_Hint("STORY_TRIGGER_ZONE","riots1")
		
		rioters3 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters3")
		rioters4 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters4")
		guards2 = Find_Hint("STORMTROOPER_TEAM", "guards2")
		riot2 = Find_Hint("STORY_TRIGGER_ZONE","riots2")
		
		rioters5 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters5")
		rioters7 = Find_Hint("WOOKIE_TEAM", "rioters7")
		guards4 = Find_Hint("STORMTROOPER_TEAM", "guards4")
		riot3 = Find_Hint("STORY_TRIGGER_ZONE","riots3")
		
		rioters9 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters9")
		rioters0 = Find_Hint("URBAN_HUMAN_CIV_TEAM", "rioters0")
		guards5 = Find_Hint("STORMTROOPER_TEAM", "guards5")
		riot4 = Find_Hint("STORY_TRIGGER_ZONE","riots4")
		
		riotersb = Find_Hint("URBAN_HUMAN_CIV_TEAM", "riotersb")
		riotersd = Find_Hint("URBAN_HUMAN_CIV_TEAM", "riotersd")
		guards6 = Find_Hint("STORMTROOPER_TEAM", "guards6")
		riot5 = Find_Hint("STORY_TRIGGER_ZONE","riots5")
		--Register_Prox(riot5, Prox_Riots5, 125, underworld_player)
		
		wookies = Find_Hint("WOOKIE_TEAM","wookies")
		
		darkguys1 = Find_Hint("DARK_TROOPER_PHASEII", "dark1")
		darkguys2 = Find_Hint("DARK_TROOPER_PHASEII", "dark2")
		darkguys3 = Find_Hint("DARK_TROOPER_PHASEII", "dark3")
		darkguys4 = Find_Hint("DARK_TROOPER_PHASEII", "dark4")
		
		Setup_Prox_Capturable_Units()
		-- set up some global mission state flags
				
		MissionPartOneStarted = false
		MissionPartTwoStarted = false
		PrisonersCaptured = false
		PrisonersTalkedTo = false
				
		PadOneCaptured = false
		PadTwoCaptured = false
		PadThreeCaptured = false
		
		Got_Credits = false
		Victory_BribeGuys = false

		
		VictoryCondition_ReachedFalcon = false
		DefeatCondition_TyberDead = false
		DefeatCondition_UraiDead = false
		
		VictoryStarted = false
		DefeatStarted = false
				
		OK_To_Land_Guys_A = false
		OK_To_Land_Guys_B = false
		OK_To_Spawn_Guys_A = false
		OK_To_Spawn_Guys_B = false
		
		underworld_player.Disable_Bombing_Run(false)
		underworld_player.Disable_Orbital_Bombardment(true)

		--FogOfWar.Reveal_All(underworld_player)
		
		CINE_Intro1_Active = false
		CINE_Intro2_Active = false
		CINE_Mid_Active = false
		CINE_End_Active = false
		current_cine_id = nil
		
		Register_Prox(bribed, Prox_Bribed, 115, underworld_player)
		Register_Prox(riot4, Prox_Riots4, 125, underworld_player)
		Register_Prox(riot3, Prox_Riots3, 125, underworld_player)
		Register_Prox(riot2, Prox_Riots2, 125, underworld_player)
		Register_Prox(riot1, Prox_Riots1, 150, underworld_player)
		--Register_Prox(hintspice, Prox_HintSpice, 75, underworld_player)
		--Register_Prox(endgame, Prox_MilleniumFalcon, 150, tyber_zann)
		Register_Prox(hintworkers, Prox_HintWorkers, 50, underworld_player)
		
		current_cine_id = Create_Thread("CINE_Start_Mission_A")
		Create_Thread("Main")
	elseif message == OnUpdate then
		--Do Nothing
	elseif message == OnExit then 
		--Do Nothing
	end
end

function Main()
	while true do
		--if underworld_player.Get_Credits() > 30 and not Got_Credits then
		--	Create_Thread("Remove_Hint_At_Object",spice) 
		--	Story_Event("CHATTER_23")
		--	Got_Credits = true
		--end
		if VictoryCondition_ReachedFalcon then
			if not VictoryStarted then
				VictoryStarted = true
				if not DefeatStarted then
					current_cine_id = Create_Thread("EndMissionVictory_NEW")
				end
			end
		end
		if PrisonersCaptured then
			Create_Thread("TyberPrisoner_Dialogue")
			Remove_Hint_At_Object(workers)
            PrisonersCaptured = false
		end			
		if not VictoryStarted then
			--if not CINE_End_Active then 
				if DefeatCondition_TyberDead then
					if not DefeatStarted then
						DefeatStarted = true
						Create_Thread("EndMissionDefeat")
					end
				end
				if DefeatCondition_UraiDead then
					if not DefeatStarted then
						DefeatStarted = true
						Create_Thread("EndMissionDefeat")
					end
				end
			--end
		end
		Sleep(.5)
	end
end

function Prox_HintWorkers(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if Victory_BribeGuys then 
			PrisonersCaptured = true
		    self_obj.Cancel_Event_Object_In_Range(Prox_HintWorkers)
		end
	end
end

function Setup_Prox_Capturable_Units()
		if TestValid(guards) then guards.Suspend_Locomotor(true) end
		if TestValid(guards1) then guards1.Suspend_Locomotor(true) end
		if TestValid(guards2) then guards2.Suspend_Locomotor(true) end
		if TestValid(guards4) then guards4.Suspend_Locomotor(true) end
		if TestValid(guards5) then guards5.Suspend_Locomotor(true) end
		if TestValid(guards6) then guards6.Suspend_Locomotor(true) end
end

function Cinematic_Suspend_Units()
		if TestValid(first1) then first1.Prevent_All_Fire(true) end
		if TestValid(first2) then first2.Prevent_All_Fire(true) end
		
		if TestValid(wookies) then wookies.Prevent_All_Fire(true) end
		if TestValid(guards) then guards.Prevent_All_Fire(true) end
		if TestValid(workers) then workers.Prevent_All_Fire(true) end
		if TestValid(rioters1) then rioters1.Prevent_All_Fire(true) end
		if TestValid(rioters2) then rioters2.Prevent_All_Fire(true) end
		if TestValid(guards1) then guards1.Prevent_All_Fire(true) end
		if TestValid(rioters3) then rioters3.Prevent_All_Fire(true) end
		if TestValid(rioters4) then rioters4.Prevent_All_Fire(true) end
		if TestValid(guards2) then guards2.Prevent_All_Fire(true) end
		if TestValid(rioters5) then rioters5.Prevent_All_Fire(true) end
		if TestValid(rioters7) then rioters7.Prevent_All_Fire(true) end
		if TestValid(guards4) then guards4.Prevent_All_Fire(true) end
		if TestValid(rioters9) then rioters9.Prevent_All_Fire(true) end
		if TestValid(rioters0) then rioters0.Prevent_All_Fire(true) end
		if TestValid(guards5) then guards5.Prevent_All_Fire(true) end
		if TestValid(riotersb) then riotersb.Prevent_All_Fire(true) end
		if TestValid(riotersd) then riotersd.Prevent_All_Fire(true) end
		if TestValid(guards6) then guards6.Prevent_All_Fire(true) end
		if TestValid(darkguys1) then darkguys1.Prevent_All_Fire(true) end
		if TestValid(darkguys2) then darkguys2.Prevent_All_Fire(true) end
		if TestValid(darkguys3) then darkguys3.Prevent_All_Fire(true) end
		if TestValid(darkguys4) then darkguys4.Prevent_All_Fire(true) end
		if TestValid(prisoners5) then prisoners5.Prevent_All_Fire(true) end
		if TestValid(prisoners6) then prisoners6.Prevent_All_Fire(true) end
		unit_list = Find_All_Objects_Of_Type("DARKTROOPER_P2_COMPANY")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(true) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("DARKTROOPER_P1_COMPANY")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(true) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(true) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_HUMAN")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(true) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_PIRATE")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(true) end
			end
		end
end

function Cinematic_UnSuspend_Units()
		if TestValid(first1) then first1.Prevent_All_Fire(true) end
		if TestValid(first2) then first2.Prevent_All_Fire(true) end
		
		if TestValid(wookies) then wookies.Prevent_All_Fire(false) end
		if TestValid(guards) then guards.Prevent_All_Fire(false) end
		if TestValid(workers) then workers.Prevent_All_Fire(false) end
		if TestValid(rioters1) then rioters1.Prevent_All_Fire(false) end
		if TestValid(rioters2) then rioters2.Prevent_All_Fire(false) end
		if TestValid(guards1) then guards1.Prevent_All_Fire(false) end
		if TestValid(rioters3) then rioters3.Prevent_All_Fire(false) end
		if TestValid(rioters4) then rioters4.Prevent_All_Fire(false) end
		if TestValid(guards2) then guards2.Prevent_All_Fire(false) end
		if TestValid(rioters5) then rioters5.Prevent_All_Fire(false) end
		if TestValid(rioters7) then rioters7.Prevent_All_Fire(false) end
		if TestValid(guards4) then guards4.Prevent_All_Fire(false) end
		if TestValid(rioters9) then rioters9.Prevent_All_Fire(false) end
		if TestValid(rioters0) then rioters0.Prevent_All_Fire(false) end
		if TestValid(guards5) then guards5.Prevent_All_Fire(false) end
		if TestValid(riotersb) then riotersb.Prevent_All_Fire(false) end
		if TestValid(riotersd) then riotersd.Prevent_All_Fire(false) end
		if TestValid(guards6) then guards6.Prevent_All_Fire(false) end
		if TestValid(darkguys1) then darkguys1.Prevent_All_Fire(false) end
		if TestValid(darkguys2) then darkguys2.Prevent_All_Fire(false) end
		if TestValid(darkguys3) then darkguys3.Prevent_All_Fire(false) end
		if TestValid(darkguys4) then darkguys4.Prevent_All_Fire(false) end
		if TestValid(prisoners5) then prisoners5.Prevent_All_Fire(false) end
		if TestValid(prisoners6) then prisoners6.Prevent_All_Fire(false) end
		unit_list = Find_All_Objects_Of_Type("DARKTROOPER_P2_COMPANY")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(false) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("DARKTROOPER_P1_COMPANY")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(false) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(false) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_HUMAN")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(false) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_PIRATE")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Prevent_All_Fire(false) end
			end
		end
end

-- controls opening of doors via destroying the remote consoles
function Find_Tyber(group)
	MessageBox("find tyber")
	for k, unit in pairs(group) do
		MessageBox("%s finding", tostring(k))
		if TestValid(unit) then
			unit.Move_To(tyber_zann)
			unit.Take_Damage(9999)
		end
	end
end


function Open_Door_1() 
	Register_Timer(Remove_Door_1,2)
	Create_Thread("Opening_Door_1")
	door1.Play_Animation("Cinematic",false,1)
	Remove_Hint_At_Object(console1)
end
function Remove_Door_1() 
	door1.Despawn()
end

function Prox_Bribed(self_obj, trigger_obj)
	for k, unit in pairs(bribeguys) do
		unit.Suspend_Locomotor(false)
		unit.Prevent_All_Fire(false)
		unit.Make_Invulnerable(false)
		unit.Attack_Move(tyber_zann)
	end
	self_obj.Cancel_Event_Object_In_Range(Prox_Bribed)
end

function HasBribeWorked()
	while not Victory_BribeGuys do
		total = table.getn(bribeguys)
		for k, unit in pairs(bribeguys) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then 
					Remove_Hint_At_Object(bribed)
					console2.Take_Damage(9999)
                    Victory_BribeGuys = true 
                end
			else
				total = total - 1
				if total < 2 then 
					Remove_Hint_At_Object(bribed)
					console2.Take_Damage(9999)
                    Victory_BribeGuys = true 
                end
			end
		end
		Sleep(1)   
	end
end

function Opening_Door_1() 
	--MessageBox("del Taco")
	Story_Event("UM01_HINT_BRIBEGUYS")
	Set_Hint_At_Object(bribed)
	underworld_player.Select_Object(tyber_zann)
	Story_Event("FLASH_BRIBE")
	Create_Thread("HasBribeWorked")
	Story_Event("CHATTER_64")
end

function Open_CineDoor1() 
	Register_Timer(Remove_CineDoor1,2)
	cinedoor1.Play_Animation("Cinematic",false,1)
end
function Remove_CineDoor1() 
	cinedoor1.Despawn()
	first1.Change_Owner(underworld_player)
	first2.Change_Owner(underworld_player)
	first1.Set_Selectable(true)
	first2.Set_Selectable(true)
	underworld_player.Select_Object(first1)
	underworld_player.Select_Object(first2)
	first1.Move_To(tyber_zann)
	first2.Move_To(tyber_zann)
end

function Open_Door_2() 
	Register_Timer(Remove_Door_2,2)
	door2.Play_Animation("Cinematic",false,1)
	OK_To_Land_Guys_A = true
	HintWorkers()
end
function Remove_Door_2() 
	door2.Despawn()
	Register_Timer(Respawn, 1)
end


function Open_Door_5() 
	Register_Timer(Remove_Door_5,2)
	door5.Play_Animation("Cinematic",false,1)
	Speech_5 = true
	Create_Thread("Speech_Open_5")
end
function Remove_Door_5() 
	door5.Despawn()
	prisoners5.Change_Owner(underworld_player)
	prisoners5.Set_Selectable(true)
	underworld_player.Select_Object(prisoners5)
	prisoners5.Move_To(tyber_zann)
end
function Speech_Open_5()
	if not Speech_6 then
		Story_Event("CHATTER_25")
		while not State_Prolog_Chatter_Dialog_25_Done do Sleep(.5) end
		Story_Event("CHATTER_27")
		while not State_Prolog_Chatter_Dialog_27_Done do Sleep(.5) end
		Speech_5 = false
	end
end
function Speech_Open_6()
	if not Speech_5 then
		Story_Event("CHATTER_24")
		while not State_Prolog_Chatter_Dialog_24_Done do Sleep(.5) end
		Story_Event("CHATTER_28")
		while not State_Prolog_Chatter_Dialog_28_Done do Sleep(.5) end
		Speech_6 = false
	end
end

function Open_Door_6() 
	Register_Timer(Remove_Door_6,2)
	door6.Play_Animation("Cinematic",false,1)
	Speech_6 = true
	Create_Thread("Speech_Open_6")
end
function Remove_Door_6() 
	door6.Despawn()
	prisoners6.Change_Owner(underworld_player)
	prisoners6.Set_Selectable(true)
	underworld_player.Select_Object(prisoners6)
	prisoners6.Move_To(tyber_zann)
end

function Open_Door_7() 
	console7.Highlight(false)
	Register_Timer(Remove_Door_7,2)
	door7.Play_Animation("Cinematic",false,1)
	--Story_Event("CHATTER_41")
	--Story_Event("CHATTER_26")
end
function Remove_Door_7() 
	door7.Despawn()
	if not DefeatStarted then
		current_cine_id = Create_Thread("MidMission_Cinematic")
	end
end

-- delay a short time and then start the game
function CINE_Start_Mission_A()

	Enable_Distance_Fog(false)
	Stop_All_Music()
	CINE_Intro1_Active = true

	cinfalcon = Find_Hint("STORY_TRIGGER_ZONE", "cinfalcon")
	startcam = Find_Hint("STORY_TRIGGER_ZONE", "textcrawl")
	endcam = Find_Hint("PROP_KESSEL_PLANET_CINE_UNIT", "kessel")
	camera_pos = cinfalcon.Get_Position()
	--cinfalcon.Despawn()
	
	Weather_Audio_Pause(true)
	
	Cinematic_Suspend_Units()
		SFXManager.Allow_Ambient_VO( false )
		Allow_Localized_SFX(false)
		Suspend_AI(1)
		Lock_Controls(1)
		Fade_Screen_In(0.5)
		Letter_Box_In(0)
		Start_Cinematic_Camera()	
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(camera_pos, 85, 25, 315, 1, 0, 1, 0)
		Set_Cinematic_Target_Key(endcam, 0, 0, 3000, 0, 0, 0, 0)
	
		Stop_All_Music()
		Stop_All_Speech()
		Allow_Localized_SFX(false)

		BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro"))
		Play_Music("Cinematic_Rebel_Intro_Music_Event_1")
		BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro_Underworld"))
		
	current_cine_id = Create_Thread("CINE_Start_Mission_B")
	Weather_Audio_Pause(false)
	
end				

function CINE_Start_Mission_B()
	
	Weather_Audio_Pause(false)
	
	Enable_Distance_Fog(false)
	CINE_Intro1_Active = false
	CINE_Intro2_Active = true
		
	Allow_Localized_SFX(true)
	
	landing_spot = Find_Hint("STORY_TRIGGER_ZONE", "falcon")
	hanend = Find_Hint("STORY_TRIGGER_ZONE_01", "hanend")
	chewieend = Find_Hint("STORY_TRIGGER_ZONE_01", "chewieend")
	
	startcam = Find_Hint("STORY_TRIGGER_ZONE", "textcrawl")
	endcam = Find_Hint("PROP_KESSEL_PLANET_CINE_UNIT", "kessel")
	
	falcon_goto_1 = Find_Hint("STORY_TRIGGER_ZONE_00", "falcongoto1")
	
	tyber_goto = Find_Hint("STORY_TRIGGER_ZONE_01", "tybergoto")
	urai_goto = Find_Hint("STORY_TRIGGER_ZONE_01", "uraigoto")
	
	cin_node = Find_Hint("UMP_CINE_NODE", "tybernode")
	
	tyber = Find_First_Object("UMP_TYBER_ZANN")
	cin_mouse = Find_Hint("UMP_CINE_MOUSEDROID", "mouse")
	cin_holo = Find_Hint("UMP_CINE_HOLOURAI", "holo")
	cin_tyber = Find_Hint("UMP_CINE_TYBERSITTING", "tybersit")
	cin_jabba = Find_Hint("UMP_CINE_HOLOJABBA", "holojabba")
	cin_droid = Find_Hint("UMP_CINE_MOUSEDROID", "mousedroid")
	
	camtybersitpos = Find_Hint("STORY_TRIGGER_ZONE", "camtybersitpos")
	camtybersitlook = Find_Hint("STORY_TRIGGER_ZONE", "camtybersitlook")
	camtybersitpanpos = Find_Hint("STORY_TRIGGER_ZONE", "camtybersitpanpos")
	camtybersitpanlook = Find_Hint("STORY_TRIGGER_ZONE", "camtybersitpanlook")
	camjabbapos = Find_Hint("STORY_TRIGGER_ZONE", "camjabbapos")
	camjabbalook = Find_Hint("STORY_TRIGGER_ZONE", "camjabbalook")
	camconsolepos = Find_Hint("STORY_TRIGGER_ZONE", "camconsolepos")
	camconsolelook = Find_Hint("STORY_TRIGGER_ZONE", "camconsolelook")
	camuraiholopos = Find_Hint("STORY_TRIGGER_ZONE", "camuraiholopos")
	camuraihololook = Find_Hint("STORY_TRIGGER_ZONE", "camuraihololook")
	camtyberuraipos = Find_Hint("STORY_TRIGGER_ZONE", "camtyberuraipos")
	camtyberurailook = Find_Hint("STORY_TRIGGER_ZONE", "camtyberurailook")
	cambountypos = Find_Hint("STORY_TRIGGER_ZONE", "cambountypos")
	cambountylook = Find_Hint("STORY_TRIGGER_ZONE", "cambountylook")
	cambountypanpos = Find_Hint("STORY_TRIGGER_ZONE", "cambountypanpos")
	cambountytalkpos = Find_Hint("STORY_TRIGGER_ZONE", "cambountytalkpos")
	cambountytalklook = Find_Hint("STORY_TRIGGER_ZONE", "cambountytalklook")
	cambountyhearpos = Find_Hint("STORY_TRIGGER_ZONE", "cambountyhearpos")
	cambountyhearlook = Find_Hint("STORY_TRIGGER_ZONE", "cambountyhearlook")
	camuraikillpos = Find_Hint("STORY_TRIGGER_ZONE", "camuraikillpos")
	camuraikilllook = Find_Hint("STORY_TRIGGER_ZONE", "camuraikilllook")
	camfinalpos = Find_Hint("STORY_TRIGGER_ZONE", "camfinalpos")
	camfinallook = Find_Hint("STORY_TRIGGER_ZONE", "camfinallook")

	mousedroidwarpto = Find_Hint("STORY_TRIGGER_ZONE", "mousedroidwarpto")
	uraikillspawn = Find_Hint("STORY_TRIGGER_ZONE", "uraikillspawn") 
	hunterspawn = Find_Hint("STORY_TRIGGER_ZONE", "hunterspawn") 
	tyberconsole = Find_Hint("STORY_TRIGGER_ZONE", "tyberconsole")
	cammousefollow1 = Find_Hint("STORY_TRIGGER_ZONE_01", "cammousefollow1")
	cammousefollow2 = Find_Hint("STORY_TRIGGER_ZONE_01", "cammousefollow2")
	
	mouse2 = Find_Hint("STORY_TRIGGER_ZONE", "mouse2")
	
	droidintnode = Find_Hint("DROID_INTERFACE_STATION", "droidintnode")
	
		Allow_Localized_SFX(true)
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
		Start_Cinematic_Camera()
		
	if true then	
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(camera_pos, 85, 25, 315, 1, 0, 1, 0)
		Set_Cinematic_Target_Key(endcam, 0, 0, 3000, 0, 0, 0, 0)

		Transition_Cinematic_Target_Key(endcam, 6, 0, 0, 0, 0, 0, 0, 0)
		Sleep(8.5)
		Fade_Screen_Out(2)
		Sleep(2)
	end
		
--********* 2nd Scene of Intro Cinematic **********		



	Enable_Distance_Fog(true)
	cin_mouse.Hide(true)
	cin_holo.Hide(true)
	cin_jabba.Hide(true)
	tyber.Hide(true)
	
	cin_tyber.Play_Animation("Cinematic", true, 0)
	Hide_Sub_Object(cin_tyber, 1, "newgun")

		Fade_Screen_In(1)
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(camtybersitpos, 0, 0, 80, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtybersitlook, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtybersitpos, 5, 0, 0, 35, 0, 0, 0, 0)
		
		Sleep(5)
		
	droidintnode = Find_Hint("DROID_INTERFACE_STATION", "droidintnode")
	droidintnodegoto = Find_Hint("STORY_TRIGGER_ZONE", "droidintnodegoto")
	
		cin_droid.Override_Max_Speed(1)
		cin_droid.Move_To(droidintnodegoto)
		--cin_droid.Move_To(mouse2)
		Set_Cinematic_Camera_Key(cammousefollow1, 0, 0, 10, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cammousefollow2, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(droidintnodegoto, 6, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(cammousefollow2, 6, 0, 0, 15, 0, 0, 0, 0)
			
		Sleep(5)
		cin_droid.Turn_To_Face(droidintnode)
		droid_bone = cin_droid.Get_Bone_Position("MuzzleA_00")
		node_bone = droidintnode.Get_Bone_Position("MuzzleA_01")
		Play_Lightning_Effect("Kessel_Mouse_Droid_Hack", droid_bone, node_bone)
		cin_droid.Play_SFX_Event("Static_On")
		
		Sleep(2)
		Transition_Cinematic_Target_Key(camtybersitlook, 6, 0, 0, 5, 0, 0, 0, 0)
		cinedoor2.Play_Animation("Cinematic",false,1)
		Sleep(2)
		cinedoor2.Despawn()
		cin_droid.Move_To(mouse2)

		Sleep(3)
		cin_tyber.Play_Animation("Cinematic", true, 1)
		Sleep(1)
		
		cin_droid.Teleport_And_Face(mousedroidwarpto)
		cin_jabba.Teleport_And_Face(mousedroidwarpto)
		cin_tyber.Play_Animation("Cinematic", true, 0)
		
		cin_droid.Hide(true)
		
		Set_Cinematic_Camera_Key(camjabbapos, 0, 0, 30, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camjabbalook, 0, 0, -25, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camjabbapos, 15, 0, 0, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camjabbalook, 15, 0, 0, 5, 0, 0, 0, 0)
		
		--Sleep(1)
		
		cin_droid.Suspend_Locomotor(true)
		cin_jabba.Hide(false)
		cin_tyber.Play_Animation("Cinematic", true, 1)
		cin_jabba.Play_Animation("deploy", false, 0)
		
		Sleep(1)
		Story_Event("CHATTER_NEW_00")
		cin_jabba.Play_Animation("idle", true, 0)
		
		while not State_Prolog_Intro_Dialog_New_00_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("cinematic", true, 0)
		
		Set_Cinematic_Camera_Key(camtybersitpos, 0, 0, 35, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtybersitlook, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtybersitpanpos, 5, 0, 5, 30, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camtybersitpanlook, 5, 0, 0, 0, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_01")
		
		while not State_Prolog_Intro_Dialog_New_01_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("idle", true, 0)
		
		Set_Cinematic_Camera_Key(camjabbapos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camjabbalook, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camjabbapos, 17, -5, -10, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camjabbalook, 17, -10, -10, 5, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_02")
		
		while not State_Prolog_Intro_Dialog_New_02_Done do Sleep(.5) end

		cin_jabba.Play_Animation("cinematic", true, 0)
		
		Set_Cinematic_Camera_Key(camtybersitpanpos, 0, 5, 30, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtybersitpanlook, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtybersitpanpos, 10, 8, 20, 30, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camtybersitpanlook, 10, -10, -10, 0, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_03")
		
		while not State_Prolog_Intro_Dialog_New_03_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("idle", true, 0)

		Set_Cinematic_Camera_Key(camjabbapos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camjabbalook, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camjabbapos, 16, 10, -10, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camjabbalook, 16, -20, 30, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_04")
		
		while not State_Prolog_Intro_Dialog_New_04_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("cinematic", true, 0)
				
		Set_Cinematic_Camera_Key(camtybersitpanpos, 0, 5, 30, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtybersitpanlook, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtybersitpanpos, 10, 8, 20, 30, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camtybersitpanlook, 10, -10, -10, 0, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_05")
		
		while not State_Prolog_Intro_Dialog_New_05_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("idle", true, 0)
		
		Set_Cinematic_Camera_Key(camjabbapos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camjabbalook, 0, 0, 5, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camjabbapos, 10, 5, 5, 20, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camjabbalook, 10, -10, -10, 0, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_06")
		
		while not State_Prolog_Intro_Dialog_New_06_Done do Sleep(.5) end
		
		cin_jabba.Play_Animation("undeploy", false, 0)
		Sleep(2)
		
		cin_droid.Hide(true)
		cin_jabba.Hide(true)		
		cin_tyber.Play_Animation("Cinematic", false, 2)
		Set_Cinematic_Camera_Key(camtybersitpos, 0, 0, 35, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtybersitlook, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtybersitpos, 5, 0, 0, 40, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(cin_jabba, 5, 0, 0, 20, 0, 0, 0, 0)
		Sleep(.5)
		camtybersitpos.Play_SFX_Event("Unit_Panic_Mouse_Droid")
		Sleep(1)
		camtybersitpos.Play_SFX_Event("Unit_Anim_Infantry_Death_Concrete")
		camtybersitpos.Play_SFX_Event("Unit_Pulse_Cannon_Fire")
		Sleep(3)
	
	if true then
		if TestValid(cinedoor2) then
			cinedoor2.Despawn()
		end
		cin_tyber.Hide(true)
		tyber.Hide(false)
		Hide_Sub_Object(tyber, 1, "newgun")
		tyber.Move_To(tyberconsole)
		tyber.Override_Max_Speed(1)
		Set_Cinematic_Camera_Key(camconsolepos, 0, 0, 20, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camconsolelook, 0, 0, 10, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camuraiholopos, 5, 0, 0, 13, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camuraihololook, 5, 0, 0, 9, 0, 0, 0, 0)
		Sleep(6)
		
		Set_Cinematic_Camera_Key(camtyberuraipos, 0, 0, 20, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtyberurailook, 0, 0, 10, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camtyberuraipos, 5, 0, 0, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camtyberurailook, 5, 0, 0, 10, 0, 0, 0, 0)
		cin_holo.Hide(false)
		cin_holo.Play_Animation("deploy", false, 0)
		Story_Event("CHATTER_NEW_07")
		
		while not State_Prolog_Intro_Dialog_New_07_Done do Sleep(.5) end
		
		tyber.Turn_To_Face(cin_holo)
		cin_holo.Play_Animation("idle", false, 0)
		Story_Event("CHATTER_NEW_08")
		
		while not State_Prolog_Intro_Dialog_New_08_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("deploy", false, 0)
		Set_Cinematic_Camera_Key(camconsolepos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camconsolelook, 0, 0, 10, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camconsolepos, 5, 5, 5, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camconsolelook, 5, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_09")
		
		while not State_Prolog_Intro_Dialog_New_09_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("idle", false, 0)
		Set_Cinematic_Camera_Key(camtyberuraipos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtyberurailook, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_10")
		
		while not State_Prolog_Intro_Dialog_New_10_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("deploy", false, 0)
		Set_Cinematic_Camera_Key(camconsolepos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camconsolelook, 0, 0, 10, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camconsolepos, 5, 5, 0, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camconsolelook, 5, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_11")
		
		while not State_Prolog_Intro_Dialog_New_11_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("idle", false, 0)
		Set_Cinematic_Camera_Key(camtyberuraipos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camtyberurailook, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_12")
		
		while not State_Prolog_Intro_Dialog_New_12_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("deploy", false, 0)
		Set_Cinematic_Camera_Key(camconsolepos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camconsolelook, 0, 0, 10, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(camconsolepos, 5, 5, 2, 16, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camconsolelook, 5, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_NEW_13")
		
		while not State_Prolog_Intro_Dialog_New_13_Done do Sleep(.5) end
		
		cin_holo.Play_Animation("undeploy", false, 0)
		Sleep(2)
		Fade_Screen_Out(2)
		Sleep(2)
	end

--********* Falcon Lands **********		
		
	if true then
		
		Allow_Localized_SFX(true)
		Set_Cinematic_Camera_Key(landing_spot, 500, 0, 0, 1, 0, 1, 0)
		Set_Cinematic_Target_Key(landing_spot, 0, 0, -75, 0, 0, 0, 0)
		
		Fade_Screen_In(2)
		
		-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)
		landing_falcon = Create_Cinematic_Transport("MILLENNIUM_FALCON_LANDING", neutral_player.Get_ID(), landing_spot, 240, 1, 0.25, 20, 1)
		landing_falcon.Attach_Particle_Effect("TRANSPORT_LANDING_DUST_URBAN")
		
		Transition_Cinematic_Camera_Key(landing_spot, 8, 600, 25, 0, 1, 0, 1, 0)
		Sleep(5.5)
		
		cine_urai = Create_Generic_Object("URAI_FEN", landing_spot.Get_Position(), neutral_player)
		Story_Event("CHATTER_35")
		
		while not State_Prolog_Chatter_Dialog_35_Done do Sleep(.5) end
		
		cine_urai.Move_To(urairunto)
		Sleep(1)
		
		cine_han = Create_Generic_Object("UMP_HANSOLO", landing_spot.Get_Position(), neutral_player)
		cine_han.Move_To(hanend)
		cine_chewie = Create_Generic_Object("UMP_CHEWBACCA", landing_spot.Get_Position(), neutral_player)
		cine_chewie.Move_To(chewieend)
		
		Sleep(1)
		falcon_gear1.Hide(false)	
		falcon_gear2.Hide(false)	
		falcon_gear3.Hide(false)	
		falcon_gear4.Hide(false)	
		falcon_gear5.Hide(false)	
		falcon_gear6.Hide(false)	
		falcon_gear7.Hide(false)	
		falcon_gear8.Hide(false)	
		falcon_gear9.Hide(false)	
		falcon_gear10.Hide(false)	
		falcon_gear11.Hide(false)	
		falcon_gear12.Hide(false)	
		falcon_gear20.Hide(false)	
		falcon_gear21.Hide(false)	
		falcon_gear22.Hide(false)	
		falcon_gear23.Hide(false)	
		falcon_gear24.Hide(false)	
		falcon_gear25.Hide(false)	
		falcon_gear26.Hide(false)	
		
		Set_Cinematic_Camera_Key(Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn"), -65, -65, 20, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn"), 0, 0, 15, 0, 0, 0, 0)
		Sleep(1)
		cine_urai.Activate_Ability("STEALTH", true)
		
		Sleep(2)
		Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn").Play_SFX_Event("Unit_Select_Chewie")
		Sleep(1)
		Story_Event("CHATTER_36")
		
		while not State_Prolog_Chatter_Dialog_36_Done do Sleep(.5) end
		
		Fade_Screen_Out(2)
		Sleep(2)
		
	end
		
--*********3rd Scene of Intro Cinematic**********		

	if true then
		cinedoor2.Play_Animation("Cinematic",false,0)
		if not TestValid(cine_urai) then
			cine_urai = Create_Generic_Object("URAI_FEN", landing_spot.Get_Position(), neutral_player)
			cine_urai.Activate_Ability("STEALTH", true)
		end
		
		tyber.Teleport_And_Face(tyberconsole)
		tyber.Hide(false)
		Hide_Sub_Object(tyber, 1, "newgun")
		hunter = Create_Generic_Object("UMP_MANDALORIAN", hunterspawn.Get_Position(), neutral_player)
		hunter.Teleport_And_Face(hunterspawn)
		
		Set_Cinematic_Camera_Key(cambountypos, 0, 0, 18, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountylook, 0, 0, 8, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(cambountypanpos, 6, 0, 0, 18, 0, 0, 0, 0)

		Fade_Screen_In(2)
		Sleep(4)
		Story_Event("CHATTER_03")
		
		while not State_Prolog_Intro_Dialog_03_Done do Sleep(.5) end
		
		Story_Event("CHATTER_04")
		tyber.Turn_To_Face(hunter)
		
		while not State_Prolog_Intro_Dialog_04_Done do Sleep(.5) end
		
		Story_Event("CHATTER_05")
		Set_Cinematic_Camera_Key(cambountytalkpos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountytalklook, 0, 0, 10, 0, 0, 0, 0)
		
		while not State_Prolog_Intro_Dialog_05_Done do Sleep(.5) end
		
		Story_Event("CHATTER_06")
		Set_Cinematic_Camera_Key(cambountyhearpos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountyhearlook, 0, 0, 10, 0, 0, 0, 0)
		
		while not State_Prolog_Intro_Dialog_06_Done do Sleep(.5) end
		
		if TestValid(cine_urai) then 
			cine_urai.Despawn() 
			cine_urai = Create_Generic_Object("URAI_FEN", urairunto.Get_Position(), neutral_player)
		end
		cine_urai.Activate_Ability("STEALTH", true)
		Story_Event("CHATTER_07")
		Set_Cinematic_Camera_Key(cambountytalkpos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountytalklook, 0, 0, 10, 0, 0, 0, 0)
		
		while not State_Prolog_Intro_Dialog_07_Done do Sleep(.5) end
		
		Story_Event("CHATTER_08")
		Set_Cinematic_Camera_Key(camuraikillpos, 0, 0, 18, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camuraikilllook, 0, 0, 8, 0, 0, 0, 0)
		
		Sleep(1)
		cine_urai.Teleport_And_Face(uraikillspawn)
		cine_urai.Activate_Ability("STEALTH", false)
		Sleep(1.5)
		cine_urai.Play_Animation("Attack",false,0)
		Sleep(1)
		
		hunter.Take_Damage(99999)
		Transition_Cinematic_Camera_Key(camfinalpos, 3, 0, 0, 11, 0, 0, 0, 0)
		Transition_Cinematic_Target_Key(camfinallook, 3, 0, 0, 15, 0, 0, 0, 0)
		
		while not State_Prolog_Intro_Dialog_08_Done do Sleep(.5) end
		
		cine_urai.Move_To(hunterspawn)
		
		Set_Cinematic_Camera_Key(cambountyhearpos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountyhearlook, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_09")
		
		while not State_Prolog_Midtro_Dialog_09_Done do Sleep(.5) end
		
		cine_urai.Turn_To_Face(tyber)
		Set_Cinematic_Camera_Key(camfinalpos, 0, 0, 11, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(camfinallook, 0, 0, 15, 0, 0, 0, 0)
		Story_Event("CHATTER_10")
		
		while not State_Prolog_Midtro_Dialog_10_Done do Sleep(.5) end

		Set_Cinematic_Camera_Key(cambountyhearpos, 0, 0, 16, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(cambountyhearlook, 0, 0, 10, 0, 0, 0, 0)
		Story_Event("CHATTER_11")
		
		while not State_Prolog_Midtro_Dialog_11_Done do Sleep(.5) end
		
		Fade_Screen_Out(1)		
		Sleep(1.5)
	end
		
	Create_Thread("IntroCineCleanup")
end

function Story_Handle_Esc()
	if CINE_Intro1_Active then 
		CINE_Intro1_Active = false
		Thread.Kill(current_cine_id)
		Stop_Bink_Movie()
		current_cine_id = Create_Thread("CINE_Start_Mission_B")
	end
	if CINE_Intro2_Active then 
		CINE_Intro2_Active = false
		Thread.Kill(current_cine_id)
		Create_Thread("IntroCineCleanup")
	end
	--if CINE_Mid_Active then
	--	CINE_Mid_Active = false
	--	Thread.Kill(current_cine_id)
	--	Create_Thread("MidCineCleanup")
	--end
	--if CINE_End_Active then
	--	CINE_End_Active = false
	--	Thread.Kill(current_cine_id)
	--	Create_Thread("EndCineCleanup")
	--end
end

function IntroCineCleanup()
	CINE_Intro1_Active = false
	CINE_Intro2_Active = false

	Enable_Distance_Fog(true)
	Fade_Screen_Out(0)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	Resume_Mode_Based_Music()
	Remove_All_Text()
	Allow_Localized_SFX(true)
	Suspend_AI(0)
	Lock_Controls(0)
	
	cin_holo.Despawn()
	cin_tyber.Despawn()
	cin_jabba.Despawn()
	cin_droid.Despawn()
	cin_node.Despawn()
	broken_node = Create_Generic_Object("UMP_INTERFACE_NODE", tyberconsole.Get_Position(), neutral_player)
	broken_node.Take_Damage(9999)
	
		if not TestValid(landing_falcon) then
			landing_falcon = Create_Cinematic_Transport("MILLENNIUM_FALCON_LANDING", neutral_player.Get_ID(), Find_Hint("STORY_TRIGGER_ZONE", "falcon"), 240, 1, 1.0, 20, 1)
		end
		han_solo = Find_First_Object("UMP_HANSOLO")
		if not TestValid(han_solo) then
			han_solo = Spawn_Unit(Find_Object_Type("UMP_HANSOLO"), Find_Hint("STORY_TRIGGER_ZONE_01", "hanspawn"), neutral_player)
		end
		chewbacca = Find_First_Object("UMP_CHEWBACCA")
		if not TestValid(chewbacca) then
			chewbacca = Spawn_Unit(Find_Object_Type("UMP_CHEWBACCA"), Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn"), neutral_player)
		end
		if TestValid(cine_urai) then
			cine_urai.Despawn()
		end
		if TestValid(hunter) then
			hunter.Despawn()
		end
		if TestValid(cinedoor2) then 
			cinedoor2.Despawn()
		end
		
		tyber_zann = Find_Nearest(pad2,"UMP_TYBER_ZANN")
		Register_Death_Event(tyber_zann, Tyber_Destroyed)
		urai_fenn = Create_Generic_Object("URAI_FEN",urai_goto.Get_Position(),underworld_player)
		Register_Death_Event(urai_fenn, Urai_Destroyed)
		tyber_zann.Teleport_And_Face(tyber_goto)
		tyber_zann.Suspend_Locomotor(false)
		tyber_zann.Prevent_All_Fire(false)
		tyber_zann.Make_Invulnerable(false)
		tyber_zann.Hide(false)
		urai_fenn.Teleport_And_Face(urai_goto)
		urai_fenn.Suspend_Locomotor(false)
		urai_fenn.Prevent_All_Fire(false)
		urai_fenn.Make_Invulnerable(false)
		urai_fenn.Hide(false)
		
	first1.Set_Selectable(false)
	first2.Set_Selectable(false)
	Hide_Sub_Object(tyber, 0, "newgun")
		
	MissionPartOneStarted = true
	current_cine_id = nil
	
		falcon_gear1.Hide(false)	
		falcon_gear2.Hide(false)	
		falcon_gear3.Hide(false)	
		falcon_gear4.Hide(false)	
		falcon_gear5.Hide(false)	
		falcon_gear6.Hide(false)	
		falcon_gear7.Hide(false)	
		falcon_gear8.Hide(false)	
		falcon_gear9.Hide(false)	
		falcon_gear10.Hide(false)	
		falcon_gear11.Hide(false)	
		falcon_gear12.Hide(false)	
		falcon_gear20.Hide(false)	
		falcon_gear21.Hide(false)	
		falcon_gear22.Hide(false)	
		falcon_gear23.Hide(false)	
		falcon_gear24.Hide(false)	
		falcon_gear25.Hide(false)	
		falcon_gear26.Hide(false)	
	
	Sleep(1)
	
	Story_Event("UM01_INTROCINE_DONE")
	Create_Thread("StartMissionObjective")
	Fade_Screen_In(.5) 
	
	Cinematic_UnSuspend_Units()
	--OK_To_Land_Guys = true

end

function MidCineCleanup()
	CINE_Mid_Active = false
	
	Fade_Screen_Out(0)
	Point_Camera_At(tyber_zann)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	--Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()
	Allow_Localized_SFX(true)
	End_Cinematic_Camera()
	Letter_Box_Out(0)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	tyber_zann.Prevent_All_Fire(false)
	urai_fenn.Prevent_All_Fire(false)
	tyber_zann.Suspend_Locomotor(false)
	urai_fenn.Suspend_Locomotor(false)
	
	MissionPartTwoStarted = true
	CINE_Mid_Active = false
	current_cine_id = nil
	Fade_Screen_In(.5) 
	
	if darkguys4.Is_Ability_Ready("JET_PACK") then
		darkguys4.Activate_Ability("JET_PACK", riot5)
	end
	if darkguys1.Is_Ability_Ready("JET_PACK") then
		darkguys1.Activate_Ability("JET_PACK", urai_loc)
	end
	Create_Thread("Hunt_Underworld", {darkguys1} )
	Create_Thread("Hunt_Underworld", {darkguys2} )
	Create_Thread("Hunt_Underworld", {darkguys3} )
	Create_Thread("Hunt_Underworld", {darkguys4} )
	
	Create_Thread("Open_Door9")
	
	Cinematic_UnSuspend_Units()
	
	riotersb.Change_Owner(underworld_player)
	riotersd.Change_Owner(underworld_player)
	riotersb.Set_Selectable(true)
	riotersd.Set_Selectable(true)
	underworld_player.Select_Object(riotersb)
	underworld_player.Select_Object(riotersd)
	guards6.Suspend_Locomotor(false)
	
	OK_To_Land_Guys_A = true
	OK_To_Land_Guys_B = false
	OK_To_Spawn_Guys_A = true
	OK_To_Spawn_Guys_B = true
	Story_Event("UM01_KILL_TROOPERS")
end

function EndCineCleanup()
	CINE_End_Active = false
	Story_Event("UM01_ENDMISSION_VICTORY")
	
	Set_Cinematic_Camera_Key(falcon, 0, -200, 100, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(falcon, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(falcon, 10, 0, -500, 100, 0, 0, 0, 0)
	
	tyber.Suspend_Locomotor(false)
	han_solo.Suspend_Locomotor(false)
	chewbacca.Suspend_Locomotor(false)
	uraiend.Suspend_Locomotor(false)
	
	Stop_All_Speech()
	Remove_All_Text()
	Allow_Localized_SFX(true)
	Weather_Audio_Pause(false)
	SFXManager.Allow_Ambient_VO(true)
	Fade_Screen_In(.5)

	tyber.Move_To(falcon)
	Sleep(1)
	uraiend.Move_To(falcon)
	Sleep(4)
	han_solo.Move_To(falcon)
	chewbacca.Move_To(falcon)
	
	Sleep(10)

end

function EndCineCleanup_OLD()
	CINE_End_Active = false
	
	if not enddeadguys then
		cargo6[1].Despawn()
		cargo5[1].Despawn()
		cargo3[1].Despawn()
		cargo2[1].Despawn()
		cargo1[1].Despawn()
		Create_Generic_Object("DEAD_BOTHAN", uraikiller.Get_Position(), neutral_player)
		--Create_Generic_Object("DEAD_BOTHAN", urai_end_loc.Get_Position(), neutral_player)
		Create_Generic_Object("UMP_DEADGUYS", cargo1_loc.Get_Position(), neutral_player)
		Create_Generic_Object("UMP_DEADGUYS", cargo2_loc.Get_Position(), neutral_player)
		Create_Generic_Object("UMP_DEADGUYS", cargo3_loc.Get_Position(), neutral_player)
		Create_Generic_Object("UMP_DEADGUYS", endgame.Get_Position(), neutral_player)
		Create_Generic_Object("UMP_DEADGUYS", Find_Hint("STORY_TRIGGER_ZONE_01", "hanspawn").Get_Position(), neutral_player)
		Create_Generic_Object("DEAD_BOTHAN", Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn").Get_Position(), neutral_player)
	end
	
	Story_Event("UM01_ENDMISSION_VICTORY")
	
	cargo4.Despawn()
	Set_Cinematic_Camera_Key(falcon, 0, -200, 100, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(falcon, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(falcon, 10, 0, -500, 100, 0, 0, 0, 0)
	
	tyber.Suspend_Locomotor(false)
	han_solo.Suspend_Locomotor(false)
	chewbacca.Suspend_Locomotor(false)
	uraiend.Suspend_Locomotor(false)
	
	tyber.Move_To(falcon)
	Sleep(1)
	uraiend.Move_To(falcon)
	Sleep(5)
	han_solo.Move_To(falcon)
	chewbacca.Move_To(falcon)
	
	Sleep(10)
	Stop_All_Speech()
	Remove_All_Text()
	Allow_Localized_SFX(true)
end

function Open_Door9()
	sfxplayed=false
	while not OK_To_Land_Guys_B do
		if not TestValid(darkguys1) and
		not TestValid(darkguys2) and
		not TestValid(darkguys3) and
		not TestValid(darkguys4) then
			door9.Play_Animation("Cinematic",false,1)
			OK_To_Land_Guys_B = true
			door9.Despawn()
			Story_Event("UM01_KILL_TROOPERS_DONE")
			Opened_Last_Door()
		end
		Sleep(1)
		if not sfxplayed then
			Sleep(3)
			Story_Event("CHATTER_42")
			sfxplayed=true
		end
	end
end


function Tyber_Destroyed()
	if not VictoryStarted then
		if not CINE_End_Active then 
			if MissionPartOneStarted then 
				DefeatCondition_TyberDead = true
				Story_Event("UM01_TYBERDEAD")
			end
		end
	end
end

function Urai_Destroyed()
	if not VictoryStarted then
		if not CINE_End_Active then 
			if MissionPartOneStarted then 
				DefeatCondition_UraiDead = true
				Story_Event("UM01_URAIDEAD")
			end
		end
	end
end

-- delay a short time and then display the mission objective
function StartMissionObjective()
	-- player cash
	Story_Event("SET_CREDITS")
	
	-- setup doors
	door1.Play_Animation("Cinematic",false,0)
	door2.Play_Animation("Cinematic",false,0)
	door5.Play_Animation("Cinematic",false,0)
	door6.Play_Animation("Cinematic",false,0)
	door7.Play_Animation("Cinematic",false,0)
	
	Create_Thread("Check_LandingPads")
	falcon.Highlight(true)
	Add_Radar_Blip(falcon, "falconblip")
	FogOfWar.Reveal(underworld_player, falcon, 250, 250);
	
	Story_Event("UMP_URAI_ADDED")
	Story_Event("CHATTER_40")
	Sleep(3)
	if TestValid(console1) then
		Story_Event("UM01_HINT_BLOWDOOR")
		Set_Hint_At_Object(console1)
	end
end


function MidMission_Cinematic()
	Cancel_Fast_Forward() 
	OK_To_Spawn_Guys_A = false
	OK_To_Land_Guys_A = false
	
	Cinematic_Suspend_Units()
	CINE_Mid_Active = true
	Suspend_AI(1)
	Lock_Controls(1)
	urai_loc = Find_Hint("STORY_TRIGGER_ZONE", "midcine-urai")
	tyber_loc = Find_Hint("STORY_TRIGGER_ZONE", "midcine-tyber")
	hunter_loc = Find_Hint("UMP_BOUNTY_HUNTER", "midcine-hunter")
	
	movers = Find_All_Objects_Of_Type(underworld_player, "Infantry")
	for k, unit in pairs(movers) do
		if TestValid(unit) then
			if not unit.Get_Parent_Object() then
				unit.Move_To(riotgoto)
			end
		end
	end
	
	Fade_Screen_Out(1)
	Sleep(1)
	tyber_zann.Suspend_Locomotor(true)
	tyber_zann.Prevent_All_Fire(true)
	tyber_zann.Teleport_And_Face(tyber_loc)
	tyber_zann.Face_Immediate(urai_loc)
	tyber_zann.Play_Animation("Idle", false, 0)
	urai_fenn.Suspend_Locomotor(true)
	urai_fenn.Prevent_All_Fire(true)
	urai_fenn.Teleport_And_Face(urai_loc)
	urai_fenn.Face_Immediate(tyber_loc)
	urai_fenn.Play_Animation("Idle", false, 0)
	Letter_Box_In(0)
	
	Start_Cinematic_Camera()	
	
	riotersb.Move_To(riotgoto)
	riotersd.Move_To(riotgoto)

	--Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(darkguys2, 65, 0, 20, 0, 1, 1, 0)
	Set_Cinematic_Target_Key(darkguys2, 0, 0, 18, 0, 1, 1, 0)
	darkguys1.Change_Owner(neutral_player)
	darkguys2.Change_Owner(neutral_player)
	Fade_Screen_In(1)
	Transition_Cinematic_Camera_Key(darkguys2, 5, 75, 0, 25, 0, 1, 1, 0)
	Transition_Cinematic_Target_Key(darkguys2, 5, 0, 0, 10, 0, 1, 1, 0)
	
	guards6.Attack_Move(riotgoto)
	
	Story_Event("CHATTER_33")
	
	while not State_Prolog_Chatter_Dialog_33_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(urai_fenn, 5, 0, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber_zann, 0, 0, 10, 0, 0, 0, 0)
	Sleep(1)
		if TestValid(riotersb) then riotersb.Prevent_All_Fire(false) end
		if TestValid(riotersd) then riotersd.Prevent_All_Fire(false) end
		if TestValid(guards6) then guards6.Prevent_All_Fire(false) end
		riotersb.Attack_Target(guards6)
		riotersd.Attack_Target(guards6)
		guards6.Attack_Target(riotersb)
	Transition_Cinematic_Target_Key(riotgoto, 3.5, -50, 25, 15, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(urai_fenn, 3.5, 40, 20, 20, 0, 0, 0, 0) -- remove?
	
	darkguys1.Change_Owner(empire_player)
	darkguys2.Change_Owner(empire_player)
	
	Story_Event("CHATTER_34")
	
	while not State_Prolog_Chatter_Dialog_34_Done do Sleep(.5) end
	
	Fade_Screen_Out(1)
	Sleep(1)
	
	Create_Thread("MidCineCleanup")
	
end

-- triggered when player gets close to the prisoner/workers 
function Prox_HintSpice(self_obj, trigger_obj)
	if trigger_obj.Is_Selectable() then
		if MissionPartOneStarted then 
			if not trigger_obj then
				DebugMessage("Warning: prox received a nil trigger_obj .")
				return
			end
			if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
				closest_infantry = Find_Nearest(self_obj, "UMP_TYBER_ZANN")
				--closest_infantry.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
				Set_Hint_At_Object(spice)
				Story_Event("UM01_HINT_GETSPICE")
				self_obj.Cancel_Event_Object_In_Range(Prox_HintSpice)
				Story_Event("CHATTER_22")
			end
		end
	end
end

---  NNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function Prox_Riots1(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
		    rioters1.Change_Owner(underworld_player)
		    rioters2.Change_Owner(underworld_player)
			rioters1.Set_Selectable(true)
			rioters2.Set_Selectable(true)
			underworld_player.Select_Object(rioters1)
			underworld_player.Select_Object(rioters2)
			guards1.Suspend_Locomotor(false)
			OK_To_Spawn_Guys_A = true
			self_obj.Cancel_Event_Object_In_Range(Prox_Riots1)
		end
	end
end

function Prox_Riots2(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
			rioters3.Change_Owner(underworld_player)
			rioters4.Change_Owner(underworld_player)
			rioters3.Set_Selectable(true)
			rioters4.Set_Selectable(true)
			underworld_player.Select_Object(rioters3)
			underworld_player.Select_Object(rioters4)
			guards2.Suspend_Locomotor(false)
			self_obj.Cancel_Event_Object_In_Range(Prox_Riots2)
		end
	end
end

function Prox_Riots3(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
			rioters5.Change_Owner(underworld_player)
			rioters7.Change_Owner(underworld_player)
			rioters5.Set_Selectable(true)
			rioters7.Set_Selectable(true)
			underworld_player.Select_Object(rioters5)
			underworld_player.Select_Object(rioters7)
			guards4.Suspend_Locomotor(false)
			self_obj.Cancel_Event_Object_In_Range(Prox_Riots3)
		end
	end
end

function Prox_Riots4(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
			rioters9.Change_Owner(underworld_player)
			rioters0.Change_Owner(underworld_player)
			rioters9.Set_Selectable(true)
			rioters0.Set_Selectable(true)
			underworld_player.Select_Object(rioters9)
			underworld_player.Select_Object(rioters0)
			guards5.Suspend_Locomotor(false)
			self_obj.Cancel_Event_Object_In_Range(Prox_Riots4)
			console7.Highlight(true)
		end
	end
end


-- triggered when player gets close to the prisoner/workers 
function HintWorkers()
	if MissionPartOneStarted then 
		if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
			Set_Hint_At_Object(workers)
			Story_Event("UM01_HINT_GETWORKERS")
			wookies.Change_Owner(underworld_player)
			workers.Change_Owner(underworld_player)
			wookies.Set_Selectable(true)
			workers.Set_Selectable(true)
			underworld_player.Select_Object(wookies)
			underworld_player.Select_Object(workers)
			guards0.Suspend_Locomotor(false)
			atst1.Suspend_Locomotor(false)
			Create_Thread("Hunt_Underworld", { atst1 })
		end
	end
end

function TyberPrisoner_Dialogue()
	Story_Event("CHATTER_30")
	while not State_Prolog_Chatter_Dialog_30_Done do Sleep(.5) end
	Story_Event("CHATTER_31")
	while not State_Prolog_Chatter_Dialog_31_Done do Sleep(.5) end
	Story_Event("CHATTER_32")
end

-- triggered when player gets close to the explosive containers
function Prox_HintContainer(self_obj, trigger_obj)
	if trigger_obj.Is_Selectable() then
		if MissionPartOneStarted then 
			if not trigger_obj then
				DebugMessage("Warning: prox received a nil trigger_obj .")
				return
			end
			if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
				closest_infantry = Find_Nearest(self_obj, "UMP_TYBER_ZANN")
				--closest_infantry.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
				Set_Hint_At_Object(container)
				Story_Event("UM01_HINT_BLOWCONTAINER")
				self_obj.Cancel_Event_Object_In_Range(Prox_HintContainer)
				Register_Death_Event(container, HintContainer_Remove)
				Story_Event("CHATTER_21")
			end
		end
	end
end

-- triggered when player destroys the explosive containers
function HintContainer_Remove()
	Remove_Hint_At_Object(container)
end

function Check_LandingPads()
	Register_Timer(GuardGuysLand, 1)
	while true do
			if pad2.Get_Owner() == underworld_player and not PadTwoCaptured then
				PadTwoCaptured = true
			end
			if pad3.Get_Owner() == underworld_player and not PadThreeCaptured then
				PadThreeCaptured = true
			end
			Sleep(1)
	end
end

function GuardGuysLand()
	if MissionPartTwoStarted then
		Register_Timer(GuardGuysLand, 30)
		reinforce_list = {
			--"DARKTROOPER_P2_COMPANY"
			"IMPERIAL_STORMTROOPER_SQUAD"
		}
	else 
		Register_Timer(GuardGuysLand, 45)
		reinforce_list = {
			"IMPERIAL_STORMTROOPER_SQUAD"
			--"DARK_TROOPER_PHASEI"
		}
	end
	--if not PadOneCaptured then
	--	ReinforceList(reinforce_list, pad1, empire_player, false, true, true, Find_And_Attack)
	--end
	if OK_To_Land_Guys_A then
		if not PadTwoCaptured then
			ReinforceList(reinforce_list, pad2, empire_player, false, true, true, Find_And_Attack)
		end
	end
	if OK_To_Land_Guys_B then
		if not PadThreeCaptured then
			ReinforceList(reinforce_list, pad3, empire_player, false, true, true, Find_And_Attack)
		end
	end
		tyber_zann.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
		Register_Timer(Kessel_Alarm_A, 2)
end

function Kessel_Alarm_A()
	tyber_zann.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
	Register_Timer(Kessel_Alarm_B, 2)
end

function Kessel_Alarm_B()
	tyber_zann.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
	Register_Timer(Kessel_Alarm_C, 2)
end

function Kessel_Alarm_C()
	tyber_zann.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
end

function Find_And_Attack(attack_list)
	Create_Thread("Hunt_Underworld",attack_list)
end

-- triggered when player gets close to the prisoner/workers 
function Prox_MilleniumFalcon(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		if MissionPartOneStarted then 
			if not trigger_obj then
				DebugMessage("Warning: prox received a nil trigger_obj .")
				return
			end
			if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
				--closest_infantry = Find_Nearest(self_obj, "UMP_TYBER_ZANN")
				--closest_infantry.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
				Remove_Hint_At_Object(falcon)
				VictoryCondition_ReachedFalcon = true
				self_obj.Cancel_Event_Object_In_Range(Prox_MilleniumFalcon)
			end
		end
	end
end

function Opened_Last_Door()
	if not DefeatCondition_TyberDead and not DefeatCondition_UraiDead then
		Remove_Hint_At_Object(falcon)
		VictoryCondition_ReachedFalcon = true
	end
end


--END CINEMATIC
function EndMissionVictory_NEW()
	Cancel_Fast_Forward() 
	OK_To_Land_Guys_A = false
	OK_To_Land_Guys_B = false
	OK_To_Spawn_Guys_A = false
	OK_To_Spawn_Guys_B = false
	unit_list = Find_All_Objects_Of_Type(empire_player)
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			unit.Suspend_Locomotor(true)
		end
	end

	unit_list = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			if TestValid(unit) then unit.Despawn() end
		end
	end
	
	CINE_End_Active = true
	Story_Event("UM01_ENDCINE_BEGIN")
	
	han_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "hanend")
	chewie_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "chewieend")
	urai_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "uraiend")
	tyber_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "tyberend")
	
	han_solo = Find_First_Object("UMP_HANSOLO")
	chewbacca = Find_First_Object("UMP_CHEWBACCA")
	tyber = Find_First_Object("UMP_TYBER_ZANN")
	uraiend = Create_Generic_Object("URAI_FEN", urai_end_loc.Get_Position(), underworld_player)
	
	cargo1_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo1")
	cargo2_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo2")
	cargo3_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo3")
	cargo4_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo4")
	
	lookspice_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "cinelookspice")
	
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()	
	
	han_solo.Prevent_All_Fire(true)
	han_solo.Teleport_And_Face(han_end_loc)
	han_solo.Face_Immediate(tyber_zann)
	han_solo.Suspend_Locomotor(true)
	chewbacca.Prevent_All_Fire(true)
	chewbacca.Teleport_And_Face(chewie_end_loc)
	chewbacca.Face_Immediate(tyber_zann)
	chewbacca.Suspend_Locomotor(true)
	tyber.Prevent_All_Fire(true)
	tyber.Teleport_And_Face(tyber_end_loc)
	tyber.Face_Immediate(han_solo)
	tyber.Suspend_Locomotor(true)
	tyber.Play_Animation("Idle", false, 0)
	uraiend.Prevent_All_Fire(true)
	uraiend.Teleport_And_Face(urai_end_loc)
	uraiend.Face_Immediate(han_solo)
	uraiend.Suspend_Locomotor(true)
	uraiend.Play_Animation("Idle", false, 0)
	
	underworld_list = Find_All_Objects_Of_Type(underworld_player)
	for k, unit in pairs(underworld_list) do
		--MessageBox("Checking underworld unit %s", unit.Get_Type().Get_Name())
		if TestValid(unit) and not
		  (unit == han_solo) and not
		  (unit == chewbacca) and not
		  (unit == tyber) and not
		  (unit == uraiend) and not
		  (unit == landing_falcon) then
		  	--MessageBox("%s passed all tests, despawning...", unit.Get_Type().Get_Name())
			unit.Despawn()
		end
	end	
	

	--cargo1 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo1_loc, underworld_player)
	--cargo2 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo2_loc, underworld_player)
	--cargo3 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo3_loc, underworld_player)
	cargo1 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo1_loc, underworld_player)
	cargo2 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo2_loc, underworld_player)
	cargo3 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo3_loc, underworld_player)
	cargo5 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Pirate_Company"), cargo1_loc, underworld_player)
	cargo6 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Pirate_Company"), cargo2_loc, underworld_player)
	cargo4 = Create_Generic_Object("CINE_Spice", cargo4_loc.Get_Position(), underworld_player)
	
	cargo1[1].Prevent_All_Fire(true)
	cargo2[1].Prevent_All_Fire(true)
	cargo3[1].Prevent_All_Fire(true)
	cargo5[1].Prevent_All_Fire(true)
	cargo6[1].Prevent_All_Fire(true)
	
	landing_spot = Find_Hint("STORY_TRIGGER_ZONE", "falcon")
	Set_Cinematic_Camera_Key(tyber_end_loc, 240, 15, 270, 1, 0, 1, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, -30, 0, 0, 0, 0)
	
	Fade_Screen_In(2)
	Sleep(2)
	Story_Event("CHATTER_12")
	
	Transition_Cinematic_Camera_Key(tyber_end_loc, 15, 230, 10, 300, 1, 0, 1, 0)
	Transition_Cinematic_Target_Key(han_solo, 15, 0, 0, -10, 0, 0, 0, 0)
	
	while not State_Prolog_End_Dialog_12_Done do Sleep(.5) end
	
	--focus on the conversation
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	
	Sleep(.5)
	
	Story_Event("CHATTER_15")
	
	while not State_Prolog_End_Dialog_15_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	Story_Event("CHATTER_16")
	
	while not State_Prolog_End_Dialog_16_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	Story_Event("CHATTER_17")
	while not State_Prolog_End_Dialog_17_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	Story_Event("CHATTER_18")
	while not State_Prolog_End_Dialog_18_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(tyber, 6, -21, -18, 10, 0, 0, 0, 0)
	Sleep(2)
	Story_Event("CHATTER_19")
	
	tyber.Suspend_Locomotor(false)
	tyber.Turn_To_Face(uraiend)
	Sleep(1)
	tyber.Suspend_Locomotor(true)
	uraiend.Suspend_Locomotor(false)
	uraiend.Turn_To_Face(tyber)
	Sleep(1)
	uraiend.Suspend_Locomotor(true)
	Sleep(1.5)
	
	Transition_Cinematic_Camera_Key(han_end_loc, 4, -57, -9, 16, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(tyber_end_loc, 4, 0, 0, 15, 0, 0, 0, 0)
	
	while not State_Prolog_End_Dialog_19_Done do Sleep(.5) end
	
	Create_Thread("EndCineCleanup")
end


function EndMissionVictory_NEW_OLD()
	Cancel_Fast_Forward() 
	OK_To_Land_Guys_A = false
	OK_To_Land_Guys_B = false
	OK_To_Spawn_Guys_A = false
	OK_To_Spawn_Guys_B = false
	
	CINE_End_Active = true
	Story_Event("UM01_ENDCINE_BEGIN")
	
	ec_tyber_start = Find_Hint("STORY_TRIGGER_ZONE","endcinetyberstart")
	ec_urai_start = Find_Hint("STORY_TRIGGER_ZONE","endcineuraistart")
	ec_tyber_goto = Find_Hint("STORY_TRIGGER_ZONE","endcinetybermoveto")
	ec_urai_goto = Find_Hint("STORY_TRIGGER_ZONE","endcineuraimoveto")
	ec_troops1 = Find_Hint("STORY_TRIGGER_ZONE","endcinetroops1") 
	ec_troops2 = Find_Hint("STORY_TRIGGER_ZONE","endcinetroops2") 
	
	ec_cam1pos = Find_Hint("STORY_TRIGGER_ZONE","endcinecam1pos") 
	ec_cam1look = Find_Hint("STORY_TRIGGER_ZONE","endcinecam1look") 
	
	han_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "hanend")
	chewie_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "chewieend")
	urai_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "uraiend")
	tyber_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "tyberend")
	urairunto = Find_Hint("STORY_TRIGGER_ZONE", "urai-runto")
	
	Fade_Screen_Out(.5)
	Sleep(.5)
	
	if TestValid(door9) then
		door9.Despawn()
	end
	
	Letter_Box_In(0)	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()	
	
	han_solo = Find_First_Object("UMP_HANSOLO")
	chewbacca = Find_First_Object("UMP_CHEWBACCA")
	tyber = Find_First_Object("UMP_TYBER_ZANN")
	uraiend = Find_First_Object("URAI_FEN")
	--uraiend = Create_Generic_Object("URAI_FEN", urai_end_loc.Get_Position(), underworld_player)
	riotgoto = Find_Hint("STORY_TRIGGER_ZONE","midcine-riotersgoto")

	han_solo.Prevent_All_Fire(true)
	han_solo.Teleport_And_Face(han_end_loc)
	han_solo.Face_Immediate(tyber_zann)
	han_solo.Suspend_Locomotor(true)
	chewbacca.Prevent_All_Fire(true)
	chewbacca.Teleport_And_Face(chewie_end_loc)
	chewbacca.Face_Immediate(tyber_zann)
	chewbacca.Suspend_Locomotor(true)
	
	tyber.Prevent_All_Fire(true)
	tyber.Prevent_AI_Usage(true)
	tyber.Teleport_And_Face(ec_tyber_start)
	uraiend.Prevent_All_Fire(true)
	uraiend.Prevent_AI_Usage(true)
	uraiend.Teleport_And_Face(ec_urai_start)
	uraiend.Activate_Ability("STEALTH", false)
	tyber.Activate_Ability("STEALTH", false)

	
	Set_Cinematic_Camera_Key(ec_cam1look, 0, 0, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(ec_cam1pos, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(ec_cam1look, 5, 0, 0, 10, 0, 0, 0, 0)
	
	tyber.Move_To(ec_tyber_goto)
	uraiend.Move_To(ec_urai_goto)
	
	t1_list = Spawn_Unit(Find_Object_Type("IMPERIAL_STORMTROOPER_SQUAD"), ec_troops1, empire_player)
	t2_list = Spawn_Unit(Find_Object_Type("IMPERIAL_STORMTROOPER_SQUAD"), ec_troops2, empire_player)
	t1_list[1].Attack_Move(riotgoto)
	t2_list[1].Attack_Move(riotgoto)
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_HUMAN")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Attack_Move(riotgoto) end
			end
		end
		unit_list = Find_All_Objects_Of_Type("UMP_PRISONER_PIRATE")
		for k, unit in pairs(unit_list) do
			if TestValid(unit) then
				if TestValid(unit) then unit.Attack_Move(riotgoto) end
			end
		end
	
	Fade_Screen_In(.5)
	Sleep(5)
	
	Set_Cinematic_Camera_Key(ec_cam1pos, 0, 0, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(ec_cam1look, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(ec_cam1pos, 5, 0, 0, 20, 0, 0, 0, 0)
	
	Sleep(1)
	uraiend.Turn_To_Face(ec_cam1look)
	Sleep(.25)
	tyber.Turn_To_Face(uraiend)
	Sleep(1)
	
	Story_Event("CHATTER_19")
	while not State_Prolog_End_Dialog_19_Done do Sleep(.5) end
	
	Sleep(1)
	tyber.Move_To(urairunto)
	uraiend.Move_To(urairunto)
	
	Fade_Screen_Out(.5)
	Sleep(.5)
	
	tyber.Prevent_All_Fire(true)
	tyber.Teleport_And_Face(tyber_end_loc)
	tyber.Face_Immediate(han_solo)
	tyber.Suspend_Locomotor(true)
	tyber.Play_Animation("Idle", false, 0)
	uraiend.Prevent_All_Fire(true)
	uraiend.Teleport_And_Face(urai_end_loc)
	uraiend.Face_Immediate(han_solo)
	uraiend.Suspend_Locomotor(true)
	uraiend.Play_Animation("Idle", false, 0)
	
	Create_Thread("EndCineCleanup")

end

--END CINEMATIC
function EndMissionVictory_OLD()
	Cancel_Fast_Forward() 
	OK_To_Land_Guys_A = false
	OK_To_Land_Guys_B = false
	OK_To_Spawn_Guys_A = false
	OK_To_Spawn_Guys_B = false
	unit_list = Find_All_Objects_Of_Type(empire_player)
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			unit.Suspend_Locomotor(true)
		end
	end

	unit_list = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
	for k, unit in pairs(unit_list) do
		if TestValid(unit) then
			if TestValid(unit) then unit.Despawn() end
		end
	end
	
	CINE_End_Active = true
	Story_Event("UM01_ENDCINE_BEGIN")
	
	han_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "hanend")
	chewie_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "chewieend")
	urai_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "uraiend")
	tyber_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "tyberend")
	
	han_solo = Find_First_Object("UMP_HANSOLO")
	chewbacca = Find_First_Object("UMP_CHEWBACCA")
	tyber = Find_First_Object("UMP_TYBER_ZANN")
	uraiend = Create_Generic_Object("URAI_FEN", urai_end_loc.Get_Position(), underworld_player)
	
	cargo1_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo1")
	cargo2_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo2")
	cargo3_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo3")
	cargo4_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "xtracargo4")
	
	lookspice_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "cinelookspice")
	
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)	
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()	
	
	han_solo.Prevent_All_Fire(true)
	han_solo.Teleport_And_Face(han_end_loc)
	han_solo.Face_Immediate(tyber_zann)
	han_solo.Suspend_Locomotor(true)
	chewbacca.Prevent_All_Fire(true)
	chewbacca.Teleport_And_Face(chewie_end_loc)
	chewbacca.Face_Immediate(tyber_zann)
	chewbacca.Suspend_Locomotor(true)
	tyber.Prevent_All_Fire(true)
	tyber.Teleport_And_Face(tyber_end_loc)
	tyber.Face_Immediate(han_solo)
	tyber.Suspend_Locomotor(true)
	tyber.Play_Animation("Idle", false, 0)
	uraiend.Prevent_All_Fire(true)
	uraiend.Teleport_And_Face(urai_end_loc)
	uraiend.Face_Immediate(han_solo)
	uraiend.Suspend_Locomotor(true)
	uraiend.Play_Animation("Idle", false, 0)
	
	underworld_list = Find_All_Objects_Of_Type(underworld_player)
	for k, unit in pairs(underworld_list) do
		--MessageBox("Checking underworld unit %s", unit.Get_Type().Get_Name())
		if TestValid(unit) and not
		  (unit == han_solo) and not
		  (unit == chewbacca) and not
		  (unit == tyber) and not
		  (unit == uraiend) and not
		  (unit == landing_falcon) then
		  	--MessageBox("%s passed all tests, despawning...", unit.Get_Type().Get_Name())
			unit.Despawn()
		end
	end	
	

	--cargo1 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo1_loc, underworld_player)
	--cargo2 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo2_loc, underworld_player)
	--cargo3 = Spawn_Unit(Find_Object_Type("URBAN_CIVILIAN_TEAM_UNDERWORLD"), cargo3_loc, underworld_player)
	cargo1 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo1_loc, underworld_player)
	cargo2 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo2_loc, underworld_player)
	cargo3 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Human_Company"), cargo3_loc, underworld_player)
	cargo5 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Pirate_Company"), cargo1_loc, underworld_player)
	cargo6 = Spawn_Unit(Find_Object_Type("UMP_Prisoner_Pirate_Company"), cargo2_loc, underworld_player)
	cargo4 = Create_Generic_Object("CINE_Spice", cargo4_loc.Get_Position(), underworld_player)
	
	cargo1[1].Prevent_All_Fire(true)
	cargo2[1].Prevent_All_Fire(true)
	cargo3[1].Prevent_All_Fire(true)
	cargo5[1].Prevent_All_Fire(true)
	cargo6[1].Prevent_All_Fire(true)
	
	landing_spot = Find_Hint("STORY_TRIGGER_ZONE", "falcon")
	Set_Cinematic_Camera_Key(tyber_end_loc, 240, 15, 270, 1, 0, 1, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, -30, 0, 0, 0, 0)
	
	Fade_Screen_In(2)
	Sleep(2)
	Story_Event("CHATTER_12")
	
	Transition_Cinematic_Camera_Key(tyber_end_loc, 15, 230, 10, 300, 1, 0, 1, 0)
	Transition_Cinematic_Target_Key(han_solo, 15, 0, 0, -10, 0, 0, 0, 0)
	
	while not State_Prolog_End_Dialog_12_Done do Sleep(.5) end
	
	--focus on the conversation
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	
	Sleep(.5)
	
	Story_Event("CHATTER_13")
	
	while not State_Prolog_End_Dialog_13_Done do Sleep(.5) end
	
	Story_Event("CHATTER_14")
	
		uraifen = Find_First_Object("URAI_FEN")
		uraifen.Suspend_Locomotor(false)
		urai_end_goto = Find_Hint("STORY_TRIGGER_ZONE_01", "uraiendgoto")
		uraifen.Move_To(urai_end_goto)
		
		tyber_zann.Play_SFX_Event("UMP_Unit_Rebel_Soldier_Death")
		
	while not State_Prolog_End_Dialog_14_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	Story_Event("CHATTER_61")
	
		urai_end_loc.Play_SFX_Event("UMP_Unit_Rebel_Soldier_2_Death")
		Sleep(0.5)
		urai_end_loc.Play_SFX_Event("UMP_Unit_Rebel_Soldier_3_Death")
		Sleep(0.25)
		urai_end_loc.Play_SFX_Event("UMP_Unit_Rebel_Soldier_2_Death")
		Sleep(0.5)
		urai_end_loc.Play_SFX_Event("UMP_Unit_Rebel_Soldier_Death")
		Sleep(0.25)
		urai_end_loc.Play_SFX_Event("UMP_Unit_Rebel_Soldier_2_Death")
	cargo1[1].Prevent_All_Fire(true)
	cargo1[1].Change_Owner(empire_player)
	cargo1[1].Attack_Target(uraiend)
	
	while not State_Prolog_Chatter_Dialog_61_Done do Sleep(.5) end
	
		lastprisoner = Create_Generic_Object("PRISONER_REBEL_01", cargo1_loc.Get_Position(), neutral_player)
		uraiend.Teleport_And_Face(uraikiller)
		lastprisoner.Prevent_All_Fire(true)
		uraiend.Prevent_All_Fire(true)

	enddeadguys = true
	
	cargo6[1].Despawn()
	cargo5[1].Despawn()
	cargo3[1].Despawn()
	cargo2[1].Despawn()
	cargo1[1].Despawn()
	Create_Generic_Object("DEAD_BOTHAN", uraikiller.Get_Position(), neutral_player)
	--Create_Generic_Object("DEAD_BOTHAN", urai_end_loc.Get_Position(), neutral_player)
	Create_Generic_Object("UMP_DEADGUYS", cargo1_loc.Get_Position(), neutral_player)
	Create_Generic_Object("UMP_DEADGUYS", cargo2_loc.Get_Position(), neutral_player)
	Create_Generic_Object("UMP_DEADGUYS", cargo3_loc.Get_Position(), neutral_player)
	Create_Generic_Object("UMP_DEADGUYS", endgame.Get_Position(), neutral_player)
	Create_Generic_Object("UMP_DEADGUYS", Find_Hint("STORY_TRIGGER_ZONE_01", "hanspawn").Get_Position(), neutral_player)
	Create_Generic_Object("DEAD_BOTHAN", Find_Hint("STORY_TRIGGER_ZONE_01", "chewiespawn").Get_Position(), neutral_player)
	
	uraiend.Prevent_All_Fire(true)
	uraiend.Face_Immediate(lastprisoner)
	uraiend.Play_Animation("Attack", false, 0)
	
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	Sleep(.6)
		
	lastprisoner.Take_Damage(9999)
	
	Story_Event("CHATTER_62")
	while not State_Prolog_Chatter_Dialog_62_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	Story_Event("CHATTER_63")
	while not State_Prolog_Chatter_Dialog_63_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	Story_Event("CHATTER_17")
	while not State_Prolog_End_Dialog_17_Done do Sleep(.5) end
	
	Set_Cinematic_Camera_Key(tyber, -20, -14, 15, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(han_solo, 0, 0, 14, 0, 0, 0, 0)
	tyber.Play_SFX_Event("Unit_Select_Chewie")
	Sleep(1.5)
	Story_Event("CHATTER_18")
	while not State_Prolog_End_Dialog_18_Done do Sleep(.5) end
	
	urai_end_loc = Find_Hint("STORY_TRIGGER_ZONE_01", "uraiend")
	uraiend.Move_To(urai_end_loc)
		
	Set_Cinematic_Camera_Key(han_solo, -30, -25, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(tyber, 0, 0, 13, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(tyber, 6, -21, -18, 10, 0, 0, 0, 0)
	Sleep(2)
	Story_Event("CHATTER_19")
	
	tyber.Suspend_Locomotor(false)
	tyber.Turn_To_Face(uraiend)
	Sleep(2)
	tyber.Suspend_Locomotor(true)
	
	Sleep(3)
	uraiend.Suspend_Locomotor(false)
	uraiend.Turn_To_Face(tyber)
	Sleep(2)
	uraiend.Suspend_Locomotor(true)
	Sleep(2)
	
	Transition_Cinematic_Camera_Key(han_end_loc, 4, -57, -9, 16, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(tyber_end_loc, 4, 0, 0, 15, 0, 0, 0, 0)
	
	while not State_Prolog_End_Dialog_19_Done do Sleep(.5) end
	
	Create_Thread("EndCineCleanup")
end

-- delay a short time and then show game has been lost DEFEAT
function EndMissionDefeat()
	Cancel_Fast_Forward() 
	Suspend_AI(1)
	Lock_Controls(1)
	
	Story_Event("UM01_ENDMISSION_DEFEAT")
end







function Respawn()

	if OK_To_Spawn_Guys_A then
		total = table.getn(prisoner_table1)
		for k, prisoner in pairs(prisoner_table1) do
			if not TestValid(prisoner) then
				total = total - 1
			end
		end
		
		if total < 1 then
			--prisoner_table1 = Create_Generic_Object("UMP_PRISONER_HUMAN_COMPANY", prisonspawn1.Get_Position(), underworld_player)
			prisoner_table1 = Spawn_Unit(Find_Object_Type("UMP_PRISONER_HUMAN_COMPANY"), prisonspawn1.Get_Position(), underworld_player)
			for k, prisoner in pairs(prisoner_table1) do
				if TestValid(prisoner) then
					prisoner.Move_To(tyber_zann)
				end
			end
			underworld_player.Select_Object(prisoner_table1[1])
		end
	end
	
	if OK_To_Spawn_Guys_B then
		total = table.getn(prisoner_table2)
		for k, prisoner in pairs(prisoner_table2) do
			if not TestValid(prisoner) then
				total = total - 1
			end
		end
		
		if total < 1 then
			--prisoner_table2 = Create_Generic_Object("UMP_PRISONER_HUMAN_COMPANY", prisonspawn2.Get_Position(), underworld_player)
			prisoner_table2 = Spawn_Unit(Find_Object_Type("UMP_PRISONER_HUMAN_COMPANY"), prisonspawn2.Get_Position(), underworld_player)
			for k, prisoner in pairs(prisoner_table2) do
				if TestValid(prisoner) then
					prisoner.Move_To(tyber_zann)
				end
			end
			underworld_player.Select_Object(prisoner_table2[1])
		end
	end
	Register_Timer(Respawn, 5)
end

function Hunt_Empire(attack_list)
	local enemy_player = Find_Player("Empire")
	while true do
		if TestValid(attack_list[1]) then
			if not attack_list[1].Is_Selectable() then
				local closest_enemy = Find_Nearest(attack_list[1], enemy_player, true)	
				if TestValid(closest_enemy) then
					attack_list[1].Attack_Move(closest_enemy)
				end
			end
		end
    	Sleep(4)
	end
end



























-- Story XML kickback functions --


		function State_Prolog_Intro_Dialog_00_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_00_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_01_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_01_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_02_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_02_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_02A_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_02A_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_00_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_00_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_01_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_01_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_02_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_02_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_03_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_03_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_04_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_04_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_05_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_05_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_06_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_06_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_07_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_07_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_08_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_08_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_09_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_09_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_10_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_10_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_11_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_11_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_12_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_12_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_New_13_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_New_13_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_03_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_03_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_04_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_04_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_05_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_05_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_06_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_06_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_07_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_07_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_08_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_08_Done = true
			end
		end
		function State_Prolog_Midtro_Dialog_09_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Midtro_Dialog_09_Done = true
			end
		end
		function State_Prolog_Midtro_Dialog_10_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Midtro_Dialog_10_Done = true
			end
		end
		function State_Prolog_Midtro_Dialog_11_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Midtro_Dialog_11_Done = true
			end
		end
		function State_Prolog_End_Dialog_12_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_12_Done = true
			end
		end
		function State_Prolog_End_Dialog_13_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_13_Done = true
			end
		end
		function State_Prolog_End_Dialog_14_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_14_Done = true
			end
		end
		function State_Prolog_End_Dialog_15_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_15_Done = true
			end
		end
		function State_Prolog_End_Dialog_16_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_16_Done = true
			end
		end
		function State_Prolog_End_Dialog_17_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_17_Done = true
			end
		end
		function State_Prolog_End_Dialog_18_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_18_Done = true
			end
		end
		function State_Prolog_End_Dialog_19_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_End_Dialog_19_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_20_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_20_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_21_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_21_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_22_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_22_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_23_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_23_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_24_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_24_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_25_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_25_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_26_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_26_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_27_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_27_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_28_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_28_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_29_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_29_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_30_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_30_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_31_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_31_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_32_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_32_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_33_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_33_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_34_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_34_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_35_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_35_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_36_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_36_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_37_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_37_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_38_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_38_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_39_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_39_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_40_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_40_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_41_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_41_Done = true
			end
		end
		function State_Prolog_Intro_Dialog_42_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Intro_Dialog_42_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_43_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_43_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_44_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_44_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_45_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_45_Done = true
			end
		end

		function State_Prolog_Chatter_Dialog_61_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_61_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_62_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_62_Done = true
			end
		end
		function State_Prolog_Chatter_Dialog_63_Speech_Done(message)
			if message == OnEnter then
			State_Prolog_Chatter_Dialog_63_Done = true
			end
		end

		

		
		
		

		
				