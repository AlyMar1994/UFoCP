-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_MonCalamari_Piracy.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_MonCalamari_Piracy.lua $
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

require("PGStateMachine")
require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		MonCalamari_Piracy_Mission_Begin = State_MonCalamari_Piracy_Mission_Begin,
	}
	
	ig2000_spawnlist =
	{
		"IG-2000"
	}
end

function State_MonCalamari_Piracy_Mission_Begin(message)
	if message == OnEnter then
		Initialize_Mission()

		-- 9/19/06 JAC - We need this even if we're not doing a cinematic intro
		-- otherwise the Master Volume will be stuck at 0
		Start_Cinematic_Camera()
		End_Cinematic_Camera()
		Letter_Box_Out(0)
		Fade_Screen_In(1)
		Lock_Controls(0)

		Story_Event("INTRO_SPEECH")
--		current_cinematic_thread = Create_Thread("Intro_Cinematic")
	elseif message == OnUpdate then
		if not mission_success and not mission_failure then
			if ig2000_is_dead then
				mission_failure = true
				Story_Event("FAIL_OBJECTIVE_00")
				if empire_active then
					Story_Event("VICTORY_EMPIRE")
				else
					Story_Event("VICTORY_REBEL")
				end
			end
			if dock_destroyed then
				mission_success = true
				Story_Event("COMPLETE_OBJECTIVE_00")
			end
		end
	end
end

function Initialize_Mission()
	mission_success = false
	mission_failure = false
	
	camera_offset = 135

	underworld_player = Find_Player("Underworld")
	rebel_player = Find_Player("Rebel")
	empire_player = Find_Player("Empire")
	empire_active = false
	rebel_active = false
		
	-- Spawn IG2000. Heroes starting on the map crashes the game.
	
	ig2000_start = Find_Hint("STORY_TRIGGER_ZONE", "igstart")
	ig2000_list = SpawnList(ig2000_spawnlist, ig2000_start.Get_Position(), underworld_player, false, true)
	ig2000 = ig2000_list[1]
	ig2000.Teleport_And_Face(ig2000_start)
	Point_Camera_At(ig2000)
	Register_Death_Event(ig2000, ig2000_Destroyed)
	ig2000_is_dead = false
	
	-- Set the Rebel and Empire units to guard their location.
	
	empire_list = Find_All_Objects_Of_Type(empire_player)
	for i,unit in pairs(empire_list) do
		if unit.Can_Move() then
			unit.Prevent_AI_Usage(true)
			unit.Guard_Target(unit.Get_Position())
			empire_active = true
		end
	end
	rebel_list = Find_All_Objects_Of_Type(rebel_player)
	for i,unit in pairs(rebel_list) do
		if unit.Can_Move() then
			unit.Prevent_AI_Usage(true)
			unit.Guard_Target(unit.Get_Position())
			rebel_active = true
		end
	end
	
	-- Set the destruction checks for the station.
	
	dockyard_list = Find_All_Objects_Of_Type("EMPIRE_DOCK_DESTROYABLE")
	for i,unit in pairs(dockyard_list) do
		Register_Death_Event(unit, Dock_Destroyed)
	end
	dock_destroyed = false
	docks_down = 0
	
	-- Set the reaction proxes for the station.
	fighters_marker = Find_Hint("STORY_TRIGGER_ZONE", "fighters")
	if empire_active then
		Register_Prox(fighters_marker, Prox_Start_Fighters, 250, empire_player)
	else
		Register_Prox(fighters_marker, Prox_Start_Fighters, 250, rebel_player)
	end
	dockyard_marker = Find_Hint("STORY_TRIGGER_ZONE", "prox01")
	dockyard_marker2 = Find_Hint("STORY_TRIGGER_ZONE", "prox02")
	Register_Prox(dockyard_marker, Prox_Approach_Dockyard, 250, underworld_player)
	Register_Prox(dockyard_marker2, Prox_Approach_Dockyard, 250, underworld_player)
end

function Prox_Approach_Dockyard(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Approach_Dockyard)
	if empire_active then
		for i,unit in pairs(empire_list) do
			if TestValid(unit) then
				if unit.Can_Move() then
					if not TestValid(unit.Get_Parent_Object()) then
						unit.Attack_Move(ig2000)
						unit.Prevent_AI_Usage(false)
					end
				end
			end
		end
	else
		for i,unit in pairs(rebel_list) do
			if TestValid(unit) then
				if unit.Can_Move() then
					if not TestValid(unit.Get_Parent_Object()) then
						unit.Attack_Move(ig2000)
						unit.Prevent_AI_Usage(false)
					end
				end
			end
		end
	end
end

function Prox_Start_Fighters(prox_obj, trigger_obj)
	if TestValid(trigger_obj) then
		if trigger_obj.Can_Move() then
			if not TestValid(trigger_obj.Get_Parent_Object()) then
				trigger_obj.Attack_Move(ig2000)
				trigger_obj.Prevent_AI_Usage(false)
			end
		end
	end
end

function Stop_Fighter_Prox()
	fighters_marker.Cancel_Event_Object_In_Range(Prox_Start_Fighters)
end

function Dock_Destroyed()
	docks_down = docks_down + 1
	if docks_down == 2 then
		dock_destroyed = true
	end
end

function ig2000_Destroyed()
	ig2000_is_dead = true
end

-- function Story_Handle_Esc()
--	if current_cinematic_thread ~= nil then
--		Thread.Kill(current_cinematic_thread)
--		current_cinematic_thread = nil
--		Create_Thread("End_Camera")
--	end
-- end

function End_Camera()
	Transition_To_Tactical_Camera(6)
	Sleep(4)
	Letter_Box_Out(2)
	Sleep(2)
	Lock_Controls(0)
	End_Cinematic_Camera()

	Register_Timer(Stop_Fighter_Prox, 5)
	
	Story_Event("INTRO_SPEECH")
end

-- ************************************************************************
-- ***********************INTRO CINEMATIC FUNCTION*************************
-- ************************************************************************

function Intro_Cinematic()
	
	Lock_Controls(1)
	Start_Cinematic_Camera()
	Letter_Box_In(0)	
	Fade_Screen_In(2)
		
	Transition_Cinematic_Camera_Key(ig2000, 0, 50, 25, 45, 1, 1, 1, 0)
	Transition_Cinematic_Target_Key(ig2000, 0, 0, 0, 7, 0, ig2000, 0, 0)
	--Sleep(7)
	
	Transition_Cinematic_Camera_Key(ig2000, 5, 50, 25, 135, 1, 1, 1, 0)
	
	Sleep(4.5)
	
	while true do
		camera_offset = camera_offset + 90
		Transition_Cinematic_Camera_Key(ig2000, 5, 50, 25, camera_offset, 1, 1, 1, 0)
		
		if camera_offset == 315 then
			Story_Handle_Esc()
		end
		
		Sleep(4.5)
	end
end