-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M08_SPACE.lua#19 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M08_SPACE.lua $
--
--    Original Author: Eric_Yiskis
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36026 $
--
--          $DateTime: 2006/01/05 17:48:43 $
--
--          $Revision: #19 $
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
		Rebel_A3_M08_Begin = State_Rebel_A3_M08_Begin
		,Rebel_A3_M08_Cargo_Found_Text_02 = State_Rebel_A3_M08_Cargo_Found_Text_02
		,FALCON_SPOTTED1_Reset_Alarm_Message = State_FALCON_SPOTTED1_Reset_Alarm_Message
		,FALCON_SPOTTED2_Reset_Alarm_Message = State_FALCON_SPOTTED2_Reset_Alarm_Message
		,FALCON_SPOTTED3_Reset_Alarm_Message = State_FALCON_SPOTTED3_Reset_Alarm_Message
		,FALCON_SPOTTED4_Reset_Alarm_Message = State_FALCON_SPOTTED4_Reset_Alarm_Message
	}

	interceptor_units_1 = {
		"TIE_BOMBER_SQUADRON"
		,"TIE_BOMBER_SQUADRON"
		,"TIE_SCOUT_SQUADRON"
		,"STAR_DESTROYER"
	}
	
	interceptor_units_2 = {
		"TARTAN_PATROL_CRUISER"
		,"TARTAN_PATROL_CRUISER"
		,"TARTAN_PATROL_CRUISER"
--	THESE ARE CRASHING THE GAME CURRENTLYinini
--		,"BROADSIDE_CLASS_CRUISER"
--		,"BROADSIDE_CLASS_CRUISER"
	}
	
	visit_list = {
		"Victory_Destroyer_No_Fighters"
	}
	
	patrol_marker_names = {
		"patrol1"
		,"patrol2"
		,"patrol3"
		,"patrol4"
		,"patrol5"
		,"patrol6"
		,"patrol7"
		,"patrol8"
		,"patrol9"
		,"patrol10"
		,"patrol11"
		,"patrol12"
	}
	
	starbase_marker = nil
	
	patrol_marker_count = 12
	patrol_markers = {}
	
	cargo_range = 150
	scanning_range = 600 
	cargo_scanned = 0
	cargo_being_scanned = nil

	spotted_range = 500 -- This should be slighly greater than the longest sight range by a patroller
	falcon_spottings = 0
	
	alarm_units = {}
	alarm_was_activated = false
	
	time_to_first_visit = 20
	min_time_between_visits = 60
	variance_between_visits = 30
	
	duration_of_fighter_assist = 30

	traffic_count = 0
	
	num_scanned_to_bring_fett = 5
	counter_enough_scanned = 10
	
	flag_okay_to_give_alarm_message = true
	
	fog_id = nil
	
end

------------------------------------------------------------------------------------------------------------------------
-- State_Rebel_A3_M08_Begin -- Get the mission started
------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A3_M08_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		--MessageBox("OnEnter State_Rebel_A3_M08_Begin")

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		
		-- Get Players
		
		starbase_marker = Find_Hint("GENERIC_MARKER_SPACE", "starbase")
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")

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
		

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Set up proximity calls to keep patrol moving along
		
		prox_range = 300
		for i,marker in pairs(patrol_markers) do
			Register_Prox(marker, Prox_Patrol, prox_range, empire)
		end
		--MessageBox("Setup marker proximity calls")

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Set up proximity calls on cargo 
		
		cargo_list = Find_All_Objects_Of_Type("ORBITAL_RESOURCE_CONTAINER")
		for i,unit in pairs(cargo_list) do
			Register_Prox(unit, Prox_Cargo, cargo_range, rebel)
			unit.Make_Invulnerable(true)
		end
		--MessageBox("Set up proximity on resource containers")

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Find the Falcon
		falcon = Find_First_Object("MILLENNIUM_FALCON")
		if not falcon then
			--MessageBox("Couldn't find Millennium Falcon")
			return
		end
		
		Register_Prox(falcon, Prox_Falcon, spotted_range, empire)
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Periodically send in a Star Destroyer that is refuelling at the starbase
						
		interceptor1 = Find_Hint("GENERIC_MARKER_SPACE", "interceptor1")
		interceptor2 = Find_Hint("GENERIC_MARKER_SPACE", "interceptor2")

		Register_Timer(Star_Destroyer_Visit,time_to_first_visit)
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		fett_spawn = Find_Hint("GENERIC_MARKER_SPACE", "fett-spawn")
		if not fett_spawn then
			--MessageBox("failed to find fett-spawn")
		end

		--DELME
		--Register_Timer(Bring_Fett, 10)
		
		-- this is a comment
		-----------------------------------------------------------------------------------------------
		-- adding radar blips here
		-----------------------------------------------------------------------------------------------
		--Add_Radar_Blip(alarm1, "blip_alarm1")
		cargo_01 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-01")
		cargo_02 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-02")
		cargo_03 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-03")
		cargo_04 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-04")
		cargo_05 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-05")
		cargo_06 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-06")
		cargo_07 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-07")
		cargo_08 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-08")
		cargo_09 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-09")
		cargo_10 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-10")
		cargo_11 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-11")
		cargo_12 = Find_Hint ("ORBITAL_RESOURCE_CONTAINER", "cargo-12")
		
		if TestValid(cargo_01) then
			Add_Radar_Blip(cargo_01, "blip_cargo_01")
		end 
		
		if TestValid(cargo_02) then
			Add_Radar_Blip(cargo_02, "blip_cargo_02")
		end 
		
		if TestValid(cargo_03) then
			Add_Radar_Blip(cargo_03, "blip_cargo_03")
		end 
		
		if TestValid(cargo_04) then
			Add_Radar_Blip(cargo_04, "blip_cargo_04")
		end 
		
		if TestValid(cargo_05) then
			Add_Radar_Blip(cargo_05, "blip_cargo_05")
		end 
		
		if TestValid(cargo_06) then
			Add_Radar_Blip(cargo_06, "blip_cargo_06")
		end 
		
		if TestValid(cargo_07) then
			Add_Radar_Blip(cargo_07, "blip_cargo_07")
		end 
		
		if TestValid(cargo_08) then
			Add_Radar_Blip(cargo_08, "blip_cargo_08")
		end 
		
		if TestValid(cargo_09) then
			Add_Radar_Blip(cargo_09, "blip_cargo_09")
		end 
		
		if TestValid(cargo_10) then
			Add_Radar_Blip(cargo_10, "blip_cargo_10")
		end 
		
		if TestValid(cargo_11) then
			Add_Radar_Blip(cargo_11, "blip_cargo_11")
		end 
		
		if TestValid(cargo_12) then
			Add_Radar_Blip(cargo_12, "blip_cargo_12")
		end 

		fog_id = FogOfWar.Reveal_All(rebel)

	end
end

------------------------------------------------------------------------------------------------------------------------
-- Star Destroyer Visit functions
------------------------------------------------------------------------------------------------------------------------

function Star_Destroyer_Visit()
	if alarm_was_activated then
		return
	end
	
	ReinforceList(visit_list,interceptor2,empire,false,true, true, Star_Destroyer_Arrived)
	
	-- Setup next visit; Han should only be able to slip past if he waits for a big gap
	Register_Timer(Star_Destroyer_Visit, min_time_between_visits + GameRandom(1, variance_between_visits))	
end


function Star_Destroyer_Arrived(unit_list)
	Create_Thread("Star_Destroyer_Sequence", unit_list[1])
	Register_Prox(unit_list[1], Prox_Visitor, spotted_range, rebel)
end


function Star_Destroyer_Sequence(star_destroyer)

	if TestValid(star_destroyer) then
		BlockOnCommand(star_destroyer.Move_To(starbase_marker))
	end

	-- Every so N star_destroyers to pass through, there's an X% chance that
	-- fighters on patrol come to assist or guard; giving han a window of easier cargo examining
	traffic_count = traffic_count + 1
	if (traffic_count == 2) then
		traffic_count = 0
		--if (GameRandom(0,1) < 0.5) then
			--MessageBox("Calling in the fighters")
			List_Guard(Find_All_Objects_Of_Type("TIE_FIGHTER_SQUADRON"), star_destroyer)
			Sleep(duration_of_fighter_assist)
			--MessageBox("Placing fighters back on patrol")
			List_Random_Patrol(Find_All_Objects_Of_Type("TIE_FIGHTER_SQUADRON"))
		--end
	else

		-- Pause for a refuel at the station or something
		Sleep(5)
	end
	

	if TestValid(star_destroyer) then
		BlockOnCommand(star_destroyer.Move_To(interceptor1))
	end
	
	if TestValid(star_destroyer) then
		star_destroyer.Hyperspace_Away()
	end
end


function List_Guard(list, obj)
	for k, unit in pairs(list) do
		if TestValid(unit) and not alarm_units[unit] then
			unit.Guard_Target(obj)
		end
	end
end

function List_Random_Patrol(list)
	for k, unit in pairs(list) do
		if TestValid(unit) then
			unit.Move_To(patrol_markers[GameRandom(1, table.getn(patrol_markers))])
		end
	end
end

function Prox_Visitor(prox_obj, trigger_obj)
	prox_obj.Cancel_Event_Object_In_Range(Prox_Visitor)
	prox_obj.Attack_Move(falcon)
	alarm_unit = prox_obj
	
	if flag_okay_to_give_alarm_message then
		flag_okay_to_give_alarm_message = false
		Alarm_Activated()
	end
end

------------------------------------------------------------------------------------------------------------------------
-- Alarm_Activated - Tie fighters lasted long enough to sound alarm
------------------------------------------------------------------------------------------------------------------------

function Alarm_Activated()

	if alarm_was_activated then
		return
	end

	--MessageBox("alarm activated")
		
	-- Bring in units to intercept Millennium Falcon
	Story_Event("ALARM_ACTIVATED")
	alarm_was_activated = true
	ReinforceList(interceptor_units_1,falcon,empire,false,true, true, List_Attack_Han)
	ReinforceList(interceptor_units_2,interceptor2,empire,false,true, true, List_Attack_Han)

end

function List_Attack_Han(unit_list)
	for i,unit in pairs(unit_list) do
		unit.Attack_Move(falcon)
	end
end

------------------------------------------------------------------------------------------------------------------------
-- Prox_Falcon - Called when an Empire spots the Millennium Falcon
------------------------------------------------------------------------------------------------------------------------

function Prox_Falcon(prox_obj, trigger_obj)
	
	trigger_type = trigger_obj.Get_Type().Get_Name()

	
	if trigger_type == "TIE_FIGHTER" then
		unit = trigger_obj.Get_Parent_Object()
	elseif trigger_type == "TARTAN_PATROL_CRUISER" then
		unit = trigger_obj
	elseif trigger_type == "SLAVE_I" then
	
		-- boba fett just wants the kill himself; no reporting to the Empire
		if not fett_found_han then
			Create_Thread("Fett_Attack_Han", trigger_obj)
		end
		return

	else
		DebugMessage("]]]] Falcon spotted by %s",trigger_type)
		return
	end
		
	--Don't trigger on the same unit...
	if alarm_units[unit] then
		return
	end
	alarm_units[unit] = 1

	--MessageBox("Falcon spotted by tie fighter squadron")
	falcon_spottings = falcon_spottings + 1
	if falcon_spottings == 1 and flag_okay_to_give_alarm_message then
		flag_okay_to_give_alarm_message = false
		Story_Event("FALCON_SPOTTED1")
	end
	if falcon_spottings == 2 and flag_okay_to_give_alarm_message then
		flag_okay_to_give_alarm_message = false
		Story_Event("FALCON_SPOTTED2")
	end
	if falcon_spottings == 3 and flag_okay_to_give_alarm_message then
		flag_okay_to_give_alarm_message = false
		Story_Event("FALCON_SPOTTED3")
	end		
	if falcon_spottings == 4 and flag_okay_to_give_alarm_message then
		flag_okay_to_give_alarm_message = false
		Story_Event("FALCON_SPOTTED4")
		
		-- The unit just reports without bothering to attack first
		DebugMessage("reporting han without attacking")
		unit.Move_To(starbase_marker)
		Register_Timer(Alarm_Activated, 10)
	else
	
		-- The first three times, Han has a chance to take out the unit before it reports		
		Create_Thread("Discover_Then_Report", unit)
	end

		
end

--jdg adding a timer between the bevy of spotted events above
function State_FALCON_SPOTTED1_Reset_Alarm_Message(message)
	if message == OnEnter then
		flag_okay_to_give_alarm_message = true
	end
end

function State_FALCON_SPOTTED2_Reset_Alarm_Message(message)
	if message == OnEnter then
		flag_okay_to_give_alarm_message = true
	end
end

function State_FALCON_SPOTTED3_Reset_Alarm_Message(message)
	if message == OnEnter then
		flag_okay_to_give_alarm_message = true
	end
end

function State_FALCON_SPOTTED4_Reset_Alarm_Message(message)
	if message == OnEnter then
		flag_okay_to_give_alarm_message = true
	end
end



function Fett_Attack_Han(unit)

	-- Safety check to prevent an extra thread on this...somehow a few were slipping in.
	if fett_found_han == true then
		return
	end

	fett_found_han = true
	--MessageBox("attacking han with fett")
	Story_Event("BOBA_ATTACK")
	if TestValid(unit) and TestValid(falcon) then
		BlockOnCommand(unit.Attack_Target(falcon), 20)
	end
	
	fett_found_han = false
end


function Discover_Then_Report(unit)

	DebugMessage("discovering han")
	-- Attack the falcon for a while
	BlockOnCommand(unit.Attack_Target(falcon), 30)
	--unit.Attack_Target(falcon)
	--Sleep(30)
	
	-- Allow the player to still have a chance to cancel the alarm	
	if TestValid(unit) then
		DebugMessage("reporting han")
        BlockOnCommand(unit.Move_To(starbase_marker))
	end
	
	-- If the unit still survived, then the falcon is reported.
	if TestValid(unit) and TestValid(falcon) then
		unit.Attack_Target(falcon)
		Alarm_Activated()
	end

end


------------------------------------------------------------------------------------------------------------------------
-- Prox_Patrol - Called when ships reach a patrol point
------------------------------------------------------------------------------------------------------------------------

function Prox_Patrol(prox_obj, trigger_obj)

	-- Send only patrols to the next waypoint
	trigger_type = trigger_obj.Get_Type().Get_Name()
	--DebugMessage("]]]] Patrol trigger picked up type %s",trigger_type)
	-- If this is a fighter, we want to issue the order to the parent instead of the trigger_obj
	if trigger_type == "TIE_FIGHTER" then
		unit = trigger_obj.Get_Parent_Object()
	elseif trigger_type == "TARTAN_PATROL_CRUISER" then
		unit = trigger_obj
	elseif trigger_type == "TIE_BOMBER" then
		unit = trigger_obj.Get_Parent_Object()
	else
		return
	end

	-- Ignore objects that have already been sent on to the next patrol
	if unit.Has_Active_Orders() then
		--MessageBox("unit has active orders")
		return
	end

	--Units dealing with the alarm don't patrol
	if alarm_units[unit] then
		return
	end
	
	-- Send to the next marker
	for i,marker in pairs(patrol_markers) do
		if prox_obj == marker then
			if i == patrol_marker_count then
				next_point = 1
			else
				next_point = i+1
			end
			unit.Move_To(patrol_markers[next_point])
			DebugMessage("]]]] Sending patrol ships from %d to patrol point %d",i,next_point)
			break
		end
	end
end


------------------------------------------------------------------------------------------------------------------------
-- Prox_Cargo
------------------------------------------------------------------------------------------------------------------------

function Prox_Cargo(prox_obj, trigger_obj)
	
	-- Stop checking for this one
	prox_obj.Cancel_Event_Object_In_Range(Prox_Cargo)
	
	Game_Message("TEXT_STORY_REBEL_ACT03_MISSION_EIGHT_11")
	
	--differentiate up the boring scan dialog here
	if (cargo_scanned == 0) or (cargo_scanned == 4) or (cargo_scanned == 8) then
		Story_Event("BEGIN_CARGO_SCAN")
	elseif (cargo_scanned == 1) or (cargo_scanned == 5) or (cargo_scanned == 9) then
		Story_Event("BEGIN_CARGO_SCAN2")
	elseif (cargo_scanned == 2)  or (cargo_scanned == 6) or (cargo_scanned == 10) then
		Story_Event("BEGIN_CARGO_SCAN3")
	elseif (cargo_scanned == 3)  or (cargo_scanned == 7) or (cargo_scanned == 11) then
		Story_Event("BEGIN_CARGO_SCAN4")
	end
	
	--Story_Event("BEGIN_CARGO_SCAN")
	scan_seconds = 5
	cargo_being_scanned = prox_obj
	Register_Timer(Scanning_Timer,scan_seconds,prox_obj )
	
	--add an arrow to cargo being scanned
	cargo_being_scanned.Highlight(true)
	
	falcon.Stop()
	
	
end

------------------------------------------------------------------------------------------------------------------------
-- Scanning_Timer() - Marks cargo as scanned if the Falcon hangs out for x seconds
------------------------------------------------------------------------------------------------------------------------

function Scanning_Timer(timer_obj)

	if cargo_being_scanned.Get_Distance(falcon) <= scanning_range then
		Game_Message("TEXT_STORY_REBEL_ACT03_MISSION_EIGHT_12")
		--MessageBox("Story_Event(CARGO_SCAN_DONE)")
		Story_Event("CARGO_SCAN_DONE")
		--MessageBox("CARGO_SCAN_DONE")
		cargo_scanned = cargo_scanned + 1

		
		--turn off appropriate radar blip here
		
		if TestValid(cargo_01) and cargo_being_scanned == cargo_01 then
			Remove_Radar_Blip("blip_cargo_01")
			cargo_being_scanned.Highlight(false)
			--MessageBox("cargo one scanned...removing blip?")
		end
		
		if TestValid(cargo_02) and cargo_being_scanned == cargo_02 then
			Remove_Radar_Blip("blip_cargo_02")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_03) and cargo_being_scanned == cargo_03 then
			Remove_Radar_Blip("blip_cargo_03")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_04) and cargo_being_scanned == cargo_04 then
			Remove_Radar_Blip("blip_cargo_04")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_05) and cargo_being_scanned == cargo_05 then
			Remove_Radar_Blip("blip_cargo_05")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_06) and cargo_being_scanned == cargo_06 then
			Remove_Radar_Blip("blip_cargo_06")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_07) and cargo_being_scanned == cargo_07 then
			Remove_Radar_Blip("blip_cargo_07")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_08) and cargo_being_scanned == cargo_08 then
			Remove_Radar_Blip("blip_cargo_08")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_09) and cargo_being_scanned == cargo_09 then
			Remove_Radar_Blip("blip_cargo_09")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_10) and cargo_being_scanned == cargo_10 then
			Remove_Radar_Blip("blip_cargo_10")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_11) and cargo_being_scanned == cargo_11 then
			Remove_Radar_Blip("blip_cargo_11")
			cargo_being_scanned.Highlight(false)
		end
		
		if TestValid(cargo_12) and cargo_being_scanned == cargo_12 then
			Remove_Radar_Blip("blip_cargo_12")
			cargo_being_scanned.Highlight(false)
		end
		
		
		if cargo_scanned == num_scanned_to_bring_fett then
			DebugMessage("Timer for fett initiated")
			Register_Timer(Bring_Fett, 10)
        elseif cargo_scanned >= counter_enough_scanned then
			Story_Event("CARGO_SCANNED")
		end
	else
		Game_Message("TEXT_STORY_REBEL_ACT03_MISSION_EIGHT_13")
		Story_Event("CARGO_SCAN_ABORTED")
		Register_Prox(cargo_being_scanned, Prox_Cargo, cargo_range, rebel)
	end

end

-- Fett arrives after a short delay
function Bring_Fett()
	DebugMessage("Reinforcing with Fett")
	if TestValid(falcon) then
		ReinforceList({"Boba_Fett_Team"}, fett_spawn, empire, false, true, true, Fett_Arrives)
	end
	
end

-- Fett gives his intro then begins his search
function Fett_Arrives(unit_list)
	fett = unit_list[1]
	--MessageBox("Fett intro dialog here")
	Story_Event("BOBA_DIALOG")
	fett.Move_To(interceptor1)
	Register_Timer(Timer_Fett_Search, 10)
end

function Timer_Fett_Search()
	Create_Thread("Fett_Search")
end

function Fett_Search()
	
	-- Fett patrols between the container second nearest to the falcon
	-- If he finds han, script elsewhere will cause him to attack.
	-- Resume patrolling if han is lost in the fog of war.
	while TestValid(falcon) do	
		if not fett_found_han then
			if not TestValid(fett) then break end
			nearest_barrel = Find_Nearest(falcon, "ORBITAL_RESOURCE_CONTAINER")
			BlockOnCommand(fett.Attack_Move(nearest_barrel.Get_Position()), 20)
		end
		Sleep(3)
		if not fett_found_han then
			if not TestValid(fett) then break end
			nearest_barrel = Find_Nearest(falcon, "ORBITAL_RESOURCE_CONTAINER")
			second_nearest_barrel = Find_Nearest(nearest_barrel, "ORBITAL_RESOURCE_CONTAINER")
			BlockOnCommand(fett.Attack_Move(second_nearest_barrel.Get_Position()), 20)
		end
		Sleep(3)
	end
end

------------------------------------------------------------------------------------------------------------------------
-- Story_Mode_Service() - gets serviced each frame
------------------------------------------------------------------------------------------------------------------------

-- Here is an opportunity for updates outside of an event
--function Story_Mode_Service()
--end

------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- dme Mission over, triggering end cinematic.
------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A3_M08_Cargo_Found_Text_02(message)
	if message == OnEnter then
		Create_Thread("Ending_Cinematic")
	end
end

------------------------------------------------------------------------------------------------------------------------
-- dme Ending Cinematic stuff
------------------------------------------------------------------------------------------------------------------------


function Ending_Cinematic()
	
	Cancel_Fast_Forward() 
	rebel = Find_Player("Rebel")
	unit_list = Find_All_Objects_Of_Type(rebel)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
	--Story_Event("END_DIALOG")
	Fade_Screen_Out(.5)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
--	Ensure Millennium Falcon is still present for this cinematic
	
	falcon = Find_First_Object("Millennium_Falcon")
	if not falcon then
		MessageBox("Couldn't find Millennium Falcon")
		return
	end
	
	falcon.Make_Invulnerable(true)
	
	Story_Event("DISABLE_FALCON_KILLED")
	
	--Set up all waypoints for cinematic
		
	falcon_start = Find_Hint("GENERIC_MARKER_SPACE", "falconstart")
	falcon_move1 = Find_Hint("GENERIC_MARKER_SPACE", "falconpos1")
	falcon_move2 = Find_Hint("GENERIC_MARKER_SPACE", "falconpos2")
	falcon_move3 = Find_Hint("GENERIC_MARKER_SPACE", "falconpos3")
	falcon_move4 = Find_Hint("GENERIC_MARKER_SPACE", "falconpos4")
	camera_start = Find_Hint("GENERIC_MARKER_SPACE", "camerastart")
	
	--Move Falcon to the start loc
	
	falcon.Teleport_And_Face(falcon_start)
	falcon.Move_To(falcon_move2)
	Start_Cinematic_Camera()
	Sleep(1)
	
	Story_Event("VICTORY_TRIGGER")
		
	Fade_Screen_In(2)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(falcon, 250, 10, 30, 1, 0, 0, 0)
	
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(falcon, 0, 0, 0, 0, falcon, 0, 0) 
	
	-- Transition_Cinematic_Camera_Key(target_pos, time, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	--Transition_Cinematic_Target_Key(falcon_move4, 5, 0, 0, 0, 0, 0, 0, 0)
	
	
	
	
	Sleep(2)
	--falcon.Move_To(falcon_move2)
	--Sleep(1)
	--falcon.Move_To(falcon_move3)
	--Sleep(1)
	
	Transition_Cinematic_Camera_Key(camera_start, 4, 200, 45, 0, 1, 0, 1, 0)
	
	falcon.Move_To(falcon_move4)
	Sleep(4)
	falcon.Hyperspace_Away()
	falcon.Make_Invulnerable(false)
end

