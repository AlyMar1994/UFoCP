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
--            $Author: Joseph_Gernert $
--
--            $Change: 
--
--          $DateTime: 
--
--          $Revision: 
--
--/////////////////////////////////////////////////////////////////////////////////////////////////


require("PGStoryMode")

-----------------------------------------------------------------------------------------------------------------------
-- Definitions -- This function is called once when the script is first created.
-----------------------------------------------------------------------------------------------------------------------

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_A3_M09_Begin = State_Rebel_A3_M09_Begin
		,Rebel_M09_IntroCine_Dialog_Line_01_Remove_Text = State_IntroCine_Dialog_Line_01_Remove_Text
		,Rebel_M09_IntroCine_Dialog_Line_02_Remove_Text = State_IntroCine_Dialog_Line_02_Remove_Text
		,Rebel_M09_IntroCine_Dialog_Line_03_Remove_Text = State_IntroCine_Dialog_Line_03_Remove_Text
		,Rebel_M09_IntroCine_Dialog_Line_04_Remove_Text = State_IntroCine_Dialog_Line_04_Remove_Text
		,Rebel_M09_IntroCine_Dialog_Line_05_Remove_Text = State_IntroCine_Dialog_Line_05_Remove_Text
		,Rebel_A3_M09_Plans_Recovered_01b_Remove_Movie = State_M09_Plans_Recovered
		--,Rebel_A3_M09_Plans_Recovered_00_Remove_Movie = State_Rebel_A3_M09_Plans_Recovered_00
	}
	
	-- Waves of enemy units recover from EMP throughout the mission
	
	--time_to_wakeup_1 = 45 original
	time_to_wakeup_1 = 5
	wakeup_table_1 = {
		{"Tartan_Patrol_Cruiser", "1a"}
		,{"Tartan_Patrol_Cruiser", "1b"}
		,{"Victory_Destroyer", "1c"}
	}

	--time_to_wakeup_2 = 90 original
	time_to_wakeup_2 = 60 
	wakeup_table_2 = {
		{"Victory_Destroyer", "2a"}
		,{"Tartan_Patrol_Cruiser", "2b"}
		,{"Tartan_Patrol_Cruiser", "2c"}
		,{"Tartan_Patrol_Cruiser", "2d"}
		,{"Tartan_Patrol_Cruiser", "2e"}
		,{"Tartan_Patrol_Cruiser", "2f"}
	}

	--time_to_wakeup_3 = 135 original
	time_to_wakeup_3 = 120
	wakeup_table_3 = {
		{"Star_Destroyer", "3a"}
		,{"Star_Destroyer", "3b"}
		,{"Tartan_Patrol_Cruiser", "3c"}
		,{"Tartan_Patrol_Cruiser", "3d"}
		,{"Tartan_Patrol_Cruiser", "3e"}
		,{"Tartan_Patrol_Cruiser", "3f"}
		,{"Tartan_Patrol_Cruiser", "3g"}
	}

	--time_to_wakeup_4 = 180 original
	time_to_wakeup_4 = 180
	--time_to_get_plans = 60 original
	time_to_get_plans = 60
	time_trigger = 0
						
	--time_to_make_transport1_vulnerable = 20 -- time_to_wakeup_1 + GameRandom(10,30)
	--time_to_make_transport2_vulnerable = 20 -- time_to_wakeup_2 + GameRandom(10,30)
	--time_to_make_transport3_vulnerable = 40 -- time_to_wakeup_3 + GameRandom(10,30)
	time_to_make_transport1_vulnerable = 0 -- time_to_wakeup_1 + GameRandom(10,30)
	time_to_make_transport2_vulnerable = 0 -- time_to_wakeup_2 + GameRandom(10,30)
	time_to_make_transport3_vulnerable = 0 -- time_to_wakeup_3 + GameRandom(10,30)
	time_to_make_transport4_vulnerable = 0 -- time_to_wakeup_3 + GameRandom(35,60)
	
	exit_range = 400

	first_time_serviced = true
	flag_shuttles_escaping = false
	
	fog_id = nil
	
end

function State_Rebel_A3_M09_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		
		rebel_player = Find_Player("Rebel")

		-- Find the transports
		transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
		transport2 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "2")
		transport3 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "3")
		transport4 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "4")
		if not transport1 or not transport2 or not transport3 or not transport4 then
			return
		end
		
		starbase = Find_First_Object("EMPIRE_STAR_BASE_4")
		if not starbase then
			return
		end
		
		-- Exit point for shuttles														 
		exit_marker = Find_Hint("GENERIC_MARKER_SPACE", "shuttle_escape")
		if TestValid(exit_marker) then
			Register_Prox(exit_marker, Exit_Prox, exit_range, rebel_player)
		else
			return
		end

		-- Get all of the defense satellites
		sat_list = Find_All_Objects_With_Hint("defense_sat")
		for i, sat in pairs(sat_list) do
			if TestValid(sat) then
				sat.Prevent_AI_Usage(true)
				sat.Prevent_Opportunity_Fire(true)
			end
		end

		Create_Thread("Intro_Cinematic")

	end
end

------------------------------------------------------------------------------------------------------------------------
-- Opening Cinematic stuff
------------------------------------------------------------------------------------------------------------------------

function Intro_Cinematic()

	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)

	transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
	transport2 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "2")
	transport3 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "3")
	transport4 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "4")
	
	if not transport1 or not transport2 or not transport3 or not transport4 then
		return
	end

	Start_Cinematic_Camera()
	
	Set_Cinematic_Camera_Key(transport3, 600, 15, 60, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(transport3, 0, 0, 0, 0, 0, 0, 0)	

	--Resume_Hyperspace_In() 
	
	if TestValid(transport1) then
		--transport1.Cinematic_Hyperspace_In(69)
		transport1.Cinematic_Hyperspace_In(9)
	end

	if TestValid(transport2) then
		--transport2.Cinematic_Hyperspace_In(81)
		transport2.Cinematic_Hyperspace_In(21)
	end

	if TestValid(transport3) then
		--transport3.Cinematic_Hyperspace_In(63)
		transport3.Cinematic_Hyperspace_In(23)
	end

	if TestValid(transport4) then
		--transport4.Cinematic_Hyperspace_In(75)
		transport4.Cinematic_Hyperspace_In(15)
	end
	
	Fade_Screen_In(1)
	Sleep(1)
	Resume_Hyperspace_In() 
	Sleep(5)
	
	Transition_Cinematic_Camera_Key(transport3, 6.0, 375, 15, 310, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(transport3, 2.5, 0, 0, 0, 0, 0, 0, 0)
	Sleep(5)
	
	Story_Event("CUE_M09_DIALOG_REBELPILOT_01") 
end

----------------------------------------------------------------------------------
-- cinematic dialog lua callbacks here
-----------------------------------------------------------------------------------

function State_IntroCine_Dialog_Line_01_Remove_Text(message)
	if message == OnEnter then
		
		Sleep(1)
		
		antilles = Find_First_Object("SUNDERED_HEART")
		
		if not TestValid(antilles) then
			return
		end
		
		Set_Cinematic_Camera_Key(antilles, 500, 18, 290, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(antilles, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(antilles, 20.0, 450, 13, 260, 1, 0, 0, 0)
		
		Story_Event("CUE_M09_DIALOG_ANTILLES_01")
		--Antilles: It's borrowed time at best.  When they get moving again, we better not be around
	end
end

function State_IntroCine_Dialog_Line_02_Remove_Text(message)
	if message == OnEnter then
		
		-- Sleep(1)
		Story_Event("CUE_M09_DIALOG_ANTILLES_02")
		--Antilles: Boarding parties, get going.  Search the station and collect any data you can! 

		if not TestValid(transport3) then
			return
		end
	end
end

function State_IntroCine_Dialog_Line_03_Remove_Text(message)
	if message == OnEnter then
		Set_Cinematic_Camera_Key(transport3, 350, 25, 170, 1, transport3, 1, 0)
		Set_Cinematic_Target_Key(transport3, 0, 0, 0, 0, transport3, 0, 0)
		Transition_Cinematic_Camera_Key(transport3, 10, 450, 20, 190, 1, transport3, 1, 0)
		
		MoveTransportsToStarbase()
		
		Story_Event("CUE_M09_DIALOG_REBELPILOT_02")
		--Rebel Soldier: Yes, sir!  
		
		Sleep(6)

		--camera shot from starbase
		starbase = Find_Hint("EMPIRE_STAR_BASE_4", "starbase")
		if not TestValid(starbase) then
			return
		end
	end
end

function State_IntroCine_Dialog_Line_04_Remove_Text(message)
	if message == OnEnter then
		Sleep(8)
		Story_Event("CUE_M09_DIALOG_ANTILLES_03")
		--Antilles: That EMP didn't last as long as we thought!  Protect the boarding party and take out any ship that reactivates! 
		
		cine_ship = Find_Hint("Tartan_Patrol_Cruiser", "unaffected")
		
		if not TestValid(cine_ship) then
			return
		end
		
		cine_ship2 = Find_Hint("Tartan_Patrol_Cruiser", "unaffected2")
		
		if not TestValid(cine_ship2) then
			return
		end
		
		cine_ship.Suspend_Locomotor(false)
		cine_ship2.Suspend_Locomotor(false)
		
		cine_ship.Prevent_AI_Usage(false)
		cine_ship2.Prevent_AI_Usage(false)
		
		cine_ship.Prevent_Opportunity_Fire(false)
		cine_ship2.Prevent_Opportunity_Fire(false)
		cine_ship2.Prevent_AI_Usage(false)
		
		cine_ship.Move_To(antilles)
		cine_ship2.Move_To(antilles)
		
		Sleep(1)

		Set_Cinematic_Camera_Key(cine_ship, 500, 15, 190, 1, cine_ship, 1, 0)
		Set_Cinematic_Target_Key(antilles, 0, 0, 0, 0, antilles, 0, 0)	
	
	end
end

function State_IntroCine_Dialog_Line_05_Remove_Text(message)
	if message == OnEnter then

		Sleep(2)
		Point_Camera_At(antilles)
		Transition_To_Tactical_Camera(2)
		Letter_Box_Out(2)
		Sleep(2)
		End_Cinematic_Camera()

		Suspend_AI(0)
		Lock_Controls(0)
		Register_Timers()
		fog_id = FogOfWar.Reveal_All(rebel_player)
	end
end

function Register_Timers()

	-- Don't register the timer events unitl the cinematics are done playing
	
	Register_Timer(Wake_Sats, time_to_wakeup_4)
	
	-- Register timers for enemy ship wakeup events
	Register_Timer(Wake_Units, time_to_wakeup_1, wakeup_table_1)
	Register_Timer(Wake_Units, time_to_wakeup_2, wakeup_table_2)
	Register_Timer(Wake_Units, time_to_wakeup_3, wakeup_table_3)
	
	-- Register timers to make transports vulnerable to enemy fire
	Register_Timer(SwitchToRebel, time_to_make_transport1_vulnerable, transport1)
	Register_Timer(SwitchToRebel, time_to_make_transport2_vulnerable, transport2)
	Register_Timer(SwitchToRebel, time_to_make_transport3_vulnerable, transport3)
	Register_Timer(SwitchToRebel, time_to_make_transport4_vulnerable, transport4)
	
	-- If all of the transports are killed, the player loses
	Register_Death_Event(transport1, Transport_Destroyed)
	Register_Death_Event(transport2, Transport_Destroyed)
	Register_Death_Event(transport3, Transport_Destroyed)
	Register_Death_Event(transport4, Transport_Destroyed)
	
	-- The player has to survive with at least one transport until this timer, then escape
	--Register_Timer(Get_Plans, time_to_get_plans)
end

function MoveTransportsToStarbase()
	if not flag_shuttles_escaping then

		transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
		transport2 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "2")
		transport3 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "3")
		transport4 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "4")
		
		transport1_move_to = Find_Hint("GENERIC_MARKER_SPACE", "transport1moveto")
		transport2_move_to = Find_Hint("GENERIC_MARKER_SPACE", "transport2moveto")
		transport3_move_to = Find_Hint("GENERIC_MARKER_SPACE", "transport3moveto")
		transport4_move_to = Find_Hint("GENERIC_MARKER_SPACE", "transport4moveto")

		if TestValid(transport1) then
			transport1.Move_To(transport1_move_to)
		end
		
		if TestValid(transport2) then
			transport2.Move_To(transport2_move_to)
		end

		if TestValid(transport3) then
			transport3.Move_To(transport3_move_to)
		end

		if TestValid(transport4) then
			transport4.Move_To(transport4_move_to)
		end
	end   	
end
									 
function Exit_Prox(prox_obj, trigger_obj)
	--MessageBox("Rebel unit close to marker")
	if trigger_obj == transport1 or trigger_obj == transport2 or trigger_obj == transport3 or trigger_obj == transport4 then
		Story_Event("shuttles_clear")
		prox_obj.Cancel_Event_Object_In_Range(Exit_Prox)
	end
end

function Wake_Sats()
	for i, sat in pairs(sat_list) do
		if TestValid(sat) then
			sat.Prevent_AI_Usage(false)
			sat.Prevent_Opportunity_Fire(false)
			sat.Prevent_All_Fire(false)
			--flagging sats here
			sat.Highlight(true)
			Add_Radar_Blip(sat, "somename")
			
		end
	end

	Story_Event("sats_awake")
end

-- Turn on AI and target of opportunity fire by and for all units of a given type and hint in the table
function Wake_Units(unit_type_table)

	if unit_type_table == wakeup_table_1 then
		Story_Event("batch_1_wake")
	elseif unit_type_table == wakeup_table_2 then
		Story_Event("batch_2_wake")
	elseif unit_type_table == wakeup_table_3 then
		Story_Event("batch_3_wake")
	end
	
	for i, type_and_hint in pairs(unit_type_table) do
		unit = Find_Hint(type_and_hint[1], type_and_hint[2])
		if TestValid(unit) then
			unit.Prevent_AI_Usage(false)
			unit.Prevent_Opportunity_Fire(false)
			unit.Suspend_Locomotor(false)
			unit.Prevent_All_Fire(false)
			
			--jdg flags these guys
			unit.Highlight(true)
			Add_Radar_Blip(unit, "somename")
		else
			return
		end
	end

	
	
end

-- Make units vulnerable by setting them as player units (but not selectable/controllable)
function SwitchToRebel(unit)
	unit.Set_Selectable(false)
	unit.Change_Owner(rebel_player)
	--unit.Prevent_Opportunity_Fire(false)
	unit.Suspend_Locomotor(true)
	unit.Prevent_All_Fire(true)
	
end



function State_M09_Plans_Recovered(message)
	if message == OnEnter then
		if not flag_shuttles_escaping then
			flag_shuttles_escaping = true
			
			-- Make transports move to an exit point
			if TestValid(transport1) then
				--transport1.Set_Selectable(true)
				transport1.Suspend_Locomotor(false)
				transport1.Move_To(exit_marker)
			end
			if TestValid(transport2) then
				--transport2.Set_Selectable(true)
				transport2.Suspend_Locomotor(false)
				transport2.Move_To(exit_marker)
			end
			if TestValid(transport3) then
				--transport3.Set_Selectable(true)
				transport3.Suspend_Locomotor(false)
				transport3.Move_To(exit_marker)
			end
			if TestValid(transport4) then
				--transport4.Set_Selectable(true)
				transport4.Suspend_Locomotor(false)
				transport4.Move_To(exit_marker)
			end
			
			Create_Thread("Ending_Cinematic")
		end
	end
end



-- Here we can get functionality outside (and before) event functions
function Story_Mode_Service()

	if first_time_serviced then
		first_time_serviced = false

		-- Turn AI off globally while we establish which units the scripted AI is allowed to use		
		Suspend_AI(1)

		empire_player = Find_Player("Empire")
		rebel_player = Find_Player("Rebel")
		empire_unit_list = Find_All_Objects_Of_Type(empire_player)
		for i, unit in pairs(empire_unit_list) do
			
			--Make sure that any units which may have been given move orders
			--before we had a chance to suspend the AI, now only have stop orders.
			if unit.Is_Category("Corvette") or unit.Is_Category("Frigate") or unit.Is_Category("Transport")
			or (unit.Is_Category("Capital") and not unit.Get_Type() == Find_Object_Type("EMPIRE_STAR_BASE_4")) then
				unit.Move_To(unit.Get_Position())
			end

			-- Prevent the Starbase from ever firing
			if unit.Get_Type() == Find_Object_Type("EMPIRE_STAR_BASE_4") then
				unit.Prevent_All_Fire(true)
				unit.Set_Selectable(false)
			end
			
			-- Turn on EMP effects (not working)
			Hide_Sub_Object(unit, 0, "pi_damage_elec_cap00.alo")
			Hide_Sub_Object(unit, 0, "pi_damage_elec_sd00.alo")
			
			-- Turn off AI and target of opportunity fire by and for this unit
			unit.Prevent_AI_Usage(true)
			unit.Prevent_Opportunity_Fire(true)
			unit.Suspend_Locomotor(true)
			unit.Prevent_All_Fire(true)
		end

		-- Reenable AI globally, so that when we stop preventing ai usage for one unit, it will wake
		Suspend_AI(0)

	end
end

------------------------------------------------------------------------------------------------------------------------
-- dme Mission over, trigger end cinematic.
------------------------------------------------------------------------------------------------------------------------


function State_Rebel_A3_M09_Plans_Recovered_00(message)
	if message == OnEnter then
		Create_Thread("Ending_Cinematic")
	end
end

------------------------------------------------------------------------------------------------------------------------
-- dme Ending Cinematic stuff
------------------------------------------------------------------------------------------------------------------------


function Ending_Cinematic()
	
	Cancel_Fast_Forward() 
	rebel = Find_Player("Rebel")
	unit_list = Find_All_Objects_Of_Type(rebel)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
	Story_Event("DISABLE_ANTILLES_KILLED")
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
		
	Story_Event("START_END_CINEMATIC")
	
--	Ensure Antilles is still present for this cinematic
	
	sundered_heart = Find_First_Object("SUNDERED_HEART")
	if not sundered_heart then
		return
	end
	
	warp_loc = Find_Hint("GENERIC_MARKER_SPACE", "warploc")
		
	Start_Cinematic_Camera()
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(warp_loc, 1000, -10, -90, 1, 0, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(sundered_heart, 0, 0, 0, 0, sundered_heart, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(warp_loc, 5, 200, 2.5, -37.5, 1, 0, 1, 0)
	Transition_Cinematic_Camera_Key(warp_loc, 5, 200, 17, 15, 1, 0, 1, 0)
	
	
	Start_Cinematic_Space_Retreat(rebel.Get_ID(), 8)
	
	Sleep(4)
	Story_Event("MISSION_09_VICTORY")
	
	Sleep(3.9)
	Set_Cinematic_Target_Key(sundered_heart, 0, 0, 0, 0, 0, 0, 0)
	End_Cinematic_Camera()
end