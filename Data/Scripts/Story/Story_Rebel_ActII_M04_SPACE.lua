-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActII_M04_SPACE.lua#40 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActII_M04_SPACE.lua $
--
--    Original Author: Eric_Yiskis
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36429 $
--
--          $DateTime: 2006/01/16 10:05:23 $
--
--          $Revision: #40 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

------------------------------------------------------------------------------------------------------------------------
-- Definitions -- This function is called once when the script is first created.
------------------------------------------------------------------------------------------------------------------------

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_A2_M04_Begin = State_Rebel_A2_M04_Begin
		,Rebel_A2_M04_All_Shuttles_Rescued_03 = State_End_Cinematic_Camera
	}
	
	convoy_escort_type = {
		"ACCLAMATOR_ASSAULT_SHIP",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON",
		"ACCLAMATOR_ASSAULT_SHIP",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON",
		--"TARTAN_PATROL_CRUISER",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON",
		--"TARTAN_PATROL_CRUISER",
		"TIE_FIGHTER_SQUADRON",
		"TIE_FIGHTER_SQUADRON"
	}
	
	-- these are markers in the layout where the ships will be spawned.
	convoy_escort_markers = {
		"capital4",
		"tiefighter5",
		"tiefighter6",
		"tiefighter7",
		"tiefighter8",
		"capital11",
		"tiefighter12",
		"tiefighter13",
		--"cruiser17",
		"tiefighter18",
		"tiefighter19",
		--"cruiser22",
		"tiefighter24",
		"tiefighter25"
	}
	
	shuttle_markers = {
		"shuttletyderium2",
		"shuttletyderium3",
		"shuttletyderium9",
		"shuttletyderium10",
		"shuttletyderium14",
		"shuttletyderium15",
	}

	star_destroyer_markers = {
		"shuttletyderium2",
		"cruiser22"
	}
	
	star_destoyers = {
		"VICTORY_DESTROYER"
		,"VICTORY_DESTROYER"
	}

	-- Init values
	start_service_calls = false
	shuttles_rescued = 0
	total_shuttles = 6
	player_notified = 0
	
	counter_shuttle_needs_rescue = 1
	counter_shuttles_disabled = 0
		    
	-- For memory pool cleanup hints
	unit = nil
	new_units = nil	
	convoy_escorts = nil
	star_destroyers = nil
	sundered_heart = nil
	
	flag_all_shuttles_disabled = false
	flag_mission_over = false
	
	fog_id = nil
	
end

function State_Rebel_A2_M04_Begin(message)
	if message == OnEnter then

-- Find the waypoints

		rescued_shuttle_goto = Find_Hint("GENERIC_MARKER_SPACE", "rescued-shuttle-goto")

		waypoint1 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint1")
		waypoint2 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint2")
		waypoint3 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint3")
		waypoint4 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint4")
		waypoint4a= Find_Hint("GENERIC_MARKER_SPACE", "waypoint4a")
		waypoint5 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint5")
		waypoint5a= Find_Hint("GENERIC_MARKER_SPACE", "waypoint5a")
		waypoint6 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint6")
		waypoint7 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint7")
		waypoint7a= Find_Hint("GENERIC_MARKER_SPACE", "waypoint7a")
		waypoint8 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint8")
		waypoint9 = Find_Hint("GENERIC_MARKER_SPACE", "waypoint9")
		destroyer_arrival = Find_Hint("GENERIC_MARKER_SPACE", "cruiser17")
		
		if not waypoint1 or not waypoint2 or not waypoint3 or not waypoint4 or not waypoint4a or not waypoint5 or not waypoint6 or not waypoint7 or not waypoint7a or not waypoint8 or not waypoint9 then
			MessageBox("Error - Could not find all waypoint markers.")
			return
		end
		
-- Get Empire & Rebel Owners

		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")
		neutral_player = Find_Player("Neutral")
		fog_id = FogOfWar.Reveal_All(rebel)

-- Spawn the shuttles

		ref_type = Find_Object_Type("SHUTTLE_TYDERIUM_PRISONERS")
		for index, marker_name in pairs(shuttle_markers) do
			spawn_marker = Find_Hint("GENERIC_MARKER_SPACE",marker_name)
			if not spawn_marker then
				spawn_marker = waypoint1
			end
			new_units = Spawn_Unit(ref_type, spawn_marker, empire)
			for j, unit in pairs(new_units) do
				unit.Prevent_AI_Usage(true)
				unit.Mark_Parent_Mode_Object_For_Death()
				unit.Move_To(waypoint1)
				Register_Death_Event(unit,Shuttle_Destroyed)
			end
		end		

-- Spawn the escorting convoy ships

		convoy_escorts = {}
		for index, marker_name in pairs(convoy_escort_markers) do
			spawn_marker = Find_Hint("GENERIC_MARKER_SPACE",marker_name)
			if not spawn_marker then
				spawn_marker = waypoint1
			end
			ref_type = Find_Object_Type(convoy_escort_type[index])
			new_units = Spawn_Unit(ref_type, spawn_marker, empire)
			for j, unit in pairs(new_units) do
				table.insert(convoy_escorts,unit)
				unit.Prevent_AI_Usage(true)
				unit.Mark_Parent_Mode_Object_For_Death()
				if convoy_escort_type[index] ~= "ACCLAMATOR_ASSAULT_SHIP" then
					unit.Guard_Target(Find_Nearest(unit,"SHUTTLE_TYDERIUM_PRISONERS"))
					unit.Override_Max_Speed(1)
					-- max speed is 2.2 normally
					
				else
					unit.Move_To(waypoint1)
				end
			end
		end

-- Set up proximity calls to keep convoy moving along, and the final prox for shuttle exit

		prox_range = 300
		Register_Prox(waypoint1, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint2, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint3, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint4, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint4a, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint5, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint5a, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint6, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint7, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint7a, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint8, Prox_Waypoint, prox_range, empire)
		Register_Prox(waypoint9, Prox_Final_Waypoint, 200, empire)
		
-- wait a while, then spawn a star destroyer to wipe out incautious rebels. Also set up service call timer.

		Register_Timer(Spawn_Star_Destroyers,120)
		Register_Timer(Start_Service_Calls,3)

-- Ensure the mission ends if the Sundered Heart is destroyed

		new_units = Find_All_Objects_Of_Type("SUNDERED_HEART")
		if new_units then
			sundered_heart = new_units[1]
			Register_Death_Event(sundered_heart,Antillies_Destroyed)
		end

-- Start the intro cinematic

		Create_Thread("Intro_Cinematic")
	end
end

------------------------------------------------------------------------------------------------------------------------
-- jdg Opening Cinematic stuff
------------------------------------------------------------------------------------------------------------------------

function Intro_Cinematic()
	
-- Lock out controls for intro cinematic and reveal FOW

	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	Point_Camera_At(sundered_heart)
	
-- now find a shuttle to point the camera at

	shuttle = Find_Hint("GENERIC_MARKER_SPACE", "shuttletyderium9")
	
	Start_Cinematic_Camera()
	Sleep(3)
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(shuttle, 800, -4, -55, 1, 0, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(shuttle, 100, 0, 50, 0, 0, 0, 0) 
	
	Transition_Cinematic_Camera_Key(shuttle, 5, 800, -2, -55, 1, 0, 1, 0)
	
	
	Sleep (1)
	Story_Event("M04_INTRO_DIALOG_01_GO")
	Sleep (4)
	--Fade_Screen_Out(.5)
	--Sleep(.5)
	Set_Cinematic_Camera_Key(shuttle, 2000, 5, -60, 1, 0, 1, 0) 
	--Fade_Screen_In(.5)
	
	
	
	Sleep(5)
	Fade_Screen_Out(.5)
	Sleep(.5)
	Transition_To_Tactical_Camera(0)
	End_Cinematic_Camera()
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)
	Point_Camera_At(sundered_heart)
	Fade_Screen_In(.5)
	Story_Event("M04_INTRO_DIALOG_02_GO")
	
end

------------------------------------------------------------------------------------------------------------------------
-- jdg Ending Cinematic stuff
------------------------------------------------------------------------------------------------------------------------


function Ending_Cinematic()
	
-- Lock out controls for intro cinematic and reveal FOW
	Sleep (2)

	Cancel_Fast_Forward() 
	Story_Event("ALL_SHUTTLES_RESCUED")
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
-- Ensure Antilles is still present for this cinematic

	if not sundered_heart then
		return
	end
	
	warp_loc = Find_Hint("GENERIC_MARKER_SPACE", "warploc")
	exit_pos = Find_Hint("ATTACKER ENTRY POSITION", "attacker-entry")
		
	Start_Cinematic_Camera()
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(warp_loc, 1000, -10, 60, 1, 0, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(warp_loc, -20, 0, 0, 0, 0, 0, 0) 
	
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(warp_loc, 7, 600, 2.5, 110, 1, 0, 1, 0)
	Transition_Cinematic_Camera_Key(warp_loc, 7, 600, 17, 160, 1, 0, 1, 0)
	
	rebel = Find_Player("Rebel")
	unit_list = Find_All_Objects_Of_Type(rebel)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
		
	Start_Cinematic_Space_Retreat(rebel.Get_ID(), 8)
	Sleep(12)
	--End_Cinematic_Camera()
end

function State_End_Cinematic_Camera(message)
	if message == OnEnter then
		Fade_Screen_Out(2)
		Sleep(2)
		End_Cinematic_Camera()
	end
end 

-- Move the convoy along the waypoint paths

function Prox_Waypoint(prox_obj, trigger_obj)

-- Send shuttles, assault ships, and scouts; the rest are guarding the shuttles

	trigger_type = trigger_obj.Get_Type().Get_Name()
	if trigger_type == "SHUTTLE_TYDERIUM_PRISONERS" or trigger_type == "ACCLAMATOR_ASSAULT_SHIP" or trigger_type == "VICTORY_DESTROYER" then
		if prox_obj == waypoint1 then
			trigger_obj.Move_To(waypoint2)
		end
		if prox_obj == waypoint2 then
			trigger_obj.Move_To(waypoint3)
		end
		if prox_obj == waypoint3 then
			trigger_obj.Move_To(waypoint4)
		end
		if prox_obj == waypoint4 then
			trigger_obj.Move_To(waypoint4a)
		end
		if prox_obj == waypoint4a then
			trigger_obj.Move_To(waypoint5)
		end
		if prox_obj == waypoint5 then
			trigger_obj.Move_To(waypoint5a)
		end
		if prox_obj == waypoint5a then
			trigger_obj.Move_To(waypoint6)
		end
		if prox_obj == waypoint6 then
			trigger_obj.Move_To(waypoint7)
		end
		if prox_obj == waypoint7 then
			trigger_obj.Move_To(waypoint7a)
		end
		if prox_obj == waypoint7a then
			if trigger_type == "SHUTTLE_TYDERIUM_PRISONERS" and player_notified == 0 then
				if not flag_all_shuttles_disabled then
					player_notified = 1
					Story_Event("SHUTTLE_ESCAPED")
				end
			end
			trigger_obj.Move_To(waypoint8)
		end
		if prox_obj == waypoint8 then
			trigger_obj.Move_To(waypoint9)
		end
	end
end

function Prox_Final_Waypoint(prox_obj, trigger_obj)
	trigger_obj.Hyperspace_Away()
end

function Spawn_Star_Destroyers()
	Story_Event("DESTROYERS_INBOUND")
	spawn_marker = Find_Hint("GENERIC_MARKER_SPACE",marker_name)
	new_units = SpawnList(star_destoyers, destroyer_arrival, empire, false, true)
	for j, unit in pairs(new_units) do
		unit.Prevent_AI_Usage(true)
		unit.Mark_Parent_Mode_Object_For_Death()
		unit.Move_To(waypoint1)
	end
end

-- The prox_obj is an immobilized shuttle waiting to be rescued
-- The trigger object is a rebel ship

function Prox_Shuttle_Rescue(prox_obj, trigger_obj)

-- You must rescue with Capt. Antillies

	if trigger_obj ~= sundered_heart then
		return
	end
	prox_obj.Cancel_Event_Object_In_Range(Prox_Shuttle_Rescue)
	Create_Thread("Handle_Shuttle_Rescue_Thread", prox_obj)

end

function Antillies_Destroyed()
	if not flag_mission_over then
		Story_Event("ANTILLIES_DESTROYED")
	end
end

-- let play know that a disabled shuttle is waiting for a rescue

function Shuttle_Needs_Rescue(unit)
	if TestValid(unit) then
		if counter_shuttle_needs_rescue == 1 then
			Story_Event("SHUTTLE_NEEDS_RESCUE_1")
			counter_shuttle_needs_rescue = counter_shuttle_needs_rescue + 1
		elseif counter_shuttle_needs_rescue == 2 then
			Story_Event("SHUTTLE_NEEDS_RESCUE_2")
			counter_shuttle_needs_rescue = counter_shuttle_needs_rescue + 1
		end
		
	end
end

function Shuttle_Destroyed()
	if not flag_mission_over then
		Story_Event("SHUTTLES_LOST")
	end
end

------------------------------------------------------------------------------------------------------------------------

-- Some values are not properly initialized (Under_Effects_Of_Ability) on the first frame of execution, wait a bit...

function Start_Service_Calls()
	start_service_calls = true
end

-- Here is an opportunity for updates outside of an event

function Story_Mode_Service()

-- wait until things are initialized (See Start_Service_Calls)

	if not start_service_calls then
		return
	end
	
-- If the user hasn't enough Y-Wings and there are still shuttles left to disable, end the mission

	if not flag_all_shuttles_disabled then
		ywing_total = Find_All_Objects_Of_Type("Y-Wing")
		if not TestValid(ywing_total[1]) then
			shuttle_list = Find_All_Objects_Of_Type("SHUTTLE_TYDERIUM_PRISONERS")
			for j, unit in pairs(shuttle_list) do
				if not unit.Is_Under_Effects_Of_Ability("Ion_Cannon_Shot") then
					Story_Event("NOT_ENOUGH_YWINGS")
					break
				end
			end
		end
	end

-- if a shuttle gets ion-cannon'ed, set it up for rescue.

	shuttle_list = Find_All_Objects_Of_Type("SHUTTLE_TYDERIUM_PRISONERS")
	for i, unit in pairs(shuttle_list) do
		if TestValid(unit) then
			if unit.Is_Under_Effects_Of_Ability("Ion_Cannon_Shot") and unit.Get_Owner() ~= rebel then
				--Story_Event("SHUTTLE_DISABLED")
				unit.Change_Owner(rebel)
				unit.Move_To(unit.Get_Position())
				unit.Set_Selectable(false)
				unit.Highlight(true)
				Register_Prox(unit, Prox_Shuttle_Rescue, 75, rebel)
				Register_Timer(Shuttle_Needs_Rescue,15,unit)
				
				if counter_shuttles_disabled == 0 then
					counter_shuttles_disabled = counter_shuttles_disabled + 1
					Story_Event("SHUTTLE_DISABLED1")
				elseif counter_shuttles_disabled == 1 then
					counter_shuttles_disabled = counter_shuttles_disabled + 1
					Story_Event("SHUTTLE_DISABLED2")
				elseif counter_shuttles_disabled == 2 then
					counter_shuttles_disabled = counter_shuttles_disabled + 1
					Story_Event("SHUTTLE_DISABLED3")
				elseif counter_shuttles_disabled == 3 then
					counter_shuttles_disabled = counter_shuttles_disabled + 1
					Story_Event("SHUTTLE_DISABLED4")	
				else
					counter_shuttles_disabled = counter_shuttles_disabled + 1
				end
				
				if counter_shuttles_disabled == 6 then
					-- turn off y-wing loss condition here
					--MessageBox("All 6 shuttles disabled--turning off y-wing lose condition")
					Story_Event("CANCEL_NOT_ENOUGH_YWINGS")
					flag_all_shuttles_disabled = true
				end
				break
			end
		end
	end
end

function Handle_Shuttle_Rescue_Thread(shuttle_obj)

	shuttles_rescued = shuttles_rescued + 1	
	
-- Check if the appropriate amount of shuttles has been met for collection

	if shuttles_rescued >= total_shuttles then
		flag_mission_over = true
		Create_Thread("Ending_Cinematic")
	elseif shuttles_rescued == 1 then
			Story_Event("1_SHUTTLE_RESCUED")
	elseif shuttles_rescued == 2 then
			Story_Event("2_SHUTTLES_RESCUED")
	elseif shuttles_rescued == 3 then
			Story_Event("3_SHUTTLES_RESCUED")
	elseif shuttles_rescued == 4 then
			Story_Event("4_SHUTTLES_RESCUED")
	elseif shuttles_rescued == 5 then
			Story_Event("5_SHUTTLES_RESCUED") 
	end

	shuttle_obj.Highlight(false)
	shuttle_obj.Make_Invulnerable(true)
	shuttle_obj.Prevent_AI_Usage(true)
	shuttle_obj.Prevent_All_Fire(true)
	
	--Play a rescue effect for player feedback and wait for it to finish before removing the shuttle
	shuttle_obj.Attach_Particle_Effect("Rescue_Effect")
	Sleep(1)

	--shuttle_obj.Teleport(waypoint1)
	shuttle_obj.Teleport(rescued_shuttle_goto)
	--shuttle_obj.Move_To(shuttle_obj.Get_Position())
	shuttle_obj.Move_To(rescued_shuttle_goto)
	shuttle_obj.Hide(true)
	shuttle_obj.Stop()
	
	
	--below will not work unless we can cancel the death event
	--shuttle_obj.Change_Owner(neutral_player)
	--shuttle_obj.Despawn()

end