-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M02_LAND.lua#100 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M02_LAND.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Mike_Lytle $
--
--            $Change: 36918 $
--
--          $DateTime: 2006/01/31 11:17:26 $
--
--          $Revision: #100 $
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
		Empire_M02_Begin = State_Empire_M02_Begin
		,Empire_A01_M02_01 = State_Empire_A01_M02_01
		,Empire_A01_M02_01a = State_Empire_A01_M02_01a
		,Empire_A01_M02_02 = State_Empire_A01_M02_02
		,Empire_A01_M02_02b = State_Empire_A01_M02_02b 
		,Empire_A01_M02_03 = State_Empire_A01_M02_03
		,Empire_A01_M02_03b = State_Empire_A01_M02_03b
		,Empire_A01_M02_04 = State_Empire_A01_M02_04
		,Empire_A01_M02_04b = State_Empire_A01_M02_04b
		,Empire_A01_M02_05 = State_Empire_A01_M02_05
		,Empire_A01_M02_05b = State_Empire_A01_M02_05b
		,Empire_M02_Final_Dialog_00 = State_M02_Final_Setup
		,Empire_M02_Final_Dialog_01_End = State_M02_Final_01_End
		,Empire_M02_Final_Dialog_02 = State_M02_Final_02
		,Empire_M02_Final_Dialog_02_End = State_M02_Final_02_End
		,Empire_M02_Final_Dialog_03 = State_M02_Final_03
		,Empire_M02_Final_Dialog_03_End = State_M02_Final_03_End 
		,Empire_M02_Final_Dialog_04 = State_M02_Final_04
		,Empire_M02_Final_Dialog_04_End = State_M02_Final_04_End
		,Empire_M02_Final_Dialog_05 = State_M02_Final_05
		,Empire_M02_Final_Dialog_05_End = State_M02_Final_05_End
		,Empire_M02_Final_Dialog_06 = State_M02_Final_06
		,Empire_M02_Final_Dialog_06_End = State_M02_Final_06_End
		,Empire_M02_Final_Dialog_07 = State_M02_Final_07
		,Empire_M02_Final_Dialog_07_End = State_M02_Final_07_End
		,Empire_M02_Allow_Win = State_M02_Final_End
		,Empire_M02_Cue_Reinforcements_01 = State_M02_Cue_Reinforcements_01
		,Empire_M02_Cue_Reinforcements_02 = State_M02_Cue_Reinforcements_02
		,Empire_M02_Cue_Reinforcements_03 = State_M02_Cue_Reinforcements_03
		,Empire_A01_M02_Misson_Goal_Complete_PowerGenerator = State_M02_Shield_Is_Dead
		,Empire_M02_Vader_Hint_01_ForcePush = State_Vader_Hint_01_ForcePush
		,Empire_M02_Vader_Hint_02_ForceCrush = State_Vader_Hint_02_ForceCrush
		,Empire_M02_Comm_Center_Info_00 = State_Comm_Center_Info_00
		,Empire_M02_Shield_Info_00 = State_Shield_Info_00
		--,Empire_M02_Power_Generator_01 = State_Power_Generator_01
		,EM02_Reset_Battle_Chatter_Timer_Stop = State_EM02_Reset_Battle_Chatter_Timer_Stop
		,EM02_Reset_Battle_Chatter_Timer02_Stop = State_EM02_Reset_Battle_Chatter_Timer02_Stop
		,EM02_Reset_Battle_Chatter_Timer03_Stop = State_EM02_Reset_Battle_Chatter_Timer03_Stop
		,Empire_M02_Build_Pad_Info_00 = State_Empire_M02_Build_Pad_Info_00
		,Empire_M02_Comm_Center_Destroyed_Lua_Notification = State_Empire_M02_Comm_Center_Destroyed_Lua_Notification
		
	
		
	}

	BikeList =
	{
		"IMPERIAL_LIGHT_SCOUT_SQUAD"
	}
	
	PrimarySkydomeList =
	{
		"Stars_Lua_Cinematic"
	}
	
	PlanetList  = 
	{
		"Temperate_Planet_Lua"
	}
	
	SpaceLuaShuttleList = 
	{
		"Shuttle_Tyderium_Lua_Cinematic"
	}	

	MaulerList =
	{
		"IMPERIAL_ANTI_INFANTRY_BRIGADE"
	}

	TrooperList =
	{
		"IMPERIAL_STORMTROOPER_SQUAD"
	}
	
	Reinforcement01List =
	{
		"IMPERIAL_ANTI_INFANTRY_BRIGADE"
	}
	
	Reinforcement02List =
	{
		"IMPERIAL_STORMTROOPER_SQUAD"
	}
	
	
	reinforced_already = false
	flag_mission_over = false
	current_cinematic_thread = nil
	intro_cinematic_skipped = false
	end_cinematic_skipped = false
	
	flag_powerTurret01_dead = false
	--flag_powerTurret02_dead = false
	
	flag_delay_fudge = false
	flag_okay_to_battle_chatter = true
	flag_vader_seen = false
	flag_at_st_seen = false
	flag_stormtrooper_seen = false
	
	fog_id = nil
	fog_id2 = nil
	fog_id3 = nil
	fog_id4 = nil
	
	bikespawn = nil
	
end





-- INTRO CINEMATIC FUNCTIONS

function State_Empire_M02_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)


		Stop_All_Music()
		-- lockout player control & AI
		Suspend_AI(1)
		Lock_Controls(1)

		-- Fade_Screen_Out(0)

		-- grab markers
		
		vader = Find_First_Object("DARTH_VADER")
		if not vader then
			--MessageBox("Can't find vader!!!")
			return
		end
		
		player = Find_Player("Empire")
		neutral_player = Find_Player("Neutral")
		enemy = Find_Player("Rebel")
		
		powerTurret01 = Find_Hint("SKIRMISH_BUILD_PAD_BASIC", "power-turret01")
		--powerTurret02 = Find_Hint("SKIRMISH_BUILD_PAD_BASIC", "power-turret02")
		
		if not powerTurret01 then
			--MessageBox("Can't find powerTurret01!!!")
			return
		end
		
		--if not powerTurret02 then
		--	MessageBox("Can't find powerTurret02!!!")
		--	return
		--end
		
		reinforce_pad = Find_Hint("REINFORCEMENT_POINT_PLUS10_CAP", "reinforcepad")
		--reinforceSpot = Find_Hint("GENERIC_MARKER_LAND", "reinforce01")
		
		reinforceSpot_01 = Find_Hint("GENERIC_MARKER_LAND", "reinforce-spot01")
		reinforceSpot_02 = Find_Hint("GENERIC_MARKER_LAND", "reinforce-spot02")
		
		bikespawnloc = Find_Hint("GENERIC_MARKER_LAND", "spawnbike")
		sdest = Find_Hint("GENERIC_MARKER_LAND", "scoutdest")
		
		vadershuttlepos = Find_Hint("GENERIC_MARKER_LAND", "vadershuttle")
		commandershuttlepos = Find_Hint("GENERIC_MARKER_LAND", "commandershuttle")
		
		-- Find the locations needed for the end cinematic
		final_vader_start_loc = Find_Hint("GENERIC_MARKER_LAND", "vaderfinalstart")
		final_vader_end_loc = Find_Hint("GENERIC_MARKER_LAND", "vaderfinalend")
		final_officer_loc = Find_Hint("GENERIC_MARKER_LAND", "dialdest")
		intro_officer_final_loc = Find_Hint("GENERIC_MARKER_LAND", "officerendintro")
		final_trooper1_loc = Find_Hint("GENERIC_MARKER_LAND", "stormtrooper1final")
		final_trooper2_loc = Find_Hint("GENERIC_MARKER_LAND", "stormtrooper2final")
		vader_dest1 = Find_Hint("GENERIC_MARKER_LAND", "vaderend")
		Trooperhide1 = Find_Hint("Stormtrooper_Team", "hidetroopers1")
		Trooperhide2 = Find_Hint("Stormtrooper_Team", "hidetroopers2")
		if not Trooperhide1 then
			--MessageBox("Can't find Trooperhide1!!!")
			return
		end
		-- vaderto = Find_Hint("GENERIC_MARKER_LAND", "cfvaderto")
			
		dialogue_cmdr = Find_First_Object("MOV_FIELD_COMMANDER_EMPIRE")
		dialogue_cmdr.Set_Selectable(false)

		
		--Sample use of Find_All_Objects_With_Hint to have all the 'field guards' placed in guard mode in a simple loop
		field_guard_table = Find_All_Objects_With_Hint("fieldguard")
		
		for i,unit in pairs(field_guard_table) do
			unit.Guard_Target(unit.Get_Position())
			Register_Prox(unit, Prox_Battle_Chatter, 100, empire)
		end

		empire = Find_Player("Empire")
		
		bikespawn = SpawnList(BikeList, bikespawnloc, empire, false, false)
	
	
		pad_list = Find_All_Objects_Of_Type("Skirmish_Build_Pad_Basic")
			for i,pad in pairs(pad_list) do
			pad.Lock_Build_Pad_Contents(true)
		end
		
		
		-- Get the space center marker
		space_cinematic_center = Find_Hint("GENERIC_MARKER_LAND", "spacecinematiccenter")
		
		-- Make sure it is valid
		if not TestValid(space_cinematic_center) then
			--MessageBox("Couldn't find hint spacecinematiccenter!!!")
		end
		
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(space_cinematic_center)
		
		-- Get the planet marker
		cinematic_planet_pos = Find_Hint("GENERIC_MARKER_LAND", "cinematicplanetposition")
			
		-- Make sure it is valid
		if not TestValid(cinematic_planet_pos) then
			--MessageBox("Couldn't create cinematic_planet_pos !!!")
		end
		
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(cinematic_planet_pos)
		
		
		cinematic_lua_shuttle_pos = Find_Hint("GENERIC_MARKER_LAND", "luashuttlestart")
		
		-- Make sure it is valid
		if not TestValid(cinematic_lua_shuttle_pos) then
			--MessageBox("Couldn't create cinematic_lua_shuttle_pos !!!")
		end
		
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(cinematic_lua_shuttle_pos)
		
		Set_Cinematic_Environment(true)
		-- *** SET UP THE OPENING CINEMATIC *** 
		if not intro_cinematic_skipped then
			current_cinematic_thread = Create_Thread("Intro_Cinematic_Text_Crawl")
		end	
	end

end

-- XML Story event for commander starting to talk
function State_Empire_A01_M02_01(message)
	if message == OnEnter then
		
		if not intro_cinematic_skipped then
			current_cinematic_thread = Create_Thread("Intro_Cinematic_Commander_Talk_1")
		end
		
	end
end

-- XML Story event for commander stopping his first speech
function State_Empire_A01_M02_01a(message)
	if message == OnEnter then

		-- Let Vader Speak
		if not intro_cinematic_skipped then
			Story_Event("M1_VADER_DIALOGUE_1_GO")
		end	
		
	end
end

-- XML Story event for vader starting to talk
function State_Empire_A01_M02_02(message)
	if message == OnEnter then
		
		if not intro_cinematic_skipped then
			current_cinematic_thread = Create_Thread("Intro_Cinematic_Vader_Talk_1")
		end
				
	end
end

-- XML Story event for vader stopping his speech
function State_Empire_A01_M02_02b(message)
	if message == OnEnter then
	
		if not intro_cinematic_skipped then
			Story_Event("M1_OFFICER_DIALOGUE_2_GO")
		end
		
	end
end


-- XML Story event for commander talking for second time
function State_Empire_A01_M02_03(message)
	if message == OnEnter then

		if not intro_cinematic_skipped then
			current_cinematic_thread =  Create_Thread("Intro_Cinematic_Commander_Talk_2")
		end
			
	end
end

-- XML Story event for commander stopping his second speech event
function State_Empire_A01_M02_03b(message)
	if message == OnEnter then
	
		if not intro_cinematic_skipped then
			Story_Event("M1_VADER_DIALOGUE_2_GO")
		end
		
	end
end

-- XML Story event for vader starting his final speech 
function State_Empire_A01_M02_04(message)
	if message == OnEnter then

		if not intro_cinematic_skipped then
			current_cinematic_thread = 	Create_Thread("Intro_Cinematic_Vader_Talk_2")
		end
				
	end
end


-- XML Story event for vader stopping his final speech 
function State_Empire_A01_M02_04b(message)
	if message == OnEnter then

		if not intro_cinematic_skipped then
			Story_Event("M1_OFFICER_DIALOGUE_3_GO")
		end	
	end
end



-- XML Story event for officer starting his final speech 
function State_Empire_A01_M02_05(message)
	if message == OnEnter then
		
		if not intro_cinematic_skipped then
			dialogue_cmdr.Play_Animation("Talk", false)
		end
			
	end
end


-- XML Story event for officer stopping his final speech 
function State_Empire_A01_M02_05b(message)
	if message == OnEnter then
		
		if not intro_cinematic_skipped then
			current_cinematic_thread = Create_Thread("Intro_Cinematics_End")
		end
			
	end
end


function DropReinforcements()

    --function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)
	ReinforceList(Reinforcement01List, reinforceSpot_01, empire, false, false, true, false)
	-- MessageBox("reinforcements script running")
	Story_Event("M1_REINFORCE_DIALOG_GO")
	
	Sleep(3)
	
	ReinforceList(Reinforcement02List, reinforceSpot_02, empire, false, false, true, false)

end

function Prox_Battle_Chatter(prox_obj, trigger_obj)
	if flag_okay_to_battle_chatter then
		
		newvader = Find_Object_Type("DARTH_VADER")
		at_st = Find_Object_Type("AT_ST_WALKER")
		stormtrooper = Find_Object_Type("SQUAD_STORMTROOPER")
		
		if trigger_obj.Get_Type() == newvader and not flag_vader_seen then
			--MessageBox("Prox_Battle_Chatter vader hit!!")
			flag_okay_to_battle_chatter = false
			flag_vader_seen = true
			Story_Event("M1_RESET_BATTLE_CHATTER")
			Story_Event("M1_BATTLE_CHATTER_REBELS_SEE_VADER")
		elseif trigger_obj.Get_Type() == at_st and not flag_at_st_seen then
			--MessageBox("Prox_Battle_Chatter at_st hit!!")
			flag_okay_to_battle_chatter = false
			flag_at_st_seen = true
			Story_Event("M1_RESET_BATTLE_CHATTER02")
			Story_Event("M1_BATTLE_CHATTER_REBELS_SEE_ATST")
		elseif trigger_obj.Get_Type() == stormtrooper and not flag_stormtrooper_seen then
			--MessageBox("Prox_Battle_Chatter stormtrooper hit!!")
			flag_okay_to_battle_chatter = false
			flag_stormtrooper_seen = true
			Story_Event("M1_RESET_BATTLE_CHATTER03")
			Story_Event("M1_BATTLE_CHATTER_REBELS_SEE_STORMTROOPERS")
		end
	end
	
end

function State_EM02_Reset_Battle_Chatter_Timer_Stop(message)
	if message == OnEnter then
		flag_okay_to_battle_chatter = true
		--MessageBox("battle chatter timer reset")
	end
end

function State_EM02_Reset_Battle_Chatter_Timer02_Stop(message)
	if message == OnEnter then
		flag_okay_to_battle_chatter = true
		--MessageBox("battle chatter timer reset")
	end
end

function State_EM02_Reset_Battle_Chatter_Timer03_Stop(message)
	if message == OnEnter then
		flag_okay_to_battle_chatter = true
		--MessageBox("battle chatter timer reset")
	end
end


-- <***************************************************************************************************************>
-- END CINEMATIC
-- <***************************************************************************************************************>

function State_M02_Final_Setup(message)
	if message == OnEnter then
		flag_mission_over = true
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("Start_End_Cinematic")
		end
	end
end

-- jdg - 8/17 turning base guards back over to AI here

function State_M02_Shield_Is_Dead(message)
	if message == OnEnter then

		if not flag_mission_over then
	
			
		
			base_guard_table = Find_All_Objects_With_Hint("baseguard")
			field_guard_table = Find_All_Objects_With_Hint("fieldguard")
			tank_guard = Find_Hint("T2B_Tank", "tank01")
			
			goto_spot = Find_Hint("GENERIC_MARKER_LAND", "reinforce01")
			
			fog_id = FogOfWar.Reveal(empire,goto_spot.Get_Position(),20000,20000)
			
			for i,unit in pairs(base_guard_table) do
				if TestValid(unit) then
				
					--unit.Prevent_AI_Usage(false)
					--unit.Attack_Move(goto_spot)
					unit.Guard_Target(goto_spot.Get_Position())
				end
			end
			
			--for i,unit in pairs(field_guard_table) do
				--if TestValid(unit) then
				
					--unit.Prevent_AI_Usage(false)
					--unit.Attack_Move(goto_spot)
					--unit.Guard_Target(goto_spot.Get_Position())
				--end
			--end
			
			if TestValid(tank_guard) then
				
					--tank_guard.Prevent_AI_Usage(false)
					--unit.Attack_Move(goto_spot)
					tank_guard.Guard_Target(goto_spot.Get_Position())
			end
		end		
	end
end

function State_M02_Final_01_End(message)
	if message == OnEnter then
	
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_1")
		end
			
	end
end

function State_M02_Final_02(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_2")
		end		
	end
end

function State_M02_Final_02_End(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_2_End")
		end		
	end
end

function State_M02_Final_03(message)
	if message == OnEnter then
	
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_3")
		end
		
	end
end

function State_M02_Final_03_End(message)
	if message == OnEnter then
	
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_3_End")
		end
		
	end
end

function State_M02_Final_04(message)
	if message == OnEnter then
		
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_4")
		end
		
	end
end

function State_M02_Final_04_End(message)
	if message == OnEnter then
	
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_4_End")
		end
		
	end
end

function State_M02_Final_05(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_5")
		end
	end
end

function State_M02_Final_05_End(message)
	if message == OnEnter then
	
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_5_End")
		end
	end
end

function State_M02_Final_06(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_6")
		end
		
	end
end

function State_M02_Final_06_End(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_6_End")
		end
		
	end
end

function State_M02_Final_07(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_7")
		end
		
	end
end

function State_M02_Final_07_End(message)
	if message == OnEnter then
		if not end_cinematic_skipped then
			current_cinematic_thread = Create_Thread("End_Cinematic_7_End")
		end
	end
end

function State_M02_Final_End(message)
	if message == OnEnter then

		
			vader.Play_Animation("Idle",false)
			finaltrooper2.Play_Animation("Idle", false)
			Sleep(3)
			Fade_Screen_Out(.5)
			Sleep(.5)
		--	End_Cinematic_Camera()	
		
		
	end
end

-------------------------------------------------------------
--********************************************************
--Hint messages here (mid mission cines too)
--**********************************************************
-------------------------------------------------------------

function State_Vader_Hint_01_ForcePush(message)
	if message == OnEnter then
		-- this is the Vader hint about using force push against infantry
		-- reveal area around first group of infantry here
		--MessageBox("vader hint 01 lua callback hit")
		infantrypos = Find_First_Object("STORY_TRIGGER_ZONE_06")
		forcepush_reveal = FogOfWar.Reveal(player, infantrypos, 200, 200)
		
		--select vader so we can flash his force push icon thingy
		if TestValid(vader) then
			player.Select_Object(vader)
			--Story_Event("M1_FLASH_VADER_FORCEPUSH_GO")
		else
			--MessageBox("no vader...cannot select him")
		end
		
		flag_delay_fudge = true
	
	end
end

function State_Vader_Hint_02_ForceCrush(message)
	if message == OnEnter then
		-- this is the Vader hint about using force crush against vehicles
		-- reveal area around first tank here
		--MessageBox("vader hint 02 lua callback hit")
		tankpos = Find_First_Object("STORY_TRIGGER_ZONE_07")
		forcecrush_reveal = FogOfWar.Reveal(player, tankpos, 200, 200)
		forcepush_reveal.Undo_Reveal()
		
		if TestValid(vader) then
			player.Select_Object(vader)
			--Story_Event("M1_FLASH_VADER_FORCECRUSH_GO")
		else
			--MessageBox("no vader...cannot select him")
		end
	
	end
end  

function State_Empire_M02_Build_Pad_Info_00(message)
	if message == OnEnter then
		forcecrush_reveal.Undo_Reveal()
	end
end

function State_Comm_Center_Info_00(message)
	if message == OnEnter then
		--MessageBox("player is at the comm center goto mini cinematic")
		commcenter = Find_First_Object("UPLINK_STATION_ABANDONED")
		if not commcenter then
			MessageBox("cinematic Can't find commcenter!!!")
			return
		end
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
		
		Start_Cinematic_Camera()
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(commcenter, 500, 12, 0, 1, 0, 0, 0)
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(commcenter, 0, 0, 0, 0, 0, 0, 0) 
		-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(commcenter, 4, 400, 12, 45, 1, 0, 0, 0)
		comm_reveal = FogOfWar.Reveal(player, commcenter, 400, 400)
		Sleep(4)
		
		closest_unit = Find_Nearest(commcenter, player, true)
		Point_Camera_At(closest_unit)
		
		Transition_To_Tactical_Camera(1)
        Letter_Box_Out(1)
        Sleep(1)
        End_Cinematic_Camera()
		Lock_Controls(0)
		Suspend_AI(0)

	
	end 
end

function State_Empire_M02_Comm_Center_Destroyed_Lua_Notification(message) 
	if message == OnEnter then
		if not flag_mission_over then
			comm_reveal.Undo_Reveal()
		end
	end
end

function State_Shield_Info_00(message)
	if message == OnEnter then
		--MessageBox("player is at the SHIELD WALL goto mini cinematic")
		shieldgen = Find_First_Object("R_GROUND_BASE_SHIELD_SMALL")
		if not shieldgen then
			MessageBox("cinematic Can't find shieldgen!!!")
			return
		end
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
		
		Start_Cinematic_Camera()
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(shieldgen, 1200, 12, 0, 1, 0, 0, 0)
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(shieldgen, 0, 0, 0, 0, 0, 0, 0) 
		-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(shieldgen, 2, 1200, 12, 15, 1, 0, 0, 0)
		Sleep(3)
		
		powergen = Find_First_Object("POWER_GENERATOR_R")
		if not powergen then
			MessageBox("cinematic Can't find powergen!!!")
			return
		end
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(powergen, 400, 12, 180, 1, 0, 0, 0)
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(powergen, 0, 0, 0, 0, 0, 0, 0) 
		-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(powergen, 2, 200, 12, 180, 1, 0, 0, 0)
		fog_id2 = FogOfWar.Reveal(player, powergen, 200, 200)
		Sleep(2)
		
		Fade_Screen_Out(0)
		
		closest_unit = Find_Nearest(shieldgen, player, true)
		Point_Camera_At(closest_unit)
		
		Transition_To_Tactical_Camera(1)
        Letter_Box_Out(1)
        --Sleep(1)
        End_Cinematic_Camera()
		Lock_Controls(0)
		Suspend_AI(0)
		
		Fade_Screen_In(1)

	
	end 
end

function State_Power_Generator_01(message)
	if message == OnEnter then
		--jdg disabling via xml...I don't like this one...too jarring/not needed
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
		
		Start_Cinematic_Camera()
		
		powergen = Find_First_Object("POWER_GENERATOR_R")
		if not powergen then
			--MessageBox("cinematic Can't find powergen!!!")
			return
		end
		
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(powergen, 400, 12, 180, 1, 0, 0, 0)
		-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(powergen, 0, 0, 0, 0, 0, 0, 0) 
		-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(powergen, 3, 200, 12, 180, 1, 0, 0, 0)
		
		Sleep(3)
		closest_unit = Find_Nearest(powergen, player, true)
		Fade_Screen_Out(1)
		Sleep(1)
		
		Point_Camera_At(closest_unit)
		
		Transition_To_Tactical_Camera(1)
		
        Letter_Box_Out(1)
        Sleep(1)
        End_Cinematic_Camera()
        Fade_Screen_In(.5)
		Lock_Controls(0)
		Suspend_AI(0)
	
	end 
end




-- ****************************************************************************
-- Intro Cinematics
-- ****************************************************************************

-- ******************** Opening Cinematic **************************
function Intro_Cinematic_Text_Crawl()

	-- Hide Vader for now	BROKEN!!
	Hide_Object(vader, 1)

	-- Create the space skydome at this position
	primary_space_skydome_list = SpawnList(PrimarySkydomeList, space_cinematic_center, empire, false, false)
	cinematic_skydome = primary_space_skydome_list[1]
		
	if not TestValid(cinematic_skydome) then
		--MessageBox("Couldn't create cinematic Skydome!!!")
	end
		
	cinematic_skydome.Teleport(space_cinematic_center)		
	
	-- Starts the cinematic camera
	Weather_Audio_Pause(true)
	Start_Cinematic_Camera(false)
	Allow_Localized_SFX(false)
	Enable_Fog(false)
	Set_Cinematic_Camera_Key(cinematic_lua_shuttle_pos, 100, -40, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(cinematic_lua_shuttle_pos, 0, 0, -27, 0, 0, 0, 0)
	
	-- ************** TEXT CRAWL STARTS HERE ****************************
	-- MessageBox("Starting Bink Movie!!!")
	-- uncomment!! jdg
	Fade_Screen_In(1)
	BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro"))

	-- MessageBox("Bink Movie done")
	Play_Music("Cinematic_Empire_Intro_Music_Event_2")

	-- MessageBox("Starting Bink Movie!!!")
	-- uncomment!! jdg
	BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro_Short"))
	-- ************** TEXT CRAWL IS DONE HERE ****************************
	
	-- Transition the camera down
	Transition_Cinematic_Camera_Key(cinematic_lua_shuttle_pos, 3, 100, -20, 0, 1, 0, 0, 0)
	
	-- Create the cinematic animation
		
	Lua_Space_Shuttle_List = SpawnList(SpaceLuaShuttleList, cinematic_lua_shuttle_pos, empire, false, false)
	Lua_Space_Shuttle = Lua_Space_Shuttle_List[1]
		
	if not TestValid(Lua_Space_Shuttle) then
		--MessageBox("Couldn't create vaders shuttle in space!!!")
	end
		
	-- Bring on the shuttle
	Lua_Space_Shuttle.Hide(true)
	Lua_Space_Shuttle.Teleport(cinematic_lua_shuttle_pos)
	Lua_Space_Shuttle.Face_Immediate(space_cinematic_center)
	Lua_Space_Shuttle.Play_Animation("Cinematic", false, 0)
	Lua_Space_Shuttle.Hide(false)

	Sleep(12)

	-- Transition camera toward shuttle to see less of Star Destroyer
	Transition_Cinematic_Camera_Key(cinematic_lua_shuttle_pos, 18, 100, -20, 0, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(cinematic_lua_shuttle_pos, 18, 0, 0, -40, 0, 0, 0, 0)
	
	Sleep(11)		

	Fade_Screen_Out(2)
	-- Stop_Bink_Movie()
	Sleep(2)
	cinematic_skydome.Despawn()
	Lua_Space_Shuttle.Despawn()
	Set_Cinematic_Environment(false)
	Enable_Fog(true)
	
	-- ******************** THIS IS THE START OF THE LAND PART OF THE CINEMATIC ********************************
	-- Fade in the scene
		
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
	-- TRANSPORT_PHASE_LANDING = 1, TRANSPORT_PHASE_UNLOADING = 2, TRANSPORT_PHASE_LEAVING = 3
	vader_tyderium_shuttle = Create_Cinematic_Transport("Shuttle_Tyderium_Landing", neutral_player.Get_ID(), vadershuttlepos, 180, 1,0.25, 20, 1)
		
	if not vader_tyderium_shuttle then
		--MessageBox("Couldn't create vaders shuttle!!!")
		return
	end
		
	-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
	-- TRANSPORT_PHASE_LANDING = 1, TRANSPORT_PHASE_UNLOADING = 2, TRANSPORT_PHASE_LEAVING = 3
	--
	commander_tyderium_shuttle = Create_Cinematic_Transport("Imperial_Landing_Craft_Landing", player.Get_ID(), commandershuttlepos, 170, 1, 1.0, 8.0, 0)

	if not commander_tyderium_shuttle then
		--MessageBox("Couldn't create commanders shuttle!!!")
		return
	end

	Hide_Sub_Object(dialogue_cmdr, 1, "gun");
	Hide_Sub_Object(dialogue_cmdr, 1, "gun_shadow");
	dialogue_cmdr.Turn_To_Face(vader)
	dialogue_cmdr.Play_Animation("Attention", true)
	
	-- FIRST CAMERA SHOT **** VIEW VADERS SHUTTLE LANDING ****
	
	Sleep(.5)
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(vader_tyderium_shuttle, 200, 5, 275, 1, 0, 0, 0)
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(vader_tyderium_shuttle, 0, 0, 0, 0, vader_tyderium_shuttle, 0, 1)	
	
	Fade_Screen_In(2)
	Weather_Audio_Pause(false)
	Sleep(2)
	-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj,use_object_rotation,cinematic_animation)
	Transition_Cinematic_Camera_Key(vader_tyderium_shuttle, 5, 240, 4, 275, 1, 0, 0, 0)
	Sleep(4)	
			
	
	-- SECOND CAMERA SHOT **** IMPERIAL COMMANDER CLOSE UP LOOKING STRESSED ****
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(dialogue_cmdr, 40, 25, 45, 1, 0, 0, 0)
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(dialogue_cmdr, 0, 4, 1, 0, dialogue_cmdr, 0, 0)	
	-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation,cinematic_animation)
	Transition_Cinematic_Camera_Key(dialogue_cmdr, 5.0, 30, 25, 45, 1, 0, 0, 0)
	
				
	Sleep(.5)
	
	for j, unit in pairs(bikespawn) do
		if TestValid(unit) then
			unit.Move_To(sdest)
		end
	end
	
	
	Sleep(1.0)	
	
	-- THIRD CAMERA SHOT **** VADER APPROACHES THE COMMANDER ****
	
	Hide_Object(vader, 0)
	Hide_Sub_Object(vader, 1, "lightsaber");
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(vader_dest1, 210, 25, 5, 1, 0, 0, 0)
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation,cinematic_animation)
	Transition_Cinematic_Camera_Key(vader_dest1, 5.0, 120, 15, 285, 1, 0, 0, 0)
	
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(vader, 0, 0, 0, 0, vader, 0, 0);
	
	-- Trigger dialogue sequence

	-- This will conclude
	current_cinematic_thread = nil
	
	Story_Event("M1_INTRO_DIALOGUE_GO")
	
end

-- ******************** Commander Starts talking Cinematic **************************

function Intro_Cinematic_Commander_Talk_1()

	dialogue_cmdr.Play_Animation("Talk",false)
	-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation,cinematic_animation)
	Transition_Cinematic_Camera_Key(vader_dest1, 10.0, 170, 15, 290, 1, 0, 0, 0)
	
	current_cinematic_thread = nil	
	
end

-- ******************** Vader Starts talking Cinematic **************************

function Intro_Cinematic_Vader_Talk_1()

	vader.Play_Animation("Talk",false)
	dialogue_cmdr.Play_Animation("Attention", true)
	
	current_cinematic_thread = nil
	
end


-- ******************** Commander Starts talking again Cinematic **************************

function Intro_Cinematic_Commander_Talk_2()

	dialogue_cmdr.Play_Animation("Talk", false)
	
	current_cinematic_thread = nil

end


-- ******************** Vader Starts talking Cinematic **************************

function Intro_Cinematic_Vader_Talk_2()

	--Set_Cinematic_Camera_Key(vader_dest1, 150, 20, 310, 1, 0, 0, 0)
	--Set_Cinematic_Target_Key(vader, -6, 5, 2, 0, vader, 0, 0);
	Transition_Cinematic_Camera_Key(vader_dest1, 10.0, 170, 35, 20, 1, 0, 0, 0)
	vader.Play_Animation("Talk_Gesture",false)
	dialogue_cmdr.Play_Animation("Attention", true)	
	
	current_cinematic_thread = nil
end		

function dialogue_cmdr_moves_to_final_trooper2_loc()
	BlockOnCommand(dialogue_cmdr.Move_To(final_trooper2_loc))
	dialogue_cmdr.Face_Immediate(vader_dest1)
end


function Intro_Cinematics_End()

	Create_Thread("dialogue_cmdr_moves_to_final_trooper2_loc")
	
	
	for j, unit in pairs(bikespawn) do
		if TestValid(unit) then
			unit.Despawn()
		end
	end
	
	pad_list = Find_All_Objects_Of_Type("Scout_Trooper_No_Bike")
	for i,unit in pairs(pad_list) do
		unit.Despawn()
	end
	

	-- TRANSISTION THE CINEMATIC CAMERA TO THE POSITION OF THE TACTICAL CAMERA
	Stop_All_Music()
	Resume_Mode_Based_Music()
	-- Set up the tactical camera	
	Point_Camera_At(vader)

	Hide_Sub_Object(vader, 0, "lightsaber");
	Hide_Sub_Object(dialogue_cmdr, 0, "gun");
	Hide_Sub_Object(dialogue_cmdr, 0, "gun_shadow");

	
	-- End the cinetic camera mode
	Allow_Localized_SFX(true)
	
	Transition_To_Tactical_Camera(1)

	-- Wait for the cinematic camera to get to the tactical camera
	Letter_Box_Out(1)	
	Sleep(1)
	
	End_Cinematic_Camera()
	Lock_Controls(0)
	Suspend_AI(0)
	
	fog_id3 = FogOfWar.Reveal(player, vadershuttlepos, 200, 200)
	
	Story_Event("M1_START_HINT")
	Story_Event("M1_START_MISSION")
	
	current_cinematic_thread = nil
	
	-- make sure we make note that the intro cinematic is over by recording it is skipped
	intro_cinematic_skipped = true

end

function Story_Handle_Esc()

	if flag_mission_over == false then 
	
		if intro_cinematic_skipped == false then

			intro_cinematic_skipped = true	
			-- MessageBox("Escape Key Pressed!!!")
			Fade_Screen_Out(0)
			
			Stop_All_Music()
			Stop_All_Speech()
			Remove_All_Text()
			
			if current_cinematic_thread ~= nil then
				Thread.Kill(current_cinematic_thread)
			end
			
			Stop_Bink_Movie()
			
			-- Make sure vader is in his final position
			
			vader.Face_Immediate(vader_dest1) 
			vader.Teleport(vader_dest1)
			vader.Hide(false)
			Hide_Sub_Object(vader, 0, "lightsaber");
			Point_Camera_At(vader)
			
			-- Make sure the commander is in his final position
			Hide_Sub_Object(dialogue_cmdr, 0, "gun");
			Hide_Sub_Object(dialogue_cmdr, 0, "gun_shadow");
			dialogue_cmdr.Teleport(final_trooper2_loc)
			dialogue_cmdr.Face_Immediate(vader_dest1)
			
			-- Make sure vaders shutle is in the proper position
			if TestValid(vader_tyderium_shuttle) then
				vader_tyderium_shuttle.Despawn()
			end
			
			-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
			-- TRANSPORT_PHASE_LANDING = 1, TRANSPORT_PHASE_UNLOADING = 2, TRANSPORT_PHASE_LEAVING = 3
			vader_tyderium_shuttle = Create_Cinematic_Transport("Shuttle_Tyderium_Landing", player.Get_ID(), vadershuttlepos, 180, 1, 1.0, 20, 1)
				
			if not vader_tyderium_shuttle then
				--MessageBox("Couldn't create vaders shuttle!!!")
				return
			end
			
			-- Make sure the other shuttle is gone
			if TestValid(commander_tyderium_shuttle) then
				commander_tyderium_shuttle.Despawn()
			end
				
			End_Cinematic_Camera()
			
			Set_Cinematic_Environment(false)
			Enable_Fog(true)

			Letter_Box_Out(0)
			fog_id4 = FogOfWar.Reveal(player, vadershuttlepos, 200, 200)
			
			for j, unit in pairs(bikespawn) do
				if TestValid(unit) then
					unit.Despawn()
				end
			end
				

			pad_list = Find_All_Objects_Of_Type("Scout_Trooper_No_Bike")
			for i,unit in pairs(pad_list) do
				unit.Despawn()
			end
		
			
			Lock_Controls(0)
			Suspend_AI(0)
			Allow_Localized_SFX(true)
			Resume_Mode_Based_Music()
			Weather_Audio_Pause(false)
			-- MLL: Creating a thread, causes a problem if the game is saved.
			--Create_Thread("Fade_Screen_In_After_Esc")	
			Fade_Screen_In_After_Esc()

		end		
	end	
	
	if flag_mission_over == true then
	
		if end_cinematic_skipped == false then
		
			Fade_Screen_Out(0)
			--Stop_All_Music()
			Stop_All_Speech()
			Remove_All_Text()
			Allow_Localized_SFX(false)
			
			end_cinematic_skipped = true
		
			if current_cinematic_thread ~= nil then
				Thread.Kill(current_cinematic_thread)
			end
			
			if TestValid(gen_cmd) then
				gen_cmd.Despawn()
			end
			
			
			if TestValid(vader) then
				vader.Despawn()
			end

			if TestValid(dialogue_cmdr) then
				dialogue_cmdr.Mark_Parent_Mode_Object_For_Death()
				dialogue_cmdr.Despawn()
			end
			
			if TestValid(gen_cmd) then
				gen_cmd.Mark_Parent_Mode_Object_For_Death()
				gen_cmd.Despawn()
			end
		

			-- spawn a new vader at the right location
			ref_type = Find_Object_Type("Darth_Vader")
			vaderlist = Spawn_Unit(ref_type, final_vader_end_loc, empire)
			vader = vaderlist[1]	
			vader.Prevent_AI_Usage(true)
			vader.In_End_Cinematic(true)

			-- spawn stormtrooper 1
			if not TestValid(finaltrooper1) then
				stref_type = Find_Object_Type("DIALOGUE_STORMTROOPER")
				finaltrooperlist1 = Spawn_Unit(stref_type, final_trooper1_loc, empire)
				finaltrooper1 = finaltrooperlist1[1]
				finaltrooper1.Prevent_AI_Usage(true)
				finaltrooper1.Mark_Parent_Mode_Object_For_Death()
			end
			
			finaltrooper1.In_End_Cinematic(true)
			
			-- spawn storm trooper 2
			if not TestValid(finaltrooper2) then
				stref2_type = Find_Object_Type("DIALOGUE_STORMTROOPER")
				finaltrooperlist2 = Spawn_Unit(stref2_type, final_trooper2_loc, empire)
				finaltrooper2 = finaltrooperlist2[1]
				finaltrooper2.Prevent_AI_Usage(true)
				finaltrooper2.Mark_Parent_Mode_Object_For_Death()
			end
			
			finaltrooper2.In_End_Cinematic(true)
			
			-- Disable the other objects for the final cinematic
			Do_End_Cinematic_Cleanup()
			
			-- turn characters to face
			vader.Face_Immediate(finaltrooper2)
			finaltrooper1.Face_Immediate(vader)
			finaltrooper2.Face_Immediate(vader)		
			
			vader.Play_Animation("Idle",false)
			finaltrooper1.Play_Animation("Idle",false)
			finaltrooper2.Play_Animation("Idle",false)
			
			Allow_Localized_SFX(true)
			
			Create_Thread("Fade_Screen_In_After_Esc_End")	
		end
	end		
end


function Fade_Screen_In_After_Esc()

	Fade_Screen_In(1)
    -- MLL: Don't sleep since this is no longer a thread.
	--Sleep(1)		
	Story_Event("M1_START_HINT")
	Story_Event("M1_START_MISSION")

end

function Fade_Screen_In_After_Esc_End()
	
	Set_Cinematic_Target_Key(final_officer_loc, 0, 0, 5, 0, 0, 0, 0)
	Set_Cinematic_Camera_Key(final_officer_loc, 80, 10, 335, 1, 0, 0, 0)
	Fade_Screen_In(.5)
	Sleep(1)
	Story_Event("M1_FINAL_DONE")
end


-- ****************************************************************************
-- End Cinematics
-- ****************************************************************************
	
	
function Start_End_Cinematic()
		
		flag_mission_over = true
		
		Cancel_Fast_Forward() 
		
		-- lockout player control & AI
		Allow_Localized_SFX(false)
		Suspend_AI(1)
		Lock_Controls(1)
		
		-- Start up the cinematic camera for the end scene shot
		Start_Cinematic_Camera()
		
		Fade_Screen_Out(1)
		Sleep(1)
		Letter_Box_In(0)
		
		-- Despawn relevent units
		
		if vader then
			vader.Despawn()
		end

		if dialogue_cmdr then
			dialogue_cmdr.Despawn()
		end
		
		
		-- Disable the other objects for the final cinematic
		Do_End_Cinematic_Cleanup()
		
		-- Spawn the new end cinematic units

		-- spawn a new vader at the right location

		ref_type = Find_Object_Type("Darth_Vader")
		vaderlist = Spawn_Unit(ref_type, final_vader_start_loc, empire)
		vader = vaderlist[1]
		vader.In_End_Cinematic(true)
		
		-- spawn commander
		gcref_type = Find_Object_Type("MOV_FIELD_COMMANDER_EMPIRE")
		gencmdlist = Spawn_Unit(gcref_type, final_officer_loc, empire)
		gen_cmd = gencmdlist[1]
		gen_cmd.In_End_Cinematic(true)
		
		-- spawn stormtrooper 1
		stref_type = Find_Object_Type("DIALOGUE_STORMTROOPER")
		finaltrooperlist1 = Spawn_Unit(stref_type, final_trooper1_loc, empire)
		finaltrooper1 = finaltrooperlist1[1]
		finaltrooper1.In_End_Cinematic(true)
		
		-- spawn storm trooper 2
		stref2_type = Find_Object_Type("DIALOGUE_STORMTROOPER")
		finaltrooperlist2 = Spawn_Unit(stref2_type, final_trooper2_loc, empire)
		finaltrooper2 = finaltrooperlist2[1]
		finaltrooper2.In_End_Cinematic(true)
		
		-- Vader commands
		Hide_Sub_Object(vader, 1, "lightsaber");
		vader.Prevent_AI_Usage(true)
			
		-- commander commands

		gen_cmd.Prevent_AI_Usage(true)
		gen_cmd.Mark_Parent_Mode_Object_For_Death()
		Hide_Sub_Object(gen_cmd, 1, "gun");
		Hide_Sub_Object(gen_cmd, 1, "gun_shadow");		
		gen_cmd.Turn_To_Face(vader)
		gen_cmd.Play_Animation("Attention", true)
		vader.Face_Immediate(gen_cmd)
		
		-- stormtrooper 1 commands
		finaltrooper1.Prevent_AI_Usage(true)
		finaltrooper1.Mark_Parent_Mode_Object_For_Death()
		finaltrooper1.Turn_To_Face(vader)
		
		-- storm trooper commands
		finaltrooper2.Prevent_AI_Usage(true)
		finaltrooper2.Mark_Parent_Mode_Object_For_Death()
		finaltrooper2.Turn_To_Face(vader)
		
		-- FIRST CAMERA SHOT **** VIEW VADERS SHUTTLE LANDING ****
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(final_officer_loc, 150, 35,45, 1, 0, 0, 0)
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(final_officer_loc, 0, 0, 5, 0, 0, 0, 0)
		-- set up Vader at the comm array (or what's left of it...)

		Fade_Screen_In(1)
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation,cinematic_animation)
		Transition_Cinematic_Camera_Key(final_officer_loc, 10.0, 120, 10, 335, 1, 0, 0, 0)
		vader.Move_To(final_vader_end_loc)
		Sleep(3)
		-- fade up & give the OK to start dialogue	
		Story_Event("M1_FINAL_GO")
		
		current_cinematic_thread = nil
end


function End_Cinematic_1()

	vader.Play_Animation("Choke", false)
	Story_Event("M1_FINAL_DIALOG_02_GO")
	current_cinematic_thread = nil
	
end

function End_Cinematic_2()

	Sleep(.5)	
	gen_cmd.Play_Animation("Choke_Die", false)
	current_cinematic_thread = nil
	
end

function End_Cinematic_2_End()

	Story_Event("M1_FINAL_DIALOG_03_GO")
	current_cinematic_thread = nil
		
end


function End_Cinematic_3()

	vader.Play_Animation("Talk", true)
	current_cinematic_thread = nil	
	
end

function End_Cinematic_3_End()

	Story_Event("M1_FINAL_DIALOG_04_GO")	
	current_cinematic_thread = nil
		
end

function End_Cinematic_4()

	-- vader.Turn_To_Face(finaltrooper2)
	vader.Play_Animation("Talk", true)
	Transition_Cinematic_Camera_Key(final_officer_loc, 10.0, 120, 10, 335, 1, 0, 0, 0)
	current_cinematic_thread = nil
	
	
end

function End_Cinematic_4_End()

	vader.Play_Animation("Idle", false)
	Story_Event("M1_FINAL_DIALOG_05_GO")
	current_cinematic_thread = nil
	gen_cmd.Play_Animation("Cinematic", true)
		
end

function End_Cinematic_5()

	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(finaltrooper2, 25, 40, 290, 1, 0, 0, 0)
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(finaltrooper2, 0, 0, 12, 0, 0, 0, 0)

	finaltrooper2.Play_Animation("Talk", false)
	current_cinematic_thread = nil
	
end

function End_Cinematic_5_End()

	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(vader, 60, 20, 0, 1, 0, 0, 0)
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(vader, 0, 0, 13, 0, 0, 0, 0)
	
	-- finaltrooper2.Play_Animation("Idle", false)
	finaltrooper2.Play_Animation("Attention", true)
	Story_Event("M1_FINAL_DIALOG_06_GO")
	current_cinematic_thread = nil
		
end

function End_Cinematic_6()

	Transition_Cinematic_Camera_Key(final_officer_loc, 10, 100, 18, 25, 1, 0, 0, 0)
			
	vader.Play_Animation("Talk_Gesture", false)		
	current_cinematic_thread = nil
	
end

function End_Cinematic_6_End()
	
	vader.Play_Animation("Idle", false)	
	Story_Event("M1_FINAL_DIALOG_07_GO")
	current_cinematic_thread = nil	
		
end

function End_Cinematic_7()	
	
	current_cinematic_thread = nil
	
end

function End_Cinematic_7_End()

	Allow_Localized_SFX(true)
	Story_Event("M1_FINAL_DONE")
	current_cinematic_thread = nil
		
end




-- This service occurs outside of the scope of events
function Story_Mode_Service()
	if flag_powerTurret01_dead and reinforce_pad and not reinforced_already and reinforce_pad.Get_Owner() == player then
		reinforced_already = true
		--MessageBox("reinforce pad captured, reinforcements landing?")
		DropReinforcements()
	end
	
	if flag_delay_fudge and not flag_powerTurret01_dead and powerTurret01.Get_Owner() ~= enemy then
		--MessageBox("flag_powerTurret01_dead = true")
		flag_powerTurret01_dead = true
	end

end
