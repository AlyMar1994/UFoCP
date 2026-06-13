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
--            $Author: Pat_Pannullo $
--
--            $Change: 
--
--          $DateTime: 
--
--          $Revision: 
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")


--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_A4_M11_Begin = State_RA04M11_Begin
	}

	rebel_list_0 = {
		"Calamari_Cruiser"
		,"Calamari_Cruiser"
		,"Calamari_Cruiser"
		,"Calamari_Cruiser"
	}
	
	empire_list_0 = {
		"Accuser_Star_Destroyer"
		,"Star_Destroyer"
		,"Star_Destroyer"
		,"Victory_Destroyer"
		,"Victory_Destroyer"
		,"Victory_Destroyer"
		,"Victory_Destroyer"
		,"Acclamator_Assault_Ship"
		,"Acclamator_Assault_Ship"
		,"Acclamator_Assault_Ship"
		,"Broadside_Class_Cruiser"
		,"Broadside_Class_Cruiser"
		,"Broadside_Class_Cruiser"
		,"Tartan_Patrol_Cruiser"
		,"Tartan_Patrol_Cruiser"
		,"Tartan_Patrol_Cruiser"
		,"Tartan_Patrol_Cruiser"
	}
	
	fleet_delay = 45						
	empire_player = nil
end





function State_RA04M11_Begin(message)
	if message == OnEnter then
		--MessageBox("Beginning script A4M11")

		-- Find the players
		rebel_player = Find_Player("Rebel")
		empire_player = Find_Player("Empire")											  
		
		-- Find the planets
		coruscant = Find_First_Object("Coruscant")
		byss = Find_First_Object("Byss")	
		corellia = Find_First_Object("Corellia")		
		kuat = Find_First_Object("Kuat")
		kashyyyk = Find_First_Object("Kashyyyk")
		moncal = Find_First_Object("MonCalimari")
		
		-- Create a massive fleet to attack Mon Calamari
		super_fleet_units = SpawnList(empire_list_0,coruscant,empire_player,false,false)
		
		-- Give the player some Calamari Cruisers
		SpawnList(rebel_list_0,moncal,rebel_player,false,false)
		
		-- Start a new thread so other events won't be blocked
		Create_Thread("Move_Super_Fleet")

		fleet_created = false
		
	elseif message == OnUpdate then
	
		-- Constant check to see if fleet has been destroyed
		if fleet_created and not TestValid(super_fleet) then
			Story_Event("fleet_destroyed")
		end
		
	end
end




function Move_Super_Fleet()
	super_fleet = Assemble_Fleet(super_fleet_units)
	if TestValid(super_fleet) then
		fleet_created = true
	end

	-- Wait a little while and let the player find out about fleet through story dialog
	Sleep(fleet_delay)

	Story_Event("Super_Fleet_Moves")
	Move_Fleet_To_Planet(byss)
	Move_Fleet_To_Planet(corellia)
	Move_Fleet_To_Planet(kuat)
	Move_Fleet_To_Planet(kashyyyk)
	-- Don't use the move_fleet function since it sleeps after arriving.  We need to inform
	-- the story script as soon as it arrives
	BlockOnCommand(super_fleet.Move_To(moncal))
	if TestValid(super_fleet) then
		Story_Event("super_fleet_arrived")
	end
end													



function Move_Fleet_To_Planet(next_planet)
	if TestValid(super_fleet) then
		--MessageBox("Moving super fleet to next planet")
		BlockOnCommand(super_fleet.Move_To(next_planet))
		Sleep(fleet_delay)									
	end
end









							 
