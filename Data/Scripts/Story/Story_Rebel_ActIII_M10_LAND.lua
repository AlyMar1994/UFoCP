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
		Rebel_A3_M10_Begin = State_Rebel_A3_M10_Begin
		,Rebel_M10_IntroCine_Dialog_Line_01_Remove_Text = State_Dialog_Line_01_Remove_Text
		,Rebel_M10_IntroCine_Dialog_Line_02_Remove_Text = State_Dialog_Line_02_Remove_Text
		,Rebel_M10_IntroCine_Dialog_Line_03_Remove_Text = State_Dialog_Line_03_Remove_Text
		,Rebel_M10_IntroCine_Dialog_Line_04_Remove_Text = State_Dialog_Line_04_Remove_Text
		,Rebel_M10_IntroCine_Dialog_Line_05_Remove_Text = State_Dialog_Line_05_Remove_Text
		,Rebel_M10_IntroCine_Dialog_Line_06_Remove_Text = State_Dialog_Line_06_Remove_Text
		,Rebel_A3_M10_Reached_Falcon_00 = State_Reached_Falcon_00
	}
	
	TransportList = 
	{
		"Imperial_Landing_Craft"
	}
	
	reinforcement_list1 =
	{
		"Imperial_Stormtrooper_Squad"
		,"Imperial_Stormtrooper_Squad"
		,"Imperial_Stormtrooper_Squad"
	}

	reinforcement_list2 =
	{
		"Imperial_Light_Scout_Squad"
		,"Imperial_Heavy_Scout_Squad"
	}

	patrol_loop_range = 100
	notice_range = 150
	notice_range_large = 300
	start_service = false
	cargo_area_reached = false
	han_arrived = false
	chewie_arrived = false
	
	fog_id = nil
			
end

function State_Rebel_A3_M10_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		
		-- Get Players
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")

		notice_stormtroopers = Find_Hint("GENERIC_MARKER_LAND", "notice-stormtroopers")
		notice_turrets = Find_Hint("GENERIC_MARKER_LAND", "notice-turrets")
		notice_maulers = Find_Hint("GENERIC_MARKER_LAND", "notice-maulers")
		notice_atsts = Find_Hint("GENERIC_MARKER_LAND", "notice-atsts")
		notice_tanks = Find_Hint("GENERIC_MARKER_LAND", "notice-tanks")
		notice_power = Find_Hint("GENERIC_MARKER_LAND", "notice-power")

		patrol_loop1_mark0 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark0")
		patrol_loop1_mark1 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark1")
		patrol_loop1_mark2 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark2")
		patrol_loop1_mark3 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark3")
		patrol_loop1_mark4 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark4")
		patrol_loop1_mark5 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop1-mark5")
		
		patrol_loop2_mark0 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop2-mark0")
		patrol_loop2_mark1 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop2-mark1")
		patrol_loop2_mark2 = Find_Hint("GENERIC_MARKER_LAND", "patrol-loop2-mark2")

		Emp_Shuttle_Land_Pos = Find_Hint("GENERIC_MARKER_LAND", "empshuttlelandpos")
		Han_Move_To = Find_Hint("GENERIC_MARKER_LAND", "hanmoveto")
		Chewie_Move_To = Find_Hint("GENERIC_MARKER_LAND", "chewiemoveto")
		Han_Move_To_2 = Find_Hint("GENERIC_MARKER_LAND", "hanmoveto2")
		Chewie_Move_To_2 = Find_Hint("GENERIC_MARKER_LAND", "chewiemoveto2")
		storage_area = Find_Hint("GENERIC_MARKER_LAND","storage-area")
		turret_camera = Find_Hint("GENERIC_MARKER_LAND","turret-camera")
		second_camera_pos = Find_Hint("GENERIC_MARKER_LAND","second-camera-pos")

		finally_hanrun = Find_Hint("GENERIC_MARKER_LAND", "hanrunto")
		finally_han_spawn = Find_Hint("GENERIC_MARKER_LAND", "hanfin")
		finally_chewie_spawn = Find_Hint("GENERIC_MARKER_LAND", "chewie-spawn")
		imp_shuttle1_loc = Find_Hint("GENERIC_MARKER_LAND", "shuttleland2")
		finally_shuttle = imp_shuttle1_loc
		imp_shuttle2_loc = Find_Hint("GENERIC_MARKER_LAND", "shuttlespot1")
		imp_shuttle1 = Create_Generic_Object("Imperial_Landing_Craft_Landing_Cinematic", imp_shuttle1_loc, empire)		
		imp_shuttle2 = Create_Generic_Object("Imperial_Landing_Craft_Landing_Cinematic", imp_shuttle2_loc, empire)
		imp_shuttle1.Teleport_And_Face(imp_shuttle1_loc)
		imp_shuttle2.Teleport_And_Face(imp_shuttle2_loc)
		imp_shuttle1.Make_Invulnerable(true)

		-- Get handles to Han and Chewie
		han_list = Find_All_Objects_Of_Type("HAN_SOLO")
		han = han_list[1]
		chewie_list = Find_All_Objects_Of_Type("CHEWBACCA")
		chewie = chewie_list[1]
		
		-- Find all disabled objects
		disabled_list = Find_All_Objects_With_Hint("disable")
		for i,unit in pairs(disabled_list) do
			unit.Prevent_Opportunity_Fire(true)
			unit.Prevent_All_Fire(true)
			unit.Lock_Current_Orders()
			unit.Prevent_AI_Usage(true)
			unit.Suspend_Locomotor(true)
		end
		
		-- Tell the service func that things have been initialized		
		start_service = true

		Create_Thread("Intro_Cinematic")
		
		--this freezes all build pads as the objects defined in the editor

		fog_id = FogOfWar.Reveal(rebel,han.Get_Position(),20000,20000)
		
		Register_Prox(patrol_loop1_mark0, f_Patrol_Loop1_Mark0, patrol_loop_range, empire)
		Register_Prox(patrol_loop1_mark1, f_Patrol_Loop1_Mark1, patrol_loop_range, empire)
		Register_Prox(patrol_loop1_mark2, f_Patrol_Loop1_Mark2, patrol_loop_range, empire)
		Register_Prox(patrol_loop1_mark3, f_Patrol_Loop1_Mark3, patrol_loop_range, empire)
		Register_Prox(patrol_loop1_mark4, f_Patrol_Loop1_Mark4, patrol_loop_range, empire)
		Register_Prox(patrol_loop1_mark5, f_Patrol_Loop1_Mark5, patrol_loop_range, empire)
		
		Register_Prox(patrol_loop2_mark0, f_Patrol_Loop2_Mark0, patrol_loop_range, empire)
		Register_Prox(patrol_loop2_mark1, f_Patrol_Loop2_Mark1, patrol_loop_range, empire)
		Register_Prox(patrol_loop2_mark2, f_Patrol_Loop2_Mark2, patrol_loop_range, empire)

		Register_Prox(notice_stormtroopers, f_Notice_Stormtroopers, notice_range, rebel)
		Register_Prox(notice_turrets, f_Notice_Turrets, notice_range, rebel)
		Register_Prox(notice_maulers, f_Notice_Maulers, notice_range, rebel)
		Register_Prox(notice_atsts, f_Notice_ATSTs, notice_range_large, rebel)
		Register_Prox(notice_tanks, f_Notice_Tanks, notice_range, rebel)
		Register_Prox(notice_power, f_Notice_Power, notice_range, rebel)
		
		Register_Prox(storage_area, f_Storage_Area, notice_range, rebel)
		Register_Prox(finally_chewie_spawn, f_End_Mission, notice_range, rebel)

		guard_table = Find_All_Objects_With_Hint("guards")
		for i,unit in pairs(guard_table) do
			unit.Guard_Target(unit.Get_Position())
		end
		
		Add_Radar_Blip(storage_area, "storage_area_blip")
	end
end

function f_End_Mission(prox_obj, trigger_obj)
	if cargo_area_reached then
		if trigger_obj == han then
			han_arrived = true
		end
		if trigger_obj == chewie then
			chewie_arrived = true
		end
		if han_arrived and chewie_arrived then
			Remove_Radar_Blip("shuttle_blip")
			prox_obj.Cancel_Event_Object_In_Range(f_End_Mission)
			Story_Event("M10_REACHED_SHUTTLE")
		end
	end
end

function f_Storage_Area(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Storage_Area)
	cargo_area_reached = true
	Story_Event("M10_REACH_CARGO_AREA")
	prox_obj.Cancel_Event_Object_In_Range(f_Patrol_Loop2_Mark0)
	reinforcements1 = SpawnList(reinforcement_list1, finally_hanrun.Get_Position(), empire, false, true)
	for i,unit in pairs(reinforcements1) do
		unit.Attack_Move(han)
	end
	reinforcements2 = SpawnList(reinforcement_list2, Han_Move_To.Get_Position(), empire, false, true)
	for i,unit in pairs(reinforcements2) do
		unit.Attack_Move(chewie)
	end
	Remove_Radar_Blip("storage_area_blip")
	Add_Radar_Blip(imp_shuttle1, "shuttle_blip")
end

function f_Notice_Stormtroopers(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_Stormtroopers)
	Story_Event("M10_DIALOG_NOTICE_STORMTROOPERS")
end

function f_Notice_Turrets(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_Turrets)
	Story_Event("M10_DIALOG_HAN_EMP_NOTICE")
end

function f_Notice_Maulers(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_Maulers)
	Story_Event("M10_DIALOG_TIE_MAULER_INTRO")
end

function f_Notice_ATSTs(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_ATSTs)
	Story_Event("M10_DIALOG_NOTICE_ATSTS")
end

function f_Notice_Tanks(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_Tanks)
	Story_Event("M10_DIALOG_NOTICE_TANKS")
end

function f_Notice_Power(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(f_Notice_Power)
	if not cargo_area_reached then
		Story_Event("M10_NOTICE_POWER_PLANT")
	end
end

------------------------------------------------------------------------------------------------------------------------
-- Patrol loop stuff
------------------------------------------------------------------------------------------------------------------------

function f_Patrol_Loop1_Mark0(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark1.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop1_Mark1(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark0.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop1_Mark2(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark3.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop1_Mark3(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark4.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop1_Mark4(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark5.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop1_Mark5(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop1_mark2.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop2_Mark0(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("AT_ST_WALKER") then
			if not trigger_obj.Has_Active_Orders() then
				trigger_obj.Attack_Move(patrol_loop2_mark1.Get_Position())
			end
		end
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop2_mark1.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop2_Mark1(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("AT_ST_WALKER") then
			if not trigger_obj.Has_Active_Orders() then
				trigger_obj.Attack_Move(patrol_loop2_mark2.Get_Position())
			end
		end
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop2_mark2.Get_Position())
				end
			end
		end
	end
end

function f_Patrol_Loop2_Mark2(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Get_Type() == Find_Object_Type("AT_ST_WALKER") then
			if not trigger_obj.Has_Active_Orders() then
				trigger_obj.Attack_Move(patrol_loop2_mark0.Get_Position())
			end
		end
		if trigger_obj.Get_Type() == Find_Object_Type("SQUAD_STORMTROOPER") then
			stormtrooper_team = trigger_obj.Get_Parent_Object()
			if TestValid(stormtrooper_team) then
				if not stormtrooper_team.Has_Active_Orders() then
					stormtrooper_team.Attack_Move(patrol_loop2_mark0.Get_Position())
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
-- Opening Cinematic stuff
------------------------------------------------------------------------------------------------------------------------

function Intro_Cinematic()

	-- Lock out controls for intro cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	-- now find cinematic x-wing
	
	Start_Cinematic_Camera()
	Set_Cinematic_Camera_Key(han, 600, 30, 315, 1, 0, 0, 0) 
	Set_Cinematic_Target_Key(han, 0, 0, 0, 0, han, 0, 0) 
	Sleep(1)
	 
	Story_Event("CUE_M10_DIALOG_HANSOLO_01")  
end

------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- Opening Cinematic dialog done call backs
------------------------------------------------------------------------------------------------------------------------

function State_Dialog_Line_01_Remove_Text(message)
	if message == OnEnter then
		Fade_Screen_In(1)		
		immperial_shuttle = Create_Cinematic_Transport("Imperial_Landing_Craft_Landing_Cinematic", empire.Get_ID(), Emp_Shuttle_Land_Pos, 180, 1, 0.25, 20, 1)
		han.Play_SFX_Event("Unit_Shuttle_Landing_3")
		Sleep(4)
		Transition_Cinematic_Camera_Key(han, 20, 500, 30, 315, 1, 0, 0, 0) 
		Story_Event("CUE_M10_DIALOG_HANSOLO_02") 
		
	end
end

function State_Dialog_Line_02_Remove_Text(message)
	if message == OnEnter then
	
		Story_Event("CUE_M10_DIALOG_HANSOLO_03") 
		
		Sleep(1.5)
		han.Play_SFX_Event("Unit_Shuttle_Door_Open_2")
		 
	end
end

function State_Dialog_Line_03_Remove_Text(message)
	if message == OnEnter then
		han.Move_To(Han_Move_To)
		Sleep(.1)
		chewie.Move_To(Chewie_Move_To)
		Story_Event("CUE_M10_DIALOG_HANSOLO_04") 	
	end
end

function State_Dialog_Line_04_Remove_Text(message)
	if message == OnEnter then
		Story_Event("CUE_M10_DIALOG_HANSOLO_05") 
	end
end

-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
-- Transition_Cinematic_Target_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)

function State_Dialog_Line_05_Remove_Text(message)
	if message == OnEnter then
		han.Move_To(Han_Move_To_2)
		Sleep(.1)
		BlockOnCommand(chewie.Move_To(Chewie_Move_To_2))
		Sleep(1)
		Story_Event("CUE_M10_DIALOG_HANSOLO_06")
		Set_Cinematic_Camera_Key(second_camera_pos,0,0,200,0,0,0,0)
		Set_Cinematic_Target_Key(storage_area,0,0,0,0,0,0,0)
		Transition_Cinematic_Camera_Key(second_camera_pos,20,0,0,20,0,0,0,0)
	end
end

function State_Dialog_Line_06_Remove_Text(message)
	if message == OnEnter then
		turbolaser_list = Find_All_Objects_Of_Type("E_GROUND_TURBOLASER_TOWER")
		for i,turbolaser in pairs(turbolaser_list) do
			turbolaser.Highlight(true)
		end

		Story_Event("CUE_M10_DIALOG_HANSOLO_07")
		Transition_Cinematic_Target_Key(turret_camera, 8, 0, 0, 80, 0, 0, 0, 0)
		
		Sleep(6)

		--UNflag the turbolaser towers during this camera pan
		for i,turbolaser in pairs(turbolaser_list) do
			turbolaser.Highlight(false)
		end
		
		--MessageBox("should be leaving cine mode now!!!") 
		Point_Camera_At(Han_Move_To_2)
		Transition_To_Tactical_Camera(2)
        Sleep(2)
        Letter_Box_Out(1)
        End_Cinematic_Camera()
		Lock_Controls(0)
		Suspend_AI(0)
		
	end
end

-----------------------------------------------------------------------------------------------------------------------

function Story_Mode_Service()

	if start_service then
	end
	
end

-----------------------------------------------------------------------------------------------------------------------
-- DME:  Ending Cinematic
-----------------------------------------------------------------------------------------------------------------------

function State_Reached_Falcon_00(message)
	if message == OnEnter then
		
		if not TestValid(han) or not TestValid(chewie) then
			ScriptExit()
		end
		
		Cancel_Fast_Forward() 
		--setting up cinematic stuff
		Fade_Screen_Out(1)
		Sleep(2)
		Suspend_AI(1)
		Lock_Controls(1)
		Start_Cinematic_Camera()
		Letter_Box_In(0)
		imp_shuttle1.Despawn()
		
		han.In_End_Cinematic(true)
		chewie.In_End_Cinematic(true)
		
		Do_End_Cinematic_Cleanup()
		
		exit_shuttle_loc = Find_Hint("GENERIC_MARKER_LAND", "shuttleland2")
		getaway_shuttle1 = Create_Cinematic_Transport("Imperial_Landing_Craft_Landing_Cinematic", empire.Get_ID(), exit_shuttle_loc, 90, 0, 1.0, 8, 0)
		
		han.Teleport_And_Face(finally_han_spawn)
		chewie.Teleport_And_Face(finally_chewie_spawn)
		han.Make_Invulnerable(true)
		chewie.Make_Invulnerable(true)
		
		Set_Cinematic_Camera_Key(han, 150, 45, 0, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(han, 0, 0, 0, 0, han, 0, 0)	
						
		Fade_Screen_In(1)
						
		han.Move_To(finally_hanrun)
		chewie.Move_To(finally_hanrun)
		
		Sleep(1)
		
		--Transition_Cinematic_Camera_Key(han, 6, 550, 55, 0, 1, 0, 0, 0)
		--Transition_Cinematic_Target_Key(Finally_Shuttle, 2, 550, 35, 0, 1, 0, 0, 0)
		Sleep(2)			
		
		Transition_Cinematic_Camera_Key(imp_shuttle1_loc, 6, 1500, 1, 10, 1, 0, 0, 0)
		Transition_Cinematic_Target_Key(exit_shuttle_loc, 6, -500, 0, 0, 0, 0, 0, 0)
		Sleep(2)
		
		--put this in where you want to cue the victory screen
		Story_Event("CUE_M10_PLAYER_WINS")
		
		Sleep(6)	
		
	end
end
