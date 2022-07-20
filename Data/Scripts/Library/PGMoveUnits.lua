-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGMoveUnits.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGMoveUnits.lua $
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



-- This will move an entire unit list with simultaneous orders.  
-- They will block as a whole and pass when the last unit's move is complete.
function Formation_Move(unit_list, target)
	if type(unit_list) == "table" then
		Cull_Unit_List(unit_list)
		for k, unit in pairs(unit_list) do -- An individual unit is needed to reach the Move_To function.
			BlockOnCommand(unit.Move_To(unit_list, target))  -- Note that the unit list is passed.
			return
		end
		DebugMessage("%s -- Formation_Move, unit_list is empty", tostring(Script))
	elseif type(unit_list) == "userdata" then
		BlockOnCommand(unit_list.Move_To(target))
	else
		DebugMessage("%s -- Formation_Move, expected table or userdata got %s", tostring(Script), tostring(unit_list))
	end
end

function Formation_Attack(unit_list, target)
	if type(unit_list) == "table" then
		Cull_Unit_List(unit_list)
		for k, unit in pairs(unit_list) do
			BlockOnCommand(unit.Attack_Target(unit_list, target))
			return
		end
		DebugMessage("%s -- Formation_Attack, unit_list is empty", tostring(Script))
	elseif type(unit_list) == "userdata" then
		BlockOnCommand(unit_list.Attack_Move(target))
	else
		DebugMessage("%s -- Formation_Attack, expected table or userdata got %s", tostring(Script), tostring(unit_list))
	end
end

function Formation_Attack_Move(unit_list, target)
	if type(unit_list) == "table" then
		Cull_Unit_List(unit_list)
		for k, unit in pairs(unit_list) do
			BlockOnCommand(unit.Attack_Move(unit_list, target))
			return
		end
		DebugMessage("%s -- Formation_Attack, unit_list is empty", tostring(Script))
	elseif type(unit_list) == "userdata" then
		BlockOnCommand(unit_list.Attack_Move(target))
	else
		DebugMessage("%s -- Formation_Attack, expected table or userdata got %s", tostring(Script), tostring(unit_list))
	end
end


function Formation_Guard(unit_list, target)
	if type(unit_list) == "table" then
		Cull_Unit_List(unit_list)
		for k, unit in pairs(unit_list) do
			BlockOnCommand(unit.Guard_Target(unit_list, target))
			return
		end
		DebugMessage("%s -- Formation_Guard, unit_list is empty", tostring(Script))
	elseif type(unit_list) == "userdata" then
		BlockOnCommand(unit_list.Guard_Target(target))
	else
		DebugMessage("%s -- Formation_Guard, expected table or userdata got %s", tostring(Script), tostring(unit_list))
	end
end


