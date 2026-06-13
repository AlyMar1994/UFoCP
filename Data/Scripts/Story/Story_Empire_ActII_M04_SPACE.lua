-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M04_SPACE.lua#15 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActII_M04_SPACE.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Joseph_Gernert $
--
--            $Change: 34288 $
--
--          $DateTime: 2005/12/05 17:24:16 $
--
--          $Revision: #15 $
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
		Empire_A02M04_Begin = State_Empire_A02M04_Begin
		,Empire_A02M04_Warp_in_MonCal_Cruiser_00 = State_Empire_A02M04_Warp_in_MonCal_Cruiser
		,Empire_A02M04_Allow_Win = State_Empire_A02M04_Allow_Win
	}
	
	reinforcement_list1 = {
		"CALAMARI_CRUISER"
		--,"CALAMARI_CRUISER"
	}
    
	-- For memory pool cleanup hints
	rebel_player = nil

end

function State_Empire_A02M04_Begin(message)
	if message == OnEnter then
		moncal_rally1 = Find_Hint("GENERIC_MARKER_SPACE", "moncal-rally1")
		moncal_rally2 = Find_Hint("GENERIC_MARKER_SPACE", "moncal-rally2")
		if not (moncal_rally1 or moncal_rally2) then
			--MessageBox("%s--marker not found; aborting", tostring(Script))
			return
		end
		rebel_player = Find_Player("Rebel")
		player = Find_Player("Empire")
	end
end

function State_Empire_A02M04_Warp_in_MonCal_Cruiser(message)
	if message == OnEnter then
		
		Create_Thread("Calamari_Cinematic")
		
	end
end

function Moncal_Callback(unit_list)
	--MessageBox("Moncal_Callback")
	
end

function Calamari_Cinematic ()

	--ReinforceList(reinforcement_list1, moncal_rally, rebel_player, true, true, false, Moncal_Callback)
	--MessageBox("State_Empire_A02M04_Warp_in_MonCal_Cruiser")
	--jdg this needs to become a spawn event...
	
	moncal_01_list = SpawnList(reinforcement_list1, moncal_rally1, rebel_player, true, true, false)
	moncal_02_list = SpawnList(reinforcement_list1, moncal_rally2, rebel_player, true, true, false)
	moncal_01 = moncal_01_list[1]
	moncal_02 = moncal_02_list[1]
	
	moncal_01.Teleport_And_Face(moncal_rally1)
	moncal_02.Teleport_And_Face(moncal_rally2)
	
	moncal_01.Cinematic_Hyperspace_In(30)
	moncal_02.Cinematic_Hyperspace_In(45)

	camera_start = Find_Hint("GENERIC_MARKER_SPACE", "mid-cine-start")
	camera_goto = Find_Hint("GENERIC_MARKER_SPACE", "moncal-rally1")
	
	--SET UP CINEMATIC CAMERA
	Cancel_Fast_Forward() 
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	Start_Cinematic_Camera()
	
	Set_Cinematic_Camera_Key(camera_start, 100, 6, 45, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(camera_goto, 0, 0, 0, 0, 0, 0, 0) 
	
	Fade_Screen_In(.5)

	Sleep(5)
	
	--mon_cal_ship = unit_list[1]
	
	Transition_Cinematic_Target_Key(moncal_01, 3, 0, 0, 0, 0, moncal_01, 0, 0)
	Transition_Cinematic_Camera_Key(moncal_01, 3, 600, -12, 270, 1, 0, 0, 0)
	Sleep(3)
	
	closest_unit = Find_Nearest(moncal_01, player, true)
	Fade_Screen_Out(1)
	Sleep(1)
	
	Point_Camera_At(closest_unit)
	
	Transition_To_Tactical_Camera(1)
	
    Letter_Box_Out(1)
    Sleep(1)
    End_Cinematic_Camera()
    Fade_Screen_In(.5)
	Lock_Controls(0)
	Suspend_AI(0)	
end


function State_Empire_A02M04_Allow_Win(message)
	if message == OnEnter then
		Create_Thread("Ending_Cinematic")
	end
end

------------------------------------------------------------
-- dme Ending Cinematic stuff
------------------------------------------------------------

function Ending_Cinematic()
	
	Cancel_Fast_Forward() 
	--Story_Event("END_DIALOG")
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	--Set up all waypoints for cinematic
		
	camera_start = Find_Hint("GENERIC_MARKER_SPACE", "camerastart")
	end_forces1 = Find_Hint("GENERIC_MARKER_SPACE", "endforces1")
	end_forces2 = Find_Hint("GENERIC_MARKER_SPACE", "endforces2")
	end_forces3 = Find_Hint("GENERIC_MARKER_SPACE", "endforces3")
	end_forces4 = Find_Hint("GENERIC_MARKER_SPACE", "endforces4")
	end_forces5 = Find_Hint("GENERIC_MARKER_SPACE", "endforces5")
	camera_stop = Find_Hint("GENERIC_MARKER_SPACE", "camerastop")
	moncal_loc1 = Find_Hint("GENERIC_MARKER_SPACE", "moncal1")
	moncal_loc2 = Find_Hint("GENERIC_MARKER_SPACE", "moncal2")
	
	neutral_player = Find_Player("Neutral")
	rebel_player = Find_Player("Rebel")
	empire_player = Find_Player("Empire")
	unit_list = Find_All_Objects_Of_Type(empire_player)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
	
	tartanlist = Find_All_Objects_Of_Type("TARTAN_PATROL_CRUISER")
	broadsidelist = Find_All_Objects_Of_Type("Broadside_Class_Cruiser")
	acclamatorlist = Find_All_Objects_Of_Type("Acclamator_Assault_Ship")
	victorylist = Find_All_Objects_Of_Type("Victory_Destroyer")
	
	unitlist = 1
	
	unitloc = {}
	unitloc[1] = camera_start
	unitloc[2] = end_forces1
	unitloc[3] = end_forces2
	unitloc[4] = end_forces3
	unitloc[5] = end_forces4
	unitloc[6] = end_forces5
	
	cine_unit = {}
	cine_unit[1] = nil
	cine_unit[2] = nil
	cine_unit[3] = nil
	cine_unit[4] = nil
	cine_unit[5] = nil
	cine_unit[6] = nil
	
	for i,victory in pairs(victorylist) do
		if unitlist <= 6 then
			--victory.Teleport_And_Face(unitloc[unitlist])
			cine_unit[i] = victory
			unitlist = unitlist + 1
		end
	end
	for i,acclamator in pairs(acclamatorlist) do
		if unitlist <= 6 then
			--unit.Teleport_And_Face(unitloc[unitlist])
			cine_unit[i] = acclamator
			unitlist = unitlist + 1
		end
	end
	for i,broadside in pairs(broadsidelist) do
		if unitlist <= 6 then
			--unit.Teleport_And_Face(unitloc[unitlist])
			cine_unit[i] = broadside
			unitlist = unitlist + 1
		end
	end
	for i,tartan in pairs(tartanlist) do
		if unitlist <= 6 then
			--unit.Teleport_And_Face(unitloc[unitlist])
			cine_unit[i] = tartan
			unitlist = unitlist + 1
		end
	end
	
	--cinematic cleanup crap
	if TestValid(cine_unit[1]) then
		cine_unit[1].In_End_Cinematic(true)
	end
	
	if TestValid(cine_unit[2]) then
		cine_unit[2].In_End_Cinematic(true)
	end
	
	if TestValid(cine_unit[3]) then
		cine_unit[3].In_End_Cinematic(true)
	end
	
	if TestValid(cine_unit[4]) then
		cine_unit[4].In_End_Cinematic(true)
	end
	
	if TestValid(cine_unit[5]) then
		cine_unit[5].In_End_Cinematic(true)
	end
	
	if TestValid(cine_unit[6]) then
		cine_unit[6].In_End_Cinematic(true)
	end
	
	Do_End_Cinematic_Cleanup()
	
	if TestValid(cine_unit[1]) then
		cine_unit[1].Teleport_And_Face(unitloc[1])
	end
	
	if TestValid(cine_unit[2]) then
		cine_unit[2].Teleport_And_Face(unitloc[2])
	end
	
	if TestValid(cine_unit[3]) then
		cine_unit[3].Teleport_And_Face(unitloc[3])
	end
	
	if TestValid(cine_unit[4]) then
		cine_unit[4].Teleport_And_Face(unitloc[4])
	end
	
	if TestValid(cine_unit[5]) then
		cine_unit[5].Teleport_And_Face(unitloc[5])
	end
	
	if TestValid(cine_unit[6]) then
		cine_unit[6].Teleport_And_Face(unitloc[6])
	end
	
	moncal1 = Create_Generic_Object("Calamari_Cruiser", moncal_loc1, neutral_player)
	moncal2 = Create_Generic_Object("Calamari_Cruiser", moncal_loc2, neutral_player)
	
	moncal1.Teleport_And_Face(moncal_loc1)
	moncal2.Teleport_And_Face(moncal_loc2)
	
	moncal1.Take_Damage(200000)
	moncal2.Take_Damage(200000)
			
	Start_Cinematic_Camera()
	Sleep(1)
	
	Story_Event("END_DIALOG")
		
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camera_start, 500, -10, 90, 1, 0, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(camera_start, 0, 0, -100, 0, 0, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(camera_start, 16, 500, 30, 0, 1, 0, 0, 0)
	
	
	Sleep(3)
	Transition_Cinematic_Target_Key(moncal_loc1, 16, 0, 0, 0, 0, 0, 0, 0)
	--Transition_Cinematic_Camera_Key(camera_start, 8, 500, 60, 0, 1, 0, 0, 0)
	Sleep(5)
	Story_Event("END_DIALOG")
	Sleep(4)
	

end
