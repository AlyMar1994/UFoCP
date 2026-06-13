-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M04_LAND.lua#15 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M04_LAND.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 34788 $
--
--          $DateTime: 2005/12/09 15:29:24 $
--
--          $Revision: #15 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	StoryModeEvents = 
	{
		Empire_M04_Land_Begin = State_Empire_M04_Land_Begin
	}
	
	reinforcement_list1 = {
		"Geonosian_Resistors"
	}
	

    
	-- For memory pool cleanup hints
	rebel_player = nil
	flag_spire_1_dead = false
	flag_spire_2_dead = false
	flag_spire_3_dead = false
	flag_spire_4_dead = false
	flag_spire_5_dead = false
	flag_spire_6_dead = false
	
	flag_initialized = false
	
	counter_spires_killed = 0
	timer_geonosian_spawn = 60
	
	fog_id = nil

end

function State_Empire_M04_Land_Begin(message)
	if message == OnEnter then
		rebel_player = Find_Player("Rebel")
		ewok_player = Find_Player("Rebel")
		
		structure_list = Find_All_Objects_Of_Type("GEONOSIAN_SPAWN_HOUSE")
		
		fog_id = FogOfWar.Reveal_All(rebel_player)
		
		--spawn some geonosians around the spires
		geonosian_spawner_table = Find_All_Objects_With_Hint("solo-spawner")
		
		for i,unit in pairs(geonosian_spawner_table) do
			SpawnList(reinforcement_list1, unit, ewok_player, true, true)
		end
		
		
		
		--MessageBox("about to create intro cine!!!")
		Create_Thread("Intro_Cinematic")
	end
end


function Geonosian_Spawn_Loop()
    --MessageBox("Geonosian_Spawn_Loop hit!!!")
    max_spawn_times = 50
    current_spawn_times = 0
    max_geonosians_allowed = 50
    repeat
         current_spawn_times = current_spawn_times + 1
         
         -- Spawn some guys at the first structure that hasn't been destroyed (if any)
         building_still_standing = false

         for i, building in pairs(structure_list) do
             if building.Get_Hull() then
				building_still_standing = true
             
				current_geonosian_count = 0
				geonosian_list = Find_All_Objects_Of_Type("GEONOSIAN")
				
				current_geonosian_count =table.getn(geonosian_list)
		         
				for i, unit in pairs(geonosian_list) do
					current_geonosian_count = current_geonosian_count + 1
				end
				
				--DebugMessage("%s—Found %i Geonosian objects...spires killed is %i", tostring(Script), current_geonosian_count, counter_spires_killed)

		         
				if current_geonosian_count >= max_geonosians_allowed then
					--MessageBox("more than 100 geonosians...not spawning!!!")
					break
				end

                 
                 --MessageBox("spawning some dudes")
                 geonosian_list = SpawnList(reinforcement_list1, building, ewok_player, true, true)
                 break
                 
             end
         end
         
         if counter_spires_killed == 1 then
			timer_geonosian_spawn = 45
         end
         
         if counter_spires_killed == 2 then
			timer_geonosian_spawn = 30
         end
         
         if counter_spires_killed == 3 then
			timer_geonosian_spawn = 15
         end
         
         if counter_spires_killed == 4 then
			timer_geonosian_spawn = 7
         end
         
         if counter_spires_killed >= 5 then
			timer_geonosian_spawn = 3
         end

         Sleep(timer_geonosian_spawn)
    until current_spawn_times > max_spawn_times or not building_still_standing
end










function Intro_Cinematic()

	--MessageBox("intro cine function hit!!!")
	-- Lock out controls for intro cinematic and reveal FOW
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)

	-- now find the cinematic spire and pan around it
	spire = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire4")
	if not spire then
		--MessageBox("intro cine Can't find spire!!!")
		return
	end
	
	
	Start_Cinematic_Camera()
	Fade_Screen_In(.5)
	
	-- this pans around the geonosian spire...also shows the rebel base
	
	base_loc = Find_Hint("GENERIC_MARKER_LAND", "rebelbase1")
	entry_loc = Find_Hint("GENERIC_MARKER_LAND", "entry")
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(spire, 400, 6, 30, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(spire, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(spire, 10, 1200, 12, -60, 1, 0, 0, 0) 
	
	Sleep(5)
	
	-- This cinematic pans around the Rebel Base.
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(base_loc, 400, 6, 30, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(base_loc, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(base_loc, 6, 800, 30, 120, 1, 0, 0, 0)
			
	Sleep(6)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(base_loc, 800, 30, 120, 1, 0, 0, 0)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(base_loc, 0, 0, 0, 0, 0, 0, 0) 
	-- Transition_Cinematic_Target_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Target_Key(entry_loc, 1, 0, 0, 0, 1, 0, 0, 0)
		
	Sleep(0.5)
	
	Transition_To_Tactical_Camera(5)
	
	Sleep(5)
	
	--Fade_Screen_Out(.5)
	Transition_To_Tactical_Camera(2)
	--Sleep(2)
	End_Cinematic_Camera()
	--Fade_Screen_In(.5)
	Letter_Box_Out(.5)	
	Lock_Controls(0)
	Suspend_AI(0)
	
	spire_1 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire1")
	spire_2 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire2")
	spire_3 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire3")
	spire_4 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire4")
	spire_5 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire5")
	spire_6 = Find_Hint("GEONOSIAN_SPAWN_HOUSE", "spire6")
	
	if TestValid(spire_1) then
		Add_Radar_Blip(spire_1, "blip_spire1")
	end
	
	if TestValid(spire_2) then
		Add_Radar_Blip(spire_2, "blip_spire2")
	end
	
	if TestValid(spire_3) then
		Add_Radar_Blip(spire_3, "blip_spire3")
	end
	
	if TestValid(spire_4) then
		Add_Radar_Blip(spire_4, "blip_spire4")
	end
	
	if TestValid(spire_5) then
		Add_Radar_Blip(spire_5, "blip_spire5")
	end
	
	if TestValid(spire_6) then
		Add_Radar_Blip(spire_6, "blip_spire6")
	end
	flag_initialized = true
	Geonosian_Spawn_Loop()
	
	
end





-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()

	if not flag_initialized then
		return
	end
	
	if not TestValid(spire_1) and not flag_spire_1_dead then
		flag_spire_1_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 
	
	if not TestValid(spire_2) and not flag_spire_2_dead then
		flag_spire_2_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 
	
	if not TestValid(spire_3) and not flag_spire_3_dead then
		flag_spire_3_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 
	
	if not TestValid(spire_4) and not flag_spire_4_dead then
		flag_spire_4_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 
	
	if not TestValid(spire_5) and not flag_spire_5_dead then
		flag_spire_5_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 
	
	if not TestValid(spire_6) and not flag_spire_6_dead then
		flag_spire_6_dead = true
		counter_spires_killed = counter_spires_killed + 1
	end 

end
