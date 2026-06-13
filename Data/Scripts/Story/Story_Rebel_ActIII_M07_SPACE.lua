-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M07_SPACE.lua#29 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M07_SPACE.lua $
--
--    Original Author: Eric_Yiskis
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36026 $
--
--          $DateTime: 2006/01/05 17:48:43 $
--
--          $Revision: #29 $
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
		Rebel_A3_M07_Begin = State_Rebel_A3_M07_Begin,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_00a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_00a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_01a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_01a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_02a  = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_02a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_03a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_03a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_04a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_04a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_05a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_05a,
		Rebel_ActIII_Mission_Seven_Intro_Cinematic_06a = State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_06a,
		Rebel_A3_M07_Victory_Trigger = State_Rebel_A3_M07_Victory_Trigger
	}

	-- These patrol markers form a ring around the level	
	patrol_marker_names = {
		"waypoint1",
		"waypoint2",
		"waypoint3",
		"waypoint4",
		"waypoint5",
		"waypoint6",
		"waypoint7",
		"waypoint8"
	}
	
	patrol_marker_count = 8
	patrol_markers = {}

	interdictor_marker_names = {
		"waypoint2",
		"waypoint4",
		"waypoint6",
		"waypoint8"
	}
	
	-- Note: this list is parallel with the marker_names, it matches a marker with an index into the waypoints
	interdictor_destination_index = {
		3,
		5,
		7,
		1
	}
	
	pirate_spawn_list = {
		"Pirate_Frigate_Captain"
	}
	
	pirate_under_attack = false
	init_done = false
	pirate_fleeing = false
	pirate_disabled = false
	pirate_captured = false
	interdictor_list = {}
	pirate_flee_range = 600
	capture_range = 250
	hull_considered_disabled = 0.5   -- when the pirate drops below this fraction hull, it's considered disabled.
	player_informed = false
	flag_interdictors_flagged = false
   
end

------------------------------------------------------------------------------------------------------------------------
-- State_Rebel_A3_M07_Begin -- Get the mission started
------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A3_M07_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		Suspend_AI(1)
		--MessageBox("OnEnter State_Rebel_A3_M07_Begin")

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		
		-- Get Players
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")
		pirates = Find_Player("Pirates")
		neutral = Find_Player("Neutral")
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		-- Find Antilles as he has to be on the mission
		
		antilles = Find_First_Object("SUNDERED_HEART")
		
		if not TestValid(antilles) then
				--MessageBox("Missing Captain Antilles")
		end
		
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		-- Find the marker where the rebel ships will enter
		
		attacker_entry_pos = Find_Hint("GENERIC_MARKER_SPACE", "cinematichyperspacepos")
		
		if not TestValid(attacker_entry_pos) then
			--MessageBox("Missing Attacker Entry Position")
		end
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		-- Find the Imperial hyperspace in point
		
		empire_entry_pos = Find_Hint("GENERIC_MARKER_SPACE", "emphyperspacein")
		
		if not TestValid(empire_entry_pos) then
			--MessageBox("Missing Empire Entry Position")
		end
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		-- Find the Imperial Fleet so we can Hyperspace them in
		
		star_destroyer = Find_Hint("STAR_DESTROYER")
		if not TestValid(star_destroyer) then
			--MessageBox("Missing Imperial Star Destroyer")
		end
		star_destroyer.Hide(true)
		star_destroyer.Suspend_Locomotor(true)
		
		tartan_cruiser_1 = Find_Hint("Tartan_Patrol_Cruiser", "emptartan1")
		if not TestValid(tartan_cruiser_1) then
			--MessageBox("Missing Tartan Cruiser 1")
		end
		tartan_cruiser_1.Hide(true)
		tartan_cruiser_1.Suspend_Locomotor(true)
		
		tartan_cruiser_2 = Find_Hint("Tartan_Patrol_Cruiser", "emptartan2")
		if not TestValid(tartan_cruiser_2) then
			--MessageBox("Missing Tartan Cruiser 2")
		end
		tartan_cruiser_2.Hide(true)
		tartan_cruiser_2.Suspend_Locomotor(true)
		
		--tartan_cruiser_3 = Find_Hint("Tartan_Patrol_Cruiser", "emptartan3")
		--if not TestValid(tartan_cruiser_3) then
			--MessageBox("Missing Tartan Cruiser 3")
		--end
		--tartan_cruiser_3.Hide(true)
		--tartan_cruiser_3.Suspend_Locomotor(true)
		
		victory_destroyer_1 = Find_Hint("VICTORY_DESTROYER", "empvictory1")
		if not TestValid(victory_destroyer_1) then
			--MessageBox("Missing Victory Destroyer 1")
		end
		victory_destroyer_1.Hide(true)
		victory_destroyer_1.Suspend_Locomotor(true)
		
		victory_destroyer_2 = Find_Hint("VICTORY_DESTROYER", "empvictory2")
		if not TestValid(victory_destroyer_2) then
			--MessageBox("Missing Victory Destroyer 2")
		end
		victory_destroyer_2.Hide(true)
		victory_destroyer_2.Suspend_Locomotor(true)
		
		interdictor_1 = Find_Hint("INTERDICTOR_CRUISER", "empinterdictor1")
		if not TestValid(interdictor_1) then
			--MessageBox("Missing Interdictor 1")
		end
		interdictor_1.Hide(true)
		interdictor_1.Suspend_Locomotor(true)
		
		interdictor_2 = Find_Hint("INTERDICTOR_CRUISER", "empinterdictor2")
		if not TestValid(interdictor_2) then
			--MessageBox("Missing Interdictor 2")
		end
		interdictor_2.Hide(true)
		interdictor_2.Suspend_Locomotor(true)
		
		interdictor_3 = Find_Hint("INTERDICTOR_CRUISER", "empinterdictor3")
		if not TestValid(interdictor_3) then
			--MessageBox("Missing Interdictor 3")
		end
		interdictor_3.Hide(true)
		interdictor_3.Suspend_Locomotor(true)
		
		interdictor_4 = Find_Hint("INTERDICTOR_CRUISER", "empinterdictor4")
		if not TestValid(interdictor_4) then
			--MessageBox("Missing Interdictor 4")
		end
		interdictor_4.Hide(true)
		interdictor_4.Suspend_Locomotor(true)
		
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
				
		-- Find all the patrol markers (waypoints)
		
		for i,name in pairs(patrol_marker_names) do
			marker = Find_Hint("GENERIC_MARKER_SPACE", name)
			if not marker then
				--MessageBox("Missing patrol marker %s",name)
			end
			table.insert(patrol_markers,marker)
		end
		--MessageBox("Done finding patrol markers")
		
		pirate_path_01 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-1")
		pirate_path_02 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-2")
		pirate_path_03 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-3")
		pirate_path_04 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-4")
		pirate_path_05 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-5")
		pirate_path_06 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-6")
		pirate_path_07 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-7")
		pirate_path_08 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-8")
		pirate_path_09 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-9")
		pirate_path_10 = Find_Hint("GENERIC_MARKER_SPACE", "pirate-patrol-10")
		
		
		
		prox_range = 200
		Register_Prox(pirate_path_01, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_02, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_03, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_04, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_05, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_06, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_07, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_08, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_09, Prox_Waypoint, prox_range, pirates)
		Register_Prox(pirate_path_10, Prox_Waypoint, prox_range, pirates)
				

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Find the interdictors
		-- for i,name in pairs(interdictor_marker_names) do
			-- marker = Find_Hint("GENERIC_MARKER_SPACE", name)
			-- interdictor = Find_Nearest(marker, "INTERDICTOR_CRUISER")			
			-- if not interdictor or not marker then
			--	MessageBox("Missing something finding interdictor near %s",name)
			-- else
				--MessageBox("Sending interdictor at %s to waypoint %d",name,interdictor_destination_index[i])
		
		-- Since we already know the interdictors and we are hyperspacing them in with the fleet
		-- just set the table for now and we will let them patrol after the intro cinematic is finished
		
		interdictor_list[interdictor_1] = interdictor_destination_index[1]
		interdictor_list[interdictor_2] = interdictor_destination_index[2]
		interdictor_list[interdictor_3] = interdictor_destination_index[3]
		interdictor_list[interdictor_4] = interdictor_destination_index[4]
				
				--Create_Thread("Loop_Waypoints", interdictor)
			-- end
		-- end		
		--MessageBox("Done finding interdictors")

		-- Spawn the pirate
		pirate_marker = Find_Hint("GENERIC_MARKER_SPACE", "pirate")
		pirate_move_to_marker = Find_Hint("GENERIC_MARKER_SPACE", "piratemoveto")
		pirate_move_to_empire_marker = Find_Hint("GENERIC_MARKER_SPACE", "piratemovetoemp")
		new_units = SpawnList(pirate_spawn_list, pirate_marker, pirates, false, true)
   		
		pirate_ship = new_units[1]
		
		--pirate_ship = Find_Hint ("PIRATE_FRIGATE_CAPTAIN","pirate-ship")
		if not pirate_ship then
			MessageBox("Couldn't create pirate ship ... aborting!")
			return
		end
		
		pirate_ship.Face_Immediate(pirate_move_to_marker)
		pirate_ship.Set_Cannot_Be_Killed(true)
		pirate_ship.Prevent_Opportunity_Fire(true)
		pirate_ship.Prevent_AI_Usage(true)	
		pirate_ship.Make_Invulnerable(true)
		pirate_ship.Move_To(pirate_move_to_marker)
		
		
		

		

		interdictor_already_attacked = false
						
		init_done = true	
		
		-- Do the cinematic intro	
		Cinematic_Intro_Thread_ID = Create_Thread("Cinematic_Intro")
		
	end
end

-- **********************************************--
-- ****Mission is over, trigger end cinematic****--
-- **********************************************--

function State_Rebel_A3_M07_Victory_Trigger(message)
	if message == OnEnter then
		Create_Thread("Ending_Cinematic")
	end
end	

------------------------------------------------------------------------------------------------------------------------
-- ******************************************** CINEMATIC SEQUENCES ****************************************************
------------------------------------------------------------------------------------------------------------------------

-- This cinematic establishes the rebel forces and establishes the presence of Antilles befoe the dialog begins
function Cinematic_Intro()

	-- Set up the start tactical camera position
	Point_Camera_At(attacker_entry_pos)
	
	-- Suspend relevent systems while cinematic plays
	Suspend_AI(1)
	Lock_Controls(1)
	
	-- Set up cinematic stroy mode	
	Start_Cinematic_Camera()
	Letter_Box_In(0)
	
	-- Set intial camera and target positions	
	-- As we do not know where in the feet formation Anitlles will be, base the camera and target positions off of his ship
	-- The entry marker has a z angle that is opposite of 45 degrees on this map
	if TestValid(antilles) then
		
		Set_Cinematic_Camera_Key(antilles, 10800, -.2, 47, 1, 0, 0, 0) 
		Set_Cinematic_Target_Key(antilles, 10100, 0, 45, 1, 1, 0, 0)		
		 
	end
		
	-- Fade the scene in and wait for the scene to be fully visisble before proceeding
	Fade_Screen_In(2)
	Sleep(2)
	
	-- Tell the ships we put on hold in XML to come in
	Resume_Hyperspace_In()
	
	-- Wait on the current shot a bit
	Sleep(3.5)
	
	-- Start hyperspacing in the imperial fleet
	if TestValid(star_destroyer) then
		--star_destroyer.Cinematic_Hyperspace_In(220)
		star_destroyer.Cinematic_Hyperspace_In(160)	
	end
		
	if TestValid(tartan_cruiser_1) then	
		--tartan_cruiser_1.Cinematic_Hyperspace_In(232)
		tartan_cruiser_1.Cinematic_Hyperspace_In(172)	 
	end
	
	if TestValid(tartan_cruiser_2) then	
		--tartan_cruiser_2.Cinematic_Hyperspace_In(245)
		tartan_cruiser_2.Cinematic_Hyperspace_In(185)	 
	end
	
	--if TestValid(tartan_cruiser_3) then	
		--tartan_cruiser_3.Cinematic_Hyperspace_In(263)	
		--tartan_cruiser_3.Cinematic_Hyperspace_In(203) 
	--end
	
	if TestValid(victory_destroyer_1) then	
		--victory_destroyer_1.Cinematic_Hyperspace_In(238)
		victory_destroyer_1.Cinematic_Hyperspace_In(178)	 
	end
	
	if TestValid(victory_destroyer_2) then	
		--victory_destroyer_2.Cinematic_Hyperspace_In(258)
		victory_destroyer_2.Cinematic_Hyperspace_In(198)	 
	end
		
	
	if TestValid(interdictor_1) then	
		--interdictor_1.Cinematic_Hyperspace_In(252)
		interdictor_1.Cinematic_Hyperspace_In(192)
		--interdictor_1.Stop()	 
		interdictor_1.Suspend_Locomotor(true)
	end
	
	if TestValid(interdictor_2) then	
		--interdictor_2.Cinematic_Hyperspace_In(270)	
		interdictor_2.Cinematic_Hyperspace_In(210) 
		--interdictor_2.Stop()
		interdictor_2.Suspend_Locomotor(true)
	end
	
	if TestValid(interdictor_3) then	
		--interdictor_3.Cinematic_Hyperspace_In(240)	
		interdictor_3.Cinematic_Hyperspace_In(180) 
		--interdictor_3.Stop()
		interdictor_3.Suspend_Locomotor(true)
	end
	
	if TestValid(interdictor_4) then	
		--interdictor_4.Cinematic_Hyperspace_In(226)	
		interdictor_4.Cinematic_Hyperspace_In(166)
		--interdictor_4.Stop() 
		interdictor_4.Suspend_Locomotor(true)
	end
	
	-- Switch to a different shot

	if TestValid(antilles) then
		Set_Cinematic_Camera_Key(antilles, 255, -15, 160, 1, antilles, 1, 0) 
		Set_Cinematic_Target_Key(empire_entry_pos, 0, 0, 0, 0, 0, 0, 0) 
							
	end
	
	-- Antilles dialogue is okay to start
	Story_Event("RA3M7_ANTILLES_DIALOGUE_1_GO")
end


-- ------------------------------------------------------------------------------------------------------------------------

-- This cinematic establishes the Imperial forces on the map prior to Antilles "Looks like I spoke too soon"
function Cinematic_Imperial_Establishing()

	Sleep(2)
	Cinematic_Zoom(2, .02)
	Story_Event("RA3M7_ANTILLES_DIALOGUE_2_GO")
	Sleep(5)

end

-- ------------------------------------------------------------------------------------------------------------------------

-- This cinematic establishes the Imperial forces on the map prior to Antilles "Looks like I spoke too soon"
function Cinematic_Imperial_Dialogue_1()

	-- We need a shot of the star destroyer here
	Sleep(1.5)
	Set_Cinematic_Camera_Key(star_destroyer, 400, -15, 170, 1, star_destroyer, 1, 0) 
	Set_Cinematic_Target_Key(antilles, 0, 0, 0, 0, 0, 0, 0)
	Cinematic_Zoom(10, .99)	 
	pirate_ship.Move_To(pirate_move_to_empire_marker)	
	Sleep(1)
	Story_Event("RA3M7_IMPERIAL_DIALOGUE_1_GO")

end
-- ------------------------------------------------------------------------------------------------------------------------

-- This cinematic establishes the pirate moving toward the Imperial forces
function Cinematic_Pirate_To_Empire()

	Sleep(1)
	Set_Cinematic_Camera_Key(star_destroyer, -200, 50, 35, 0, pirate_ship, 0, 0) 
	Set_Cinematic_Target_Key(star_destroyer, 0, 0, 0, 0, 0, 0, 0)

	Story_Event("RA3M7_ANTILLES_DIALOGUE_3_GO")
	
end		

-- ------------------------------------------------------------------------------------------------------------------------

-- This cinematic holds the existing shot while the empire threatens the pirate
function Cinematic_Empire_Threatens_Pirate() 

	Sleep(1)
	Set_Cinematic_Camera_Key(star_destroyer, 400, -15, 170, 1, star_destroyer, 1, 0) 
	Set_Cinematic_Target_Key(pirate_ship, 0, 0, 0, 0, pirate_ship, 0, 0)
	
	Story_Event("RA3M7_IMPERIAL_DIALOGUE_2_GO")
	
	Sleep(4)
	
	Set_Cinematic_Camera_Key(star_destroyer, -200, 50, 35, 0, pirate_ship, 0, 0) 
	Set_Cinematic_Target_Key(star_destroyer, 0, 0, 0, 0, 0, 0, 0)
	
end		

-- ------------------------------------------------------------------------------------------------------------------------

-- This cinematic shows the pirate fleeing after being threatened by the empire
function Cinematic_Pirate_Retreats()

	Set_Cinematic_Camera_Key(star_destroyer, 400, 10, 170, 1, star_destroyer, 1, 0) 
	Set_Cinematic_Target_Key(pirate_ship, 0, 0, 0, 0, pirate_ship, 0, 0)
	
	--Create_Thread("Thread_Pirate_Escape_Patrol")	
	--pirate_ship.Move_To(pirate_move_to_marker)
	pirate_ship.Move_To(pirate_path_01)
		
	
	Sleep(6)
	Story_Event("RA3M7_IMPERIAL_DIALOGUE_3_GO")
	Sleep(.5)
	
end		


-- ------------------------------------------------------------------------------------------------------------------------
-- The race is on to destroy the pirate

function Cinematic_Attack_Pirate()
	
	pirate_ship.Prevent_Opportunity_Fire(false)
	
	star_destroyer.Attack_Move(pirate_ship)
	victory_destroyer_1.Attack_Move(pirate_ship)
	victory_destroyer_2.Attack_Move(pirate_ship)
	tartan_cruiser_1.Attack_Move(pirate_ship)
	tartan_cruiser_2.Attack_Move(pirate_ship)
	--tartan_cruiser_3.Attack_Move(pirate_ship)
	
	Sleep(6)
	
	Set_Cinematic_Camera_Key(antilles, 550, 15, 180, 1, antilles, 1, 0) 
	Set_Cinematic_Target_Key(antilles, 200, 0, 0, 0, antilles, 1, 0) 
	Cinematic_Zoom(10, .9)	 
	Story_Event("RA3M7_ANTILLES_DIALOGUE_4_GO")
		
end		

-- ------------------------------------------------------------------------------------------------------------------------
-- End the intro cinematic

function Cinematic_Intro_End() 
	
	Sleep(1)	
	Point_Camera_At(antilles)
	Transition_To_Tactical_Camera(1)
	Letter_Box_Out(1)
	Sleep(1)
	
	for interdictor, index in pairs(interdictor_list) do
		--Register_Attacked_Event(interdictor, Interdictor_Attacked_Callback)
		--preventing auto-fire on interdictors and making interdictors actually interdict
		interdictor.Prevent_AI_Usage(true)
		interdictor.Prevent_Opportunity_Fire(true)
		interdictor.Activate_Ability("INTERDICT", true)
	end
	
	pirate_ship.Override_Max_Speed(3)
	pirate_ship.Set_Cannot_Be_Killed(true)
	pirate_ship.Make_Invulnerable(false)
	
	
	
	--Register_Attacked_Event(pirate_ship, Pirate_Attacked_Callback)
	--Register_Prox(pirate_ship, Pirate_Prox, pirate_flee_range, rebel)
	
	
	End_Cinematic_Camera()
	Suspend_AI(0)
	Lock_Controls(0)		
	
end		





------------------------------------------------------------------------------------------------------------------------
-- Interdictor_Attacked_Callback - respond to falling under attack or cooling off from being attacked

------------------------------------------------------------------------------------------------------------------------

function Interdictor_Attacked_Callback(fell_under_attack, most_deadly_enemy)
	-- We only care about the first time an interdictor is attacked
	if not interdictor_already_attacked and fell_under_attack and most_deadly_enemy == pirate_ship then
		interdictor_already_attacked = true
		Story_Event("interdictor_attacked")
	end

	if interdictor_already_attacked then
		Cancel_Attacked_Event(fell_under_attack)
	end
end
		


------------------------------------------------------------------------------------------------------------------------
-- Disable_Pirate
------------------------------------------------------------------------------------------------------------------------

function Disable_Pirate()
	--MessageBox("Pirate Disabled!")
	pirate_disabled = true
	Cancel_Attacked_Event(pirate_ship)
	pirate_ship.Move_To(pirate_ship.Get_Position())
	pirate_ship.Lock_Current_Orders()
	pirate_ship.Make_Invulnerable(true)
	pirate_ship.Prevent_Opportunity_Fire(true)
	Story_Event("PIRATE_DISABLED")
	
	Register_Prox(pirate_ship,Prox_Rebel_Capture,capture_range,rebel)
end

------------------------------------------------------------------------------------------------------------------------
-- Despawn_Pirate()
------------------------------------------------------------------------------------------------------------------------

function Despawn_Pirate()
	pirate_ship.Cancel_Event_Object_In_Range(Prox_Rebel_Capture)
	--pirate_ship.Cancel_Event_Object_In_Range(Prox_Empire_Capture)
	--pirate_ship.Despawn()
	--making the pirate "killable" again
	pirate_ship.Make_Invulnerable(false)
	pirate_ship.Set_Cannot_Be_Killed(false)
	pirate_ship = nil
end

------------------------------------------------------------------------------------------------------------------------
-- Prox_Rebel_Capture - One of the rebels captured the pirate
------------------------------------------------------------------------------------------------------------------------

function Prox_Rebel_Capture(prox_obj, trigger_obj)

	if not pirate_disabled then
		return
	end

	if trigger_obj.Is_Category("Fighter") or trigger_obj.Is_Category("Bomber") then
		return
	end


	--MessageBox("Rebels captured the pirate")
	Despawn_Pirate()
	Story_Event("REBELS_CAPTURED_PIRATE")
	pirate_captured = true

	if one_left == true then
		Story_Event("REBELS_CAPTURED_PIRATE_SI")	-- Still interdictors
	else
		Story_Event("REBELS_CAPTURED_PIRATE_NI")	-- No interdictors
	end
end



------------------------------------------------------------------------------------------------------------------------
-- Story_Mode_Service() - gets serviced each frame
------------------------------------------------------------------------------------------------------------------------

-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()

	if not init_done then
		return
	end
	
	
	if  TestValid(pirate_ship) and not pirate_disabled then
		-- If the pirate ship takes too much damage, then disable it.
		if pirate_ship.Get_Hull() < hull_considered_disabled then
			Disable_Pirate()
			
		end
	end
	
		
	-- if interdictor receives hull damage, let the AI take over
	one_left = false
	remainder = 0
	for unit,i in pairs(interdictor_list) do
		if TestValid(unit) then
			one_left = true
			remainder = remainder + 1
		else
			--MessageBox("Interdictor destroyed, if they all go, the pirate will get away.")
			interdictor_list[unit] = nil
		end
	end


	if not one_left then
		if not pirate_disabled then
			--MessageBox("YOU LOSE: All of the interdictors are gone and we haven't disabled the pirate, so he's fleeing.")
			pirate_ship.Hyperspace_Away()
			Story_Event("PIRATE_ESCAPED")
			ScriptExit()
		else
			Story_Event("INTERDICTORS_DESTROYED")
		end
	elseif not player_informed and remainder == 1 then
		-- Tell the player that there's only one left
		player_informed = true
		if pirate_captured then
			Story_Event("one_left_captured")
		else
			Story_Event("one_left_not_captured")
		end		
	end
		
end

-- Cinematic triggers

-- Antilles first speaks "Looks like we beat the imperial fleet..." or similar
function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_00a(message)
	if message == OnEnter then
	
		Cinematic_Imperial_Establishing_Thread_ID = Create_Thread("Cinematic_Imperial_Establishing")
	
	end
end	

function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_01a(message)
	if message == OnEnter then

		Cinematic_Imperial_Dialogue_1_Thread_ID = Create_Thread("Cinematic_Imperial_Dialogue_1")
		
	end
end	


function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_02a(message)
	if message == OnEnter then
		
		Cinematic_Pirate_To_Empire_Thread_ID = Create_Thread("Cinematic_Pirate_To_Empire")
		
	end
end	


function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_03a(message)
	if message == OnEnter then
		
		Cinematic_Empire_Threatens_Pirate_Thread_ID = Create_Thread("Cinematic_Empire_Threatens_Pirate")
		
	end
end	

function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_04a(message)
	if message == OnEnter then

		Cinematic_Pirate_Retreats_Thread_ID = Create_Thread("Cinematic_Pirate_Retreats")
		
	end
end	

function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_05a(message)
	if message == OnEnter then

		Cinematic_Attack_Pirate_Thread_ID = Create_Thread("Cinematic_Attack_Pirate")
	
	end
end	

function State_Rebel_ActIII_Mission_Seven_Intro_Cinematic_06a(message)
	if message == OnEnter then

		Cinematic_Intro_End_Thread_ID = Create_Thread("Cinematic_Intro_End")
	
	end
end	


-- prox events to keep pirate on the move
function Prox_Waypoint(prox_obj, trigger_obj)
		
	if trigger_obj == pirate_ship and not pirate_disabled then
	
		--MessageBox("Prox_Waypoint hit")
		
		if prox_obj == pirate_path_01 then
			--MessageBox("pirate to pirate_path_02")
			trigger_obj.Move_To(pirate_path_02)
		end
		if prox_obj == pirate_path_02 then
			--MessageBox("pirate to pirate_path_03")
			trigger_obj.Move_To(pirate_path_03)
			
			if not flag_interdictors_flagged then
			
				flag_interdictors_flagged = true
				for interdictor, index in pairs(interdictor_list) do
					Register_Attacked_Event(interdictor, Interdictor_Attacked_Callback)
					interdictor.Prevent_Opportunity_Fire(false)
				end
			end
		end
		if prox_obj == pirate_path_03 then
			trigger_obj.Move_To(pirate_path_04)
		end
		if prox_obj == pirate_path_04 then
			trigger_obj.Move_To(pirate_path_05)
		end
		if prox_obj == pirate_path_05 then
			trigger_obj.Move_To(pirate_path_06)
		end
		if prox_obj == pirate_path_06 then
			pirate_ship.Override_Max_Speed(1)
			trigger_obj.Move_To(pirate_path_07)
		end
		if prox_obj == pirate_path_07 then
			pirate_ship.Override_Max_Speed(2)
			trigger_obj.Move_To(pirate_path_08)
		end
		if prox_obj == pirate_path_08 then
			trigger_obj.Move_To(pirate_path_09)
		end
		if prox_obj == pirate_path_09 then
			trigger_obj.Move_To(pirate_path_10)
		end

		if prox_obj == pirate_path_10 then
			trigger_obj.Move_To(pirate_path_01)
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
-- dme Ending Cinematic stuff
------------------------------------------------------------------------------------------------------------------------


function Ending_Cinematic()
	
	Cancel_Fast_Forward() 
	Story_Event("DISABLE_ANTILLES_KILLED")
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
--	Ensure Antilles is still present for this cinematic
	
	sundered_heart = Find_First_Object("SUNDERED_HEART")
	if not sundered_heart then
		return
	end
	
	warp_loc = Find_Hint("GENERIC_MARKER_SPACE", "warploc")
		
	Start_Cinematic_Camera()
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(warp_loc, 1000, -10, -90, 1, 0, 1, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(warp_loc, -50, 0, 0, 0, 0, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Transition_Cinematic_Camera_Key(warp_loc, 5, 200, 2.5, -37.5, 1, 0, 1, 0)
	Transition_Cinematic_Camera_Key(warp_loc, 5, 200, 17, 15, 1, 0, 1, 0)
	
	
	rebel = Find_Player("Rebel")
	unit_list = Find_All_Objects_Of_Type(rebel)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
	Start_Cinematic_Space_Retreat(rebel.Get_ID(), 8)
	
	Sleep(4)
	End_Cinematic_Camera()
	Story_Event("MISSION_07_VICTORY")
end




