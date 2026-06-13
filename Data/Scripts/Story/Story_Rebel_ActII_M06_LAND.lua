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
		Rebel_M06_Begin = State_Rebel_M06_Begin
		,Rebel_M06_Start_OpeningDialog_HanSolo_01_Remove_Text = State_OpeningDialog_HanSolo_01_Remove_Text
		,Rebel_M06_Start_OpeningDialog_MonMothma_01_Remove_Text = State_OpeningDialog_MonMothma_01_Remove_Text
		,Rebel_M06_Start_OpeningDialog_HanSolo_02_Remove_Text = State_OpeningDialog_HanSolo_02_Remove_Text
		,Rebel_M06_Prison_Delayed_Explosion_00b = State_Rebel_M06_Prison_Delayed_Explosion_00b
		,Rebel_M06_Prison_Delayed_Explosion_01b = State_Rebel_M06_Prison_Delayed_Explosion_01b
		,Rebel_M06_Prison_Delayed_Explosion_02b = State_Rebel_M06_Prison_Delayed_Explosion_02b
		,Rebel_M06_Prison_Delayed_Explosion_03b = State_Rebel_M06_Prison_Delayed_Explosion_03b
		,Rebel_M06_Prison_Delayed_Explosion_04b = State_Rebel_M06_Prison_Delayed_Explosion_04b
		,Rebel_M06_Set_Goal = State_Rebel_M06_Set_Goal
		,Rebel_M06_Han_End_Cin_01b = State_Rebel_M06_Han_End_Cin_01b
	}
	
	prison_marker_names = {
		"prison1-marker",
		"prison2-marker",
		"prison3-marker",
		"prison4-marker",
		"prison5-marker"
	}
	
	prison_list = {}
	prison_markers = {}
	prison_locations = {}
	wookie_houses = {}
	
	-- Victory Condition Tracking --
	
	wookies_liberated = 0
	wookies_liberated_goal = 5
	wookies_armed = 0
	wookies_armed_goal = 3
	
	unarmed_wookie_type_list = {
		"Kashyyyk_Wookie_War_Party_Unarmed"
	}
	
	armed_wookie_type_list = {
		"Kashyyyk_Wookie_War_Party"
	}
	
	han_solo = nil
	hans_health = nil
	waiting_for_next_complaint = false
	flag_prison_attacked = false
	time_required_to_jailbreak = 30
	release_the_hounds = false
	
	flag_prison_1_destroyed = false
	flag_prison_2_destroyed = false
	flag_prison_3_destroyed = false
	flag_prison_4_destroyed = false
	flag_prison_5_destroyed = false
	flag_mission_initiated = false
end

-----------------------------------------------------------------------------------------------------------------------

function Tell_Units_To_Guard(unit_list)
	if unit_list == nil then
		return
	end
	for i, unit in pairs(unit_list) do
		unit.Prevent_AI_Usage(true)
		unit.Guard_Target(unit.Get_Position())
	end
end

-----------------------------------------------------------------------------------------------------------------------

-- Explosives were placed in the prisons, Han Solo has the destruct codes

function Prox_Prison(prox_obj, trigger_obj)
	if trigger_obj.Get_Type().Get_Name() == "HAN_SOLO" then
		if TestValid(trigger_obj) then
		--put han in bomb animation here 
			
			Create_Thread("Han_Ties_His_Shoes")
			prox_obj.Cancel_Event_Object_In_Range(Prox_Prison)
			trigger_obj.Set_Selectable(false)
			Story_Event("XML_PRISON_DELAY")
		end
	end
end

function Han_Ties_His_Shoes()
	if TestValid(han_solo) then
		--MessageBox("han starts shoe tying anim")
		han_solo.Stop()
		han_solo.Prevent_All_Fire(true)
		han_solo.Prevent_AI_Usage(true)
		han_solo.Suspend_Locomotor(true)
		--rebel.Select_Object(falcon_spawn_point) 
		Sleep(1)
		han_solo.Play_Animation("cinematic", false, 2)
		Sleep(2.75)
		han_solo.Play_Animation("cinematic", true, 3)
	end
end

function State_Rebel_M06_Prison_Delayed_Explosion_00b(message)
	if message == OnEnter then
		closest_prison = Find_Nearest(han_solo, "IMPERIAL_PRISON_KASHYYYK")
		if TestValid(closest_prison) then
			closest_prison.Take_Damage(10001)
		end
		if TestValid(han_solo) then
			han_solo.Set_Selectable(true)
			Story_Event("PRISON_DESTROYED")
		end
	end
end

function State_Rebel_M06_Prison_Delayed_Explosion_01b(message)
	if message == OnEnter then
		closest_prison = Find_Nearest(han_solo, "IMPERIAL_PRISON_KASHYYYK")
		if TestValid(closest_prison) then
			closest_prison.Take_Damage(10001)
		end
		if TestValid(han_solo) then
			han_solo.Set_Selectable(true)
			Story_Event("PRISON_DESTROYED")
		end
	end
end

function State_Rebel_M06_Prison_Delayed_Explosion_02b(message)
	if message == OnEnter then
		closest_prison = Find_Nearest(han_solo, "IMPERIAL_PRISON_KASHYYYK")
		if TestValid(closest_prison) then
			closest_prison.Take_Damage(10001)
		end
		if TestValid(han_solo) then
			han_solo.Set_Selectable(true)
			Story_Event("PRISON_DESTROYED")
		end
	end
end

function State_Rebel_M06_Prison_Delayed_Explosion_03b(message)
	if message == OnEnter then
		closest_prison = Find_Nearest(han_solo, "IMPERIAL_PRISON_KASHYYYK")
		if TestValid(closest_prison) then
			closest_prison.Take_Damage(10001)
		end
		if TestValid(han_solo) then
			han_solo.Set_Selectable(true)
			Story_Event("PRISON_DESTROYED")
		end
	end
end

function State_Rebel_M06_Prison_Delayed_Explosion_04b(message)
	if message == OnEnter then
		closest_prison = Find_Nearest(han_solo, "IMPERIAL_PRISON_KASHYYYK")
		if TestValid(closest_prison) then
			closest_prison.Take_Damage(10001)
		end
		if TestValid(han_solo) then
			han_solo.Set_Selectable(true)
			Story_Event("PRISON_DESTROYED")
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------

function Prox_Wookie_House(prox_obj, trigger_obj)
	if TestValid(trigger_obj) and trigger_obj.Get_Type() == Find_Object_Type("Wookie_Warrior_Unarmed") then
		wookie_team = trigger_obj.Get_Parent_Object()
		if TestValid(wookie_team) then
			armed_wookie = SpawnList(armed_wookie_type_list, wookie_team, rebel, true, true)
			wookie_team.Despawn()
			wookies_armed = wookies_armed + 1
			if wookies_armed >= wookies_armed_goal then
				Story_Event("WOOKIES_ARMED")
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------
-- Function for Event: 
-----------------------------------------------------------------------------------------------------------------------

function State_Rebel_M06_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		-- Get Empire & Rebel Owners
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")

	
		--spawn in falcon
		falcon_spawn_point = Find_Hint("GENERIC_MARKER_LAND", "spawn-falcon")
		if not falcon_spawn_point then
			MessageBox("cannot find falcon_spawn_point")
		end
		
		falcon = Find_Hint("Millennium_Falcon_Ground", "falcon")
		
		
		if not falcon then
			MessageBox("cannot find falcon")
		end
		
		falcon.Teleport_And_Face(falcon_spawn_point)		
		empire_marker = Find_Hint("GENERIC_MARKER_LAND", "empiremarker")
		
		pad_list = Find_All_Objects_Of_Type("Skirmish_Build_Pad")
		for i,pad in pairs(pad_list) do
			pad.Lock_Build_Pad_Contents(true)
		end
		
		-- defining the prisons here
		prison_1 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "prison1") 
		prison_2 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "prison2") 
		prison_3 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "prison3") 
		prison_4 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "prison4") 
		prison_5 = Find_Hint("IMPERIAL_PRISON_KASHYYYK", "prison5") 
		
		Register_Death_Event(prison_1,Prison_Destroyed)
		Register_Death_Event(prison_2,Prison_Destroyed)
		Register_Death_Event(prison_3,Prison_Destroyed)
		Register_Death_Event(prison_4,Prison_Destroyed)
		Register_Death_Event(prison_5,Prison_Destroyed)
		--preventing turrets from auto-destroying these
		prison_1.Prevent_Opportunity_Fire(true)
		prison_2.Prevent_Opportunity_Fire(true)
		prison_3.Prevent_Opportunity_Fire(true)
		prison_4.Prevent_Opportunity_Fire(true)
		prison_5.Prevent_Opportunity_Fire(true)
		
		prison1_marker = Find_Hint("GENERIC_MARKER_LAND", "prison1-marker") 
		prison2_marker = Find_Hint("GENERIC_MARKER_LAND", "prison2-marker") 
		prison3_marker = Find_Hint("GENERIC_MARKER_LAND", "prison3-marker") 
		prison4_marker = Find_Hint("GENERIC_MARKER_LAND", "prison4-marker") 
		prison5_marker = Find_Hint("GENERIC_MARKER_LAND", "prison5-marker") 
		
		prox_range = 40
		Register_Prox(prison1_marker, Prox_Prison, prox_range, rebel)
		Register_Prox(prison2_marker, Prox_Prison, prox_range, rebel)
		Register_Prox(prison3_marker, Prox_Prison, prox_range, rebel)
		Register_Prox(prison4_marker, Prox_Prison, prox_range, rebel)
		Register_Prox(prison5_marker, Prox_Prison, prox_range, rebel)
		
		prison1_marker.Highlight(true)
		prison2_marker.Highlight(true)
		prison3_marker.Highlight(true)
		prison4_marker.Highlight(true)
		prison5_marker.Highlight(true)
		
		
		
		-- Set most of the units to guard 
		guard_list = Find_All_Objects_With_Hint("guard")
		Tell_Units_To_Guard(guard_list)
		second_list = Find_All_Objects_With_Hint("second")
		Tell_Units_To_Guard(second_list)
		
		-- Setup callbacks for prisons
		 
		
		-- Setup proximity callbacks for wookie houses
		wookie_house_range = 150
		wookie_houses = Find_All_Objects_Of_Type("WOOKIEE_HOUSE")
		for i,unit in pairs(wookie_houses) do
			Register_Prox(unit, Prox_Wookie_House, wookie_house_range, rebel)
			unit.Make_Invulnerable(true)
		end
		
		-- Look up Han Solo
		unit_list = Find_All_Objects_Of_Type("HAN_SOLO")
		if unit_list then
			han_solo = unit_list[1]
			hans_health = han_solo.Get_Hull()
			Register_Death_Event(han_solo,Han_Killed)
		end
		Create_Thread("Intro_Cinematic")
		
		flag_mission_initiated = true
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
	
	-- now find han solo
	han = Find_First_Object("HAN_SOLO")
	if not han then
		return
	end
	
	-- find R2D3
	R2D3 = Find_Hint("MOV_R2D3", "r2d3")
	if not R2D3 then
		return
	end
	
	-- find Mothma hologram
	Mothma = Find_Hint("MOV_Mothma", "mothma")
	if not Mothma then
		return
	end
	
	-- find R2D3 Flag
	R2D3_Move_To = Find_Hint("GENERIC_MARKER_LAND", "r2d3goto")
	if not R2D3_Move_To then
		return
	end
	
	Point_Camera_At(han)	
	
	R2D3.Suspend_Locomotor(true)
	R2D3.Play_Animation("cinematic", true, 0)
	
	Mothma.Play_Animation("cinematic", true, 0)
	
	falcon.Hide(true)
	
	Start_Cinematic_Camera()
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(han, 115, 15, 0, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(han, 0, 0, 0, 0, 0, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(han, 10, 105, 20, 10, 1, 0, 0, 0) 
	
	Story_Event("M06_INTRO_DIALOG_HANSOLO_01_GO")
	Mothma.Play_Animation("cinematic", true, 0)	
	han.Play_Animation("talk", true, 1)
	
end

function State_OpeningDialog_HanSolo_01_Remove_Text(message)
	if message == OnEnter then
		falcon.Hide(false)
		Story_Event("M06_INTRO_DIALOG_MONMOTHMA_01_GO")
		Mothma.Play_Animation("cinematic", true, 1)
		han.Play_Animation("idle", true, 0)
		Set_Cinematic_Camera_Key(han, 65, 11, 70, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(han, 0, 0, 15, 0, 0, 0, 0) 
		Cinematic_Zoom(8,1.3)
	end
end

function State_OpeningDialog_MonMothma_01_Remove_Text(message)
	if message == OnEnter then
		Story_Event("M06_INTRO_DIALOG_HANSOLO_02_GO")
		han.Play_Animation("talk", false, 0)
		Mothma.Play_Animation("cinematic", true, 0)
		Set_Cinematic_Camera_Key(han, 65, 15, 340, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(han, 15, 0, 10, 0, 0, 0, 0) 
		Transition_Cinematic_Camera_Key(han, 6, 70, 20, 340, 1, 0, 0, 0) 
	end
end

function State_OpeningDialog_HanSolo_02_Remove_Text(message)
	if message == OnEnter then
	
		-- get rid of the cinematic actors
		R2D3.Play_SFX_Event("Unit_Anim_R2_Holo_Off_1")
		Mothma.Despawn()
		R2D3.Play_Animation("move", true, 1)
		R2D3.Suspend_Locomotor(false)
		R2D3.Move_To(R2D3_Move_To)
		han.Play_Animation("idle", true, 0)
		Sleep(1)
		Transition_To_Tactical_Camera(2)
		Sleep(2)
		R2D3.Despawn()
		End_Cinematic_Camera()
		Letter_Box_Out(.5)	
		Lock_Controls(0)
		Suspend_AI(0)
	end
end

-----------------------------------------------------------------------------------------------------------------------

function Han_Killed()
	Story_Event("HAN_KILLED")
end

-----------------------------------------------------------------------------------------------------------------------


function State_Rebel_M06_Set_Goal(message)
	if message == OnEnter then
		prison_radar_marker = Find_All_Objects_Of_Type("IMPERIAL_PRISON_KASHYYYK")
		for i,unit in pairs(prison_radar_marker) do
			Add_Radar_Blip(unit, "prison_marker")
		end
	end
end

function Prison_Destroyed()

	--take solo out of bomb animation and allow usage again.
	if TestValid(han_solo) then
		--MessageBox("han leaves shoe tying anim")
		han_solo.Play_Animation("cinematic", false, 4)
		han_solo.Prevent_All_Fire(false)
		han_solo.Prevent_AI_Usage(false)
		han_solo.Suspend_Locomotor(false)
	end

	-- Turn the secondary group on for an assault.
	if not release_the_hounds then
		if second_list == nil then
			return
		end
		for i, unit in pairs(second_list) do
			if TestValid(unit) then
				unit.Prevent_AI_Usage(false)
				if TestValid(han) then
					unit.Attack_Move(han)
				end
			end
		end
	end
	
end

-----------------------------------------------------------------------------------------------------------------------

function Spawn_Wookie_Unit(spawn_location, marker)
	new_units = SpawnList(unarmed_wookie_type_list, marker, rebel, false, true)
end

-----------------------------------------------------------------------------------------------------------------------

function Reset_Complaint()
	waiting_for_next_complaint = false
end



-----------------------------------------------------------------------------------------------------------------------

function End_Cinematic()

	Cancel_Fast_Forward() 
	-- Lock out controls for end cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)
	
	--cinematic cleanup
	han = Find_First_Object("HAN_SOLO")
	falcon = Find_First_Object("MILLENNIUM_FALCON_GROUND")
	han.In_End_Cinematic(true)
	falcon.In_End_Cinematic(true)
	
	Do_End_Cinematic_Cleanup()
	
	
	-- now find han solo and put him at the end cine
	han_loc = Find_Hint("GENERIC_MARKER_LAND", "endstart")
	
	han.Teleport_And_Face(han_loc)
	if not han then
		return
	end
	
	-- Find Wookiee spawn location and Millennium Falcon Loc and obj
	wookiee_loc1 = Find_Hint("GENERIC_MARKER_LAND", "wookieespawn1")
	wookiee_loc2 = Find_Hint("GENERIC_MARKER_LAND", "wookieespawn2")
	falcon_loc = Find_Hint("GENERIC_MARKER_LAND", "r2d3goto")
	
	han_move = Find_Hint("GENERIC_MARKER_LAND", "handespawn")
	horizon = Find_Hint("GENERIC_MARKER_LAND", "horizonpoint")
	
	-- Spawn Wookiee war party
	wookieelist1 = SpawnList(armed_wookie_type_list, wookiee_loc1, rebel, false, true)
	wookieelist2 = SpawnList(armed_wookie_type_list, wookiee_loc2, rebel, false, true)
	
	-- Play Cheer Anim on Wookiees
	for i, wookiee in pairs(wookieelist1) do
		Sleep(0.1)
		--MessageBox("playing anim on group 1")
		wookiee.Prevent_All_Fire(true)
		wookiee.Play_Animation("celebrate", true, 0)
	end
	
	for j, wookiee2 in pairs(wookieelist2) do
		Sleep(0.1)
		--MessageBox("playing anim on group 2")
		wookiee2.Prevent_All_Fire(true)
		wookiee2.Play_Animation("celebrate", true, 0)
	end	
	
	Start_Cinematic_Camera()	
	Fade_Screen_In(1)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(han_loc, 140, 25, 110, 1, 0, 0, 0)
	
	-- Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(falcon_loc, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(1)
	
	Story_Event("WOOKIES_LIBERATED")
	
	han.Play_Animation("talk", true, 1)	
	
	Cinematic_Zoom(5,1.1)	
	
	Sleep(1)
	 
	han.Move_To(falcon_loc)	
	
	Sleep(2)	
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(falcon_loc, 350, 50, 240, 1, 0, 0, 0)
	
	-- Set_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(falcon_loc, 50, 0, 0, 0, 0, 0, 0)
	
	Sleep(.5)
	
	Story_Event("CINEMATIC_COMPLETE")
	
	Sleep(1)
	
	han.Teleport(han_move)	
	
	Sleep(1)
	
	falcon.Play_Animation("takeoff", false)	
	
	Transition_Cinematic_Camera_Key(falcon_loc, 4, 450, 55, 240, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(falcon_loc, 4, 50, 0, 500, 0, 0, 0, 0)
	
	Sleep(6)	
	Fade_Screen_Out(1)
		
	End_Cinematic_Camera()
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)
end

-----------------------------------------------------------------------------------------------------------------------

function Story_Mode_Service()

	if not flag_mission_initiated then
		return
	end

	-- See if any prisons have been attacked
	for i, unit in pairs(prison_list) do
		if unit.Is_Valid() and unit.Get_Hull() < 1.0 and not flag_prison_attacked then
			Story_Event("USE_HAN_HINT_TEXT")
			flag_prison_attacked = true
		end
	end
	
	if not flag_prison_1_destroyed and not TestValid(prison_1) then
		flag_prison_1_destroyed = true
		prison1_marker.Highlight(false)
		--Spawn_Wookie_Unit(prison1_marker.Get_Position(),prison_markers[i])
		SpawnList(unarmed_wookie_type_list, han, rebel, false, true)
		Story_Event("ARM_WOOKIE_TEXT")
		wookies_liberated = wookies_liberated + 1
		if wookies_liberated >= wookies_liberated_goal then
			Create_Thread("End_Cinematic")
		end
	end
	
	if not flag_prison_2_destroyed and not TestValid(prison_2) then
		flag_prison_2_destroyed = true
		prison2_marker.Highlight(false)
		SpawnList(unarmed_wookie_type_list, han, rebel, false, true)
		Story_Event("ARM_WOOKIE_TEXT")
		wookies_liberated = wookies_liberated + 1
		if wookies_liberated >= wookies_liberated_goal then
			Create_Thread("End_Cinematic")
		end
	end
	
	if not flag_prison_3_destroyed and not TestValid(prison_3) then
		flag_prison_3_destroyed = true
		prison3_marker.Highlight(false)
		SpawnList(unarmed_wookie_type_list, han, rebel, false, true)
		Story_Event("ARM_WOOKIE_TEXT")
		wookies_liberated = wookies_liberated + 1
		if wookies_liberated >= wookies_liberated_goal then
			Create_Thread("End_Cinematic")
		end
	end
	
	if not flag_prison_4_destroyed and not TestValid(prison_4) then
		flag_prison_4_destroyed = true
		prison4_marker.Highlight(false)
		SpawnList(unarmed_wookie_type_list, han, rebel, false, true)
		Story_Event("ARM_WOOKIE_TEXT")
		wookies_liberated = wookies_liberated + 1
		if wookies_liberated >= wookies_liberated_goal then
			Create_Thread("End_Cinematic")
		end
	end
	
	if not flag_prison_5_destroyed and not TestValid(prison_5) then
		flag_prison_5_destroyed = true
		prison5_marker.Highlight(false)
		SpawnList(unarmed_wookie_type_list, han, rebel, false, true)
		Story_Event("ARM_WOOKIE_TEXT")
		wookies_liberated = wookies_liberated + 1
		if wookies_liberated >= wookies_liberated_goal then
			Create_Thread("End_Cinematic")
		end
	end
	
	if TestValid(han_solo) and han_solo.Get_Hull() < hans_health then
		if not waiting_for_next_complaint then
			Story_Event("HAN_TAKING_DAMAGE")
			waiting_for_next_complaint = true
			Register_Timer(Reset_Complaint,10)
		end
		hans_health = han_solo.Get_Hull()
	end
end
