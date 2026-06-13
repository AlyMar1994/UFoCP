-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M06_LAND.lua#27 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M06_LAND.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Joseph_Gernert $
--
--            $Change: 34948 $
--
--          $DateTime: 2005/12/12 17:11:26 $
--
--          $Revision: #27 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

-- Land Map Numeric Definitions:
-- 1 = Commander Group 1 => 14
-- 2 = Commander Group 2 R> 16
-- 3 = Commander Group 3 R> 17
-- 4 = Commander Group 4 R> 18
-- 5 = Commander Group 5 R> 15
-- Imperial_Stormtrooper_Squad =>10
-- Imperial_Mini_Stormtrooper_Squad 12<=>13
-- AT_ST_Walker =>10
-- 80 Trigger Zone: Pirate Invasion (21,22)
-- 81 Trigger Zone: Rancors (31)
-- 82 Trigger Zone: Rebel Invasion (41,42,43,44)

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	StoryModeEvents = 
	{
		Empire_A02M06_Begin = State_Empire_A02M06_Begin,
		Empire_A02M06_Trigger_Rebels = State_Empire_A02M06_Trigger_Rebels,
		Empire_A02M06_Encourage_Timer_Highlight = State_Empire_A02M06_Encourage_Timer_Highlight,
		Empire_A02M06_Encourage_T2B = State_Empire_A02M06_Encourage_T2B,
		Empire_A02M06_Encourage_T2B_Highlight = State_Empire_A02M06_Encourage_T2B_Highlight,
		Empire_A02M06_Encourage_T4B = State_Empire_A02M06_Encourage_T4B,
		Empire_A02M06_Encourage_T4B_Highlight = State_Empire_A02M06_Encourage_T4B_Highlight,
		Empire_A02M06_Encourage_Pod_Walker = State_Empire_A02M06_Encourage_Pod_Walker,
		Empire_A02M06_Encourage_Pod_Walker_Highlight = State_Empire_A02M06_Encourage_Pod_Walker_Highlight,
		Empire_A02M06_Encourage_Pirates_Highlight = State_Empire_A02M06_Encourage_Pirates_Highlight,
		Empire_A02M06_Emperor_Response_00 = State_Empire_A02M06_Emperor_Response_00,
		Empire_A02M06_Emperor_Response_02 = State_Empire_A02M06_Emperor_Response_02,
		Empire_A02M06_All_Rebel_Destroyed_WIN = State_Empire_A02M06_All_Rebel_Destroyed_WIN,
		Empire_A02M06_Rebel_Destroyed_Complete_Mission = State_Empire_A02M06_Rebel_Destroyed_Complete_Mission
	}

	type_list1 = {
		"Rebel_Infantry_Squad",
		"Rebel_Light_Tank_Brigade"
	}
	
	type_list2 = {
		"Rebel_Infantry_Squad",
		"Rebel_Infantry_Squad"
	}
	
	type_list3 = {
		"Rebel_Infantry_Squad",
		"Rebel_Infantry_Squad"
	}

	type_list4 = {
		"Rebel_Infantry_Squad",
		"Rebel_Light_Tank_Brigade"
	}
	
	type_list5 = {
		"Pirate_Soldier_Squad"
	}

	prox_range_despawn_cines = 200
	prox_range_movement_patrol = 100
	prox_range_despawn_commanders = 10
	
	prox_range_spawn_pirates = 200
	prox_range_spawn_rancors = 200
	prox_range_spawn_rebels = 200
	
	rebels_are_invading = 0
	pirates_are_invading = 0
	rancors_are_invading = 0
	
	-- For memory pool cleanup hints
	
	unit = nil
	
end

function State_Empire_A02M06_Begin(message)
	if message == OnEnter then
	
--		Fade_Screen_Out(0)
		Letter_Box_In(0)
		Lock_Controls(1)

		empire_player = Find_Player("Empire")
		rebel_player = Find_Player("Rebel")
		veers_startpos = Find_All_Objects_Of_Type("Veers_AT_AT_Walker")
		veers_atat = Find_First_Object("Veers_AT_AT_Walker")

		marker10 = Find_Hint("GENERIC_MARKER_LAND", "10")
		marker12 = Find_Hint("GENERIC_MARKER_LAND", "12")
		marker13 = Find_Hint("GENERIC_MARKER_LAND", "13")
		marker14 = Find_Hint("GENERIC_MARKER_LAND", "14")
		--marker15 = Find_Hint("GENERIC_MARKER_LAND", "15")
		marker16 = Find_Hint("GENERIC_MARKER_LAND", "16")
		marker17 = Find_Hint("GENERIC_MARKER_LAND", "17")
		--marker18 = Find_Hint("GENERIC_MARKER_LAND", "18")
		marker21 = Find_Hint("GENERIC_MARKER_LAND", "21")
		marker22 = Find_Hint("GENERIC_MARKER_LAND", "22")
		marker31 = Find_Hint("GENERIC_MARKER_LAND", "31")
		marker41 = Find_Hint("GENERIC_MARKER_LAND", "41")
		marker42 = Find_Hint("GENERIC_MARKER_LAND", "42")
		marker43 = Find_Hint("GENERIC_MARKER_LAND", "43")
		marker44 = Find_Hint("GENERIC_MARKER_LAND", "44")
		marker80 = Find_Hint("GENERIC_MARKER_LAND", "80")
		marker81 = Find_Hint("GENERIC_MARKER_LAND", "81")
		marker82 = Find_Hint("GENERIC_MARKER_LAND", "82")
		
		target_hint_table = Find_All_Objects_With_Hint("99")
		for i,unit in pairs(target_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
			unit.Prevent_Opportunity_Fire(true)
			unit.Prevent_All_Fire(true)
			unit.Suspend_Locomotor(true)
		end
		
		default_hint_table = Find_All_Objects_With_Hint("1")
		for i,unit in pairs(default_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
			unit.Move_To(marker14)
		end

		command01_hint_table = Find_All_Objects_With_Hint("2")
		for i,unit in pairs(command01_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
		end

		command02_hint_table = Find_All_Objects_With_Hint("3")
		for i,unit in pairs(command02_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
		end

		command03_hint_table = Find_All_Objects_With_Hint("4")
		for i,unit in pairs(command03_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
		end

		command04_hint_table = Find_All_Objects_With_Hint("5")
		for i,unit in pairs(command04_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
		end

		default_hint_table = Find_All_Objects_With_Hint("6")
		for i,unit in pairs(default_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
			unit.Move_To(marker10)
		end

		guard_patrol_table = Find_All_Objects_With_Hint("7")
		for i,unit in pairs(guard_patrol_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
			unit.Move_To(marker12)
		end

		default_hint_table = Find_All_Objects_With_Hint("8")
		for i,unit in pairs(default_hint_table) do
			unit.Set_Selectable(false)
			unit.Prevent_AI_Usage(true)
			unit.Move_To(marker10)
		end
		
		bunker_shutoff_table = Find_All_Objects_Of_Type("IMPERIAL_OBSERVATION_BUNKER")
		for i,unit in pairs(bunker_shutoff_table) do
			unit.Set_Selectable(false)
		end

		shuttle_shutoff_table = Find_All_Objects_Of_Type("LANDED_EMPIRE_SHUTTLE")
		for i,unit in pairs(shuttle_shutoff_table) do
			unit.Set_Selectable(false)
		end

		Register_Prox(marker10, State_Empire_A02M06_Marker10_Prox, prox_range_despawn_cines, empire_player)
		Register_Prox(marker14, State_Empire_A02M06_Marker14_Prox, prox_range_despawn_commanders, empire_player)
		
		Register_Prox(marker12, State_Empire_A02M06_Marker12_Prox, prox_range_movement_patrol, empire_player)
		Register_Prox(marker13, State_Empire_A02M06_Marker13_Prox, prox_range_movement_patrol, empire_player)
		
		Register_Prox(marker80, State_Empire_A02M06_Marker80_Prox, prox_range_spawn_pirates, empire_player)
		Register_Prox(marker81, State_Empire_A02M06_Marker81_Prox, prox_range_spawn_rancors, empire_player)

		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		-- Transition_Cinematic_Target_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)

		Point_Camera_At(veers_atat)
		Start_Cinematic_Camera()
		Set_Cinematic_Camera_Key(marker14, 0, 0, 20, 0, 0, 0, 0)
		Set_Cinematic_Target_Key(veers_atat, 0, 0, 0, 0, 0, 0, 0)
		
		Fade_Screen_In(5)
		
--		Transition_Cinematic_Camera_Key(runawaycamerastart, 15, 100, 0, 300, 0, 0, 0, 0)

		
		Transition_To_Tactical_Camera(12)
		Sleep(10)
		Letter_Box_Out(0.5)
		End_Cinematic_Camera()
		Lock_Controls(0)
		
	end
end

function State_Empire_A02M06_Marker10_Prox(prox_obj, trigger_obj)
	if rebels_are_invading == 1 then
		prox_obj.Despawn()
	else
		if TestValid(trigger_obj) then
			if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") or trigger_obj.Get_Type() == Find_Object_Type("AT_ST_WALKER") then
				trigger_obj.Despawn()
			end
		end
	end
end

function State_Empire_A02M06_Marker14_Prox(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("GENERIC_FIELD_COMMANDER_EMPIRE") then
			trigger_obj.Despawn()
		end
	end
end

function State_Empire_A02M06_Marker12_Prox(prox_obj, trigger_obj)
	if rebels_are_invading == 1 then
		prox_obj.Despawn()
	else
		if TestValid(trigger_obj) then
			if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
				for i,unit in pairs(guard_patrol_table) do
					unit.Move_To(marker13)
				end
			end
		end
	end
end

function State_Empire_A02M06_Marker13_Prox(prox_obj, trigger_obj)
	if rebels_are_invading == 1 then
		prox_obj.Despawn()
	else
		if TestValid(trigger_obj) then
			if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
				for i,unit in pairs(guard_patrol_table) do
					unit.Move_To(marker12)
				end
			end
		end
	end
end

function State_Empire_A02M06_Marker80_Prox(prox_obj, trigger_obj)
	if pirates_are_invading == 0 then
		if trigger_obj.Get_Type() == Find_Object_Type("VEERS_AT_AT_WALKER") then
			pirates_are_invading = 1
 			ReinforceList(type_list5, marker21, rebel_player, true, true, true, Attack_Veers)
 			ReinforceList(type_list5, marker22, rebel_player, true, true, true, Attack_Veers)
			Story_Event("A02M06_TRIGGER_PIRATES")
		end
	else
		prox_obj.Despawn()
	end
end

function Attack_Veers(attack_list)
	if TestValid(veers_atat) then
		for k, unit in pairs(attack_list) do
			if TestValid(unit) then
				unit.Attack_Move(veers_atat)
			end
		end
	end
end

function State_Empire_A02M06_Marker81_Prox(prox_obj, trigger_obj)
	if rancors_are_invading == 0 then
		if trigger_obj.Get_Type() == Find_Object_Type("VEERS_AT_AT_WALKER") then
			ref_type = Find_Object_Type("Rancor")
			rancorlist = Spawn_Unit(ref_type, marker31, rebel_player)
			rancorlist[1].Prevent_AI_Usage(true)
			--rancorlist[1].Take_Damage(1000)
			--rancorlist[1].Guard_Target(rancorlist[1].Get_Position())
			rancors_are_invading = 1
			Story_Event("A02M06_TRIGGER_RANCORS")
		end
	else
		prox_obj.Despawn()
	end
end

function State_Empire_A02M06_Trigger_Rebels()
	if rebels_are_invading == 0 then
		rebels_are_invading = 1;
		for i,unit in pairs(guard_patrol_table) do
			if TestValid(unit) then
				unit.Despawn()
			end
		end
		for i,unit in pairs(target_hint_table) do
			if TestValid(unit) then
				unit.Despawn()
			end
		end
--		Register_Prox(marker16, State_Empire_A02M06_Marker14_Prox, prox_range_despawn_commanders, empire_player)
--		Register_Prox(marker17, State_Empire_A02M06_Marker14_Prox, prox_range_despawn_commanders, empire_player)
--		Register_Prox(marker18, State_Empire_A02M06_Marker14_Prox, prox_range_despawn_commanders, empire_player)
--		Register_Prox(marker15, State_Empire_A02M06_Marker14_Prox, prox_range_despawn_commanders, empire_player)
		for i,unit in pairs(command01_hint_table) do
			if TestValid(unit) then
				unit.Set_Selectable(true)
				unit.Prevent_AI_Usage(false)
--				unit.Move_To(marker16)
			end
		end
		for i,unit in pairs(command02_hint_table) do
			if TestValid(unit) then
				unit.Set_Selectable(true)
				unit.Prevent_AI_Usage(false)
--				unit.Move_To(marker17)
			end
		end
		for i,unit in pairs(command03_hint_table) do
			if TestValid(unit) then
				unit.Set_Selectable(true)
				unit.Prevent_AI_Usage(false)
--				unit.Move_To(marker18)
			end
		end
		for i,unit in pairs(command04_hint_table) do
			if TestValid(unit) then
				unit.Set_Selectable(true)
				unit.Prevent_AI_Usage(false)
--				unit.Move_To(marker15)
			end
		end
		ReinforceList(type_list1, marker41, rebel_player, true, true, true)
		ReinforceList(type_list2, marker42, rebel_player, true, true, true)
		ReinforceList(type_list3, marker43, rebel_player, true, true, true)
		ReinforceList(type_list4, marker44, rebel_player, true, true, true)
		--Story_Event("A02M06_TRIGGER_REBELS")
		
		Create_Thread("Show_Rebels_Cine")
	end
end

function Show_Rebels_Cine()

	Sleep(2)
	
	Cancel_Fast_Forward() 
	--SET UP CINEMATIC CAMERA
	Fade_Screen_Out(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Sleep(1)
	Start_Cinematic_Camera()
	Fade_Screen_In(1)
	
	camera_start = Find_Hint("GENERIC_MARKER_LAND", "42")
	
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camera_start, 500, 12, 30, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(camera_start, 0, 0, 0, 0, camera_start, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(camera_start, 7, 500, 12, 170, 1, 0, 0, 0)
	Sleep(1)
	Story_Event("A02M06_TRIGGER_REBELS")
	Sleep(7)

	Fade_Screen_Out(1)
	Sleep(1)
	--end cinematic
	Point_Camera_At(veers_atat)
	
	Transition_To_Tactical_Camera(1)
    Letter_Box_Out(1)
    
    End_Cinematic_Camera()
    Fade_Screen_In(1)
	Lock_Controls(0)
	Suspend_AI(0)	
end




function State_Empire_A02M06_Encourage_Timer_Highlight(message)
	if message == OnEnter then
		Story_Event("A02M06_HIGHLIGHT_COURSE")
	end
end

function State_Empire_A02M06_Encourage_T2B(message)
	if message == OnEnter then
		if rebels_are_invading == 0 then
			Story_Event("A02M06_ENCOURAGE_T2B")
		end
	end
end

function State_Empire_A02M06_Encourage_T2B_Highlight(message)
	if message == OnEnter then
		Story_Event("A02M06_HIGHLIGHT_COURSE")
	end
end

function State_Empire_A02M06_Encourage_T4B(message)
	if message == OnEnter then
		if rebels_are_invading == 0 then
			Story_Event("A02M06_ENCOURAGE_T4B")
		end
	end
end

function State_Empire_A02M06_Encourage_T4B_Highlight(message)
	if message == OnEnter then
		Story_Event("A02M06_HIGHLIGHT_COURSE")
	end
end

function State_Empire_A02M06_Encourage_Pod_Walker(message)
	if message == OnEnter then
		if rebels_are_invading == 0 then
			Story_Event("A02M06_ENCOURAGE_POD_WALKER")
		end
	end
end

function State_Empire_A02M06_Encourage_Pod_Walker_Highlight(message)
	if message == OnEnter then
		Story_Event("A02M06_HIGHLIGHT_COURSE")
	end
end

function State_Empire_A02M06_Encourage_Pirates_Highlight(message)
	if message == OnEnter then
		Story_Event("A02M06_HIGHLIGHT_COURSE")
	end
end

function State_Empire_A02M06_Emperor_Response_00(message)
	if message == OnEnter then
		if rebels_are_invading == 0 then
			Story_Event("A02M06_EMPEROR_ANNOUNCES")
		end
	end
end

function State_Empire_A02M06_Emperor_Response_02(message)
	if message == OnEnter then
		if rebels_are_invading == 0 then
			Story_Event("A02M06_EMPEROR_ANNOUNCES2")
		end
	end
end 

function State_Empire_A02M06_All_Rebel_Destroyed_WIN(message)
	if message == OnEnter then
		Create_Thread("Ending_Cine")
	end
end 

function Ending_Cine()

	
	Cancel_Fast_Forward() 
	--SET UP CINEMATIC CAMERA
	Fade_Screen_Out(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Sleep(1)
	Start_Cinematic_Camera()
	Fade_Screen_In(1)
	
	if not TestValid(veers_atat) then
		--MessageBox("ending cine cannot find veers")
	end
	
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(veers_atat, 350, 12, 180, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(veers_atat, 0, 0, 0, 0, veers_atat, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(veers_atat, 20, 350, 12, 45, 1, 0, 0, 0)
	Sleep(20)
	
	--Fade_Screen_Out(1)
	--

end

--turn off cinematic camera safety stuff here
function State_Empire_A02M06_Rebel_Destroyed_Complete_Mission(message)
	if message == OnEnter then
		--MessageBox("End_Cinematic_Camera()")
		End_Cinematic_Camera()
	end
end 


