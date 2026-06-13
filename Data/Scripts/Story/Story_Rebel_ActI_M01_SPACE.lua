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
--            $Author: Mike_Lytle $
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
		Rebel_A1_M01_Begin = State_RA01M01_Begin
		,Rebel_A01_IntroCine_Dialog_Line_01_Remove_Text = State_IntroCine_Dialog_Line_01_Remove_Text
		,Rebel_A01_IntroCine_Dialog_Line_02_Remove_Text = State_IntroCine_Dialog_Line_02_Remove_Text
		,Rebel_A01_IntroCine_Dialog_Line_03_Remove_Text = State_IntroCine_Dialog_Line_03_Remove_Text
		,Rebel_A01_IntroCine_Dialog_Line_04_Remove_Text = State_IntroCine_Dialog_Line_04_Remove_Text
		,Rebel_A01_IntroCine_Dialog_Line_05_Remove_Text = State_IntroCine_Dialog_Line_05_Remove_Text
		,Rebel_A01_IntroCine_Dialog_Line_06_Remove_Text = State_IntroCine_Dialog_Line_06_Remove_Text
		,Rebel_A1_M01_Intro_Speech_00_Remove_Text = State_Rebel_A1_M01_Intro_Speech_00_Remove_Text
		,Rebel_A1_M01_Intro_Speech_01_Remove_Text = State_Rebel_A1_M01_Intro_Speech_01_Remove_Text
		,Rebel_A1_M01_Intro_Speech_02_Remove_Text = State_Rebel_A1_M01_Intro_Speech_02_Remove_Text
		,Rebel_A1_M01_Intro_Speech_03_Remove_Text = State_Rebel_A1_M01_Intro_Speech_03_Remove_Text
		,Rebel_A1_M01_Intro_Speech_04_Remove_Text = State_Rebel_A1_M01_Intro_Speech_04_Remove_Text
		,Rebel_A01_M02_LUA_MISSION_END = State_Rebel_A01_M02_LUA_MISSION_END

		,Rebel_A1_M01_Check_Destroyed_Flag_01 = State_RA01M01_Reinforce_00
		,Rebel_A1_M01_Check_Destroyed_Flag_11 = State_RA01M01_Reinforce_01	
		,Rebel_A1_M01_Third_Speech_01 = State_Rebel_A1_M01_Third_Speech_01

		
		,Rebel_A1_M01_Give_Task_00 = State_M01_Give_Task_00
		,Rebel_A1_M01_First_Speech_00_Remove_Text = State_First_Speech_00_Remove_Text
		,Rebel_A1_M01_Give_Weaken_Enemy_Hint = State_Give_Weaken_Enemy_Hint
		--,Rebel_A1_M01_RESET_Runaway_Hint = State_M01_RESET_Runaway_Hint
		
		--new cinematic callbacks here
		,Rebel_A1_M01_Third_Speech_00 = State_Rebel_A1_M01_Third_Speech_00
		,Rebel_A1_M01_Third_Speech_00_Remove_Text = State_Rebel_A1_M01_Third_Speech_00_Remove_Text
	
	}
       
	empire_list_0 = {
		"TIE_Scout_Squadron"
		,"TIE_Scout_Squadron"
		,"TIE_Scout_Squadron"
	}
	
	empire_list_1 = {
		"TIE_Scout_Squadron"
		,"Tartan_Patrol_Cruiser_Easy"
		,"TIE_Scout_Squadron"

	}

	empire_list_2 = {
		"TIE_Scout_Squadron"
		,"TIE_Scout_Squadron"
		,"TIE_Scout_Squadron"
	}

	Sundered_Heart_Clone = {
		"Sundered_Heart_Cinematic_Clone"
	}

	PrimarySkydomeList =
	{
		"Stars_Lua_Cinematic"
	}
	
	IntroAnimationList = 
	{
		"MOV_Rebel_Cinematic_Intro"
	}	
	
	SD_list = {
		"Star_Destroyer"
	}

	tie_list = {
		"Tie_Fighter_Squadron"
		
	}

	tie_list_2 = {
		"Tie_Fighter_Squadron"
	    ,"Tie_Fighter_Squadron"	
	}

	station_reaction_list2 = {
		"Tartan_Patrol_Cruiser_Easy"
	}
	
	start_tartan_list = {
		"Tartan_Patrol_Cruiser_Easy"
	}

	station_reaction_list3 = {
		"Tartan_Patrol_Cruiser_Easy"
		,"Tie_Fighter_Squadron"
	}

	station_reaction_list4 = {
		"Tartan_Patrol_Cruiser_Easy"
		,"Tie_Fighter_Squadron"
		,"TIE_Scout_Squadron"
	}
	
	station_reaction_list5 = {
		"Tartan_Patrol_Cruiser_Easy"
		,"Tartan_Patrol_Cruiser_Easy"
		,"Tie_Fighter_Squadron"
	}
	
	station_reaction_list6 = {
		"Tartan_Patrol_Cruiser_Easy"
		,"Tie_Fighter_Squadron"
		,"TIE_Scout_Squadron"
	}
	
	antilles_weaken_enemy_effect = {
		"Antilles_Weaken_Enemy_Effect"

	} 

	marker_list = {}	
	empire_player = nil
	empire_units = nil
	antilles_enter = nil
	corvette_1 = nil
	corvette_2 = nil
	corvette_3 = nil
	corvette_4 = nil
	reveal_01 = nil
	reveal_02 = nil
	reveal_03 = nil
	reveal_04 = nil
	reveal_05 = nil
	reveal_06 = nil

	dock_sensor_dist = 1400  -- jdg was 1400, 400
	pod_sensor_dist = 800    -- jdg was 800, 200
	docks_attacked = 0
	alarm_time = 5 --was 35
	default_repeat_time = 30 -- was 55
	repeat_time_min = 30		-- minimum time for repeat reinforcements jdg was 30
	repeat_time_decrement = 5
	repeat_time = default_repeat_time
	repeat_active = false
	maximum_repeats = 2 	-- maximum times a reinforcement force will attack per dock attacked jdg was 6
	
	intro_cinematic_skipped = false
	end_cinematic_skipped = false
	mission_initialized = false;
	mission_over = false;
	current_cinematic_thread_id = nil
	
	flag_initialized = false

	--flag_start_tartans_destroyed = false
	flag_run_away_hint_given = false
	flag_cine_fuel_destroyed = false
	flag_cine_ok_to_exit = false
	
	sensor1_responded = false
	sensor2_responded = false
	sensor3_responded = false
	sensor4_responded = false
	sensor5_responded = false
	sensor6_responded = false
	sensor7_responded = false
	
	counter_run_away_hint = 0
	counter_shipyards_destroyed = 0
	
	flag_shipyard_01_destroyed = false
	flag_shipyard_02_destroyed = false
	flag_shipyard_03_destroyed = false
	flag_shipyard_04_destroyed = false
	flag_shipyard_05_destroyed = false
	flag_shipyard_06_destroyed = false
	flag_mission_over = false
	flag_shipyard01_destroyer01_destroyed = false
	flag_shipyard01_destroyer02_destroyed = false
	flag_shipyard02_destroyer01_destroyed = false
	flag_shipyard03_destroyer01_destroyed = false
	flag_shipyard04_destroyer01_destroyed = false
	
	flag_second_distress_call_made = false
	
	tartan_prox_range = 150
	
end

-- *****************************************************************************************************
-- Initial cinematic setup & play
-- *****************************************************************************************************

function State_RA01M01_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")

		Stop_All_Music()
		-- lockout player control & AI
		Suspend_AI(1)
		Lock_Controls(1)
		--MessageBox("Beginning script")

		-- Find all the reinforcement markers
		victory_enter = Find_Hint("GENERIC_MARKER_SPACE", "victoryenter")
		victory_evasive = Find_Hint("GENERIC_MARKER_SPACE", "victoryevasive")
		marker_list[0] = Find_Hint("GENERIC_MARKER_SPACE", "EMPIRE_REINFORCE_0")
		
		if not TestValid(marker_list[0]) then
			MessageBox("Couldn't find marker_list[0]")
		end
			
			
		marker_list[1] = Find_Hint("GENERIC_MARKER_SPACE", "EMPIRE_REINFORCE_1")
		marker_list[2] = Find_Hint("GENERIC_MARKER_SPACE", "EMPIRE_REINFORCE_2")
		marker_list[3] = Find_Hint("GENERIC_MARKER_SPACE", "EMPIRE_REINFORCE_3")
		marker_list[4] = Find_Hint("GENERIC_MARKER_SPACE", "EMPIRE-REINFORCE-4")
		
		
		antilles_enter = Find_Hint("GENERIC_MARKER_SPACE", "antillesenter")
		antilles_leave = Find_Hint("GENERIC_MARKER_SPACE", "antillesleave")
		corvette_1 = Find_Hint("CORELLIAN_CORVETTE", "corvette1")
		corvette_2 = Find_Hint("CORELLIAN_CORVETTE", "corvette2")
		corvette_3 = Find_Hint("CORELLIAN_CORVETTE", "corvette3")
		corvette_4 = Find_Hint("CORELLIAN_CORVETTE", "corvette4")
		
		-- Find captain antilles
		antilles = Find_First_Object("Sundered_heart")
		if not TestValid(antilles) then
			--MessageBox("Couldn't find sundered heart")
		end
		
		start_tartan01 = Find_Hint("Tartan_Patrol_Cruiser_Easy", "start-tartan01")
		start_tartan02 = Find_Hint("Tartan_Patrol_Cruiser_Easy", "start-tartan02")
		
		start_tartan01_pos = start_tartan01.Get_Position()
		start_tartan02_pos = start_tartan02.Get_Position()
		start_tartan01.Despawn()
		start_tartan02.Despawn()
		
		corvette_1.Prevent_Opportunity_Fire(true)
		corvette_2.Prevent_Opportunity_Fire(true)
		corvette_3.Prevent_Opportunity_Fire(true)
		corvette_4.Prevent_Opportunity_Fire(true)
		antilles.Prevent_Opportunity_Fire(true)
		
		rebel_player = Find_Player("Rebel")
		


		pod1 = Find_Hint("ORBITAL_CONSTRUCTION_POD", "cp1")
		pod2 = Find_Hint("ORBITAL_CONSTRUCTION_POD", "cp2")
		--pod3 = Find_Hint("ORBITAL_CONSTRUCTION_POD", "cp3")

		station_point = Find_Hint("GENERIC_MARKER_SPACE", "rnfstation")

		hide_me_table = Find_All_Objects_With_Hint("hide-me")
		for i,hide_me in pairs(hide_me_table) do
			hide_me.Hide(true)
		end 
		
		
		rebel_player = Find_Player("Rebel")
		neutral = Find_Player("Neutral")
		
		--JDG - these are the objects for the ending cine...getting initial positions then deleting
		--will then respawn for ending cinematic
		cine_platform_01 = Find_Hint("ORBITAL_CONSTRUCTION_POD","cine-platform-01")
		cine_platform_02 = Find_Hint("ORBITAL_CONSTRUCTION_POD","cine-platform-02")
		cine_platform_03 = Find_Hint("ORBITAL_CONSTRUCTION_POD","cine-platform-03")
		cine_alarm_01 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","cine-alarm-01")
		cine_alarm_02 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","cine-alarm-02")
		cine_alarm_03 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","cine-alarm-03")
		
		cine_fuel_1_1 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-1")
		cine_fuel_1_2 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-2")
		cine_fuel_1_3 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-3")
		cine_fuel_1_4 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-4")
		cine_fuel_1_5 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-5")
		cine_fuel_1_6 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-1-6")
		
		cine_fuel_2_1 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-1")
		cine_fuel_2_2 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-2")
		cine_fuel_2_3 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-3")
		cine_fuel_2_4 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-4")
		cine_fuel_2_5 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-5")
		cine_fuel_2_6 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-2-6")
		
		cine_fuel_3_1 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-1")
		cine_fuel_3_2 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-2")
		cine_fuel_3_3 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-3")
		cine_fuel_3_4 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-4")
		cine_fuel_3_5 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-5")
		cine_fuel_3_6 = Find_Hint("ORBITAL_RESOURCE_CONTAINER_HIDE","cine-fuel-3-6")
		
		cine_platform_01.Hide(true)
		cine_platform_02.Hide(true)
		cine_platform_03.Hide(true)
		cine_alarm_01.Hide(true)
		cine_alarm_02.Hide(true)
		cine_alarm_03.Hide(true)
		
		cine_fuel_1_1.Hide(true)
		cine_fuel_1_2.Hide(true)
		cine_fuel_1_3.Hide(true)
		cine_fuel_1_4.Hide(true)
		cine_fuel_1_5.Hide(true)
		cine_fuel_1_6.Hide(true)
		
		cine_fuel_2_1.Hide(true)
		cine_fuel_2_2.Hide(true)
		cine_fuel_2_3.Hide(true)
		cine_fuel_2_4.Hide(true)
		cine_fuel_2_5.Hide(true)
		cine_fuel_2_6.Hide(true)
		
		cine_fuel_3_1.Hide(true)
		cine_fuel_3_2.Hide(true)
		cine_fuel_3_3.Hide(true)
		cine_fuel_3_4.Hide(true)
		cine_fuel_3_5.Hide(true)
		cine_fuel_3_6.Hide(true)	
		
		--jdg making cargo containers NOT targets of opportunity
		cargo_table = Find_All_Objects_Of_Type("ORBITAL_RESOURCE_CONTAINER")
		destroyer_table = Find_All_Objects_Of_Type("DRYDOCK_STAR_DESTROYER_CONSTRUCTION")
		
		for i,cargo in pairs(cargo_table) do
			cargo.Prevent_Opportunity_Fire(true)
		end
		
		for i,destroyer in pairs(destroyer_table) do
			destroyer.Prevent_Opportunity_Fire(true)
		end
			
		alarm_01 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm1")
		alarm_02 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm2")
		alarm_03 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm3")
		alarm_04 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm4")
		--alarm_05 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm5") removed from map...jdg
		alarm_06 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm6")
		alarm_07 = Find_Hint("ORBITAL_SENSOR_POD_SMALL","alarm7")
		
		--defining the six shipyards here
		shipyard_01 = Find_Hint("EMPIRE_DOCK_DESTROYABLE","shipyard-01")
		shipyard_02 = Find_Hint("EMPIRE_DOCK_DESTROYABLE","shipyard-02")
		shipyard_03 = Find_Hint("EMPIRE_DOCK_DESTROYABLE","shipyard-03")
		shipyard_04 = Find_Hint("EMPIRE_DOCK_DESTROYABLE","shipyard-04")
		shipyard_05 = Find_Hint("ORBITAL_CONSTRUCTION_POD","cp1")
		shipyard_06 = Find_Hint("ORBITAL_CONSTRUCTION_POD","cp2")
		
		--preventing opportunity fire from the shipyards 
		shipyard_01.Prevent_Opportunity_Fire(true)
		shipyard_02.Prevent_Opportunity_Fire(true)
		shipyard_03.Prevent_Opportunity_Fire(true)
		shipyard_04.Prevent_Opportunity_Fire(true)
		shipyard_05.Prevent_Opportunity_Fire(true)
		shipyard_06.Prevent_Opportunity_Fire(true)
		
		shipyard01_destroyer01 = Find_Hint("DRYDOCK_STAR_DESTROYER_CONSTRUCTION","shipyard01-destroyer01")
		shipyard01_destroyer02 = Find_Hint("DRYDOCK_STAR_DESTROYER_CONSTRUCTION","shipyard01-destroyer02")
		shipyard02_destroyer01 = Find_Hint("DRYDOCK_STAR_DESTROYER_CONSTRUCTION","shipyard02-destroyer01")
		shipyard03_destroyer01 = Find_Hint("DRYDOCK_STAR_DESTROYER_CONSTRUCTION","shipyard03-destroyer01")
		shipyard04_destroyer01 = Find_Hint("DRYDOCK_STAR_DESTROYER_CONSTRUCTION","shipyard04-destroyer01")
		
		--jdg setting alarms to idle here
		alarm_table = Find_All_Objects_Of_Type("ORBITAL_SENSOR_POD_SMALL")
		for i,alarm in pairs(alarm_table) do
			alarm.Play_Animation("Idle",true)
		end

		-- Hide the models initially
		antilles.Hide(true)	
		corvette_1.Hide(true)
		corvette_2.Hide(true)
		corvette_3.Hide(true)
		corvette_4.Hide(true)
		
		-- Don't let the ships move while we are doing the cinematic opening	
		antilles.Suspend_Locomotor(true)
		corvette_1.Suspend_Locomotor(true)
		corvette_2.Suspend_Locomotor(true)
		corvette_3.Suspend_Locomotor(true)
		corvette_4.Suspend_Locomotor(true)
		
		-- Hide the real antilles
		antilles_end_position = Find_Hint("GENERIC_MARKER_SPACE", "antillesendposition")
	
		if not TestValid(antilles_end_position) then
			--MessageBox("Invalid antilles end marker")
		end
		
		-- Get the camera away from the rebel ships at the beginning to prevent hearing their engines
		Point_Camera_At(antilles_end_position)	
		
		-- **** Opening Cinematic in alternate space skydome, fudging the Fresia system in Kuat ****
		-- Find the marker for the intro cinematic and promote it to the space layer
		intro_camera_marker = Find_Hint("GENERIC_MARKER_SPACE", "introcameramarker")
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(intro_camera_marker)
		
		-- Find the marker for the skydome and promote it to the space layer
		space_cinematic_center = Find_Hint("GENERIC_MARKER_SPACE", "spacecinematiccenter")
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(space_cinematic_center)
			
		-- Find the marker for the skydome and promote it to the space layer
		space_cinematic_model = Find_Hint("GENERIC_MARKER_SPACE", "spacecinematicmodel")
		-- Promote the markers position to the layer we are doing the space cinematics in
		Promote_To_Space_Cinematic_Layer(space_cinematic_model)
			
		-- Create the space skydome at this position
			
		rebel_owner = Find_Player("Rebel")
		neutral_player = Find_Player("Neutral")
		primary_space_skydome_list = SpawnList(PrimarySkydomeList, space_cinematic_center, neutral_player, false, false)
		cinematic_skydome = primary_space_skydome_list[1]
			
		cinematic_skydome.Teleport(space_cinematic_center)
		cinematic_skydome.Face_Immediate(space_cinematic_model)
					
		Intro_Animation_List = SpawnList(IntroAnimationList, space_cinematic_model, neutral_player, false, false)
		Intro_Animation = Intro_Animation_List[1]
		Intro_Animation.Hide(true)	
		
		Set_Cinematic_Environment(true)
		Letter_Box_In(0)
		
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Intro_Cinematic")
		end
	end
end



--jdg this is a feedback from the lua hint message...reveal and flag sensors here
function State_M01_Give_Task_00(message)
	if message == OnEnter then
		--want to continue the cinematic through the task and hint message here
	
		reveal_01 = FogOfWar.Reveal(rebel_player,shipyard_01.Get_Position(),1000,1000)
		reveal_02 = FogOfWar.Reveal(rebel_player,shipyard_02.Get_Position(),1000,1000)
		reveal_03 = FogOfWar.Reveal(rebel_player,shipyard_03.Get_Position(),1000,1000)
		reveal_04 = FogOfWar.Reveal(rebel_player,shipyard_04.Get_Position(),1000,1000)
		reveal_05 = FogOfWar.Reveal(rebel_player,shipyard_05.Get_Position(),500,500)
		reveal_06 = FogOfWar.Reveal(rebel_player,shipyard_06.Get_Position(),500,500)
		
		shipyard_01.Highlight(true, 30)
		Add_Radar_Blip(shipyard_01, "somename")
		
		shipyard_02.Highlight(true, 30)
		Add_Radar_Blip(shipyard_02, "somename")
		
		shipyard_03.Highlight(true, 30)
		Add_Radar_Blip(shipyard_03, "somename")
		
		shipyard_04.Highlight(true, 30)
		Add_Radar_Blip(shipyard_04, "somename")
		
		shipyard_05.Highlight(true, 70)
		Add_Radar_Blip(shipyard_05, "somename")
		
		shipyard_06.Highlight(true, 70)
		Add_Radar_Blip(shipyard_06, "somename")
		

		
	end
end 

function State_Give_Weaken_Enemy_Hint(message)
	if message == OnEnter then
		--select antilles and flash his weaken enemy power
		
		if TestValid(antilles) then
			rebel_player.Select_Object(antilles)
		else
			MessageBox("cannot find antilles to flash his weaken enemy")
		end
	end
end  

--feedback from lua first distress message...put alarms into alarm state here. 
function State_First_Speech_00_Remove_Text(message)
	if message == OnEnter then
		--MessageBox("sensors should now be in alarm state -- function hit!!")
		corvette_1.Prevent_Opportunity_Fire(false)
		corvette_2.Prevent_Opportunity_Fire(false)
		corvette_3.Prevent_Opportunity_Fire(false)
		corvette_4.Prevent_Opportunity_Fire(false)
		antilles.Prevent_Opportunity_Fire(false)
		
		alarm_table = Find_All_Objects_Of_Type("ORBITAL_SENSOR_POD_SMALL")
		for i,alarm in pairs(alarm_table) do
			--MessageBox("sensors should now be in alarm state")
			alarm.Play_Animation("Alarm",true)
		end
		
		Alarm_Loop()
	end
end

function Alarm_Loop()
	for i,alarm in pairs(alarm_table) do
		alarm.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
	end
	Register_Timer(Alarm_Loop, 2)
end

------------------------------------------------------------------------------------------------------------------------
-- jdg Opening Cinematic stuff
------------------------------------------------------------------------------------------------------------------------


function Intro_Cinematic()

	mission_initialized = true
	
	Start_Cinematic_Camera(false)		
	Allow_Localized_SFX(false)
	Set_Cinematic_Camera_Key(intro_camera_marker, 100, -50, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(intro_camera_marker, 0, 0, -20, 0, 0, 0, 0)
	
	Fade_Screen_In(1)
	BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro"))

	-- MessageBox("Bink Movie done")
	Play_Music("Cinematic_Rebel_Intro_Music_Event_1")

	-- MessageBox("Starting Bink Movie!!!")
	BlockOnCommand(Play_Bink_Movie("Star_Wars_Intro_Rebel"))

	-- elie stuff here
	
	Intro_Animation.Teleport(space_cinematic_model)
	Intro_Animation.Face_Immediate(space_cinematic_center)
	Intro_Animation.Play_Animation("Cinematic", true, 0)
	Intro_Animation.Hide(false)
		
	-- Transition the camera down
	Transition_Cinematic_Camera_Key(intro_camera_marker, 4, 100, -15, 0, 1, 0, 0, 0)
		
	Sleep(7)

	Set_Cinematic_Camera_Key(space_cinematic_model, -30, -160, -350, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(space_cinematic_model, -5, -260, -355, 0, 0, 0, 0)

	Sleep(.5)

	Cinematic_Zoom(15,0.75)

	current_cinematic_thread_id = nil
	
	Story_Event("CUE_INTROCINE_DIALOG_REBELPILOT_01")
	-- this will start the dialog chain	
end


------------------------------------------------------------------------------------------------------------------------
-- jdg Opening Cinematic dialog done call backs
------------------------------------------------------------------------------------------------------------------------

function State_IntroCine_Dialog_Line_01_Remove_Text(message)
	if message == OnEnter then		
		
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_Dialog_01_Done")
		end	
	end
end

function Cinematic_Dialog_01_Done()

	--Sleep(1)
	current_cinematic_thread_id = nil
	Story_Event("CUE_INTROCINE_DIALOG_ANTILLES_01") 
	--Antilles: It’s not their fault.  The nationalization wasn’t announced.  The Emperor likes his surprises.
end

------------------------------------------------------------------------------------------------------------------------

function State_IntroCine_Dialog_Line_02_Remove_Text(message)
	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_Dialog_02_Done")
		end		
	end
end

function Cinematic_Dialog_02_Done()
	
	--Sleep(1)
	current_cinematic_thread_id = nil
	Story_Event("CUE_INTROCINE_DIALOG_REBELPILOT_02") 
	--Rebel Pilot: So what now?

end

------------------------------------------------------------------------------------------------------------------------


function State_IntroCine_Dialog_Line_03_Remove_Text(message)
	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_Dialog_03_Done")
		end
	end
end

function Cinematic_Dialog_03_Done()
	
	Set_Cinematic_Camera_Key(space_cinematic_model, -30, -340, -385, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(space_cinematic_model,  0, 0, -320, 0, 0, 0, 0)

	Transition_Cinematic_Camera_Key(space_cinematic_model, 15, -20, -500, -370, 0, 0, 0, 0)
	-- Cinematic_Zoom(15,1.1)

	Sleep(1)
	Story_Event("CUE_INTROCINE_DIALOG_ANTILLES_02") 
	--Antilles: If the Tyranny is here, then it’s not at its normal station…and the Tyranny is normally stationed at

end

------------------------------------------------------------------------------------------------------------------------


function State_IntroCine_Dialog_Line_04_Remove_Text(message)
	if message == OnEnter then

		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_Dialog_04_Done")
		end		
		
	end
end

function Cinematic_Dialog_04_Done()
	
	current_cinematic_thread_id = nil
	Story_Event("CUE_INTROCINE_DIALOG_REBELPILOT_03") 

end
------------------------------------------------------------------------------------------------------------------------
function State_IntroCine_Dialog_Line_05_Remove_Text(message)
	if message == OnEnter then
	
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_Dialog_05_Done")
		end		
		
	end
end

function Cinematic_Dialog_05_Done()
	
	--Sleep(1)
	current_cinematic_thread_id = nil
	Story_Event("CUE_INTROCINE_DIALOG_ANTILLES_03") 
	--Antilles: If the Tyranny is here, then it’s not at its normal station…and the Tyranny is normally stationed at…

end

------------------------------------------------------------------------------------------------------------------------
function State_IntroCine_Dialog_Line_06_Remove_Text(message)
	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Second_Intro_Cinematic")
		end	
	end
end


------------------------------------------------------------------------------------------------------------------------

function Second_Intro_Cinematic()

	-- jim Richmond stuff here

	Fade_Screen_Out(1)
	Sleep(1)
	Point_Camera_At(antilles_enter)
	Allow_Localized_SFX(true)
	-- Stop_All_Music()
	
	if TestValid(cinematic_skydome) then
		cinematic_skydome.Despawn()
	end		
	
	if TestValid(Intro_Animation) then
		Intro_Animation.Despawn()
	end		
	
	Set_Cinematic_Environment(false)	
	-- **** End of the opening cinematic, we are now in Kuat space **** 
		
	Set_Cinematic_Target_Key(antilles_enter, 25, 0, -15, 0, 0, 0, 0)
	Set_Cinematic_Camera_Key(antilles_enter, 300, 10, 212, 1, 0, 0, 0)
	
	Fade_Screen_In(1)	
	Sleep(1)
    
	corvette_1.Cinematic_Hyperspace_In(10)
	corvette_2.Cinematic_Hyperspace_In(20)
	antilles.Cinematic_Hyperspace_In(35)
	corvette_3.Cinematic_Hyperspace_In(48)
	corvette_4.Cinematic_Hyperspace_In(59)
	Sleep(1.5)
	Transition_Cinematic_Target_Key(antilles, 3, 0, 0, 0, 0, antilles, 0, 0)
	Sleep(2)
	Transition_Cinematic_Camera_Key(antilles_enter, 30, 200, 15, 60, 1, 0, 0, 0)
	
	current_cinematic_thread_id = nil
	Story_Event("RA1M1_INTRO_DIALOGUE_GO") 

end
-----------------------------------------------------------------------------------------------------------------------

function State_Rebel_A1_M01_Intro_Speech_00_Remove_Text(message)

	if message == OnEnter then
	
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_End_Antilles_Speech_1")
		end
	end

end

function Cinematic_End_Antilles_Speech_1()

	current_cinematic_thread_id = nil
	Story_Event("RA1M1_THREEPIO_DIALOGUE_GO") 

end

------------------------------------------------------------------------------------------------------------------------



function Cinematic_End_Threepio_Speech_1()

	current_cinematic_thread_id = nil
	Story_Event("RA1M1_ANTILLES_DIALOGUE_2_GO") 

end

------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A1_M01_Intro_Speech_01_Remove_Text(message)

	if message == OnEnter then
	
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_End_Threepio_Speech_1")
		end
	end

end

function Cinematic_End_Threepio_Speech_1()

	current_cinematic_thread_id = nil
	Story_Event("RA1M1_ANTILLES_DIALOGUE_2_GO") 

end

------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A1_M01_Intro_Speech_02_Remove_Text(message)

	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_End_Antilles_Speech_2")
		end
	end

end

function Cinematic_End_Antilles_Speech_2()

	current_cinematic_thread_id = nil
	Story_Event("RA1M1_R2_DIALOGUE_1_GO") 

end

------------------------------------------------------------------------------------------------------------------------



function State_Rebel_A1_M01_Intro_Speech_03_Remove_Text(message)

	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Cinematic_End_R2_Speech")
		end
	end

end

function Cinematic_End_R2_Speech()

	current_cinematic_thread_id = nil
	Story_Event("RA1M1_ANTILLES_DIALOGUE_3_GO") 

end

------------------------------------------------------------------------------------------------------------------------
function State_Rebel_A1_M01_Intro_Speech_04_Remove_Text(message)

	if message == OnEnter then
		if not intro_cinematic_skipped then		
			current_cinematic_thread_id = Create_Thread("Intro_Cinematic_End")
		end		
	end

end

function Intro_Cinematic_End()

	intro_cinematic_skipped = true
	-- Stop_All_Music()
	Resume_Mode_Based_Music()
	Point_Camera_At(antilles)
	Transition_To_Tactical_Camera(1)
	Letter_Box_Out(1)
	Sleep(1)
	Suspend_AI(0)
	Lock_Controls(0)
	Allow_Localized_SFX(true)
	End_Cinematic_Camera()

	Set_Off_Alarm()
	
	current_cinematic_thread_id = nil
	 
	flag_initialized = true
	
	hide_me_table = Find_All_Objects_With_Hint("hide-me")
	for i,hide_me in pairs(hide_me_table) do
		hide_me.Hide(false)
	end 
	
	start_tartan01 = SpawnList(start_tartan_list, start_tartan01_pos, empire, false, true)
	start_tartan02 = SpawnList(start_tartan_list, start_tartan02_pos, empire, false, true)
	
	for i,unit in pairs(start_tartan01) do
		unit.Prevent_AI_Usage(true)
		unit.Guard_Target(unit.Get_Position())
		unit.Move_To(start_tartan01_pos)
		Register_Prox(unit, Start_Tartan_Prox_Event, tartan_prox_range, rebel)
	end
	
	for i,unit in pairs(start_tartan02) do
		unit.Prevent_AI_Usage(true)
		unit.Guard_Target(unit.Get_Position())
		unit.Move_To(start_tartan02_pos)
		Register_Prox(unit, Start_Tartan_Prox_Event, tartan_prox_range, rebel)
	end

		
	Story_Event("MISSION_START") 
	

end

------------------------------------------------------------------------------------------------------------------------
function Start_Tartan_Prox_Event(prox_obj, trigger_obj)
	--MessageBox("Start_Tartan_Prox_Event")
	
	if (trigger_obj == corvette_1) or (trigger_obj == corvette_2) or (trigger_obj == corvette_3)  or (trigger_obj == corvette_4)  or (trigger_obj == antilles) then
		if TestValid(prox_obj) then
			prox_obj.Cancel_Event_Object_In_Range(Start_Tartan_Prox_Event)
		end
		
		if TestValid(start_tartan01) then
			--MessageBox("Start_Tartan_Prox_Event")
			for i,unit in pairs(start_tartan01) do
				unit.Prevent_AI_Usage(false)
				unit.Attack_Move(trigger_obj)
			end
		end
		
		if TestValid(start_tartan02) then
			for i,unit in pairs(start_tartan02) do
				unit.Prevent_AI_Usage(false)
				unit.Attack_Move(trigger_obj)
			end
		end
	end
end






function Find_Nearest_Marker()
	best_distance = 99999
	best_marker = marker_list[0]

	if TestValid(antilles) then
		for j, marker in pairs(marker_list) do
			distance = marker.Get_Distance(antilles)
			if distance < best_distance then
				best_marker = marker
				best_distance = distance
			end
		end
	end

	return best_marker
end

-- *****************************************************************************************************
-- Reinforcement groups for each time the player causes a distress call
-- *****************************************************************************************************

function State_RA01M01_Reinforce_00(message)
	if message == OnEnter then

		entry_marker = Find_Nearest_Marker()
		if not TestValid(entry_marker) then
			--MessageBox("couldn't find marker")
			return
		end
		
		ReinforceList(empire_list_0, entry_marker, empire, false, true, false, Find_And_Attack)

	end

end
						
function State_RA01M01_Reinforce_01(message)
	if message == OnEnter then

		entry_marker = Find_Nearest_Marker()
		if not TestValid(entry_marker) then
			--MessageBox("couldn't find marker")
			return
		end

		ReinforceList(empire_list_1, entry_marker, empire, false, true, false, Find_And_Attack)

	end

end

function State_Rebel_A1_M01_Third_Speech_01(message)
	if message == OnEnter then
	

		entry_marker = Find_Nearest_Marker()
		if not TestValid(entry_marker) then
			MessageBox("couldn't find marker")
			return
		end

		ReinforceList(empire_list_2, entry_marker, empire, false, true, false, Find_And_Attack)
						
	end
end   								


function Find_And_Attack(attack_list)

	-- find the closest rebel unit and have the newly reinforced units attack it!

	closest_target = Find_Nearest(entry_marker, rebel, true)
	-- MessageBox("%s is closest",tostring(closest_target))
	List_Attack(attack_list, closest_target)

end



-- *****************************************************************************************************
-- Alarm set off function when control is returned to the player (set up everything)
-- *****************************************************************************************************

function Set_Off_Alarm()

	empire = Find_Player("Empire")
	rebel = Find_Player("Rebel")
	FogOfWar.Reveal_All(empire)

	-- spawn tie groups to defend the docks
	dock1_def_list = SpawnList(tie_list_2, marker_list[0], empire, false, true)
	List_Guard(dock1_def_list, shipyard_01) 

	dock2_def_list = SpawnList(tie_list_2, marker_list[1], empire, false, true)
	List_Guard(dock2_def_list, shipyard_02)

	dock3_def_list = SpawnList(tie_list_2, marker_list[2], empire, false, true)
	List_Guard(dock3_def_list, shipyard_03)

	dock4_def_list = SpawnList(tie_list_2, marker_list[3], empire, false, true)
	List_Guard(dock4_def_list, shipyard_04)
	
	dock5_def_list = SpawnList(tie_list_2, marker_list[3], empire, false, true)
	List_Guard(dock5_def_list, shipyard_05)
	
	dock6_def_list = SpawnList(tie_list_2, marker_list[3], empire, false, true)
	List_Guard(dock6_def_list, shipyard_06)
	

	-- set prox on sensors & posd to have ties attack when approached  
	Register_Prox(shipyard_01, Enemy_Near_Dock, dock_sensor_dist, rebel)
	Register_Prox(shipyard_02, Enemy_Near_Dock, dock_sensor_dist, rebel)
	Register_Prox(shipyard_03, Enemy_Near_Dock, dock_sensor_dist, rebel)
	Register_Prox(shipyard_04, Enemy_Near_Dock, dock_sensor_dist, rebel)
	Register_Prox(shipyard_05, Enemy_Near_Dock, pod_sensor_dist, rebel)
	Register_Prox(shipyard_06, Enemy_Near_Dock, pod_sensor_dist, rebel)

end

-- *****************************************************************************************************
-- Dock proximity function to have Ties attack intruders and up the ante of constant reinforcements
-- *****************************************************************************************************

function Enemy_Near_Dock(prox_obj, trigger_obj)

	prox_obj.Cancel_Event_Object_In_Range(Enemy_Near_Dock)

	--MessageBox("Ties to attack!")

	if prox_obj == shipyard_01 and not sensor1_responded then
		sensor1_responded = true
		List_Attack(dock1_def_list, trigger_obj)
		Register_Timer(Timer_Alarm1, alarm_time)
	elseif prox_obj == shipyard_02 and not sensor2_responded then
		sensor2_responded = true
		List_Attack(dock2_def_list, trigger_obj)
		Register_Timer(Timer_Alarm2, alarm_time)
	elseif prox_obj == shipyard_03 and not sensor3_responded then
		sensor3_responded = true
		List_Attack(dock3_def_list, trigger_obj)
		Register_Timer(Timer_Alarm3, alarm_time)
	elseif prox_obj == shipyard_04 and not sensor4_responded then
		sensor4_responded = true
		List_Attack(dock4_def_list, trigger_obj)
		Register_Timer(Timer_Alarm4, alarm_time)
	elseif prox_obj == shipyard_05 and not sensor5_responded then
		sensor5_responded = true
		List_Attack(dock5_def_list, trigger_obj)
		Register_Timer(Timer_Alarm5, alarm_time)
	elseif prox_obj == shipyard_06 and not sensor6_responded then
		sensor6_responded = true
		List_Attack(dock6_def_list, trigger_obj)
		Register_Timer(Timer_Alarm6, alarm_time)
	else
		-- MessageBox("Prox fired, but from what?")
	end

end

-- *****************************************************************************************************
-- Guard and Attack functions for listed groups
-- *****************************************************************************************************

-- Have the units in a list guard the location of an object (continue to guard after the obj dies).
function List_Guard(list, obj)
	for k, unit in pairs(list) do
		if TestValid(unit) and TestValid(obj) then
			unit.Guard_Target(obj.Get_Position())
		end
	end
end

-- Have units attack an object.
function List_Attack(list, object)
	--MessageBox("attacking")
	for k, unit in pairs(list) do
		if TestValid(object) and TestValid(unit) then
			unit.Attack_Move(object)
		end
	end
end

-- *****************************************************************************************************
-- Alarm timers for each space dock
-- *****************************************************************************************************

function Timer_Alarm1()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm2()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm3()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm4()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm5()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm6()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Alarm7()

	Cancel_Timer(Timer_Repeat)
	docks_attacked = docks_attacked + 1
	repeat_time = default_repeat_time
	times_repeated = 0
	Process_DA(docks_attacked)

end

function Timer_Repeat()

	Process_DA(docks_attacked)

end

-- *****************************************************************************************************
-- Reduce reinforcement repeat time
-- *****************************************************************************************************

function repeat_process()

	times_repeated = times_repeated + 1

	if times_repeated < maximum_repeats then
		if repeat_time > repeat_time_min then
			repeat_time = repeat_time - repeat_time_decrement
		end
		Register_Timer(Timer_Repeat, repeat_time)
	end

end

-- *****************************************************************************************************
-- Process dock attack function to increase threat level over time
-- *****************************************************************************************************

function Process_DA(quan_attacked)

	if not station_point then
		MessageBox("rnfstation not found -- aborting")
		return
	end

	if not entry_marker then
		entry_marker = Find_Nearest_Marker()
	end

	if quan_attacked == 1 then

		-- 3 tie groups
		--MessageBox("first attack processed")

		tie_group1 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group1)
		repeat_process()

	elseif quan_attacked == 2 then

		-- 3 tie groups, 3 easy tartans
		--MessageBox("second attack processed")

		tie_group2 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group2)
		ReinforceList(station_reaction_list2, station_point, empire, false, true, false, Find_And_Attack)
		repeat_process()

	elseif quan_attacked == 3 then

		-- 3 tie groups, 2 tartans, 2 victory SD!
		-- MessageBox("third attack processed")

		tie_group3 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group3)
		closest_point = Find_Nearest_Marker()
		ReinforceList(station_reaction_list3, closest_point, empire, false, true, false, Find_And_Attack)
		repeat_process()

	elseif quan_attacked == 4 then

		tie_group3 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group3)
		closest_point = Find_Nearest_Marker()
		ReinforceList(station_reaction_list4, closest_point, empire, false, true, true, Find_And_Attack)

		-- MessageBox("final attack processed")
		
	elseif quan_attacked == 5 then

		tie_group3 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group3)
		closest_point = Find_Nearest_Marker()
		ReinforceList(station_reaction_list5, closest_point, empire, false, true, false, Find_And_Attack)
	
	elseif quan_attacked == 6 then

		tie_group3 = SpawnList(tie_list_2, station_point, empire, false, true)
		Sleep(1)
		Find_And_Attack(tie_group3)
		closest_point = Find_Nearest_Marker()
		ReinforceList(station_reaction_list6, closest_point, empire, false, true, false, Find_And_Attack)



	else
		--MessageBox("Error in quan: %d",quan_attacked)
	end

end

-- *****************************************************************************************************
-- Cinematic end functions
-- *****************************************************************************************************
--jdg this is the new ending cinematic  
--Imperial Officer: Kuat shipyard to all Imperial units!  
--We are under siege by significant Rebel forces!  
--All ships in the area, respond!  Emergency code zero!

function State_Rebel_A1_M01_Third_Speech_00(message)
	if message == OnEnter then
		Cancel_Fast_Forward() 
		space_station = Find_Hint("EMPIRE_STAR_BASE_3","space-station")
		if not space_station then
			MessageBox("cannot find space_station")
			return
		end
		
		--setting up cinematic stuff
		Fade_Screen_Out(1)
		Sleep(2)
		Suspend_AI(1)
		Lock_Controls(1)
		Start_Cinematic_Camera()
		Letter_Box_In(0)
		Play_Music("Space_Map_Rebel_Battle_Music_Event")
		
		--remove all the remaining mission objects
		mission_containers_list = Find_All_Objects_Of_Type("ORBITAL_RESOURCE_CONTAINER")
		mission_satellites_list = Find_All_Objects_Of_Type("DEFENSE_SATELLITE_LASER_SMALL")
		mission_docks_list = Find_All_Objects_Of_Type("EMPIRE_DOCK")
		mission_drydock_bombers_list = Find_All_Objects_Of_Type("DRYDOCK_TIE_BOMBER")
		mission_drydock_fighters_list = Find_All_Objects_Of_Type("DRYDOCK_TIE_FIGHTER")
		mission_drydock_destroyers_list = Find_All_Objects_Of_Type("DRYDOCK_STAR_DESTROYER_CONSTRUCTION")
		mission_drydock_shuttles_list = Find_All_Objects_Of_Type("DRYDOCK_TYDERIUM_SHUTTLE")
		mission_active_scouts_list = Find_All_Objects_Of_Type("TIE_Scout_Squadron")
		mission_active_fighters_list = Find_All_Objects_Of_Type("Tie_Fighter_Squadron")
		mission_active_tartans_list = Find_All_Objects_Of_Type("Tartan_Patrol_Cruiser_Easy")
		
		for i,containers in pairs(mission_containers_list) do
			containers.Despawn()
		end
		
		for i,docks in pairs(mission_docks_list) do
			docks.Despawn()
		end
		
		for i,satellites in pairs(mission_satellites_list) do
			satellites.Despawn()
		end
		
		for i,bombers in pairs(mission_drydock_bombers_list) do
			bombers.Despawn()
		end
		
		for i,fighters in pairs(mission_drydock_fighters_list) do
			fighters.Despawn()
		end
		
		for i,destroyers in pairs(mission_drydock_destroyers_list) do
			destroyers.Despawn()
		end
		
		for i,shuttles in pairs(mission_drydock_shuttles_list) do
			shuttles.Despawn()
		end
		
		for i,active_scouts in pairs(mission_active_scouts_list) do
			active_scouts.Despawn()
		end
		
		for i,active_fighters in pairs(mission_active_fighters_list) do
			active_fighters.Despawn()
		end
		
		for i,active_tartans in pairs(mission_active_tartans_list) do
			active_tartans.Despawn()
		end
		
		--now check for specific-named items for clean up  
		if TestValid(alarm_01) then
			alarm_01.Despawn()
		end
		
		if TestValid(alarm_02) then
			alarm_02.Despawn()
		end
		
		if TestValid(alarm_03) then
			alarm_03.Despawn()
		end
		
		if TestValid(alarm_04) then
			alarm_04.Despawn()
		end
		
		--if TestValid(alarm_05) then
		--	alarm_05.Despawn()
		--end
		
		if TestValid(alarm_06) then
			alarm_06.Despawn()
		end
		
		if TestValid(alarm_07) then  
			alarm_07.Despawn()
		end
		
		if TestValid(pod1) then  
			pod1.Despawn()
		end
		
		if TestValid(pod2) then  
			pod2.Despawn()
		end
		
		--if TestValid(pod3) then  
		--	pod3.Despawn()
		--end
		
		
		cine_platform_01.Hide(false)
		cine_platform_02.Hide(false)
		cine_platform_03.Hide(false)
		cine_alarm_01.Hide(false)
		cine_alarm_02.Hide(false)
		cine_alarm_03.Hide(false)
		
		cine_fuel_1_1.Hide(false)
		cine_fuel_1_2.Hide(false)
		cine_fuel_1_3.Hide(false)
		cine_fuel_1_4.Hide(false)
		cine_fuel_1_5.Hide(false)
		cine_fuel_1_6.Hide(false)
		
		cine_fuel_2_1.Hide(false)
		cine_fuel_2_2.Hide(false)
		cine_fuel_2_3.Hide(false)
		cine_fuel_2_4.Hide(false)
		cine_fuel_2_5.Hide(false)
		cine_fuel_2_6.Hide(false)
		
		cine_fuel_3_1.Hide(false)
		cine_fuel_3_2.Hide(false)
		cine_fuel_3_3.Hide(false)
		cine_fuel_3_4.Hide(false)
		cine_fuel_3_5.Hide(false)
		cine_fuel_3_6.Hide(false)
		
		--rebel_comm_array.Change_Owner(empire_player)
		
		empire_player = Find_Player("Empire")
		cine_platform_01.Change_Owner(empire_player)
		cine_platform_02.Change_Owner(empire_player)
		cine_alarm_01.Change_Owner(empire_player)
		cine_alarm_02.Change_Owner(empire_player)
		
		cine_fuel_1_1.Change_Owner(empire_player)
		cine_fuel_1_2.Change_Owner(empire_player)
		cine_fuel_1_3.Change_Owner(empire_player)
		cine_fuel_1_4.Change_Owner(empire_player)
		cine_fuel_1_5.Change_Owner(empire_player)
		cine_fuel_1_6.Change_Owner(empire_player)
		
		cine_fuel_2_1.Change_Owner(empire_player)
		cine_fuel_2_2.Change_Owner(empire_player)
		cine_fuel_2_3.Change_Owner(empire_player)
		cine_fuel_2_4.Change_Owner(empire_player)
		cine_fuel_2_5.Change_Owner(empire_player)
		cine_fuel_2_6.Change_Owner(empire_player)
		
			-- finding Antilles and Corvettes
		end_cine_antilles_start = Find_Hint("GENERIC_MARKER_SPACE","end-cine-antilles-start") 
		end_cine_corvette1_start = Find_Hint("GENERIC_MARKER_SPACE","end-cine-corvette1-start") 
		end_cine_corvette2_start = Find_Hint("GENERIC_MARKER_SPACE","end-cine-corvette2-start")
		end_cine_corvette3_start = Find_Hint("GENERIC_MARKER_SPACE","end-cine-corvette3-start")
		end_cine_corvette4_start = Find_Hint("GENERIC_MARKER_SPACE","end-cine-corvette4-start")	
		
		if TestValid(antilles) then
			antilles.Teleport_And_Face(end_cine_antilles_start)
			antilles.Make_Invulnerable(true)
		end
		
		if TestValid(corvette_1) then
			corvette_1.Teleport_And_Face(end_cine_corvette1_start)
			corvette_1.Make_Invulnerable(true)
		end
		
		if TestValid(corvette_2) then
			corvette_2.Teleport_And_Face(end_cine_corvette2_start)
			corvette_2.Make_Invulnerable(true)
		end
		
		if TestValid(corvette_3) then
			corvette_3.Teleport_And_Face(end_cine_corvette3_start)
			corvette_3.Make_Invulnerable(true)
		end
		
		if TestValid(corvette_4) then
			corvette_4.Teleport_And_Face(end_cine_corvette4_start)
			corvette_4.Make_Invulnerable(true)
		end
		
		Fade_Screen_In(1)
		
		
		--MessageBox("show the starbase here and pan around")
		Set_Cinematic_Camera_Key(space_station, 2500, -10, 0, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(space_station, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(space_station, 8, 2500, -12, 15, 1, 0, 0, 0)
		
		Sleep(6)		
		
	end
end

function State_Rebel_A1_M01_Third_Speech_00_Remove_Text(message)
	if message == OnEnter then
		Create_Thread("Antilles_Move_Thread")
	end
end  

function Antilles_Move_Thread()

	--this cues at end of "Imperial Officer: Kuat shipyard to all Imperial units!  We are under siege by significant Rebel forces!  
	--All ships in the area, respond!  Emergency code zero!"
	
	--MessageBox("end imp officer line")
	
	tyrrany_enter = Find_Hint("GENERIC_MARKER_SPACE","tyrrany-enter")
	
	if not tyrrany_enter then
		MessageBox("did not create the tyrrany_enter")
	end	

	Set_Cinematic_Camera_Key(tyrrany_enter, 1200, -35, 130, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(tyrrany_enter, 0, 0, -480, 0, 0, 0, 0)		
	
	-- Tyranny enters
	empire_player = Find_Player("Empire")
	Tyranny_List = SpawnList(SD_list, tyrrany_enter, empire_player, false, true)
	Tyranny = Tyranny_List[1]
	Tyranny.Set_Garrison_Spawn(false)
	Tyranny.Hide(true)
	Tyranny.Suspend_Locomotor(true)
	Tyranny.Cinematic_Hyperspace_In(60)
	Tyranny.Move_To(end_cine_antilles_start)
	Tyranny.Set_Single_Ability_Autofire("TRACTOR_BEAM", false)
	Tyranny.Set_Cannot_Be_Killed(true)		
	
	
	Sleep(1)

	--MessageBox("start this is tyranny line")
	Story_Event("M01_ENDCINE_TYRRANY_LINE_01_GO")
	-- Imperial Captain: This is the Tyranny.  Responding to code zero....	
	
	Sleep(1)		
	
	-- Move Antilles and Corvettes
	
	exit_spot = Find_Hint("GENERIC_MARKER_SPACE","antilles-exit")
	
	antilles.Set_Selectable(false)
	antilles.Attack_Move(Tyranny)
	antilles.Override_Max_Speed(7)
			
	if TestValid(corvette_1) then
		corvette_1.Set_Selectable(false)
		corvette_1.Attack_Move(Tyranny)
		corvette_1.Override_Max_Speed(7)
	end
	
	if TestValid(corvette_2) then
		corvette_2.Set_Selectable(false)
		corvette_2.Attack_Move(Tyranny)
		corvette_2.Override_Max_Speed(7)
	end
	
	if TestValid(corvette_3) then
		corvette_3.Set_Selectable(false)
		corvette_3.Attack_Move(Tyranny)
		corvette_3.Override_Max_Speed(7)
	end
	
	if TestValid(corvette_4) then
		corvette_4.Set_Selectable(false)
		corvette_4.Attack_Move(Tyranny)
		corvette_4.Override_Max_Speed(7)
	end	
	
	Sleep(1)
	
	
	--MessageBox("shot01")
	
	--Set_Cinematic_Camera_Key(end_cine_antilles_start, 0, 0, -55, 0, 0, 0, 0)
	--Set_Cinematic_Target_Key(Tyranny, 0, 0, 0, 0, Tyranny, 0, 0)
	
	Tyranny.Override_Max_Speed(4)
	Tyranny.Move_To(cine_fuel_2_4)
	
	Sleep(2)
				
	--MessageBox("shot02")
	
	Set_Cinematic_Camera_Key(antilles, 300, -5, 180, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(antilles, 0, 0, 0, 0, antilles, 0, 0)
	
	Sleep(6)
	
	--MessageBox("shot03")
	Set_Cinematic_Camera_Key(Tyranny, 250, -30, 150, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(antilles, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(3)			
	
		
	--MessageBox("shot04")
	
	Set_Cinematic_Camera_Key(antilles, 500, 20, 90, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(Tyranny, 0, 0, 0, 0, 0, 0, 0)
	Cinematic_Zoom(5, .9)
		
	Sleep(2)		

	antilles.Attack_Move(cine_fuel_2_4)
	
	Sleep(1)
	
	if TestValid(cine_fuel_2_4) then
		cine_fuel_2_4.Take_Damage(10000)
	end	
	
	flag_cine_ok_to_exit = true
	--MessageBox("Ok to exit flag set to true!!!")
		
end  


-- Escape for the intro 

function Story_Handle_Esc()

	if mission_initialized == true then 

		if intro_cinematic_skipped == false then

			intro_cinematic_skipped = true	
			-- MessageBox("Escape Key Pressed!!!")
			Fade_Screen_Out(0)
			Stop_All_Music()
			Stop_All_Speech()
			Remove_All_Text()
			
			if current_cinematic_thread_id ~= nil then
				Thread.Kill(current_cinematic_thread_id)
			end
			
			Stop_Bink_Movie()
			
			if TestValid(cinematic_skydome) then
				cinematic_skydome.Despawn()
			end		
		
			if TestValid(Intro_Animation) then
				Intro_Animation.Despawn()
			end		
			
			antilles.Cancel_Hyperspace()
			corvette_1.Cancel_Hyperspace()
			corvette_2.Cancel_Hyperspace()
			corvette_3.Cancel_Hyperspace()
			corvette_4.Cancel_Hyperspace()
			
			-- Don't let the ships move while we are doing the cinematic opening	
			antilles.Suspend_Locomotor(false)
			corvette_1.Suspend_Locomotor(false)
			corvette_2.Suspend_Locomotor(false)
			corvette_3.Suspend_Locomotor(false)
			corvette_4.Suspend_Locomotor(false)
				
			-- Hide the models initially
			antilles.Hide(false)	
			corvette_1.Hide(false)
			corvette_2.Hide(false)
			corvette_3.Hide(false)
			corvette_4.Hide(false)
			
			Resume_Mode_Based_Music()
			
			Letter_Box_Out(0)
			Point_Camera_At(antilles)
			Lock_Controls(0)
			Suspend_AI(0)
			Allow_Localized_SFX(true)
			Set_Cinematic_Environment(false)	
			End_Cinematic_Camera()
			
             Fade_Screen_In_After_Esc()
			-- MLL: Creating a thread, causes a problem if the game is saved.
			--Create_Thread("Fade_Screen_In_After_Esc")

		end		
		
	end		
	
end


function Fade_Screen_In_After_Esc()

	Fade_Screen_In(1)
    -- MLL: Don't sleep since this is no longer a thread.
	--Sleep(1)	
	Set_Off_Alarm()	
	flag_initialized = true
	
	hide_me_table = Find_All_Objects_With_Hint("hide-me")
	for i,hide_me in pairs(hide_me_table) do
		hide_me.Hide(false)
	end 
	
	start_tartan01 = SpawnList(start_tartan_list, start_tartan01_pos, empire, false, true)
	start_tartan02 = SpawnList(start_tartan_list, start_tartan02_pos, empire, false, true)
	
	for i,unit in pairs(start_tartan01) do
		unit.Prevent_AI_Usage(true)
		unit.Guard_Target(unit.Get_Position())
		unit.Move_To(start_tartan01_pos)
		Register_Prox(unit, Start_Tartan_Prox_Event, tartan_prox_range, rebel)
	end
	
	for i,unit in pairs(start_tartan02) do
		unit.Prevent_AI_Usage(true)
		unit.Guard_Target(unit.Get_Position())
		unit.Move_To(start_tartan02_pos)
		Register_Prox(unit, Start_Tartan_Prox_Event, tartan_prox_range, rebel)
	end
	
	Story_Event("MISSION_START") 
end

function end_cinematic_call()
	Sleep(3)
	Fade_Screen_Out(1)
	Sleep(1)
	--MessageBox("calling end cinematic function")
	End_Cinematic_Camera()
end

-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()

	if not flag_initialized then
		return
	end 
	
	if flag_cine_ok_to_exit and not flag_cine_fuel_destroyed then
		flag_cine_fuel_destroyed = true
		
		Tyranny.Take_Damage(100000, "HP_Star_Destroyer_Weapon_FL")
				
		Sleep(.3)
		Tyranny.Take_Damage(100000, "HP_Star_Destroyer_Weapon_FR")
		Sleep(.2)
		Tyranny.Take_Damage(100000, "HP_Star_Destroyer_Tractor_Beam")
		
		
		antilles.Attack_Move(exit_spot)
		Sleep(.25)
		
		if TestValid(corvette_1) then
			corvette_1.Attack_Move(exit_spot)
			Sleep(.25)
		end
		
		if TestValid(corvette_2) then
			corvette_2.Attack_Move(exit_spot)
			Sleep(.1)
		end
		
		if TestValid(corvette_3) then
			corvette_3.Attack_Move(exit_spot)
			
		end
		
		if TestValid(corvette_4) then
			corvette_4.Attack_Move(exit_spot)
			Sleep(.2)
		end
				
		Story_Event("LUA_MISSION_END")
					
		if TestValid(corvette_1) then
			--MessageBox("corvette 1 hyperspace away here")
			corvette_1.Hyperspace_Away()
			Sleep(0.25)
		end
		
		if TestValid(corvette_2) then
			corvette_2.Hyperspace_Away()
			Sleep(0.15)
		end
		
		if TestValid(corvette_3) then
			corvette_3.Hyperspace_Away()
			Sleep(0.25)
		end
		
		if TestValid(corvette_4) then
			corvette_4.Hyperspace_Away()
			--Sleep(0.5)
		end	
		
		antilles.Hyperspace_Away()		
	
		Sleep(2)
		Create_Thread("end_cinematic_call")
		-- This is the end of final cini . ELIE
	end
	
	--JDG check when various shipyards are destroyed
	if not TestValid(shipyard_01) and not flag_shipyard_01_destroyed then
		flag_shipyard_01_destroyed = true
		reveal_01.Undo_Reveal()
		--MessageBox("flag_shipyard_01_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if not TestValid(shipyard_02) and not flag_shipyard_02_destroyed then
		flag_shipyard_02_destroyed = true
		reveal_02.Undo_Reveal()
		--MessageBox("flag_shipyard_02_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if not TestValid(shipyard_03) and not flag_shipyard_03_destroyed then
		flag_shipyard_03_destroyed = true
		reveal_03.Undo_Reveal()
		--MessageBox("flag_shipyard_03_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if not TestValid(shipyard_04) and not flag_shipyard_04_destroyed then
		flag_shipyard_04_destroyed = true
		reveal_04.Undo_Reveal()
		--MessageBox("flag_shipyard_04_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if not TestValid(shipyard_05) and not flag_shipyard_05_destroyed then
		flag_shipyard_05_destroyed = true
		reveal_05.Undo_Reveal()
		--MessageBox("flag_shipyard_05_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if not TestValid(shipyard_06) and not flag_shipyard_06_destroyed then
		flag_shipyard_06_destroyed = true
		reveal_06.Undo_Reveal()
		--MessageBox("flag_shipyard_06_destroyed = true")
		counter_shipyards_destroyed = counter_shipyards_destroyed + 1
	end
	
	if counter_shipyards_destroyed == 3 and not flag_second_distress_call_made then
		flag_second_distress_call_made = true
		Story_Event("M01_CUE_SECOND_DISTRESS_CALL")
	end
	
	--JDG check for new win condition
	if flag_shipyard_01_destroyed and
		flag_shipyard_02_destroyed and
		flag_shipyard_03_destroyed and
		flag_shipyard_04_destroyed and
		flag_shipyard_05_destroyed and
		flag_shipyard_06_destroyed and 
		not flag_mission_over then
		
		flag_mission_over = true
		Story_Event("M01_CUE_ENDING_CINE_GO")
		--MessageBox("M01_CUE_ENDING_CINE_GO")
	end
	
	if not flag_run_away_hint_given then
		if TestValid(corvette_1) and (corvette_1.Get_Shield() < .5) then
			flag_run_away_hint_given = true 
			rebel_player.Select_Object(corvette_1)
			Story_Event("M01_RUNAWAY_HINT_GO") 
		end
		
		if TestValid(corvette_2) and (corvette_2.Get_Shield() < .5) then
			flag_run_away_hint_given = true 
			rebel_player.Select_Object(corvette_2)
			Story_Event("M01_RUNAWAY_HINT_GO") 
		end
		
		if TestValid(corvette_3) and (corvette_3.Get_Shield() < .5) then
			flag_run_away_hint_given = true 
			rebel_player.Select_Object(corvette_3)
			Story_Event("M01_RUNAWAY_HINT_GO") 
		end
		
		if TestValid(corvette_4) and (corvette_4.Get_Shield() < .5) then
			flag_run_away_hint_given = true 
			rebel_player.Select_Object(corvette_4)
			Story_Event("M01_RUNAWAY_HINT_GO") 
		end
		
		if TestValid(antilles) and (antilles.Get_Shield() < .5) then
			flag_run_away_hint_given = true 
			rebel_player.Select_Object(antilles)
			Story_Event("M01_RUNAWAY_HINT_GO") 
		end
		
	end
	
	--jdg forcing docks destruction when destroyers are killed
	if  not TestValid(shipyard01_destroyer01)and 
		not TestValid(shipyard01_destroyer02)and 
		not flag_shipyard01_destroyer01_destroyed and 
		not flag_shipyard01_destroyer02_destroyed and 
		 not flag_shipyard_01_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard_01)
		 --MessageBox("killing shipyard 1")
		 --shipyard_01.Take_Damage(10000) 
		 flag_shipyard01_destroyer01_destroyed = true
		 flag_shipyard01_destroyer02_destroyed = true
		 flag_shipyard_01_destroyed = true
	end
	
	if  not TestValid(shipyard02_destroyer01)and 
		not flag_shipyard02_destroyer01_destroyed and 
		 not flag_shipyard_02_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard_02)
		 --MessageBox("killing shipyard 2")
		 --shipyard_02.Take_Damage(10000) 
		 flag_shipyard02_destroyer01_destroyed = true
		 flag_shipyard_02_destroyed = true
	end
	
	if  not TestValid(shipyard03_destroyer01)and 
		not flag_shipyard03_destroyer01_destroyed and 
		 not flag_shipyard_03_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard_03)
		 --MessageBox("killing shipyard 3")
		 --shipyard_03.Take_Damage(10000) 
		 flag_shipyard03_destroyer01_destroyed = true
		 flag_shipyard_03_destroyed = true
	end
	
	if  not TestValid(shipyard04_destroyer01)and 
		not flag_shipyard04_destroyer01_destroyed and 
		 not flag_shipyard_04_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard_04)
		 --MessageBox("killing shipyard 4")
		 --shipyard_04.Take_Damage(10000) 
		 flag_shipyard04_destroyer01_destroyed = true
		 flag_shipyard_04_destroyed = true
	end
	
	--jdg forcing destroyer destruction if/when docks are killed
	if  TestValid(shipyard01_destroyer01)and 
		flag_shipyard_01_destroyed and 
		not flag_shipyard01_destroyer01_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard01_destroyer01)
		 --MessageBox("killing destroyer 1-1")
		 --shipyard01_destroyer01.Take_Damage(10000) 
		 flag_shipyard01_destroyer01_destroyed = true

	end
	
	if  TestValid(shipyard01_destroyer02)and 
		flag_shipyard_01_destroyed and 
		not flag_shipyard01_destroyer02_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard01_destroyer02)
		 --MessageBox("killing destroyer 1-2")
		 --shipyard01_destroyer02.Take_Damage(10000) 
		 flag_shipyard01_destroyer02_destroyed = true

	end
	
	if  TestValid(shipyard02_destroyer01)and 
		not flag_shipyard02_destroyer01_destroyed and 
		  flag_shipyard_02_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard02_destroyer01)
		 --MessageBox("killing destroyer 2-1")
		 --shipyard02_destroyer01.Take_Damage(10000) 
		 flag_shipyard02_destroyer01_destroyed = true
	end
	
	if  TestValid(shipyard03_destroyer01)and 
		not flag_shipyard03_destroyer01_destroyed and 
		  flag_shipyard_03_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard03_destroyer01)
		 --MessageBox("killing destroyer 3-1")
		 --shipyard03_destroyer01.Take_Damage(10000) 
		 flag_shipyard03_destroyer01_destroyed = true
	end
	
	if  TestValid(shipyard04_destroyer01)and 
		not flag_shipyard04_destroyer01_destroyed and 
		  flag_shipyard_04_destroyed then
		 
		 Create_Thread("Kill_Me_On_Delay", shipyard04_destroyer01)
		 --MessageBox("killing destroyer 4-1")
		 --shipyard04_destroyer01.Take_Damage(10000) 
		 flag_shipyard04_destroyer01_destroyed = true
	end
	
	
end
	
function Kill_Me_On_Delay(obj)
	Sleep(.5)
	obj.Take_Damage(10000) 
end


