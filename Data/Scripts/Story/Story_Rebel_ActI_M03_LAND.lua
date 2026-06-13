-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActI_M03_LAND.lua#5 $																						  
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

--
-- Definitions -- This function is called once when the script is created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_Act1_M03_Begin = State_Rebel_A01M03_Begin
		,Rebel_ActI_M03_Pilot_Despawned_01 = State_Rebel_A01M03_Create_AA_Turrets
		,Rebel_ActI_M03_Check_Win_00 = State_Rebel_A01M03_Xwing_Escape
	}
	
	reinforce_list = {
		"Imperial_Heavy_Scout_Squad_Small"
		,"Imperial_Medium_Stormtrooper_Squad"
		,"Imperial_Light_Scout_Squad"
		,"Imperial_Anti_Infantry_Brigade_Small"
	}

	num_reinforcements = 0
	allowed_reinforcements = 2
	reinforcement_delay = 180
	front_xwing_range = 80
	rear_xwing_range = 120

	power_hint_range = 175
	cancel_hint_range =150

	captured_list = {}
	captured_count = 0

	-- For memory pool cleanup hints
	rebel_player = nil
	empire_player = nil
	
	fog_id = nil
	fog_id2 = nil
	fog_id3 = nil
	powerplant_reveal = nil
	
end

function State_Rebel_A01M03_Begin(message)
	if message == OnEnter then
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)

		 --Sample use of Find_All_Objects_With_Hint to have all the 'field guards' placed in guard mode in a simple loop
		guard_table = Find_All_Objects_With_Hint("guard")
		
		for i,unit in pairs(guard_table) do
			unit.Guard_Target(unit.Get_Position())
		end
		
		pilot_entry = Find_Hint("GENERIC_MARKER_LAND", "pilot-entry")
			
		-- Find the xwings
		front_xwing_list = Find_All_Objects_With_Hint("front-xwing")
		rear_xwing_list = Find_All_Objects_With_Hint("rear-xwing")

		-- Find the spawn points													 
		marker_list = Find_All_Objects_Of_Type("REINFORCEMENT_POINT_PLUS5_CAP")
		
		-- Find the build pads and don't let the AI control them so we can force AA turrets to be built there
		build_pad_list = Find_All_Objects_Of_Type("EMPIRE_BUILD_PAD")

		
		-- Empire reinforcements will be called in when rebel units near this marker															  
		trigger_spawn_0 = Find_Hint("GENERIC_MARKER_LAND", "reinforce_trigger")

		-- turbolaser towers & hint markers
		backup_marker = Find_Hint("GENERIC_MARKER_LAND", "backup")
		turbolaser1 = Find_Hint("E_GROUND_TURBOLASER_TOWER","tlt1")
		turbolaser2 = Find_Hint("E_GROUND_TURBOLASER_TOWER","tlt2")
		tl_hint_marker = Find_Hint("GENERIC_MARKER_LAND","turretreveal")
		tl_cancel_marker = Find_Hint("GENERIC_MARKER_LAND","trcancel")
		power_plant = Find_First_Object("POWER_GENERATOR_E")

		if not turbolaser1 or not turbolaser2 or not tl_hint_marker or not tl_cancel_marker or not power_plant then
			--MessageBox("Can't find new marker object(s)")
		end

		-- Make sure we found everything
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")
		rebel_player = Find_Player("Rebel")
		empire_player = Find_Player("Empire")
		neutral_player = Find_Player("Neutral")

		-- register turbolaser / power hint and cancel markers

		-- Register all the xwings so we know when a pilot has approached it
		for i, frontxwing in pairs(front_xwing_list) do
			Register_Prox(frontxwing, Xwing_Prox, front_xwing_range, rebel_player)
		end   
		
		for i, rearxwing in pairs(rear_xwing_list) do
			Register_Prox(rearxwing, Xwing_Prox, rear_xwing_range, rebel_player)
		end  

		if TestValid(trigger_spawn_0) then
			--MessageBox("Found reinforcement marker")
			Register_Prox(trigger_spawn_0, Bring_In_Main_Reinforcements, 200, rebel_player)
		end
		
		pad_list = Find_All_Objects_Of_Type("Skirmish_Build_Pad")
		for i,pad in pairs(pad_list) do
			pad.Lock_Build_Pad_Contents(true)
			pad.Change_Owner(empire_player)
		end
		
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
	
	-- now find cinematic x-wing
	xwing = Find_First_Object("STORY_TRIGGER_ZONE_00")
	if not xwing then
		--MessageBox("intro cinematic Can't find xwing!!!")
		return
	end
	
	-- now find first pilot
	pilot = Find_Hint("REBEL_PILOT")
	if not pilot then
		--MessageBox("intro cinematic Can't find pilot!!!")
		return
	end
	
	Point_Camera_At(REBEL_PILOT)
	
	
	Start_Cinematic_Camera()
	Fade_Screen_In(.5)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(xwing, 500, 45, 0, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(xwing, 0, 0, 0, 0, 0, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(xwing, 2, 200, 30, 0, 1, 0, 0, 0) 

	Sleep(2)
	Story_Event("M03_INTRO_DIALOG_01_GO")

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(xwing, 200, 30, 0, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(xwing, 0, 0, 0, 0, 0, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(xwing, 3, 200, 30, 270, 1, 0, 0, 0) 
	
	Sleep(3)

	fog_id = FogOfWar.Temporary_Reveal(rebel_player, turbolaser1, 200)
	fog_id2 = FogOfWar.Temporary_Reveal(rebel_player, turbolaser2, 200)

	-- move camera to turbolaser tower and reveal them

	Story_Event("turbolaser_power_hint")

	Point_Camera_At(turbolaser1)

	Set_Cinematic_Camera_Key(turbolaser1, 500, 35, 65, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(turbolaser1, 0, 0, 0, 0, turbolaser1, 0, 0)
	
	Sleep(1)	
	Cinematic_Zoom(3,0.3)	
	Sleep(2)

	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	-- Transition_Cinematic_Camera_Key(turbolaser2, 4, 200, 20, 40, 1, 0, 0, 0) 
	
	Sleep(1)

    

	powerplant_reveal = FogOfWar.Reveal(rebel_player, power_plant, 200,200)
	power_plant.Highlight(true)
	Add_Radar_Blip(power_plant, "blip_power_plant")

	Story_Event("turbolaser_power_hint2")

	Set_Cinematic_Camera_Key(power_plant, 450, 45, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(power_plant, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(power_plant, 5, 300, 30, 15, 1, 0, 0, 0) 

	pilot_list = Find_All_Objects_Of_Type("REBEL_PILOT")
	for i,unit in pairs(pilot_list) do
		unit.Teleport(pilot_entry.Get_Position())
	end

	Sleep(4)

	-- return control

	closest_player_unit = Find_Nearest(turbolaser1, rebel_player, true)
	Point_Camera_At(closest_player_unit)	
       
	End_Cinematic_Camera()
	powerplant_reveal.Undo_Reveal()
	-- Fade_Screen_In(.5)
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Sleep(4)
	Suspend_AI(0)
	
	
	
	Story_Event("M03_INTRO_DIALOG_02_GO")
end
------------------------------------------------------------------------------------------------------------------------

function Xwing_Prox(prox_obj, trigger_obj)

	--MessageBox("Rebel near uplink!")
	if TestValid(trigger_obj) and trigger_obj.Get_Type() == Find_Object_Type("Rebel_Pilot") then
		-- Pilot is near the uplink
		--MessageBox("Pilot entering xwing!")
		tl_hint_given = true

		-- Cencel this proximity check so no other pilots try to enter this xwing
		prox_obj.Cancel_Event_Object_In_Range(Xwing_Prox)
		
		-- Tell the story mode that we're going to despawn a pilot
		-- This event is perpetual so it will be triggered every time a pilot nears an xwing
		Story_Event("pilot_despawned")
		
		-- Get rid of pilot
		trigger_obj.Despawn()

		-- Add this xwing to the captured list
		--table.insert(captured_list,prox_obj)
		captured_list[captured_count] = prox_obj
		captured_count = captured_count + 1

		-- Play anim on xwing
		prox_obj.Play_Animation("Deploy",false)

		-- Change the owner to the rebel so the empire units will target them														  
		prox_obj.Change_Owner(rebel_player)
	end
end

-- Bring in a large group of reinforcements when player nears xwings
function Bring_In_Main_Reinforcements(prox_obj, trigger_obj)
	--MessageBox("Bringing in main reinforcements!")
	
	-- Find the first pilot.  They're all in a team so they're always close together																								 
	pilot = Find_First_Object("Rebel_Pilot")
	best_marker = nil
	best_distance = 99999
	tl_hint_given = true

	-- Find the closest empire controlled reinforcement point to the pilot
	if TestValid(pilot) then
		for i, marker in pairs(marker_list) do
			if marker.Get_Owner() == empire_player then
				distance = marker.Get_Distance(pilot)
				if distance < best_distance then
					best_marker = marker
					best_distance = distance
				end
			end
		end
	end

	if TestValid(best_marker) then	
		--MessageBox("Spawning reinforcements")
		ReinforceList(reinforce_list, best_marker, empire_player, true, true, true)
		prox_obj.Cancel_Event_Object_In_Range(Bring_In_Main_Reinforcements)
		Story_Event("m03_reinforcements_spotted")
	else
		-- It's valid for the player to control all reinforcement points
		--MessageBox("Marker not found")
	end
end												

function State_Rebel_A01M03_Create_AA_Turrets(message)
	if message == OnEnter then
		tl_hint_given = true
		Sleep(10)
		-- This function is triggered the first time a pilot enters an xwing
		for j, pad in pairs(build_pad_list) do
			--MessageBox("Build on build pad")
			pad.Change_Owner(empire_player)
			pad.Build("UC_Empire_Buildable_Anti_Aircraft_Turret")
			pad.Lock_Build_Pad_Contents(true)
			pad.Change_Owner(neutral_player)
		end
		ReinforceList(reinforce_list, backup_marker, empire_player, true, true, true)
		
		fog_id3 = FogOfWar.Reveal(rebel_player, backup_marker, 9999, 9999)
		aa_gun_uc_list = Find_All_Objects_Of_Type("UC_Empire_Buildable_Anti_Aircraft_Turret")
		for j, aa_gun_uc in pairs(aa_gun_uc_list) do
			--MessageBox("Placing Highlight on building aa guns!")
			Add_Radar_Blip(aa_gun_uc, "blip_aa_uc_gun")
			--aa_gun_uc.Highlight(true)
			aa_gun_uc.Highlight_Small(true,  -100)
		end
		Sleep(18)
		aa_gun_list = Find_All_Objects_Of_Type("Empire_Anti_Aircraft_Turret")
		for j, aa_gun in pairs(aa_gun_list) do
			--MessageBox("Placing Highlight on building aa guns!")
			Add_Radar_Blip(aa_gun, "blip_aa_gun")
			--aa_gun.Highlight(true)
			aa_gun.Highlight_Small(true, -100)
		end
	end
end
				 
function State_Rebel_A01M03_Xwing_Escape(message)
	if message == OnEnter then

		Cancel_Fast_Forward() 
		
		total_delay = 0.5
		xwing_index = 1

		if TestValid(neutral_player) then
			for j, xwing in pairs(captured_list) do
				xwing.Change_Owner(neutral_player)
			end
		else
			--MessageBox("Unable to switch xwings to neutral player")
		end

		-- Have the first xwing takeoff
		xwing = captured_list[0]
		xwing.Play_Animation("Takeoff",false)
		
		-- Delay the takeoff of the remaining xwings
		if xwing_index < captured_count then
			Register_Timer(Xwing_Escape, total_delay)
		end

		Create_Thread("Ending_Cinematic")
		
		
	end
end				

function Xwing_Escape()

	xwing = captured_list[xwing_index]
	if TestValid(xwing) then
		xwing.Play_Animation("Takeoff",false)
	end
	
	xwing_index = xwing_index + 1
	
	if xwing_index < captured_count then
		Register_Timer(Xwing_Escape, total_delay)
	end
end

------------------------------------------------------------------------------------------------------------------------
-- jdg Ending Cinematic stuff
------------------------------------------------------------------------------------------------------------------------

function Ending_Cinematic()

	-- Lock out controls for intro cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
		
	-- now find cinematic x-wing
	xwing = Find_First_Object("CAPTUREABLE_XWING")
	if not xwing then
		--MessageBox("ending cinematic Can't find xwing!!!")
		return
	end
		
	Start_Cinematic_Camera()
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(xwing, 400, 19, 275, 1, 1, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(xwing, -100, 0, 0, 0, xwing, 0, 1) 
	
	Cinematic_Zoom(16,1.4)
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	-- Transition_Cinematic_Target_Key(xwing, 8, 0, 0, 0, 0, xwing, 0, 1) 
	
	Sleep(2)
	
	Story_Event("CUE_M03_ENDING_DIALOG")
	
	Sleep(6)
	
	--Story_Event("CUE_M03_WIN")
	
end
------------------------------------------------------------------------------------------------------------------------