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
		Rebel_A3_M09_Begin = State_Rebel_A3_M09_Begin
	}
	
	at_at_list = {}
	power_generator = nil
	han_made_it = false
	chewie_made_it = false
	
	spawn1 = {
		"Imperial_Stormtrooper_Squad"
	}
	
	spawn2 = {
		"Imperial_Anti_Infantry_Brigade"
	}

	spawn3 = {
		"Imperial_Armor_Group"
	}

	spawn4 = {
		"Imperial_Stormtrooper_Squad",
	}

	start_service = false
			
end

-----------------------------------------------------------------------------------------------------------------------
-- Generator Destroyed
-----------------------------------------------------------------------------------------------------------------------

function GeneratorDestroyed()

	Story_Event("GENERATOR_DESTROYED")
	
	-- Release the ATAT's
	for i,unit in pairs(at_at_list) do
		unit.Attack_Move(han)
	end
	
	-- Set up trigger for when Han and Chewie get to the cargo area
	cargo_area = Find_Hint("GENERIC_MARKER_LAND", "cargoarea")
	cargo_range = 100
	Register_Prox(cargo_area, Prox_Cargo, cargo_range, rebel)

	-- Hack! wipe out turbo-lasers when generator blows
	turbo_lasers = Find_All_Objects_Of_Type("E_GROUND_TURBOLASER_TOWER")
	for i,unit in pairs(turbo_lasers) do
		unit.Take_Damage(10000)
	end	

end

-----------------------------------------------------------------------------------------------------------------------
-- Spawn_Ambush_Squad - Spawns a squad of units and sends them to attack Han and Chewie
-----------------------------------------------------------------------------------------------------------------------

function Spawn_Ambush_Squad(spawn_marker_name,spawn_type_list)

	spawn_marker = Find_Hint("GENERIC_MARKER_LAND", spawn_marker_name)
	if not spawn_marker then
		--MessageBox("Couldn't find spawn marker %s",spawn_marker_name)
	end
	
	new_units = SpawnList(spawn_type_list,spawn_marker,empire,false,true)
	for i,unit in pairs(new_units) do
		unit.Attack_Move(han)
	end
end

-----------------------------------------------------------------------------------------------------------------------
-- Prox_Cargo
-----------------------------------------------------------------------------------------------------------------------

function Prox_Cargo(prox_obj, trigger_obj)

	prox_obj.Cancel_Event_Object_In_Range(Prox_Cargo)
	
	-- Ambush!
	Spawn_Ambush_Squad("spawn1",spawn1)
	Spawn_Ambush_Squad("spawn2",spawn2)
	Spawn_Ambush_Squad("spawn3",spawn3)
	Spawn_Ambush_Squad("spawn4",spawn4)
	
	Story_Event("REACHED_CARGO")
	
	falcon_marker = Find_Hint("GENERIC_MARKER_LAND", "falcon")
	if not falcon_marker then
		--MessageBox("Couldn't find the falcon marker")
	end
	falcon_range = 100
	Register_Prox(falcon_marker, Prox_Falcon, falcon_range, rebel)
	--MessageBox("Registered Prox_Falcon")
end


-----------------------------------------------------------------------------------------------------------------------
-- Prox_Falcon
-----------------------------------------------------------------------------------------------------------------------

function Prox_Falcon(prox_obj, trigger_obj)
	
	--MessageBox("Prox_Falcon triggered")
	
	if trigger_obj == han then
		--MessageBox("Han Made It")
		han_made_it = true
	end
	
	if trigger_obj == chewie then
		--MessageBox("Chewie Made It")
		chewie_made_it = true
	end
	
	if han_made_it and chewie_made_it then
		--MessageBox("Han and Chewie made it")
		Cancel_Fast_Forward() 
		Story_Event("REACHED_FALCON") -- victory!
	end
	
end

-----------------------------------------------------------------------------------------------------------------------
-- Tell_Units_To_Guard
-----------------------------------------------------------------------------------------------------------------------

function Tell_Units_To_Guard(unit_list)

	for i, unit in pairs(unit_list) do
		if unit.Get_Hint() ~= "disabled" then
			unit.Guard_Target(unit.Get_Position())
		end
	end
	
end


-----------------------------------------------------------------------------------------------------------------------
-- Function for Event: 
-----------------------------------------------------------------------------------------------------------------------


function State_Rebel_A3_M09_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)

		DebugMessage("]]]] LUA: State_Rebel_M06_Begin")

		-- Get handles to Han and Chewie
		han_list = Find_All_Objects_Of_Type("HAN_SOLO")
		han = han_list[1]
		chewie_list = Find_All_Objects_Of_Type("CHEWBACCA")
		chewie = chewie_list[1]

						
		-- For debugging purposes! TAKE OUT --
		--han.Make_Invulnerable(true)
		--chewie.Make_Invulnerable(true)
		-- For debugging purposes! TAKE OUT --


		-- Get Players
		spawn1_marker = Find_Hint("GENERIC_MARKER_LAND", "spawn1")
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")
		
		
		-- Find the At-At's that we are going to activate
		at_at_list = Find_All_Objects_Of_Type("AT_AT_WALKER")

		
		-- Find the power_generator
		power_generator_list = Find_All_Objects_Of_Type("POWER_GENERATOR_E")
		power_generator = power_generator_list[1]
		if not power_generator then
			--MessageBox("Couldn't Find Empire Power Generator!")
			return
		end

		
		-- Release some units when the generator goes down
		Register_Death_Event(power_generator,GeneratorDestroyed)


		-- Find all disabled objects
		disabled_list = Find_All_Objects_With_Hint("disabled")
		for i,unit in pairs(disabled_list) do
			--DebugMessage("]]]] disabling unit %s",unit.Get_Type().Get_Name())
			unit.Prevent_Opportunity_Fire(true)
		end
		
		
		-- Set most of the units to guard 
		--MessageBox("Set to defend mode")
		guard_list = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
		Tell_Units_To_Guard(guard_list)
		guard_list = Find_All_Objects_Of_Type("AT_ST_WALKER")
		Tell_Units_To_Guard(guard_list)
		guard_list = Find_All_Objects_Of_Type("TIE_CRAWLER")
		Tell_Units_To_Guard(guard_list)
		--MessageBox("Done setting defend mode")


		-- Tell the service func that things have been initialized		
		start_service = true
				
	end
end

-----------------------------------------------------------------------------------------------------------------------

function Story_Mode_Service()

	if start_service then
		if not TestValid(han) or not TestValid(chewie) then
			Story_Event("HAN_OR_CHEWIE_KILLED")
		end
	end
	
end

-----------------------------------------------------------------------------------------------------------------------
