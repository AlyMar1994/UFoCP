-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M02_Fondor_LAND.lua#11 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M02_Fondor_LAND.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 34788 $
--
--          $DateTime: 2005/12/09 15:29:24 $
--
--          $Revision: #11 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	StoryModeEvents = 
	{
		Empire_M02_Fondor_Begin = State_M02_Fondor_Begin
		,Empire_M2_FONDOR_WIN_All_Rebels_Dead = State_FONDOR_WIN
		,Empire_M02_Fondor_HINT02 = State_Empire_M02_Fondor_HINT02
	}
	
	reinforcement_list1 = {
		"CIVILIAN_INDEPENDENT_AI_PARTY"
	}
	
	reinforcement_list2 = {
		"CIVILIAN_INDEPENDENT_AI_PARTY"
	}
	
	stormtrooper_reinforcement_list = {
		"IMPERIAL_MEDIUM_STORMTROOPER_SQUAD"
	}
	
	atst_reinforcement_list = {
		"AT_ST_WALKER"
	}
    
	-- For memory pool cleanup hints
	rebel_player = nil
	ewok_player = nil
	player = nil
	fog_id = nil

end

function State_M02_Fondor_Begin(message)
	if message == OnEnter then
		--MessageBox("State_M02_Fondor_Begin -- HIT!!!")
		rebel_player = Find_Player("Rebel")
		ewok_player = Find_Player("Rebel")
		player = Find_Player("Empire")
		structure_list = Find_All_Objects_Of_Type("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL")
		
		building_01 = Find_Hint("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL","cine-building")
		building_02 = Find_Hint("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL","civ-building2")
		building_03 = Find_Hint("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL","civ-building3")
		building_04 = Find_Hint("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL","civ-building4")
		
		building_01_spawnflag = Find_Hint("GENERIC_MARKER_LAND","cine-building-spawnflag")
		building_02_spawnflag = Find_Hint("GENERIC_MARKER_LAND","civ-building2-spawnflag")
		building_03_spawnflag = Find_Hint("GENERIC_MARKER_LAND","civ-building3-spawnflag")
		building_04_spawnflag = Find_Hint("GENERIC_MARKER_LAND","civ-building4-spawnflag")
		
		
		--spawn some empire units for cine-civs to fight with
		stormtrooper_spawner = Find_Hint("GENERIC_MARKER_LAND","stormtrooper-spawner")
		SpawnList(stormtrooper_reinforcement_list, stormtrooper_spawner, player, true, true)
		
		atst_spawner = Find_Hint("GENERIC_MARKER_LAND","atst-spawner")
		atst_list = SpawnList(atst_reinforcement_list, stormtrooper_spawner, player, true, true)
		starting_atst = atst_list[1]
		
		--spawn some civs around the buildings
		civ_spawner_table = Find_All_Objects_With_Hint("civ-spawner")
		
		for i,unit in pairs(civ_spawner_table) do
			SpawnList(reinforcement_list2, unit, ewok_player, true, true)
		end
		
		--make civs attack empire units
		civs_list = Find_All_Objects_Of_Type("CIVILIAN_INDEPENDENT_AI_PARTY")
		for i,civs in pairs(civs_list) do
			civs.Move_To(stormtrooper_spawner)
			civs.Guard_Target(stormtrooper_spawner.Get_Position())
		end
		
		
		--MessageBox("about to create intro cine!!!")
		Create_Thread("Intro_Cinematic")
		
		
		
	end
end



function State_Empire_M02_Fondor_HINT02(message)
	if message == OnEnter then
		structure_list = Find_All_Objects_Of_Type("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL")
		for i, building in pairs(structure_list) do
			--MessageBox("adding radar blip to building")
			Add_Radar_Blip(building, "somename")
		end
	end
end

function State_FONDOR_WIN(message)
	if message == OnEnter then
		--player has won...goto ending cinematic
		Cancel_Fast_Forward() 
		Rotate_Camera_By(180,30)
		Letter_Box_In(0)
		Suspend_AI(1)
		Lock_Controls(1)

	end
end

function Civilian_Spawn_Loop()
	--MessageBox("Civilian_Spawn_Loop hit!!!")
	
	max_spawn_times = 50
	current_spawn_times = 0
	max_civilians_allowed = 25
	repeat
		current_spawn_times = current_spawn_times + 1
		
		-- Spawn some guys at the first structure that hasn't been destroyed (if any)
		building_still_standing = false
		for i, building in pairs(structure_list) do
			if building.Get_Hull() then
				building_still_standing = true
				
				current_civilian_count = 0
				civilian_list = Find_All_Objects_Of_Type("CIVILIAN_INDEPENDENT_AI")
		         
				for i, unit in pairs(civilian_list) do
					current_civilian_count = current_civilian_count + 1
				end
				
				if current_civilian_count >= max_civilians_allowed then
					--MessageBox("more than 50 civilians...not spawning!!!")
					break
				end
				
				--MessageBox("spawning some dudes")
				if building == building_01 then
					civilian_list = SpawnList(reinforcement_list1, building_01_spawnflag, ewok_player, true, true)
				elseif building == building_02 then
					civilian_list = SpawnList(reinforcement_list1, building_02_spawnflag, ewok_player, true, true)
				elseif building == building_03 then
					civilian_list = SpawnList(reinforcement_list1, building_03_spawnflag, ewok_player, true, true)
				elseif building == building_04 then
					civilian_list = SpawnList(reinforcement_list1, building_04_spawnflag, ewok_player, true, true)
				end
				
				
				break
			end
		end
		
		Sleep(10)
	until current_spawn_times > max_spawn_times or not building_still_standing
end

function Intro_Cinematic()

	--MessageBox("intro cine function hit!!!")
	-- Lock out controls for intro cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0) 

	-- now find the cinematic spire and pan around it
	cine_camera = Find_Hint("DEFENDING FORCES POSITION", "cine-camera-spot")
	if not cine_camera then
		--MessageBox("intro cine Can't find cine_camera!!!")
		return
	end
	
	
	Start_Cinematic_Camera()
	Fade_Screen_In(.5)
	
	-- this pans around the rebel base
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(cine_camera, 400, 30, -60, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(cine_camera, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(cine_camera, 4, 600, 30, -120, 1, 0, 0, 0) 
	
	Sleep(1)	
	Story_Event("M2_FONDOR_TASK_GO")
	Sleep(3)
	
	civilian = Find_Hint("URBAN_CIVILIAN_SPAWN_HOUSE_REBEL", "cine-building")
	if not civilian then
		MessageBox("intro cine Can't find civilian!!!")
		return
	end
	
	if TestValid(starting_atst) then
		starting_atst.Take_Damage(10000)
	end
	

	
	-- this pans around the civilains fighting the stormtroopers
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(civilian, 600, 12, -40, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(civilian, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(civilian, 4, 800, 12, -20, 1, 0, 0, 0) 
	
	Sleep(1)	
	Story_Event("M2_FONDOR_TASK2_GO")
	Sleep(5)
	
	Fade_Screen_Out(.5)
	Transition_To_Tactical_Camera(2)
	--Sleep(2)
	End_Cinematic_Camera()
	Fade_Screen_In(.5)
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	Story_Event("M2_FONDOR_HINT_GO")
	
	
	
	Create_Thread("Civilian_Spawn_Loop")
	
end





-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()
	--do stuff here
end
