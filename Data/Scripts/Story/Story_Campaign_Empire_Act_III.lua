-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_III.lua#19 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_III.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Joseph_Gernert $
--
--            $Change: 35043 $
--
--          $DateTime: 2005/12/13 15:21:05 $
--
--          $Revision: #19 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()
	
	StoryModeEvents = 
	{
		Empire_ActIII_Reveal_07 = State_Empire_ActIII_Jabiim_Population,
		Empire_ActIII_Holocron_MofKalst_Entry = State_Initial_Falast_Spawn,
		Empire_ActIII_M08_Periodic_Spawn_Falast = State_Empire_ActIII_M08_Periodic_Spawn_Falast,
		Empire_ActIII_M08_Falast_Destroyed = State_Empire_ActIII_M08_Falast_Destroyed
	}
	
	jabiim_spawn_list = {
							"Rebel_Infantry_Squad",
							"Rebel_Infantry_Squad",
							"Rebel_Infantry_Squad",
							"Rebel_Infantry_Squad",
							"Rebel_Tank_Buster_Squad",
							"Rebel_Tank_Buster_Squad",
							"Rebel_Infiltrator_Team",
							"Rebel_Infiltrator_Team",
							"Rebel_Artillery_Brigade",
							"Rebel_Heavy_Tank_Brigade",
							"Rebel_Heavy_Tank_Brigade",
							"Rebel_Heavy_Tank_Brigade",
							"Rebel_Heavy_Tank_Brigade",
							"Rebel_Heavy_Tank_Brigade",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Y-Wing_Squadron",
							"Y-Wing_Squadron",
							"Y-Wing_Squadron",
							"Y-Wing_Squadron",
							"Corellian_Gunboat",
							"Corellian_Gunboat",
							"Corellian_Gunboat",
							"Corellian_Gunboat",
							"Corellian_Gunboat",
							"Corellian_Gunboat",
							"Alliance_Assault_Frigate",
							"Alliance_Assault_Frigate",
							"Alliance_Assault_Frigate"
						}
						
	falast_spawn_list =	{
							"Moff_Falast_Star_Destroyer",
							"Nebulon_B_Frigate",
							"Nebulon_B_Frigate",
							"Marauder_Missile_Cruiser",
							"Corellian_Corvette",
							"Corellian_Corvette",
							"Corellian_Corvette",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Rebel_X-Wing_Squadron",
							"Y-Wing_Squadron",
							"Y-Wing_Squadron"
						}
	
	--Memory pooling hints
	falast = nil
	fleet = nil
	rebel_player = nil
	falast_despawn_time = 0
	falast_spawn_time = 0
	planet_highlight = false
	falast_destroyed = false
end


function State_Empire_ActIII_Jabiim_Population(message)
	if message == OnEnter then
		jabiim = FindPlanet("Jabiim")
		rebel_player = Find_Player("REBEL")
		fleet = SpawnList(jabiim_spawn_list, jabiim, rebel_player, false, false)
		
		for i,unit in pairs (fleet) do
			unit.Prevent_AI_Usage(true)
		end
	end
end


function State_Initial_Falast_Spawn(message)

	if message == OnEnter then
		
		atzerri = FindPlanet("Atzerri")
		if not atzerri then
			--MessageBox("couldn't find Atzerri")
		end
		
		-- Simply place Falast at Atzerri
		rebel_player = Find_Player("REBEL")
		fleet = SpawnList(falast_spawn_list, atzerri, rebel_player, false, false)
--		falast_spawn_time = GetCurrentTime()

	end

end


function State_Empire_ActIII_M08_Periodic_Spawn_Falast(message)

	if message == OnEnter then
	
		falast_despawn_time = GetCurrentTime()
		--MessageBox("Empire_ActIII_M08_Periodic_Spawn_Falast")
	
	elseif message == OnUpdate then
	
		if not falast_destroyed then
			if fleet then
			
				--Currently spawned.  Perhaps we should despawn him?  Or maybe a tactical battle already has
				falast = Find_First_Object("Moff_Falast_Star_Destroyer")
				if not falast or GetCurrentTime() - falast_spawn_time > 60.0 then
					falast_despawn_time = GetCurrentTime()
					if falast then
						--MessageBox("Despawned Falast")
						falast.Despawn()
					end
					
					-- just to be evil we'll keep the others alive but restore AI control for them
					for i,ship in pairs(fleet) do
						if TestValid(ship) then
							ship.Prevent_AI_Usage(false)
						end
					end	
					fleet = nil
					
					-- This skips the first time through, as he despawns once before we need the highlight.
					
					if planet_highlight then
						Remove_Planet_Highlight("0")
					else
						planet_highlight = true
					end
					
					Story_Event("FALAST_DESPAWNS")
				end
			
			else
				
				--He's not currently spawned. Maybe we should try to spawn him?
				if GetCurrentTime() - falast_despawn_time > 30.0 then
					spawn_location = FindTarget.Reachable_Target(rebel_player, "Story_Empire_Is_Suitable_Falast_Spawn", "Enemy | Friendly | Neutral", "Any", 0.1)
					if spawn_location then
						--MessageBox("Spawning Falast at a system")
						Spawn_Falast(spawn_location)
					else
						--There were no systems without Empire presence in space, so we'll force the issue.
						--MessageBox("Spawning Falast at a system with an interdictor")
						spawn_location = FindTarget.Reachable_Target(rebel_player, "Story_Empire_Is_Suitable_Falast_Backup_Spawn", "Enemy | Friendly | Neutral", "Any", 1.0)
						if spawn_location then
							Spawn_Falast(spawn_location)
							--spawn_location.Force_Test_Space_Conflict()
						else
							--MessageBox("Couldn't get a spawn location for Falast (unexpected)")
						end
					end
				end
			end
		end
	end
end

function Spawn_Falast(loc)
	if not falast_destroyed then
		fleet = SpawnList(falast_spawn_list, loc.Get_Game_Object(), rebel_player, false, false)
		if fleet then
			falast_spawn_time = GetCurrentTime()
			-- MessageBox("Spawned Falast at %s", tostring(loc.Get_Game_Object()))						
			
			--Give the spawn location information to the story system so the player knows where to go
			plot = Get_Story_Plot("Story_Campaign_Empire_Act_III.xml")
			event = plot.Get_Event("Empire_ActIII_M08_Falast_Spawn_Notice_Line")
			planet_obj = loc.Get_Game_Object()
			event.Set_Reward_Parameter(2, planet_obj)
			Add_Planet_Highlight(planet_obj,"0")
			Story_Event("FALAST_IS_PRESENT")					
			
		else
			--MessageBox("Couldn't spawn Falast at %s for some reason", tostring(loc.Get_Game_Object()))
		end
	end
end


function State_Empire_ActIII_M08_Falast_Destroyed(message)
	falast_destroyed = true
	--This exists so that we don't continually spawn Falast once the mission is over.  Don't actually need to do anything
end
