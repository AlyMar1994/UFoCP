-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M03_SPACE.lua#55 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M03_SPACE.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36118 $
--
--          $DateTime: 2006/01/09 11:17:25 $
--
--          $Revision: #55 $
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
		Empire_M03_Begin = State_Empire_M03_Begin
		,Empire_A01M03_Intro_Fett_TEXT = State_Empire_A01M03_Intro_Fett_TEXT
		,Empire_A01M03_Intro_Officer_TEXT = State_Empire_A01M03_Intro_Officer_TEXT
		,Empire_M2_Pirate_Base_is_Dead = State_M2_Pirate_Base_is_Dead
		,Empire_M03_Final_Dialog_Begin_00 = State_Empire_M03_Final_Dialog_Begin_00
		,Empire_A01M03_Final_Fett_TEXT = State_Empire_A01M03_Final_Fett_TEXT
		,Empire_A01M03_Final_Fett_END = State_Empire_A01M03_Final_Fett_END
		,Empire_A01M03_Final_Officer_TEXT = State_Empire_A01M03_Final_Officer_TEXT
		,Empire_A01M03_Final_Officer_END = State_Empire_A01M03_Final_Officer_END
		,Empire_A01M03_TASK_Use_Fett_Against_Sensors = State_TASK_Use_Fett_Against_Sensors
		,Empire_M03_HINT_Use_Seismic_Charge = State_HINT_Use_Seismic_Charge
		,Empire_A01M03_Sat_Destroyed_Dialog_00_Remove_Text = State_Sat_Destroyed_Dialog_Remove_Text
	}
	
	pirate_type_list0 = {
		"Pirate_Fighter_Squadron"
	}
	
	pirate_type_list1 = {
		"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
	}

	pirate_type_list2 = {
		"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
	}
	
	pirate_type_list3 = {
		"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"Pirate_Fighter_Squadron"
		,"IPV1_System_Patrol_Craft"
		,"IPV1_System_Patrol_Craft"
		,"IPV1_System_Patrol_Craft"
	}

	pirate_captain_type = {
		"Pirate_Frigate_Leader"
	}
	
	
	break_patrol = false
	sensor_range = 600
	base_warning_range = 2000
	base_alarm_range = 1000
	patrol_aggro_range = 400
	countdown_underway = false
	alarm_active = false
	alarm_time = 10
	captain_disabled = false
	initial_units_spawned = false
	num_probes_triggered = 0
	sensors_down = false
	captain_found = false
	captain_start_range = 600
	sensor01_flagged = false
	sensor02_flagged = false
	sensor03_flagged = false
	sensor04_flagged = false
	sensor05_flagged = false
	sensor06_flagged = false
	sensor07_flagged = false
	sensor01_destroyed = false
	sensor02_destroyed = false
	sensor03_destroyed = false
	sensor04_destroyed = false
	sensor05_destroyed = false
	sensor06_destroyed = false
	sensor07_destroyed = false
	number_of_sensors_destroyed = 0
	guard_loc_1 = 1
	guard_loc_2 = 2
	guard_loc_3 = 3
	guard_loc_4 = 4
	guard_loc_5 = 5
	guard_loc_6 = 6
	guard_loc_7 = 7
	
	flag_fett_successful = false
	flag_pirate_base_dead = false
	flag_hardpoint_speech_given = false
	flag_spot_01_filled = false
	flag_spot_02_filled = false
	flag_spot_03_filled = false
	
	-- For memory pool cleanup hints
	enemy = nil
	unit = nil
	fog_id = nil
	fog_id2 = nil

end

-- Have the units in a list guard the location of an object (continue to guard after the obj dies).
function List_Guard(list, obj)
	for k, unit in pairs(list) do
		if TestValid(unit) then
			unit.Attack_Move(obj.Get_Position())
		end
	end
end

-- Have units attack an object.
function List_Attack(list, object)
	--MessageBox("attacking")
	for k, unit in pairs(list) do
		if TestValid(object) then
			unit.Attack_Move(object)
		end
	end
end


	

function State_Empire_M03_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		
		-- MessageBox("OnEnter State_Empire_M03_Begin")
		
		-- Lock out controls for intro cinematic

		Suspend_AI(1)
		Lock_Controls(1)
		Letter_Box_In(0)

		-- Locate Boba Fett's ship
		fett = Find_First_Object("Slave_I")
		if not fett then
			--MessageBox("Can't find Boba Fett! Aborting!")
			return
		end

		fettfly2 = Find_Hint("GENERIC_MARKER_SPACE", "fettflyto2")
		fettfly3 = Find_Hint("GENERIC_MARKER_SPACE", "fettflyto3")
		pirate_base = Find_First_Object("PIRATE_ASTEROID_BASE_WEAK")
		
		--prevent pirate base shooting at fett until alarm is raised
		pirate_base.Prevent_All_Fire(true)

		Create_Thread("Intro_Cinematic")

		-- Find the various alarm triggers
        alarm1 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor1")
		alarm2 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor2")
		alarm3 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor3")
		alarm4 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor4")
		alarm5 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor5")
		alarm6 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor6")
		alarm7 = Find_Hint("Orbital_Sensor_Pod_Pirate", "sensor7")
		retreat1 = Find_Hint("GENERIC_MARKER_SPACE", "1")
		retreat2 = Find_Hint("GENERIC_MARKER_SPACE", "2")
		retreat3 = Find_Hint("GENERIC_MARKER_SPACE", "3")
		--captainspawn = (Find_Hint("GENERIC_MARKER_SPACE", "leaderspawn")).Get_Position()
		captainspawn = pirate_base.Get_Position()
		captainflyto = Find_Hint("GENERIC_MARKER_SPACE", "leaderflyto")
		patrol_01 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol1")).Get_Position()
		patrol_02 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol2")).Get_Position()
		patrol_03 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol3")).Get_Position()
		patrol_04 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol4")).Get_Position()
		patrol_05 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol5")).Get_Position()
		patrol_06 = (Find_Hint("GENERIC_MARKER_SPACE", "patrol6")).Get_Position()
		
		cinematic_fett_start = Find_Hint("GENERIC_MARKER_SPACE", "cinematicfettstart")
		cinematic_fett_end = Find_Hint("GENERIC_MARKER_SPACE", "cinematicfettend")
		cinematic_pirate_start = Find_Hint("GENERIC_MARKER_SPACE", "cinematicpiratestart")
		cinematic_pirate_end = Find_Hint("GENERIC_MARKER_SPACE", "cinematicpirateend")
		cinematic_acclamator_start = Find_Hint("GENERIC_MARKER_SPACE", "cinematicacclamatorstart")
		cinematic_acclamator_end = Find_Hint("GENERIC_MARKER_SPACE", "cinematicacclamatorend")

		if not alarm1 or not alarm2 or not alarm3 or not alarm4 or not alarm5 or not alarm6 or not alarm7 or not retreat1 or not retreat2 or not retreat3 or not pirate_base or not captainspawn or not captainflyto then
			--MessageBox("missing expected objects; aborting")
			return
		else

			-- Find the players
			pirates = Find_Player("Pirates")
			empire = Find_Player("Empire")
			
			-- Set up death callbacks.
			Register_Death_Event(alarm1, Sensor_Destroyed)
			Register_Death_Event(alarm2, Sensor_Destroyed)
			Register_Death_Event(alarm3, Sensor_Destroyed)
			Register_Death_Event(alarm4, Sensor_Destroyed)
			Register_Death_Event(alarm5, Sensor_Destroyed)
			Register_Death_Event(alarm6, Sensor_Destroyed)
			Register_Death_Event(alarm7, Sensor_Destroyed)
			
			-- Set up proximities for each alarm.
			Register_Prox(alarm1, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm2, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm3, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm4, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm5, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm6, Prox_Sensor_Response, sensor_range, empire)
			Register_Prox(alarm7, Prox_Sensor_Response, sensor_range, empire)
			
			-- Add a warning and an alarm-trigger prox for the main base
			Register_Prox(pirate_base, Prox_Base_Warning, base_warning_range, empire)
			Register_Prox(pirate_base, Prox_Base_Alarm, base_alarm_range, empire)
		end

		-- Spawn some non-AI pirates to guard each
		sat1guards_list = SpawnList(pirate_type_list1, alarm1, pirates, false, true)
		List_Guard(sat1guards_list, alarm1)
		sat2guards_list = SpawnList(pirate_type_list1, alarm2, pirates, false, true)
		List_Guard(sat2guards_list, alarm2)
		sat3guards_list = SpawnList(pirate_type_list1, alarm3, pirates, false, true)
		List_Guard(sat3guards_list, alarm3)
		sat4guards_list = SpawnList(pirate_type_list1, alarm4, pirates, false, true)
		List_Guard(sat4guards_list, alarm4)
		sat5guards_list = SpawnList(pirate_type_list1, alarm1, pirates, false, true)
		List_Guard(sat5guards_list, alarm5)
		sat6guards_list = SpawnList(pirate_type_list1, alarm1, pirates, false, true)
		List_Guard(sat6guards_list, alarm6)
		sat7guards_list = SpawnList(pirate_type_list1, alarm7, pirates, false, true)
		List_Guard(sat7guards_list, alarm7)
		
		-- dme 9/21/05 Spawn the patrol units
		patrol1_list = SpawnList(pirate_type_list0, patrol_02, pirates, false, true)
		patrol_group1 = patrol1_list[1]
		patrol2_list = SpawnList(pirate_type_list0, patrol_04, pirates, false, true)
		patrol_group2 = patrol2_list[1]
		patrol3_list = SpawnList(pirate_type_list0, patrol_04, pirates, false, true)
		patrol_group3 = patrol3_list[1]
		
				
		initial_units_spawned = true
		
		--jdg 8/23/05 putting sensors into idle anim here
		alarm1.Play_Animation("Idle",true)
		alarm2.Play_Animation("Idle",true)
		alarm3.Play_Animation("Idle",true)
		alarm4.Play_Animation("Idle",true)
		alarm5.Play_Animation("Idle",true)
		alarm6.Play_Animation("Idle",true)
		alarm7.Play_Animation("Idle",true)
		
		if TestValid(patrol_group1) then		
			Create_Thread("Move_patrol_group_01")
		end
		
		if TestValid(patrol_group1) then		
			Create_Thread("Move_patrol_group_02")
		end
		
		if TestValid(patrol_group1) then		
			Create_Thread("Move_patrol_group_03")
		end

	end
end

--jdg delaying reinforcement hint/flashing until after Fetts line 
function State_Sat_Destroyed_Dialog_Remove_Text(message)
	if message == OnEnter then
		Story_Event("ENABLE_REINFORCEMENTS")
	end
end


-- dme 9/22/05 Pirate Group Management
function Guard_Management (Old_Sensor_Loc, New_Sensor_Loc)
	if guard_loc_1 == Old_Sensor_Loc then
		guard_loc_1 = New_Sensor_Loc
	end	
	if guard_loc_2 == Old_Sensor_Loc then
		guard_loc_2 = New_Sensor_Loc
	end	
	if guard_loc_3 == Old_Sensor_Loc then
		guard_loc_3 = New_Sensor_Loc
	end	
	if guard_loc_4 == Old_Sensor_Loc then
		guard_loc_4 = New_Sensor_Loc
	end	
	if guard_loc_5 == Old_Sensor_Loc then
		guard_loc_5 = New_Sensor_Loc
	end	
	if guard_loc_6 == Old_Sensor_Loc then
		guard_loc_6 = New_Sensor_Loc
	end	
	if guard_loc_7 == Old_Sensor_Loc then
		guard_loc_7 = New_Sensor_Loc
	end
end

-- dme 9/22/05 Find closest sensor
	
function Get_Closest_Sensor (Old_Sensor)
	if Old_Sensor == 1 then
		if TestValid(alarm5)
			then return 5
		elseif TestValid(alarm6)
			then return 6
		elseif TestValid(alarm7)
			then return 7
		elseif TestValid(alarm3)
			then return 3
		elseif TestValid(alarm4)
			then return 4
		elseif TestValid(alarm2)
			then return 2
		else return 8
		end
	end
	
	if Old_Sensor == 2 then
		if TestValid(alarm4)
			then return 4
		elseif TestValid(alarm3)
			then return 3
		elseif TestValid(alarm7)
			then return 7
		elseif TestValid(alarm5)
			then return 5
		elseif TestValid(alarm1)
			then return 1
		elseif TestValid(alarm6)
			then return 6
		else return 8
		end
	end
	
	if Old_Sensor == 3 then
		if TestValid(alarm4)
			then return 4
		elseif TestValid(alarm2)
			then return 2
		elseif TestValid(alarm5)
			then return 5
		elseif TestValid(alarm1)
			then return 1
		elseif TestValid(alarm7)
			then return 7
		elseif TestValid(alarm6)
			then return 6
		else return 8
		end
	end
	
	if Old_Sensor == 4 then
		if TestValid(alarm3)
			then return 3
		elseif TestValid(alarm2)
			then return 2
		elseif TestValid(alarm5)
			then return 5
		elseif TestValid(alarm1)
			then return 1
		elseif TestValid(alarm7)
			then return 7
		elseif TestValid(alarm6)
			then return 6
		else return 8
		end
	end
	
	if Old_Sensor == 5 then
		if TestValid(alarm1)
			then return 1
		elseif TestValid(alarm3)
			then return 3
		elseif TestValid(alarm4)
			then return 4
		elseif TestValid(alarm6)
			then return 6
		elseif TestValid(alarm7)
			then return 7
		elseif TestValid(alarm2)
			then return 2
		else return 8
		end
	end
	
	if Old_Sensor == 6 then
		if TestValid(alarm7)
			then return 7
		elseif TestValid(alarm1)
			then return 1
		elseif TestValid(alarm5)
			then return 5
		elseif TestValid(alarm4)
			then return 4
		elseif TestValid(alarm3)
			then return 3
		elseif TestValid(alarm2)
			then return 2
		else return 8
		end
	end
	
	if Old_Sensor == 7 then
		if TestValid(alarm6)
			then return 6
		elseif TestValid(alarm1)
			then return 1
		elseif TestValid(alarm4)
			then return 4
		elseif TestValid(alarm3)
			then return 3
		elseif TestValid(alarm5)
			then return 5
		elseif TestValid(alarm2)
			then return 2
		else return 8
		end
	end
end
	
--jdg flagging the sensors at initial task message here
function State_TASK_Use_Fett_Against_Sensors(message)
	if message == OnEnter then
	
		if TestValid(alarm1) then
			alarm1.Highlight(true)
			Add_Radar_Blip(alarm1, "blip_alarm1")
		end
		
		if TestValid(alarm2) then
			alarm2.Highlight(true)
			Add_Radar_Blip(alarm2, "blip_alarm2")
		end
		
		if TestValid(alarm3) then
			alarm3.Highlight(true)
			Add_Radar_Blip(alarm3, "blip_alarm3")
		end
		
		if TestValid(alarm4) then
			alarm4.Highlight(true)
			Add_Radar_Blip(alarm4, "blip_alarm4")
		end
		
		if TestValid(alarm5) then
			alarm5.Highlight(true)
			Add_Radar_Blip(alarm5, "blip_alarm5")
		end
		
		if TestValid(alarm6) then
			alarm6.Highlight(true)
			Add_Radar_Blip(alarm6, "blip_alarm6")
		end
		
		if TestValid(alarm7) then
			alarm7.Highlight(true)
			Add_Radar_Blip(alarm7, "blip_alarm7")
		end
	end
end  


--jdg auto-select fett for button flash in XML 
function State_HINT_Use_Seismic_Charge(message)
	if message == OnEnter then
		--select fett so we can flash his force push icon thingy
		if TestValid(fett) then
			empire.Select_Object(fett)
		end
	end
end

function Intro_Cinematic()

	-- intro cine function
	Point_Camera_At(fettfly3)
	Start_Cinematic_Camera()
	Resume_Mode_Based_Music()
	
	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	-- Set_Cinematic_Camera_Key(alarm2, 1925, 3, 92, 1, 0, 0, 0)
	Set_Cinematic_Camera_Key(alarm2, 1940, 0, 91.95, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(fett, -15.0, 0, -10, 0, fett, 0, 0)
	--Transition_Cinematic_Camera_Key(alarm2, 6, 1925, 1, 92, 1, 0, 0, 0)
	-- Transition_Cinematic_Camera_Key(alarm2, 6, 1925, 0, 92, 1, 0, 0, 0)
	-- Transition_Cinematic_Camera_Key(alarm2, 6, 1925, -.5, 92, 1, 0, 0, 0)
	
	fett.Teleport_And_Face(fettfly3)
	
	
	--BlockOnCommand(fett.Turn_To_Face(fettfly3))	
	Fade_Screen_In(1)	
	fett.Cinematic_Hyperspace_In(30)
	--BlockOnCommand(fett.Move_To(fettfly3))	
	
	fett.Move_To(fettfly2)
	Sleep(2)
	fett.Play_Cinematic_Engine_Flyby()
	Sleep(3)
	Transition_Cinematic_Target_Key(alarm2, 4, 0, -40, 0, 0, fett, 0, 0)
	Sleep(3)
	Story_Event("M2_INTRO_DIALOGUE_GO")

end

-- Fett dialogue catch

function State_Empire_A01M03_Intro_Fett_TEXT(message)
	
	if message == OnEnter then
	
		Sleep(2)
		Set_Cinematic_Camera_Key(alarm2, 750, 10, 92, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(alarm2, 0, 0, 0, 0, alarm2, 0, 0)
		Transition_Cinematic_Camera_Key(alarm2, 10, 500, 10, 97, 1, 0, 0, 0)
		Sleep(2)
		--jdg huh? no need for this wacky kluge.
		--Story_Event("LUA_FETT_SPEECH_HANDLED")
	end
end

function State_Empire_A01M03_Intro_Officer_TEXT(message)

	if message == OnEnter then
		Sleep(2)
		--Set_Cinematic_Camera_Key(alarm2, 1925, 1, 92, 1, 0, 0, 0)
		Set_Cinematic_Camera_Key(alarm2, 1925, 0, 92, 1, 0, 0, 0)
		--Set_Cinematic_Target_Key(fett, 0, -50, 0, 0, fett, 0, 0)
		Set_Cinematic_Target_Key(alarm2, 0, -50, 0, 0, fett, 0, 0)
		Sleep(2)
		Transition_To_Tactical_Camera(2)
		Sleep(1)
		End_Cinematic_Camera()
		Letter_Box_Out(.5)	
		Lock_Controls(0)
		Suspend_AI(0)
	end
end


		

-- Start the alarm countdown and make sure that the timer can't be reset.
function Prox_Sensor_Response(prox_obj, trigger_obj)
	--MessageBox("%s-- prox_obj type: %s trigger_obj type: %s", tostring(Script), tostring(prox_obj), tostring(trigger_obj))
	
	-- Cancel the object in range event from signaling anymore.
	-- A probe detection always results in the probe being destroyed or the alarm going off (unreversable).
	prox_obj.Cancel_Event_Object_In_Range(Prox_Sensor_Response)
	
	if (trigger_obj.Get_Type() == Find_Object_Type("Slave_I")) then

		--Boba Fett has an opportunity to destroy the timer before it goes off.
		--MessageBox("Disarm countdown Triggered! ...user feedback, animation state, audio, etc.")
		Story_Event("SENSOR_RESPONSE")
		Register_Timer(Timer_Alarm, alarm_time)
		num_probes_triggered = num_probes_triggered + 1
		
		-- jdg - 8/22/05 -- adding in map flag events here
		
		if prox_obj == alarm1 then
			--Story_Event("Sensor_1_Tripped")
			-- Empire_M03_Flag_Sensor01_OFF story flag to turn off
			--MessageBox("Sensor 01 should now be flagged")
			sensor01_flagged = true
			alarm1.Play_Animation("Warning",true)
			alarm1.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm2 then
			--Story_Event("Sensor_2_Tripped")
			--MessageBox("Sensor 02 should now be WARNING")
			sensor02_flagged = true
			alarm2.Play_Animation("Warning",true)
			alarm2.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm3 then
			--Story_Event("Sensor_3_Tripped")
			--MessageBox("Sensor 03 should now be flagged")
			sensor03_flagged = true
			alarm3.Play_Animation("Warning",true)
			alarm3.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm4 then
			--Story_Event("Sensor_4_Tripped")
			--MessageBox("Sensor 04 should now be flagged")
			sensor04_flagged = true
			alarm4.Play_Animation("Warning",true)
			alarm4.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm5 then
			--Story_Event("Sensor_5_Tripped")
			--MessageBox("Sensor 05 should now be flagged")
			sensor05_flagged = true
			alarm5.Play_Animation("Warning",true)
			alarm5.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm6 then
			--Story_Event("Sensor_6_Tripped")
			--MessageBox("Sensor 06 should now be flagged")
			sensor06_flagged = true
			alarm6.Play_Animation("Warning",true)
			alarm6.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
		
		if prox_obj == alarm7 then
			--Story_Event("Sensor_7_Tripped")
			--MessageBox("Sensor 07 should now be flagged")
			sensor07_flagged = true
			alarm7.Play_Animation("Warning",true)
			alarm7.Play_SFX_Event("Structure_Orbital_LRS_Loop")
		end
			
	else
	
		--Other units immediately trip the alarm
		--MessageBox("Alarm tripped without disarm opportunity.")
		Story_Event("USED_SUPPORT_UNITS_TOO_EARLY")

		-- Create a thread for this event, because we want to use Sleep within a prox response
		Create_Thread("Timer_Alarm")
	end
end
 

function Prox_Base_Warning(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Base_Warning) 

	if alarm_active then
		return
	end
	if not flag_fett_successful then
		--MessageBox("prox_obj is %s, trigger is %s", tostring(prox_obj), tostring(trigger_obj))
		--MessageBox("Stay back from base warning.")
		Story_Event("BASE_PROX_WARNING")
		--reveal around base here
		fog_id = FogOfWar.Reveal(empire,prox_obj.Get_Position(),400,400)
		
	else 
		--MessageBox("Player approaching base after Fett's success") 
		
		
	
	end
end

function Prox_Base_Alarm(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Base_Alarm)

	if alarm_active then
		return
	end
	
	if flag_fett_successful then
		-- play the Pirate Leader: Imperials! Where did they come from?  Prepare my shuttle! line here
		-- Story_Event("BASE_PROX_POST_FETT_SUCCESS")
	end
	
	if not flag_fett_successful then
		--MessageBox("Too close to base, alarm triggered with no timer.")
		
		-- Create a thread for this event, because we want to use Sleep within a prox response
		Create_Thread("Timer_Alarm")
		pirate_base.Prevent_All_Fire(false)
	end
	
end

function Extra_Pirates_Callback(pirate_list)
	if TestValid(captain) then
		pirate_fighter_list = Find_All_Objects_Of_Type("Pirate_Fighter_Squadron")
		--pirate_ipv_list = Find_All_Objects_Of_Type("IPV1_System_Patrol_Craft")
		
		local_list = pirate_list
		
		for j, unit in pairs(local_list) do
			unit.Override_Max_Speed(3)
			unit.Move_To(retreat3)
		end
		for j, unit in pairs(pirate_fighter_list) do
			unit.Override_Max_Speed(4)
			unit.Guard_Target(captain)
		end
	end
end

function Mid_Cine()

	-- Mini cinematic of pirate captain leaving station

	if not TestValid (captain) then
		--MessageBox("cannot find captain!")
	end
	
	Cancel_Fast_Forward() 
	Sleep(1)
	
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	Fade_Screen_Out(.5)
	Start_Cinematic_Camera()
	
	Fade_Screen_In(.5)
	
	Story_Event("FLAG_THE_LEADER")
	
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(captain, 400, 6, 30, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(captain, 0, 0, 0, 0, captain, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(captain, 8, 1200, 12, -60, 1, 0, 0, 0) 
	
	
	--this midtro only plays if player fails the main sensor destruction objective
	-- so setting captain faster here 
	captain.Override_Max_Speed(4)
	BlockOnCommand(captain.Move_To(captainflyto))
	Sleep(2)
	
	Sleep(3)
	Story_Event("PIRATE_CAPTAIN_SPAWNS")
	Fade_Screen_Out(.5)
	if TestValid(fett) then
		Point_Camera_At(fett)
	end
	Transition_To_Tactical_Camera(0)
	
	Fade_Screen_Out(.5)
	Transition_To_Tactical_Camera(.5)
	End_Cinematic_Camera()
	Fade_Screen_In(.5)
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	Story_Event("ENABLE_REINFORCEMENTS")
	
	

end


function Timer_Alarm()

	if alarm_active then
		return
	end
	
	--setting base back to active
	pirate_base.Prevent_All_Fire(false)

	-- When this fires, the base is alerted
	--MessageBox("Alarm Triggered!")
	
	--jdg 8/23/05 putting alarm guys into alarm anim
	if TestValid (alarm1) then
		alarm1.Play_Animation("Alarm",true)
		alarm1.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm1")
	end
	
	if TestValid (alarm2) then
		alarm2.Play_Animation("Alarm",true)
		alarm2.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm2")
	end
	
	if TestValid (alarm3) then
		alarm3.Play_Animation("Alarm",true)
		alarm3.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm3")
	end
	
	if TestValid (alarm4) then
		alarm4.Play_Animation("Alarm",true)
		alarm4.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm4")
	end
	
	if TestValid (alarm5) then
		alarm5.Play_Animation("Alarm",true)
		alarm5.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm5")
	end
	
	if TestValid (alarm6) then
		alarm6.Play_Animation("Alarm",true)
		alarm6.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm6")
	end
	
	if TestValid (alarm7) then
		alarm7.Play_Animation("Alarm",true)
		alarm7.Play_SFX_Event("Structure_Orbital_LRS_Fast_Loop")
		Remove_Radar_Blip("blip_alarm7")
	end
	
	-- Spawn the pirate captain and don't let the AI control him
	captain_list = SpawnList(pirate_captain_type, captainspawn, pirates, false, true)
	captain = captain_list[1]
	
	--jdg setting the pirate leader to non-killable to prevent bugs.
	captain.Set_Cannot_Be_Killed(true)
	
	break_patrol = true
	--Story_Event("FLAG_THE_LEADER")
	--Story_Event("PIRATE_CAPTAIN_SPAWNS")
	fog_id2 = FogOfWar.Reveal_All(empire)
	
	--jdg moving to cinematic midtro
	--Story_Event("ENABLE_REINFORCEMENTS")

	if not flag_fett_successful then
		Story_Event("ALARM_TRIGGERED")
	end
	
	alarm_active = true
	
	Create_Thread("Mid_Cine") -- NEEDS MID-GAME CINE ISSUES RESOLVED
        
	-- reinforce extra pirates, and trigger early captain's retreat.
	if TestValid(captain)then
		--MessageBox("Reinforcing at Captain.")
		--Sleep(2)	
		if not flag_fett_successful then
			Story_Event("PIRATES_INCOMING")
		end
		--Sleep(1)	
		cap_guards = SpawnList(pirate_type_list3, captain, pirates, false, true, false, Extra_Pirates_Callback)

		Create_Thread("Extra_Pirates_Callback", cap_guards)
		Create_Thread("Move_Pirate_Captain")
		
	end
end



-- Destroying an alarm will deactivate the countdown.
function Sensor_Destroyed()
	--MessageBox("Sensor destroyed.")
	if num_probes_triggered > 0 and not alarm_active then
	
		-- If we've destroyed as many probes as we've set off, then we're cool.  
		-- Don't worry about tracking individual probes.
		num_probes_triggered = num_probes_triggered - 1
		if num_probes_triggered < 1 and not alarm_triggered then
			--MessageBox("Countdown stopped.  Probably need some user feedback here.")
			Cancel_Timer(Timer_Alarm)
			countdown_underway = false
			
			number_of_sensors_destroyed = number_of_sensors_destroyed + 1
			
			--need to track probes so I can remove flags
			if not TestValid(alarm1) and sensor01_destroyed == false then
				sensor01_destroyed = true
				--alarm1.Highlight(false)
				Remove_Radar_Blip("blip_alarm1")
			end
			
			if not TestValid(alarm2) and sensor02_destroyed == false then
				sensor02_destroyed = true
				Remove_Radar_Blip("blip_alarm2")
			end
			
			if not TestValid(alarm3) and sensor03_destroyed == false then
				sensor03_destroyed = true
				Remove_Radar_Blip("blip_alarm3")
			end
			
			if not TestValid(alarm4) and sensor04_destroyed == false then
				sensor04_destroyed = true
				Remove_Radar_Blip("blip_alarm4")
			end
			
			if not TestValid(alarm5) and sensor05_destroyed == false then
				sensor05_destroyed = true
				Remove_Radar_Blip("blip_alarm5")
			end
			
			if not TestValid(alarm6) and sensor06_destroyed == false then
				sensor06_destroyed = true
				Remove_Radar_Blip("blip_alarm6")
			end
			
			if not TestValid(alarm7) and sensor07_destroyed == false then
				sensor07_destroyed = true
				Remove_Radar_Blip("blip_alarm7")
			end
			
			-- now turn off flags if appropriate
			
			if sensor01_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_01")
				Sensor_Guards_to_New_Spot (1, mylocation, sat1guards_list)
				
				if sensor01_flagged == true then
					Story_Event("Sensor_1_Destroyed")
					--MessageBox("Sensor 01 flag should now be off")
					sensor01_flagged = false
				end				
			end
			
			if sensor02_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_02")
				Sensor_Guards_to_New_Spot (2, mylocation, sat2guards_list)
				
				if sensor02_flagged == true then
					Story_Event("Sensor_2_Destroyed")
					--MessageBox("Sensor 02 flag should now be off")
					sensor02_flagged = false
				end				
			end
			
			if sensor03_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_03")				
				Sensor_Guards_to_New_Spot (3, mylocation, sat3guards_list)
				
				if sensor03_flagged == true then
					Story_Event("Sensor_3_Destroyed")
					--MessageBox("Sensor 03 flag should now be off")
					sensor03_flagged = false
				end				
			end
			
			if sensor04_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_04")				
				Sensor_Guards_to_New_Spot (4, mylocation, sat4guards_list)
				
				if sensor04_flagged == true then
					Story_Event("Sensor_4_Destroyed")
					--MessageBox("Sensor 04 flag should now be off")
					sensor04_flagged = false
				end				
			end
			
			if sensor05_destroyed == true then 
				mylocation = Find_First_Object("Story_Trigger_Zone_05")				
				Sensor_Guards_to_New_Spot (5, mylocation, sat5guards_list)
				
				if sensor05_flagged == true then
					Story_Event("Sensor_5_Destroyed")
					--MessageBox("Sensor 05 flag should now be off")
					sensor05_flagged = false
				end				
			end
			
			if sensor06_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_06")				
				Sensor_Guards_to_New_Spot (6, mylocation, sat6guards_list)
				
				if sensor06_flagged == true then
					Story_Event("Sensor_6_Destroyed")
					--MessageBox("Sensor 06 flag should now be off")
					sensor06_flagged = false
				end				
			end
			
			if sensor07_destroyed == true then
				mylocation = Find_First_Object("Story_Trigger_Zone_07")				
				Sensor_Guards_to_New_Spot (7, mylocation, sat7guards_list)
				
				if sensor07_flagged == true then
					Story_Event("Sensor_7_Destroyed")
					--MessageBox("Sensor 07 flag should now be off")
					sensor07_flagged = false
				end				
			end
			
			-- Play appropriate feedback message
			
			if number_of_sensors_destroyed == 1 then
				Story_Event("Total_1_Sensor_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_40
				-- Boba Fett: That's one down.
			end
			
			if number_of_sensors_destroyed == 2 then
				Story_Event("Total_2_Sensors_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_41
				-- Boba Fett: That's two.
			end
			
			if number_of_sensors_destroyed == 3 then
				Story_Event("Total_3_Sensors_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_42
				-- Boba Fett: Got it!
			end
			
			if number_of_sensors_destroyed == 4 then
				Story_Event("Total_4_Sensors_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_42
				-- Boba Fett: Got it!
			end
			
			if number_of_sensors_destroyed == 5 then
				Story_Event("Total_5_Sensors_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_43
				-- Boba Fett: Got it, only two sensors left.
			end
			
			if number_of_sensors_destroyed == 6 then
				Story_Event("Total_6_Sensors_Destroyed")
				-- TEXT_STORY_EMPIRE_ACT01_MISSION_THREE_44
				-- Boba Fett: Just one more sensor and the pirates will be blind.
			end

			-- steve is taking care of this last one down message elsewhere
		end
		
		
		
	end
end

function Sensor_Guards_to_New_Spot(Sensor_num, origin, unit_list)

	--MessageBox("guards to new spot function hit")
	--new_GuardSpot = Find_First_Object("Orbital_Sensor_Pod_Pirate")
	--new_GuardSpot = Find_Nearest(origin, "Orbital_Sensor_Pod_Pirate")
	
	new_Guard_Loc = Get_Closest_Sensor (Sensor_num)
			
	if new_Guard_Loc == 1
		then new_GuardSpot = alarm1
	elseif new_Guard_Loc == 2
		then new_GuardSpot = alarm2
	elseif new_Guard_Loc == 3
		then new_GuardSpot = alarm3
	elseif new_Guard_Loc == 4
		then new_GuardSpot = alarm4
	elseif new_Guard_Loc == 5
		then new_GuardSpot = alarm5
	elseif new_Guard_Loc == 6
		then new_GuardSpot = alarm6
	elseif new_Guard_Loc == 7
		then new_GuardSpot = alarm7
	elseif new_Guard_Loc == 8
		then new_GuardSpot = Find_First_Object("Pirate_Asteroid_Base_Weak")
	end

	if TestValid(new_GuardSpot) then
		if guard_loc_1 == Sensor_num
			then List_Guard(sat1guards_list, new_GuardSpot)
		end
		if guard_loc_2 == Sensor_num
			then List_Guard(sat2guards_list, new_GuardSpot)
		end
		if guard_loc_3 == Sensor_num
			then List_Guard(sat3guards_list, new_GuardSpot)
		end
		if guard_loc_4 == Sensor_num
			then List_Guard(sat4guards_list, new_GuardSpot)
		end
		if guard_loc_5 == Sensor_num
			then List_Guard(sat5guards_list, new_GuardSpot)
		end
		if guard_loc_6 == Sensor_num
			then List_Guard(sat6guards_list, new_GuardSpot)
		end
		if guard_loc_7 == Sensor_num
			then List_Guard(sat7guards_list, new_GuardSpot)
		end
	
	else 
		-- send them to guard the starbase
		new_GuardSpot = Find_First_Object("Pirate_Asteroid_Base_Weak")
		List_Guard(unit_list, new_GuardSpot)
		--MessageBox("guards to new spot  STARBASE")
	end
	
	Guard_Management (Sensor_num, new_Guard_Loc)
end







function Captain_Prox(prox_obj, trigger_obj)

	-- The player is near the captain.  Start him up
	prox_obj.Cancel_Event_Object_In_Range(Captain_Prox)
	Create_Thread("Move_Pirate_Captain")
	
end

function Get_Block_Stop()
	return break_patrol
end

function Move_patrol_group_01()
	-- dme 9/21/05 function to move patrol groups back and forth
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_01), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_02), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_03), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_04), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_05), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group1.Attack_Move(patrol_06), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group1) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group1) then		
		Create_Thread("Move_patrol_group_01")
	end
end

function Move_patrol_group_02()
	-- dme 9/21/05 function to move patrol groups back and forth
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_03), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_02), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_01), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_06), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_05), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group2.Attack_Move(patrol_04), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group2) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group2) then		
		Create_Thread("Move_patrol_group_02")
	end
end

function Move_patrol_group_03()
	-- dme 9/21/05 function to move patrol groups back and forth
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_05), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_06), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_01), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_02), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to first patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_03), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then
		--MessageBox("Moving patrol to second patrol waypoint.")
		BlockOnCommand(patrol_group3.Attack_Move(patrol_04), -1, Get_Block_Stop)
	end
	
	if TestValid(patrol_group3) then		
		Sleep(1)
	end
	
	if TestValid(patrol_group3) then		
		Create_Thread("Move_patrol_group_03")
	end
end



function Move_Pirate_Captain()
	-- Exit sequence, run away.
	-- This is the last chance for the player to disable the captain.
	-- There is no "CAPTAIN_RETREATING" notification on the first move as the player is warned when 
	-- the captain is spawned
	
	if TestValid(captain) and not captain_disabled then
		--MessageBox("Moving Captain to first escape waypoint.")
		BlockOnCommand(captain.Move_To(retreat1))
	end
	
	if TestValid(captain) and not captain_disabled then		
		Sleep(0)
	end
	
	if TestValid(captain) and not captain_disabled then
		--Story_Event("CAPTAIN_RETREATING")
	end		
	
	if TestValid(captain) and not captain_disabled then
		--MessageBox("Moving Captain to second escape waypoint.")	
		BlockOnCommand(captain.Move_To(retreat2))
	end
	
	if TestValid(captain) and not captain_disabled then		
		Sleep(0)
	end		
	
	if TestValid(captain) and not captain_disabled then
		Story_Event("CAPTAIN_RETREATING2")
	end
	
	if TestValid(captain) and not captain_disabled then
		--MessageBox("Moving Captain to third escape waypoint.")	
		BlockOnCommand(captain.Move_To(retreat3))
	end
				
	-- Pirate retreat (player loss)		
	if TestValid(captain) and not captain_disabled then
		--MessageBox("Triggering retreat.")
		--pirates.Retreat()
		captain.Hyperspace_Away()
		Story_Event("FAILURE_CAPTAIN_RETREAT")
	end	
end


function State_Empire_M03_Final_Dialog_Begin_00(message)
	if message == OnEnter then
		Cancel_Fast_Forward() 
		Lock_Controls(1)
		Suspend_AI(1)
		Fade_Screen_Out(1)
		Sleep(1)
		Letter_Box_In(0)
		
		empire = Find_Player("Empire")
		unit_list = Find_All_Objects_Of_Type(empire)
		for i, unit in pairs(unit_list) do
			unit.Set_Selectable(false)
		end
		
		-- Clean up the map of spawned objects for the pirate side 
		pirate_base_list = Find_All_Objects_Of_Type("PIRATE_ASTEROID_BASE_WEAK")
		pirate_fighters_list = Find_All_Objects_Of_Type("Pirate_Fighter_Squadron")
		pirate_IPV1_list = Find_All_Objects_Of_Type("IPV1_System_Patrol_Craft")
		pirate_satellite_list = Find_All_Objects_Of_Type("PIRATE_DEFENSE_SATELLITE_LASER")
		
		for i,pirate_base in pairs(pirate_base_list) do
			pirate_base.Despawn()
		end
		
		for i,pirate_fighters in pairs(pirate_fighters_list) do
			pirate_fighters.Despawn()
		end
		
		for i,pirate_IPV1 in pairs(pirate_IPV1_list) do
			pirate_IPV1.Despawn()
		end
		
		for i,pirate_satellite in pairs(pirate_satellite_list) do
			pirate_satellite.Despawn()
		end
		
		--jdg querry for player units and move into cinematic formation
		endcine_playerunit_spot01 = Find_Hint("GENERIC_MARKER_SPACE","endcine-playerunit-spot01")
		endcine_playerunit_spot02 = Find_Hint("GENERIC_MARKER_SPACE","endcine-playerunit-spot02")
		endcine_playerunit_spot03 = Find_Hint("GENERIC_MARKER_SPACE","endcine-playerunit-spot03")
		
		player_acclamator_list = Find_All_Objects_Of_Type("ACCLAMATOR_ASSAULT_SHIP")
		player_broadside_list = Find_All_Objects_Of_Type("BROADSIDE_CLASS_CRUISER")
		player_tartan_list = Find_All_Objects_Of_Type("TARTAN_PATROL_CRUISER")
		
		flag_broadside_01_used = false
		flag_broadside_02_used = false
		flag_tartan_01_used = false
		flag_tartan_02_used = false
		
		slot_01_ship = nil
		slot_02_ship = nil
		slot_03_ship = nil
	
		-- if player has acclamators fill in the cinematic spots
		if player_acclamator_list[1] then
			--MessageBox("moving acclamator1 to end cine spot 01.")
			player_acclamator_list[1].Teleport_And_Face(endcine_playerunit_spot01)
			player_acclamator_list[1].Prevent_Opportunity_Fire(true)
			
			slot_01_ship = player_acclamator_list[1]
			flag_spot_01_filled = true
		end
		
		if player_acclamator_list[2] then
			--MessageBox("moving acclamator2 to end cine spot 02.")
			player_acclamator_list[2].Teleport_And_Face(endcine_playerunit_spot02)
			player_acclamator_list[2].Prevent_Opportunity_Fire(true)
			
			slot_02_ship = player_acclamator_list[2]
			flag_spot_02_filled = true
		end
		
		if player_acclamator_list[3] then
			--MessageBox("moving acclamator3 to end cine spot 03.")
			player_acclamator_list[3].Teleport_And_Face(endcine_playerunit_spot03)
			player_acclamator_list[3].Prevent_Opportunity_Fire(true)
			
			slot_03_ship = player_acclamator_list[3]
			flag_spot_03_filled = true
		end
		
		--now fill in empty spot 01 if needed
		if not flag_spot_01_filled then
			if player_broadside_list[1] then
				--MessageBox("moving broadside1 to end cine spot 01.")
				player_broadside_list[1].Teleport_And_Face(endcine_playerunit_spot01)
				player_broadside_list[1].Prevent_Opportunity_Fire(true)
				
				slot_01_ship = player_broadside_list[1]
				flag_broadside_01_used = true
			elseif player_tartan_list[1] then
				--MessageBox("moving tartan1 to end cine spot 01.")
				player_tartan_list[1].Teleport_And_Face(endcine_playerunit_spot01)
				player_tartan_list[1].Prevent_Opportunity_Fire(true)
				
				slot_01_ship = player_tartan_list[1]
				flag_tartan_01_used = true
			end
		end
		
		--now fill in empty spot 02 if needed
		if not flag_spot_02_filled then
			if player_broadside_list[1] and not flag_broadside_01_used then
				--MessageBox("moving broadside1 to end cine spot 02.")
				player_broadside_list[1].Teleport_And_Face(endcine_playerunit_spot02)
				player_broadside_list[1].Prevent_Opportunity_Fire(true)
				
				slot_02_ship = player_broadside_list[1]
				flag_broadside_01_used = true
			elseif player_broadside_list[2] then
				--MessageBox("moving broadside2 to end cine spot 02.")
				player_broadside_list[2].Teleport_And_Face(endcine_playerunit_spot02)
				player_broadside_list[2].Prevent_Opportunity_Fire(true)
				
				slot_02_ship = player_broadside_list[2]
				flag_broadside_02_used = true
	
			elseif player_tartan_list[1] and not flag_tartan_01_used then
				--MessageBox("moving tartan1 to end cine spot 02.")
				player_tartan_list[1].Teleport_And_Face(endcine_playerunit_spot02)
				player_tartan_list[1].Prevent_Opportunity_Fire(true)
				
				slot_02_ship = player_tartan_list[1]
				flag_tartan_01_used = true
			elseif player_tartan_list[2] then
				--MessageBox("moving tartan2 to end cine spot 02.")
				player_tartan_list[2].Teleport_And_Face(endcine_playerunit_spot02)
				player_tartan_list[2].Prevent_Opportunity_Fire(true)
				
				slot_02_ship = player_tartan_list[2]
				flag_tartan_02_used = true
			end
		end
		
		--now fill in empty spot 03 if needed
		if not flag_spot_03_filled then
			if player_broadside_list[1] and not flag_broadside_01_used then
				--MessageBox("moving broadside1 to end cine spot 03.")
				player_broadside_list[1].Teleport_And_Face(endcine_playerunit_spot03)
				player_broadside_list[1].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_broadside_list[1]
			elseif player_broadside_list[2] and not flag_broadside_02_used then
				--MessageBox("moving broadside2 to end cine spot 02.")
				player_broadside_list[2].Teleport_And_Face(endcine_playerunit_spot03)
				player_broadside_list[2].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_broadside_list[2]
			elseif player_broadside_list[3] then
				--MessageBox("moving broadside3 to end cine spot 03.")
				player_broadside_list[3].Teleport_And_Face(endcine_playerunit_spot03)
				player_broadside_list[3].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_broadside_list[3]
				
			elseif player_tartan_list[1] and not flag_tartan_01_used then
				--MessageBox("moving tartan1 to end cine spot 03.")
				player_tartan_list[1].Teleport_And_Face(endcine_playerunit_spot03)
				player_tartan_list[1].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_tartan_list[1]
			elseif player_tartan_list[2] and not flag_tartan_02_used then
				--MessageBox("moving tartan2 to end cine spot 03.")
				player_tartan_list[2].Teleport_And_Face(endcine_playerunit_spot03)
				player_tartan_list[2].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_tartan_list[2]
			elseif player_tartan_list[3] then
				--MessageBox("moving tartan3 to end cine spot 03.")
				player_tartan_list[3].Teleport_And_Face(endcine_playerunit_spot03)
				player_tartan_list[3].Prevent_Opportunity_Fire(true)
				
				slot_03_ship = player_tartan_list[3]
			end
	
		end		
		
		
		
		
		if TestValid(captain) then
			Hide_Object(captain, 1)
			-- captain.Despawn()
		end
			
		-- Teleport or spawn units to the final cinematic setting
		
		if TestValid(slot_01_ship) then
			slot_01_ship.In_End_Cinematic(true)
		end 
		
		if TestValid(slot_02_ship) then
			slot_02_ship.In_End_Cinematic(true)
		end 
		
		if TestValid(slot_03_ship) then
			slot_03_ship.In_End_Cinematic(true)
		end 
		
		if TestValid(fett) then
			fett.In_End_Cinematic(true)
		end 
		
		
		Do_End_Cinematic_Cleanup()
		
		
		if TestValid(slot_01_ship) then
			slot_01_ship.Teleport_And_Face(endcine_playerunit_spot01)
		end 
		
		if TestValid(slot_02_ship) then
			slot_02_ship.Teleport_And_Face(endcine_playerunit_spot02)
		end 
		
		if TestValid(slot_03_ship) then
			slot_03_ship.Teleport_And_Face(endcine_playerunit_spot03)
		end 
		
		
		if TestValid(fett) then
			fett.Prevent_AI_Usage(true)
			fett.Teleport(cinematic_fett_start)
			fett.Face_Immediate(cinematic_fett_end)
			fett.Prevent_Opportunity_Fire(true)
		end
		
		captain_list_cinematic = SpawnList(pirate_captain_type, captainspawn, pirates, false, true)
		cinematic_captain = captain_list_cinematic[1]
		cinematic_captain.Prevent_AI_Usage(true)
		cinematic_captain.Teleport(cinematic_pirate_start)
		cinematic_captain.Face_Immediate(cinematic_pirate_end)
		cinematic_captain.Move_To(cinematic_pirate_end)
		cinematic_captain.Make_Invulnerable(true)
		cinematic_captain.Prevent_Opportunity_Fire(true)
		
		
		
		
		
		
		Start_Cinematic_Camera()
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(cinematic_pirate_end, 200, -45, 210, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(cinematic_pirate_end, 0, 0, -105, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(cinematic_pirate_end, 15, 400, 10, 240, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(cinematic_pirate_end, 15, 0, 0, 0, 0, 0, 0, 0)
		
		Fade_Screen_In(1)
		Sleep(2)
		

		fett.Move_To(cinematic_fett_end)
		Sleep(2)
		Story_Event("M2_END_DIALOGUE_GO")
		
	end
end

function State_Empire_A01M03_Final_Fett_TEXT(message)
	if message == OnEnter then
	
	end
end	

function State_Empire_A01M03_Final_Fett_END(message)
	if message == OnEnter then
	-- MessageBox("M2_END_DIALOGUE_2_GO.")
	Story_Event("M2_END_DIALOGUE_2_GO")
	end
end	

function State_Empire_A01M03_Final_Officer_TEXT(message)
	if message == OnEnter then
	
	end
end	

function State_Empire_A01M03_Final_Officer_END(message)
	if message == OnEnter then
	Sleep(1)
	Story_Event("M2_END_DIALOGUE_3_GO")
	Lock_Controls(0)
	Suspend_AI(0)
	Sleep(2)
	Fade_Screen_Out(1)
	Sleep(1)
	End_Cinematic_Camera()
	-- MessageBox("M2_END_DIALOGUE_3_GO.")
	end
end	


-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()
	
	if initial_units_spawned then
		if alarm_active or flag_fett_successful then

		-- Set the captain as disabled, if sufficiently damaged.
		-- Once this happens, one component of victory conditions are met.
			if TestValid(captain) then
				if not captain_disabled then
					if not captain_found then
						if captain.Get_Hull() < 0.99 then
							-- Story_Event("CAPTAIN_FOUND")
							captain_found = true
						end
					elseif flag_fett_successful and captain.Get_Hull() < 0.5 then
						--MessageBox("Captain disabled.")
						captain.Make_Invulnerable(true)
						captain_disabled = true
						
						if TestValid(fett) then
							fett.Make_Invulnerable(true)
						end
							
						captain.Prevent_AI_Usage(true)
						captain.Move_To(captain)
						Story_Event("CAPTAIN_DISABLED")
						
					elseif not flag_fett_successful and captain.Get_Hull() < 0.1 then
						--MessageBox("Captain disabled.")
						captain.Make_Invulnerable(true)
						captain_disabled = true
						
						if TestValid(fett) then
							fett.Make_Invulnerable(true)
						end
							
						captain.Prevent_AI_Usage(true)
						captain.Move_To(captain)
						Story_Event("CAPTAIN_DISABLED")
						-- ScriptExit()
					end
				end
			else
				-- MessageBox("error, unexpected condition: captain killed")
			end
		end
		
		if not TestValid(pirate_base) then
			if not flag_pirate_base_dead then
			
				--MessageBox("LUA pirate base dead")
				flag_pirate_base_dead = true
				-- Spawn the pirate captain and don't let the AI control him
				captain_list = SpawnList(pirate_captain_type, captainspawn, pirates, false, true)
				captain = captain_list[1]
				captain.Set_Cannot_Be_Killed(true)
				break_patrol = true
				alarm_active = true
				Story_Event("FLAG_THE_LEADER")
				Story_Event("PIRATE_CAPTAIN_SPAWNS")
				fog_id2 = FogOfWar.Reveal_All(empire)
				--Story_Event("ENABLE_REINFORCEMENTS")
				    
				-- reinforce extra pirates, and trigger early captain's retreat.
				if TestValid(captain)then
					--MessageBox("Reinforcing at Captain.")	
					cap_guards = SpawnList(pirate_type_list2, captain, pirates, false, true, false, Extra_Pirates_Callback)

					Create_Thread("Extra_Pirates_Callback", cap_guards)
					Create_Thread("Move_Pirate_Captain")
					captain.Override_Max_Speed(2)
				end
			end
		end
		
		--this okays the captain to spawn when the pirate base is destroyed
		if TestValid(pirate_base) then
		
			if (pirate_base.Get_Shield() < .99) and not flag_pirate_base_dead and not flag_hardpoint_speech_given then
				Story_Event("FETT_TALKS_ABOUT_HARDPOINTS")
				flag_hardpoint_speech_given = true
				pirate_base.Prevent_All_Fire(false)
			end
			
			
		end
		 
		-- Let the player know if all of the sensors are down
		if 	not alarm_active and
			not sensors_down and
			not TestValid(alarm1) and
			not TestValid(alarm2) and
			not TestValid(alarm3) and
			not TestValid(alarm4) and
			not TestValid(alarm5) and
			not TestValid(alarm6) and
			not TestValid(alarm7) then
				sensors_down = true
				-- MessageBox("Sensors down message here.")
				Story_Event("ALL_SENSORS_DOWN")
				fog_id2 = FogOfWar.Reveal_All(empire)
				--Story_Event("ENABLE_REINFORCEMENTS")
				
				flag_fett_successful = true
				--MessageBox("fett flag should now be changed")
		end
	end
	
	
end
