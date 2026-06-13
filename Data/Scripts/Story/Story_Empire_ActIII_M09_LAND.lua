-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIII_M09_LAND.lua#23 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIII_M09_LAND.lua $
--
--    Original Author: Jim_Richmond
--
--            $Author: Joseph_Gernert $
--
--            $Change: 37023 $
--
--          $DateTime: 2006/02/02 15:31:38 $
--
--          $Revision: #23 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

function Definitions()

	StoryModeEvents = 
	{
		Empire_A03M09_Begin = State_Empire_M09_Begin
		,Empire_ActIII_M09_00 = State_Empire_ActIII_M09_00
		,Empire_ActIII_M09_03 = State_Empire_ActIII_M09_03
		,Empire_ActIII_M09_WIN_CONDITION = State_Empire_ActIII_M09_WIN_CONDITION
		,Empire_ActIII_M09_WIN_CONDITION_01 = State_Empire_ActIII_M09_WIN_CONDITION_01
	}

	reinforcement_list1 = {
		"Bothan_Resistors"
	}
	
	reinforcement_list2 = {
		"Rebel_Tank_Buster_Squad"
		,"Rebel_Tank_Buster_Squad"
		,"Rebel_Tank_Buster_Squad"
		,"Rebel_Tank_Buster_Squad"
	}
	
	reinforcement_list3 = {
		"Rebel_Light_Tank_Brigade"
	}
	
	flag_building01_dead = false
	flag_building02_dead = false
	flag_building03_dead = false
	flag_building04_dead = false
	flag_building05_dead = false
	flag_building06_dead = false
	flag_building07_dead = false
	flag_building08_dead = false
	flag_map_revealed = false
	flag_intialized = false
	
	fog_id = nil

end

function State_Empire_M09_Begin(message)

	if message == OnEnter then

		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		
		structure_list = Find_All_Objects_Of_Type("Bothan_Spawn_House_Mission")
		
		
		
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)
	
		-- *** Get the Imperial player *** 	
		imperial_player = Find_Player("Empire")
		bothan_player = Find_Player("Rebel")
		rebel_player = Find_Player("Rebel")
		--rebel_player.Enable_As_Actor()
		
		--tracking building here
		building_01 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building01")
		building_02 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building02")
		building_03 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building03")
		building_04 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building04")
		building_05 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building05")
		building_06 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building06")
		building_07 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building07")
		building_08 = Find_Hint("BOTHAN_SPAWN_HOUSE_MISSION", "building08")
		
		-- find all of the objects we need for the mission cinematics
		
		-- *** EMPEROR PALPATINE ***
		emperor_palpatine = Find_Hint("EMPEROR_PALPATINE", "emperor")
		-- check to see that we were able to obtain emperor palpatine
		if not TestValid(emperor_palpatine) then
			--MessageBox("Couldn't find the emperor!!!")
			ScriptExit()
		end
		
		emperor_palpatine.Enable_Behavior(78, false)
		
		-- *** PALPATINE GUARD 1 ***
		guard_palpatine_1 = Find_Hint("IMPERIAL_GUARD_NON_AI", "emperorguard1")
		-- check to see that we were able to obtain the guard
		if not TestValid(guard_palpatine_1) then
			--MessageBox("Couldn't find emperors first guard!!!")
			ScriptExit()
		end
		
		-- *** PALPATINE GUARD 2 ***
		guard_palpatine_2 = Find_Hint("IMPERIAL_GUARD_NON_AI", "emperorguard2")
		-- check to see that we were able to obtain the guard
		if not TestValid(guard_palpatine_2) then
			--MessageBox("Couldn't find emperors second guard!!!")
			ScriptExit()
		end
	
		-- *** BOTHAN 1 ***
		bothan_1 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan1")
		-- check to see that we were able to obtain the first bothan
		if not TestValid(bothan_1) then
			--MessageBox("Couldn't find the first bothan!!!")
			ScriptExit()
		end
		
		-- *** BOTHAN 2 ***
		bothan_2 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan2")
		-- check to see that we were able to obtain the second bothan
		if not TestValid(bothan_2) then
			--MessageBox("Couldn't find the second bothan!!!")
			ScriptExit()
		end
		
		-- *** BOTHAN 3 ***
		bothan_3 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan3")
		-- check to see that we were able to obtain the third bothan
		if not TestValid(bothan_3) then
			--MessageBox("Couldn't find the third bothan!!!")
			ScriptExit()
		end
	

		-- *** BOTHAN 4 ***
		bothan_4 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan4")
		-- check to see that we were able to obtain the third bothan
		if not TestValid(bothan_4) then
			--MessageBox("Couldn't find the third bothan!!!")
			ScriptExit()
		end

		-- *** BOTHAN 5 ***
		bothan_5 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan5")
		-- check to see that we were able to obtain the third bothan
		if not TestValid(bothan_5) then
			--MessageBox("Couldn't find the third bothan!!!")
			ScriptExit()
		end

		-- *** BOTHAN 6 ***
		bothan_6 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan6")
		-- check to see that we were able to obtain the third bothan
		if not TestValid(bothan_6) then
			--MessageBox("Couldn't find the third bothan!!!")
			ScriptExit()
		end

		-- *** BOTHAN 7 ***
		bothan_7 = Find_Hint("BOTHAN_CIVILIAN_MISSION", "bothan7")
		-- check to see that we were able to obtain the third bothan
		if not TestValid(bothan_7) then
			--MessageBox("Couldn't find the third bothan!!!")
			ScriptExit()
		end


		-- Next, we need to get all of the relevent position markers
		-- *** Emperor Palpatine's shuttle position marker ***
		emperor_shuttle_pos = Find_Hint("GENERIC_MARKER_LAND", "emperorshuttle")
		if not TestValid(emperor_shuttle_pos) then
			--MessageBox("Couldn't find the emperor's shuttle position!!!")
			ScriptExit()
		end
		
		-- *** Emperor Palpatine's move to marker ***
		emperor_move_to_pos_1 = Find_Hint("GENERIC_MARKER_LAND", "emperormoveto1")
		if not TestValid(emperor_move_to_pos_1) then
			--MessageBox("Couldn't find the emperor's first move to position!!!")
			ScriptExit()
		end
		
		emperor_move_to_pos_2 = Find_Hint("GENERIC_MARKER_LAND", "emperormoveto2")
		if not TestValid(emperor_move_to_pos_2) then
			--MessageBox("Couldn't find the emperor's second move to position!!!")
			ScriptExit()
		end
		
		emperor_end_cinematic_start = Find_Hint("GENERIC_MARKER_LAND", "emperorfinalcinematicstart")
		if not TestValid(emperor_end_cinematic_start) then
			--MessageBox("Couldn't find the emperor's end cinematic start position!!!")
			ScriptExit()
		end
		
		emperor_end_cinematic_end = Find_Hint("GENERIC_MARKER_LAND", "emperorfinalcinematicend")
		if not TestValid(emperor_end_cinematic_end) then
			--MessageBox("Couldn't find the emperor's final cinematic position!!!")
			ScriptExit()
		end
		
		-- *** Palpatine's first guard's move to marker ***
		emperor_guard_move_to_pos_1 = Find_Hint("GENERIC_MARKER_LAND", "emperorguard1moveto1")
		if not TestValid(emperor_guard_move_to_pos_1) then
			--MessageBox("Couldn't find the first emperor's guard's move to position!!!")
			ScriptExit()
		end
		
		-- *** Palpatine's second guard's move to marker ***
		emperor_guard_move_to_pos_2 = Find_Hint("GENERIC_MARKER_LAND", "emperorguard2moveto1")
		if not TestValid(emperor_guard_move_to_pos_2) then
			--MessageBox("Couldn't find the second emperor's guard's move to position!!!")
			ScriptExit()
		end
		
		-- *** Find the second Bothan's run to position marker ***
		bothan_2_run_to_pos = Find_Hint("GENERIC_MARKER_LAND", "bothan2run")
		if not TestValid(bothan_2_run_to_pos) then
			--MessageBox("Couldn't find the second bothans run to position!!!")
			ScriptExit()
		end
		
		-- *** Find the third Bothan's run to position marker ***
		bothan_3_run_to_pos = Find_Hint("GENERIC_MARKER_LAND", "bothan3run")
		if not TestValid(bothan_3_run_to_pos) then
			--MessageBox("Couldn't find the third bothans run to position!!!")
			ScriptExit()
		end

		emperor_cinematic_End_Move_to = Find_Hint("GENERIC_MARKER_LAND", "cinematicfinishemperor")
		emperor_Finalstop_Move_to = Find_Hint("GENERIC_MARKER_LAND", "emperorfinalstop1")
		
		-- Dead Bothans for finale

		Dead_Bothans_1 = Find_Hint("Dead_Bothan", "deadbothan1")
		Dead_Bothans_2 = Find_Hint("Dead_Bothan", "deadbothan2")
		Dead_Bothans_3 = Find_Hint("Dead_Bothan", "deadbothan3")
		Dead_Bothans_4 = Find_Hint("Dead_Bothan", "deadbothan4")
		Dead_Bothans_5 = Find_Hint("Dead_Bothan", "deadbothan5")
		Dead_Bothans_6 = Find_Hint("Dead_Bothan", "deadbothan6")
		Dead_Bothans_7 = Find_Hint("Dead_Bothan", "deadbothan7")
		Dead_Bothans_8 = Find_Hint("Dead_Bothan", "deadbothan8")
		Dead_Bothans_9 = Find_Hint("Dead_Bothan", "deadbothan9")
		Dead_Bothans_10 = Find_Hint("Dead_Bothan", "deadbothan10")
		Dead_Bothans_11 = Find_Hint("Dead_Bothan", "deadbothan11")
		Dead_Bothans_12 = Find_Hint("Dead_Bothan", "deadbothan12")
		Dead_Bothans_13 = Find_Hint("Dead_Bothan", "deadbothan13")		
		
			
		-- *** Create the emperors shuttle and set it to the proper place in its animation ***
		-- Create_Cinematic_Transport(object_type_name, player_id, transport_pos, zangle, phase_mode, anim_delta, idle_time, persist,hint)  
		-- TRANSPORT_PHASE_LANDING = 1, TRANSPORT_PHASE_UNLOADING = 2, TRANSPORT_PHASE_LEAVING = 3
		emperor_tyderium_shuttle = Create_Cinematic_Transport("Shuttle_Tyderium_Landing", imperial_player.Get_ID(), emperor_shuttle_pos, 0, 1, 0.25, 20, 1)
		
		if not emperor_tyderium_shuttle then
			--MessageBox("Couldn't create the emperors shuttle!!!")
			ScriptExit()
		end
		
		-- Set the tactical camera to the emperor
		Point_Camera_At(emperor_move_to_pos_1)
		
		-- Start the Cinematic Camera
		Start_Cinematic_Camera()
		Set_Cinematic_Camera_Key(emperor_tyderium_shuttle, 180, 4, 88, 1, 0, 0, 0)   
		Set_Cinematic_Target_Key(emperor_tyderium_shuttle, 0, 50, 5, 0, emperor_tyderium_shuttle, 0, 1)   
		
		guard_palpatine_1.Prevent_AI_Usage(true)
		guard_palpatine_2.Prevent_AI_Usage(true)
		
		emperor_palpatine.Hide(true)
		guard_palpatine_1.Hide(true)
		guard_palpatine_2.Hide(true)
		Hide_Sub_Object(emperor_palpatine, 1, "lightsaber")
		-- Disable holster weapon
		
		
		Dead_Bothans_1.Hide(true)
		Dead_Bothans_2.Hide(true)
		Dead_Bothans_3.Hide(true)
		Dead_Bothans_4.Hide(true)
		Dead_Bothans_5.Hide(true)
		Dead_Bothans_6.Hide(true)
		Dead_Bothans_7.Hide(true)
		Dead_Bothans_8.Hide(true)
		Dead_Bothans_9.Hide(true)
		Dead_Bothans_10.Hide(true)
		Dead_Bothans_11.Hide(true)
		Dead_Bothans_12.Hide(true)
		Dead_Bothans_13.Hide(true)

		
		-- Fade the screen in on the opening
		Fade_Screen_In(1)
		
		Transition_Cinematic_Camera_Key(emperor_tyderium_shuttle, 6, 180, 4, 75, 1, 0, 0, 0)

		Sleep(7)
		
				
		-- Set Camera shot of the Bothans Bowing
		Set_Cinematic_Camera_Key(bothan_1, 20, 35, 300, 1, 0, 0, 0)   
		Set_Cinematic_Target_Key(bothan_1, 15, 15, 130, 1, 0, 0, 0) 
  
		Transition_Cinematic_Camera_Key(bothan_1, 5, 25, 40, 300, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(bothan_1, 5, 15, 0, 130, 1, 0, 0, 0)

		bothan_1.Play_Animation("cinematic", false, 1)
		Sleep(.1)
		bothan_2.Play_Animation("cinematic", false, 1)
		bothan_3.Play_Animation("cinematic", false, 1)
		Sleep(.1)
		bothan_4.Play_Animation("cinematic", false, 1)
		Sleep(.1)
		bothan_5.Play_Animation("cinematic", false, 1)
		bothan_6.Play_Animation("cinematic", false, 1)
		Sleep(.1)
		bothan_7.Play_Animation("cinematic", false, 1)
				
		emperor_palpatine.Hide(false)
		guard_palpatine_1.Hide(false)
		guard_palpatine_2.Hide(false)
		emperor_palpatine.Teleport(emperor_move_to_pos_1)
		guard_palpatine_1.Teleport(emperor_guard_move_to_pos_1)	
		guard_palpatine_2.Teleport(emperor_guard_move_to_pos_2)	

		Sleep(2.0)

		emperor_palpatine.Play_Animation("cinematic", false, 0)
		guard_palpatine_1.Play_Animation("cinematic", false, 0)
		guard_palpatine_2.Play_Animation("cinematic", false, 0)
		
		Sleep(0.3)
		
		Set_Cinematic_Camera_Key(emperor_palpatine, 20, 20, 90, 1, 0, 0, 0)   
		Set_Cinematic_Target_Key(emperor_tyderium_shuttle, 0, 0, 30, 0, 0, 0, 0)
		 
		bothan_1.Play_Animation("cinematic", true, 2)		
		bothan_2.Play_Animation("cinematic", true, 2)
		bothan_3.Play_Animation("cinematic", true, 2)		
		bothan_4.Play_Animation("cinematic", true, 2)		
		bothan_5.Play_Animation("cinematic", true, 2)
		bothan_6.Play_Animation("cinematic", true, 2)		
		bothan_7.Play_Animation("cinematic", true, 2)		

		
		-- Signal the XML script that lua is done handling the beginning of the mission 
		Story_Event("LUA_EM09_BEGIN_FINISHED")


		Sleep(3)

		Set_Cinematic_Camera_Key(emperor_tyderium_shuttle, 170, 3, 75, 1, 0, 0, 0)   
		Set_Cinematic_Target_Key(emperor_palpatine, 0, 0, 10, 0, 0, 0, 0) 		

		Sleep(3)	
		emperor_palpatine.Play_Animation("cinematic", true, 1)
	end
end

-- Emperor speaks 
function State_Empire_ActIII_M09_03(message)

	if message == OnEnter then
	
		-- Fry the first bothan
		
		bothan_1.Change_Owner(bothan_player)
		bothan_2.Change_Owner(bothan_player)
		bothan_3.Change_Owner(bothan_player)
		bothan_4.Change_Owner(bothan_player)
		bothan_5.Change_Owner(bothan_player)
		bothan_6.Change_Owner(bothan_player)
		bothan_7.Change_Owner(bothan_player)		
		
		--bothan_1.Prevent_Opportunity_Fire(true)
		--bothan_2.Prevent_Opportunity_Fire(true)
		--bothan_3.Prevent_Opportunity_Fire(true)
		--bothan_4.Prevent_Opportunity_Fire(true)
		--bothan_5.Prevent_Opportunity_Fire(true)
		--bothan_6.Prevent_Opportunity_Fire(true)
		--bothan_7.Prevent_Opportunity_Fire(true)
		
		Sleep(.2)
		
		emperor_palpatine.Activate_Ability("force_lightning", bothan_1)		
		
		Transition_Cinematic_Target_Key(emperor_palpatine, 3, 0, 40, 0, 0, 0, 0, 0) 
		
		emperor_palpatine.Reset_Ability_Counter()			
		
		Sleep(5)
				
		Suspend_AI(0)
		Lock_Controls(0)
		-- Enable holster weapon
		emperor_palpatine.Enable_Behavior(78, true)
		Hide_Sub_Object(emperor_palpatine, 0, "lightsaber")
		Transition_To_Tactical_Camera(2)
		Sleep(1)
		Letter_Box_Out(1)
		Sleep(1)
		End_Cinematic_Camera()		
		Sleep(5)
		
		for i, structure in pairs(structure_list) do
			Add_Radar_Blip(structure, "somename")
			structure.Highlight(true, 50)
		end
		
		flag_intialized = true
		
		Story_Event("MISSION_BEGINNING_HINT")
	end
end

-- Called after win condition is met
function State_Empire_ActIII_M09_WIN_CONDITION(message)

	if message == OnEnter then
	
		Create_Thread("EM09_Ending_Cinematic")
	
		
	end
end	

function EM09_Ending_Cinematic()
	--vehicle_delete_list = Find_All_Objects_Of_Type("T2B_Tank")
		--for i, unit in pairs(vehicle_delete_list) do
		--	unit.Despawn()
		--end
		
		--vehicle_delete_list = Find_All_Objects_Of_Type("Squad_Plex_Soldier")
		--for i, unit in pairs(vehicle_delete_list) do
		--	unit.Despawn()
		--end
		
		emperor_palpatine.In_End_Cinematic(true)
		Dead_Bothans_1.In_End_Cinematic(true)
		Dead_Bothans_2.In_End_Cinematic(true)
		Dead_Bothans_3.In_End_Cinematic(true)
		Dead_Bothans_4.In_End_Cinematic(true)
		Dead_Bothans_5.In_End_Cinematic(true)
		Dead_Bothans_6.In_End_Cinematic(true)
		Dead_Bothans_7.In_End_Cinematic(true)
		Dead_Bothans_8.In_End_Cinematic(true)
		Dead_Bothans_9.In_End_Cinematic(true)
		Dead_Bothans_10.In_End_Cinematic(true)
		Dead_Bothans_11.In_End_Cinematic(true)
		Dead_Bothans_12.In_End_Cinematic(true)
		Dead_Bothans_13.In_End_Cinematic(true)
		Do_End_Cinematic_Cleanup()
	
		Cancel_Fast_Forward() 
		Fade_Screen_Out(1)
		Sleep(3)
		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)

		emperor_palpatine.Teleport(emperor_end_cinematic_start)
		emperor_palpatine.Face_Immediate(emperor_Finalstop_Move_to)

		Sleep(0.5)
		
		-- Unhide Dead Bothans		

		Dead_Bothans_1.Hide(false)
		Dead_Bothans_2.Hide(false)
		Dead_Bothans_3.Hide(false)
		Dead_Bothans_4.Hide(false)
		Dead_Bothans_5.Hide(false)
		Dead_Bothans_6.Hide(false)
		Dead_Bothans_7.Hide(false)
		Dead_Bothans_8.Hide(false)
		Dead_Bothans_9.Hide(false)
		Dead_Bothans_10.Hide(false)
		Dead_Bothans_11.Hide(false)
		Dead_Bothans_12.Hide(false)
		Dead_Bothans_13.Hide(false)		
					
		Start_Cinematic_Camera()
		Sleep(2)

		Set_Cinematic_Camera_Key(emperor_palpatine, 40, 5, 5, 1, emperor_palpatine, 1, 0)
		Set_Cinematic_Target_Key(emperor_palpatine, 0, 0, 20, 0, 0, 0, 0)

		Transition_Cinematic_Camera_Key(emperor_palpatine, 10, 130, 30, 30, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(emperor_Finalstop_Move_to, 3.1, 0, 0, 10, 0, 0, 0, 0)

		Fade_Screen_In(2)
		--BlockOnCommand(emperor_palpatine.Move_To(emperor_Finalstop_Move_to))
		BlockOnCommand(emperor_palpatine.Move_To(emperor_Finalstop_Move_to), 5)
		Sleep(1)

		Hide_Sub_Object(emperor_palpatine, 1, "lightsaber")

		emperor_palpatine.Play_Animation("cinematic", true, 1)
		Story_Event("LUA_EM09_START_END")

		--Sleep(3)
end

-- Called after final emperor speech is started
function State_Empire_ActIII_M09_WIN_CONDITION_01(message)

	if message == OnEnter then
		
		Sleep(2)
		
		Fade_Screen_Out(2)
		Sleep(2)
		Hide_Sub_Object(emperor_palpatine, 0, "lightsaber")
		Suspend_AI(0)
		Lock_Controls(0)
		Letter_Box_Out(0)
		End_Cinematic_Camera()
		
		Story_Event("LUA_EM09_FINISHED_END")

	end
end	

function Story_Mode_Service()

	if not flag_intialized then
		return
	end
	
	if not TestValid(building_01) and not flag_building01_dead then
		flag_building01_dead = true
	end
	
	if not TestValid(building_02) and not flag_building02_dead then
		flag_building02_dead = true
	end
	
	if not TestValid(building_03) and not flag_building03_dead then
		flag_building03_dead = true
	end
	
	if not TestValid(building_04) and not flag_building04_dead then
		flag_building04_dead = true
	end
	
	if not TestValid(building_05) and not flag_building05_dead then
		flag_building05_dead = true
	end
	
	if not TestValid(building_06) and not flag_building06_dead then
		flag_building06_dead = true
	end
	
	if not TestValid(building_07) and not flag_building07_dead then
		flag_building07_dead = true
	end
	
	if not TestValid(building_08) and not flag_building08_dead then
		flag_building08_dead = true
	end
	
	if flag_building01_dead and
		flag_building02_dead and
		flag_building03_dead and
		flag_building04_dead and
		flag_building05_dead and
		flag_building06_dead and
		flag_building07_dead and
		flag_building08_dead and
		not flag_map_revealed then
			if TestValid(emperor_palpatine) then 
				flag_map_revealed = true
				--MessageBox("revealing map")
				fog_id = FogOfWar.Reveal(imperial_player,emperor_palpatine.Get_Position(),200000,200000)
			end
	end

end

