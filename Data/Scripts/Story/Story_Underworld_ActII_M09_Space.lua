-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M09_Space.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActII_M09_Space.lua $
--
--    Original Author: Dan Etter
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
--
function Definitions()
	StoryModeEvents =
	{
		Underworld_A02M09_Begin = State_Underworld_A02M09_Begin,
		Mission_9_Intro_Dialog_00_Speech_Done = State_Mission_9_Intro_Dialog_00_Speech_Done,
		Mission_9_Intro_Dialog_01_Speech_Done = State_Mission_9_Intro_Dialog_01_Speech_Done,
		Mission_9_Intro_Dialog_02_Speech_Done = State_Mission_9_Intro_Dialog_02_Speech_Done,
		Mission_9_Intro_Dialog_03_Speech_Done = State_Mission_9_Intro_Dialog_03_Speech_Done,
		Mission_9_Intro_Dialog_04_Speech_Done = State_Mission_9_Intro_Dialog_04_Speech_Done,
		Mission_9_Intro_Dialog_05_Speech_Done = State_Mission_9_Intro_Dialog_05_Speech_Done,
		Mission_9_Intro_Dialog_06_Speech_Done = State_Mission_9_Intro_Dialog_06_Speech_Done,
		Mission_9_Intro_Dialog_07_Speech_Done = State_Mission_9_Intro_Dialog_07_Speech_Done,
		Mission_9_Midtro_Dialog_00_Speech_Done = State_Mission_9_Midtro_Dialog_00_Speech_Done,
		Mission_9_Midtro_Dialog_01_Speech_Done = State_Mission_9_Midtro_Dialog_01_Speech_Done,
		Mission_9_Midtro_Dialog_02_Speech_Done = State_Mission_9_Midtro_Dialog_02_Speech_Done,
		Mission_9_Midtro_Dialog_02A_Speech_Done = State_Mission_9_Midtro_Dialog_02A_Speech_Done,
		Mission_9_Midtro_Dialog_03_Speech_Done = State_Mission_9_Midtro_Dialog_03_Speech_Done,
		Mission_9_Midtro_Dialog_04_Speech_Done = State_Mission_9_Midtro_Dialog_04_Speech_Done,
		Mission_9_Midtro_Dialog_05_Speech_Done = State_Mission_9_Midtro_Dialog_05_Speech_Done,
		Mission_9_Midtro_Dialog_06_Speech_Done = State_Mission_9_Midtro_Dialog_06_Speech_Done,
		Mission_9_Midtro_Dialog_07_Speech_Done = State_Mission_9_Midtro_Dialog_07_Speech_Done
	}

	interceptor_frigate =
	{
		"INTERCEPTOR4_FRIGATE"
	}

	bossk_list =
	{
		"HOUNDSTOOTH"
	}

	mission_begin = false
end

function State_Underworld_A02M09_Begin (message)
	if message == OnEnter then

		Initialize_Mission_Variables()
		Initialize_Cinematic_Variables()

		current_cine_id = Create_Thread("Intro_Cinematic")

		mission_begin = true
	end
end

function Story_Mode_Service()
	if mission_begin then
		if not mission_defeat_tyber then
			if not TestValid(tyber[1]) then
				mission_defeat_tyber = true
				Create_Thread("Mission_Defeat")
			end
			if TestValid(thrawn) then
				if thrawn.Get_Hull() < 0.50 and not midtro_cinematic_1 then
					Create_Thread("Midtro_Cinematic")
				elseif thrawn.Get_Hull() < 0.20 and not midtro_cinematic_2 then
					Create_Thread("Midtro_Cinematic_2")
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------
-- INITIALIZATION

function Initialize_Mission_Variables()
	underworld_player = Find_Player("Underworld")
	empire_player = Find_Player("Empire")

	tyber_target = {}
	tyber_target[1] = nil

	mission_victory = false
	mission_defeat_tyber = false
	bossk_defected = false
	intro_cinematic_units_spawned = false
	midtro_cinematic_1 = false
	midtro_cinematic_2 = false

	empire_reveal = FogOfWar.Reveal_All(empire_player)
	uw_reveal = FogOfWar.Reveal_All(underworld_player)

-- BOSSK
	loc_start = Find_Hint("STORY_TRIGGER_ZONE", "bosskpos")
	bossk = Find_First_Object("HOUNDSTOOTH")
	if TestValid(bossk) then
		bossk.Despawn()

		--Need to despawn Bossk himself also to eliminate hero icon.
		bossk_land_version = Find_First_Object("BOSSK")
		if TestValid(bossk_land_version) then
			bossk_land_version.Despawn()
		end
	end

-- THE PEACEBRINGER
	tyber_pos = Find_Hint("STORY_TRIGGER_ZONE", "tyberpos")
	tyber = Spawn_Unit(Find_Object_Type("TYBER_ZANN_TEAM_CAMPAIGN"), tyber_pos, underworld_player)
	tyber[1].Teleport_And_Face(tyber_pos)
	tyber[1].Stop()
	tyber[1].Hide(true)

-- THRAWN
	thrawn = Find_First_Object("Admonitor_Star_Destroyer_No_Engine_Hardpoint")
	thrawn.Set_Cannot_Be_Killed(true)
	thrawn_engine = Find_First_Object("HP_Thrawn_SD_Engines")
	if TestValid(thrawn_engine) then
		thrawn_engine.Make_Invulnerable(true)
	end

-- FOUND INTERCEPTORS ON FIELD
	underworld_interceptor_list = Find_All_Objects_Of_Type("INTERCEPTOR4_FRIGATE")
	for i, unit in pairs (underworld_interceptor_list) do
		unit.Hide(true)
		unit.Prevent_Opportunity_Fire(true)
		unit.Stop()
	end

-- FOUND CRUSADERS ON FIELD
	underworld_crusader_list = Find_All_Objects_Of_Type("CRUSADER_GUNSHIP")
	for i, unit in pairs (underworld_crusader_list) do
		unit.Hide(true)
		unit.Prevent_Opportunity_Fire(true)
		unit.Stop()
	end

-- FOUND VENGEANCE ON FIELD
	underworld_vengeance_list = Find_All_Objects_Of_Type("VENGEANCE_FRIGATE")
	for i, unit in pairs (underworld_vengeance_list) do
		unit.Hide(true)
		unit.Prevent_Opportunity_Fire(true)
		unit.Stop()
	end

-- HYPERVELOCITY TARGET
	target_vessel_pos = Find_Hint("STORY_TRIGGER_ZONE", "targetpos")
	target_vessel = Spawn_Unit(Find_Object_Type("INTERCEPTOR4_FRIGATE"), target_vessel_pos, underworld_player)
	target_vessel[1].Teleport_And_Face(target_vessel_pos)

-- EMPIRE UNITS
	local empire_list = Find_All_Objects_Of_Type(empire_player)
	for i, unit in pairs (empire_list) do
		unit.Prevent_AI_Usage(true)
		unit.Prevent_Opportunity_Fire(true)
		unit.Stop()
	end

-- HYPERVELOCITY CANNON
	hypervelocity = Spawn_Special_Weapon("Ground_Empire_Hypervelocity_Gun", empire_player)
	hypervelocity.Prevent_AI_Usage(true)

end

function Initialize_Cinematic_Variables()
	CINE_Intro_Active = false
	camera1 = Find_Hint("STORY_TRIGGER_ZONE", "camera1")
	camera2 = Find_Hint("STORY_TRIGGER_ZONE", "camera2")
	camera3 = Find_Hint("STORY_TRIGGER_ZONE", "camera3")
	camera4 = Find_Hint("STORY_TRIGGER_ZONE", "camera4")
	hypercamera = Find_Hint("STORY_TRIGGER_ZONE", "hypercamera")
	tybercam = Find_Hint("STORY_TRIGGER_ZONE", "tybercam")
	tyber_target_pos = Find_Hint("STORY_TRIGGER_ZONE", "tybertarget")

	mid1cam1 = Find_Hint("STORY_TRIGGER_ZONE", "mid1cam1")

	thrawnmid = Find_Hint("STORY_TRIGGER_ZONE", "thrawnmid")
	bosskmid = Find_Hint("STORY_TRIGGER_ZONE", "bosskmid")

	phantom_01 = Find_Hint("STORY_TRIGGER_ZONE", "phantom1")
	phantom_02 = Find_Hint("STORY_TRIGGER_ZONE", "phantom2")
	phantom_03 = Find_Hint("STORY_TRIGGER_ZONE", "phantom3")
	phantom_04 = Find_Hint("STORY_TRIGGER_ZONE", "phantom4")

	hyper1 = Find_Hint("STORY_TRIGGER_ZONE", "hyper1")
	hyper2 = Find_Hint("STORY_TRIGGER_ZONE", "hyper2")
	hyper3 = Find_Hint("STORY_TRIGGER_ZONE", "hyper3")
	hyper4 = Find_Hint("STORY_TRIGGER_ZONE", "hyper4")
end

---------------------------------------------------------------------------------------------
-- COMMON MISSION FUNCTIONS

function Timer_Fire_Hypervelocity()
	if TestValid(hypervelocity) then
		vengeance_target = Find_First_Object("VENGEANCE_FRIGATE")
		if TestValid(vengeance_target) then
			hypervelocity.Fire_Special_Weapon(vengeance_target, empire_player)
		end
		Register_Timer(Timer_Fire_Hypervelocity_Again,120)
	end
end

function Timer_Fire_Hypervelocity_Again()
	if TestValid(hypervelocity) then
		interceptor_target = Find_First_Object("INTERCEPTOR4_FRIGATE")
		if TestValid(interceptor_target) then
			hypervelocity.Fire_Special_Weapon(interceptor_target, empire_player)
		end
	end
end

---------------------------------------------------------------------------------------------
-- VICTORY AND DEFEAT FUNCTIONS

function Mission_Defeat()
	Cancel_Fast_Forward()
	GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 1)
	Story_Event("M09_DEFEAT_TYBER")
end

---------------------------------------------------------------------------------------------
-- CINEMATIC FUNCTIONS

function Story_Handle_Esc()
	if CINE_Intro_Active then
		CINE_Intro_Active = false
		Thread.Kill(current_cine_id)
		Create_Thread("IntroCineCleanup")
	end
end

function IntroCineCleanup()
	current_cine_id = nil
	Story_Event("DISABLE_INTRO_BRANCH")
	Stop_All_Music()
	Stop_All_Speech()
	Remove_All_Text()
	Allow_Localized_SFX(true)
	Transition_To_Tactical_Camera(2)
	Letter_Box_Out(1)
	Sleep(2)
	End_Cinematic_Camera()
	Lock_Controls(0)
	Suspend_AI(0)

-- EMPIRE UNITS
	local empire_list = Find_All_Objects_Of_Type(empire_player)
	for i, unit in pairs (empire_list) do
		unit.Prevent_AI_Usage(false)
		unit.Prevent_Opportunity_Fire(false)
	end

	--It's important to do this after releasing the Empire units (since that will include the HV gun)
	hypervelocity.Prevent_AI_Usage(true)
	Register_Timer(Timer_Fire_Hypervelocity,120)

	if TestValid(tyber_target[1]) then
		tyber_target[1].Take_Damage(10000)
	end

-- TYBER'S UNITS
	for i, unit in pairs (underworld_interceptor_list) do
		unit.Hide(false)
	end

	for i, unit in pairs (underworld_crusader_list) do
		unit.Hide(false)
	end

	for i, unit in pairs (underworld_vengeance_list) do
		unit.Hide(false)
	end

-- OLD TYBER ZANN, REPLACED BY PEACEBRINGER
	old_tyber = Find_First_Object("TYBER_ZANN_PASSENGER")
	if TestValid(old_tyber) then
		old_tyber.Despawn()
	end

	tyber[1].Hide(false)

	if TestValid(target_vessel[1]) then
		target_vessel[1].Take_Damage(10000)
	end

	if TestValid(tyber_target[1]) then
		tyber_target[1].Take_Damage(10000)
	end

-- ADDITIONAL SPAWNED UNITS FROM INTRO CINEMATIC

	if not intro_cinematic_units_spawned then
		local hyperspace_interceptor_01_list = SpawnList(interceptor_frigate, hyper1.Get_Position(), underworld_player, false, false)
		local hyperspace_interceptor_02_list = SpawnList(interceptor_frigate, hyper2.Get_Position(), underworld_player, false, false)
		local hyperspace_interceptor_03_list = SpawnList(interceptor_frigate, hyper3.Get_Position(), underworld_player, false, false)
		local hyperspace_interceptor_04_list = SpawnList(interceptor_frigate, hyper4.Get_Position(), underworld_player, false, false)
	end

	CINE_Intro_Active = false

	tyber[1].Prevent_Opportunity_Fire(true)

	-- Thrawn: 	This is actually proving interesting.  Why don�t we begin?
	Story_Event("INTRO_DIALOG_06")
end

function State_Mission_9_Intro_Dialog_06_Speech_Done(message)
	if message == OnEnter then
		-- Tyber: Agreed.
		Story_Event("INTRO_DIALOG_07")
	end
end

function Intro_Cinematic()

	CINE_Intro_Active = true

	Cancel_Fast_Forward()
	Sleep(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	Fade_Screen_In(1)

	Set_Cinematic_Camera_Key(camera1.Get_Position(), 0, 0, 0, -400, camera1, 0, 0)
	Set_Cinematic_Target_Key(thrawn.Get_Position(), 0, 0, 0, 0, thrawn, 0, 0)
	Transition_Cinematic_Camera_Key(camera1.Get_Position(), 10, 0, 0, 90, 0, camera1, 0, 0)
	-- Thrawn: Ah, Tyber, nice to see you again.
	Story_Event("INTRO_DIALOG_00")
end

function State_Mission_9_Intro_Dialog_00_Speech_Done(message)
	if message == OnEnter then
		Set_Cinematic_Camera_Key(camera2.Get_Position(), 0, 0, 100, 0, camera2, 0, 0)
		Set_Cinematic_Target_Key(target_vessel[1].Get_Position(), 0, 0, 0, 0, target_vessel[1], 0, 0)
		Transition_Cinematic_Camera_Key(camera2.Get_Position(), 6, 0, 90, 0, 0, camera2, 0, 0)
		-- Tyber: Well this explains things.  You are our Imperial contact?
		Story_Event("INTRO_DIALOG_01")
	end
end

function State_Mission_9_Intro_Dialog_01_Speech_Done(message)
	if message == OnEnter then
		Set_Cinematic_Camera_Key(thrawn, 600, 20, 0, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(thrawn.Get_Position(), 0, 0, 0, 0, thrawn, 0, 0)
		Transition_Cinematic_Camera_Key(thrawn, 13, 700, 30, 45, 1, 0, 0, 0)
		-- Thrawn: In a manner of speaking.  You have been overstepping your bounds again and it's time to end it.  Oh, and I'm to collect a certain artifact on behalf of the Emperor.
		Story_Event("INTRO_DIALOG_02")
	end
end

function State_Mission_9_Intro_Dialog_02_Speech_Done(message)
	if message == OnEnter then
		Set_Cinematic_Camera_Key(camera3.Get_Position(), 0, 0, 0, 0, camera3, 0, 0)
		Set_Cinematic_Target_Key(hypercamera.Get_Position(), 0, 0, 0, 0, hypercamera, 0, 0)
		-- Tyber: Really.  You didn't think I came unprepared, did you?
		Story_Event("INTRO_DIALOG_03")

		-- Bring in Tyber's remaining initial fleet here.
		for i, unit in pairs (underworld_interceptor_list) do
			unit.Hide(false)
			unit.Cinematic_Hyperspace_In(1)
		end

		for i, unit in pairs (underworld_crusader_list) do
			unit.Hide(false)
			unit.Cinematic_Hyperspace_In(1)
		end

		for i, unit in pairs (underworld_vengeance_list) do
			unit.Hide(false)
			unit.Cinematic_Hyperspace_In(1)
		end

		local hyperspace_interceptor_01_list = SpawnList(interceptor_frigate, hyper1.Get_Position(), underworld_player, false, false)
		hyper_interceptor_01 = hyperspace_interceptor_01_list[1]
		local hyperspace_interceptor_02_list = SpawnList(interceptor_frigate, hyper2.Get_Position(), underworld_player, false, false)
		hyper_interceptor_02 = hyperspace_interceptor_02_list[1]
		local hyperspace_interceptor_03_list = SpawnList(interceptor_frigate, hyper3.Get_Position(), underworld_player, false, false)
		hyper_interceptor_03 = hyperspace_interceptor_03_list[1]
		local hyperspace_interceptor_04_list = SpawnList(interceptor_frigate, hyper4.Get_Position(), underworld_player, false, false)
		hyper_interceptor_04 = hyperspace_interceptor_04_list[1]
		hyper_interceptor_01.Cinematic_Hyperspace_In(1)
		hyper_interceptor_02.Cinematic_Hyperspace_In(1)
		hyper_interceptor_03.Cinematic_Hyperspace_In(1)
		hyper_interceptor_04.Cinematic_Hyperspace_In(1)
		intro_cinematic_units_spawned = true

		Transition_Cinematic_Camera_Key(camera3.Get_Position(), 3, 0, -400, -100, 0, camera3, 0, 0)
	end
end

function State_Mission_9_Intro_Dialog_03_Speech_Done(message)
	if message == OnEnter then
		planet = Find_First_Object("FOREST_BACKDROP_LARGE")
		Set_Cinematic_Camera_Key(target_vessel[1].Get_Position(), 600, 20, -20, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(planet, 0, 0, 0, 0, 0, 0, 0)
		-- Thrawn: Well done.  But then you couldn�t have known about the hypervelocity gun on the surface, could you?
		Story_Event("INTRO_DIALOG_04")
		Transition_Cinematic_Target_Key(target_vessel[1], 4, 0, 0, 0, 0, 0, 0, 0)
		hypervelocity.Fire_Special_Weapon(target_vessel[1], empire_player)
		Sleep(5)

		target_vessel[1].Take_Damage(10000)
	end
end

function State_Mission_9_Intro_Dialog_04_Speech_Done(message)
	if message == OnEnter then
		-- Tyber: Unfortunate.  But then you aren�t the only one with toys...
		Story_Event("INTRO_DIALOG_05")

		Sleep(1)

		Set_Cinematic_Camera_Key(tybercam.Get_Position(), 0, 0, 0, 0, tybercam, 0, 0)
		Set_Cinematic_Target_Key(tyber[1].Get_Position(), 0, 0, 0, 0, tyber[1], 0, 0)

		tyber_target = Spawn_Unit(Find_Object_Type("VICTORY_DESTROYER"), tyber_target_pos, empire_player)
		tyber_target[1].Teleport_And_Face(tyber_target_pos)

		tyber[1].Hide(false)
		tyber[1].Cinematic_Hyperspace_In(1)
		tyber[1].Activate_Ability("BLAST", true)
		Sleep(2)

		Transition_Cinematic_Camera_Key(tyber_target[1].Get_Position(), 6, 1000, 25, -90, 1, 0, 0, 0)
		Sleep(4)
		if TestValid(tyber_target[1]) then
			tyber[1].Attack_Target(tyber_target[1])
			Transition_Cinematic_Target_Key(tyber_target[1].Get_Position(), 4, 0, 0, 0, 0, tyber_target[1], 0, 0)
		end
		if TestValid(tyber_target[1]) then
			Sleep(4.5)
			tyber_target[1].Take_Damage(10000)
		end

	--	Set_Cinematic_Camera_Key(camera1.Get_Position(), 0, 0, 0, 0, camera1, 0, 0)
	--	Set_Cinematic_Target_Key(thrawn.Get_Position(), 0, 0, 0, 0, thrawn, 0, 0)

	--	Set_Cinematic_Camera_Key(camera2.Get_Position(), 0, 0, 0, 0, camera2, 0, 0)
	--	Set_Cinematic_Target_Key(tyber[1].Get_Position(), 0, 0, 0, 0, tyber[1], 0, 0)
	end
end

function State_Mission_9_Intro_Dialog_05_Speech_Done(message)
	if message == OnEnter then
		Create_Thread("IntroCineCleanup")
	end
end

function Midtro_Cinematic()
	Cancel_Fast_Forward()
	midtro_cinematic_1 = true
	bossk_defected = true
	tyber[1].Make_Invulnerable(true)
	tyber[1].Set_Cannot_Be_Killed(true)
	thrawn.Make_Invulnerable(true)

	Suspend_AI(1)
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)

	thrawn.Prevent_AI_Usage(true)
	thrawn.Prevent_Opportunity_Fire(true)
	thrawn.Stop()

	local bossk_spawnlist = SpawnList(bossk_list, bosskmid.Get_Position(), underworld_player, false, true)
	bossk = bossk_spawnlist[1]
	bossk.Teleport_And_Face(tyber[1])
	bossk.Prevent_Opportunity_Fire(true)
	bossk.Make_Invulnerable(true)
	bossk.Set_Cannot_Be_Killed(true)
	bossk.Move_To(thrawn.Get_Position())

	Set_Cinematic_Camera_Key(bossk, 450, 35, 0, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(bossk, 0, 0, 0, 0, bossk, 0, 0)

	Fade_Screen_In(2)
	Sleep(1)
	Story_Event("BOSSK_MIDTRO")

	Sleep(2)
	Transition_Cinematic_Camera_Key(thrawn, 15, 900, 50, 0, 1, thrawn, 0, 0)
	Transition_Cinematic_Target_Key(thrawn, 4, 0, 0, 0, 0, thrawn, 0, 0)
	Sleep(8)

	Fade_Screen_Out(1)
	Sleep(1.2)
	Letter_Box_Out(0)

	bossk.Make_Invulnerable(false)
	bossk.Set_Cannot_Be_Killed(false)
	bossk.Despawn()

	thrawn.Prevent_AI_Usage(false)
	thrawn.Prevent_Opportunity_Fire(false)
	thrawn.Make_Invulnerable(false)
	tyber[1].Make_Invulnerable(false)
	tyber[1].Set_Cannot_Be_Killed(false)

	Remove_All_Text()
	Allow_Localized_SFX(true)
	Transition_To_Tactical_Camera(0)
	End_Cinematic_Camera()
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(2)

	star_destroyer = Spawn_Unit(Find_Object_Type("Acclamator_Assault_Ship"), camera1.Get_Position(), empire_player)
	star_destroyer[1].Teleport_And_Face(camera1)
	star_destroyer[1].Cinematic_Hyperspace_In(3)
end

function Midtro_Cinematic_2()
	midtro_cinematic_2 = true
	Cancel_Fast_Forward()
	tyber[1].Make_Invulnerable(true)
	tyber[1].Set_Cannot_Be_Killed(true)
	thrawn.Make_Invulnerable(true)
	thrawn.Prevent_AI_Usage(true)
	thrawn.Prevent_Opportunity_Fire(true)

	Lock_Controls(1)
	Start_Cinematic_Camera()
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)

-- TIE PHANTOMS AND VICTORY DESTROYER
	phantom_squadron_01 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_01.Get_Position(), empire_player)
	phantom_squadron_02 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_02.Get_Position(), empire_player)
	phantom_squadron_03 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_03.Get_Position(), empire_player)
	phantom_squadron_04 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_04.Get_Position(), empire_player)
	phantom_squadron_05 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_01.Get_Position(), empire_player)
	phantom_squadron_06 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_02.Get_Position(), empire_player)
	phantom_squadron_07 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_03.Get_Position(), empire_player)
	phantom_squadron_08 = Spawn_Unit(Find_Object_Type("TIE_PHANTOM_SQUADRON"), phantom_04.Get_Position(), empire_player)

	star_destroyer2 = Spawn_Unit(Find_Object_Type("VICTORY_DESTROYER"), phantom_04.Get_Position(), empire_player)
	star_destroyer2[1].Teleport_And_Face(phantom_04)
	star_destroyer2[1].Cinematic_Hyperspace_In(8)

	Suspend_AI(1)

	thrawn.Teleport_And_Face(thrawnmid)

	Set_Cinematic_Camera_Key(camera1.Get_Position(), 0, 0, 0, 0, camera1, 0, 0)
	Set_Cinematic_Target_Key(thrawn.Get_Position(), 0, 0, 0, 0, thrawn, 0, 0)

	Fade_Screen_In(2)
	Story_Event("THRAWN_ENDTRO")
	Sleep(2)

	thrawn.Hyperspace_Away(true)
	Sleep(3)

	phantom_squadron_01[1].Activate_Ability("STEALTH", true)
	phantom_squadron_02[1].Activate_Ability("STEALTH", true)
	phantom_squadron_03[1].Activate_Ability("STEALTH", true)
	phantom_squadron_04[1].Activate_Ability("STEALTH", true)
	phantom_squadron_05[1].Activate_Ability("STEALTH", true)
	phantom_squadron_06[1].Activate_Ability("STEALTH", true)
	phantom_squadron_07[1].Activate_Ability("STEALTH", true)
	phantom_squadron_08[1].Activate_Ability("STEALTH", true)
	Sleep(1)

	if TestValid(thrawn) then
		thrawn.Make_Invulnerable(false)
		thrawn.Set_Cannot_Be_Killed(false)
		thrawn.Despawn()
	end

	tyber[1].Make_Invulnerable(false)
	tyber[1].Set_Cannot_Be_Killed(false)

	Allow_Localized_SFX(true)
	Transition_To_Tactical_Camera(2)
	Letter_Box_Out(1)
	Sleep(2)
	End_Cinematic_Camera()
	Lock_Controls(0)
	Suspend_AI(0)
end
