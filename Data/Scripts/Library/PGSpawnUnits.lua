-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGSpawnUnits.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGSpawnUnits.lua $
--
--    Original Author: Brian Hayes
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGBaseDefinitions")


function Process_Reinforcements()
	for index, btable in ipairs(block_table) do
		for k, block in pairs(btable) do
			if not block.block then
				--Haven't yet issued the reinforcement command, or else a previous attempt failed
				block.block = Reinforce_Unit(block.ref_type, block.entry_marker, block.player, true, block.obey_zones)
			elseif block.block.IsFinished() then
				new_units = block.block.Result()
				if type(new_units) == "table" then
					for j, unit in pairs(new_units) do
						DebugMessage("%s -- Process_Reinforcements Block: %s, unit: %s, allow:%s, delete:%s", tostring(Script), tostring(block.block), tostring(unit), tostring(block.allow_ai_usage), tostring(block.delete_after_scenario))
						if block.allow_ai_usage then
							--MessageBox("allow_ai_usage: %s", tostring(unit))
							unit.Prevent_AI_Usage(false)
						end
						if block.delete_after_scenario then
							--MessageBox("deleting after scenario: %s", tostring(unit))
							unit.Mark_Parent_Mode_Object_For_Death()
						end
						table.insert(block.block_track.unit_list, unit)
					end
					block.block_track.type_count = block.block_track.type_count - 1
					if block.block_track.type_count <= 0 then
						if type(block.callback) == "function" then
							block.callback(block.block_track.unit_list)
						end
						table.remove(block_table, index)
						Process_Reinforcements()
						return
					end
				end
				block_table[index][k] = nil
				Process_Reinforcements()
				return
			end
		end
	end
		
	new_units = nil
end

function Add_Reinforcement(object_type, player)

	if type(object_type) == "string" then
		object_type = Find_Object_Type(object_type)
	end
	
	Reinforce_Unit(object_type, false, player, true, false)
end


-- Reinforce units via transport, simultaneously.
function ReinforceList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario, ignore_reinforcement_rules, callback)

	if type(ignore_reinforcement_rules) == "function" then
		MessageBox("Received a function for 6th parameter; expected bool.  Note the signature change, sorry.")
		return
	end
	
	if player == nil then
		MessageBox("expected a player for 3rd parameter; aborting")
		return
	end

	table.insert(block_table, {})
	index = table.getn(block_table)

	block_track = {
		type_count = table.getn(type_list),
		unit_list = {} 
	}
	
	for k, unit_type in pairs(type_list) do
		ref_type = Find_Object_Type(unit_type)
		btab = {
			block = nil,
			block_track = block_track,
			ref_type = ref_type,
			entry_marker = entry_marker,
			player = player,
			obey_zones = not ignore_reinforcement_rules,
			allow_ai_usage = allow_ai_usage, 
			callback = callback,
			delete_after_scenario = delete_after_scenario 
		}
		table.insert(block_table[index], btab)
		btab = nil
		ref_type = nil
	end
end

-- Spawn units simultaneously.
function SpawnList(type_list, entry_marker, player, allow_ai_usage, delete_after_scenario)

		unit_list = {}
		
		for k, unit_type in pairs(type_list) do
			ref_type = Find_Object_Type(unit_type)
			new_units= Spawn_Unit(ref_type, entry_marker, player)
			for j, unit in pairs(new_units) do
				table.insert(unit_list, unit)
				if allow_ai_usage then
					--MessageBox("allow_ai_usage: %s", tostring(unit))
					unit.Prevent_AI_Usage(false)
				else
					unit.Prevent_AI_Usage(true) -- This doesn't happen automatically, unlike for Reinforce_Unit
				end
				if delete_after_scenario then
					--MessageBox("deleting after scenario: %s", tostring(unit))
					unit.Mark_Parent_Mode_Object_For_Death()
				end
			end
		end
		
		new_units = nil
		
		return unit_list
end
