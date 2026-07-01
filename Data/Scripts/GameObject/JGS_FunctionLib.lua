-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/JGS_FunctionLib.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/JGS_FunctionLib.lua $
--
--    Original Author: Jeff_Stewart
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////


-- this function is used to send units on a neverending hunt for underworld units
-- Usage: Create_Thread("Hunt_Underworld",attack_list)
-- where attack_list is a list of units to send on the hunt.  for a single unit, use:
-- Usage: Create_Thread("Hunt_Underworld",{single_unit})
function Hunt_Underworld(attack_list)
	local enemy_player = Find_Player("Underworld")
	while true do
	  if not VictoryStarted and not DefeatStarted then
		for k, unit in pairs(attack_list) do
			if TestValid(unit) then
				if not unit.Get_Owner().Is_Human() then
					local closest_enemy = Find_Nearest(unit, enemy_player, true)	
					if TestValid(closest_enemy) then
						unit.Attack_Move(closest_enemy)
					end
				end
			end
		end
	  end
      Sleep(4)
	end
end

function Set_Hint_At_Object(locobj)
	--locobj.Play_SFX_Event("SFX_UMP_EmpireKesselAlarm")
	locobj.Highlight(true)
	Add_Radar_Blip(locobj, "somename")
end

function Remove_Hint_At_Object(objloc)
	objloc.Highlight(false)
	Remove_Radar_Blip("somename")
end

-- The following function is a waypoint patrol should be used like so:
-- Create_Thread("Rebel_Patrol_Points", hint)
-- hint is the name shared by the objects that follow the patrol path, as well as the patrol paths themselves
-- all patrol points (ex JGS_PATHPOINT_1) must be present and named properly for the script to work
-- it is extremely limited to only nine waypoints, but does allow for multiple patrols to be going on at once
function Rebels_Patrol_Points(hint)
	underworld_player = Find_Player("Underworld")
	rebel_player = Find_Player("Rebel")
	local pursuing_target = false
	local unitlist = Find_All_Objects_With_Hint(tostring(hint))
		one = Find_Hint("JGS_PATHPOINT_1", tostring(hint))
		two = Find_Hint("JGS_PATHPOINT_2", tostring(hint))
		three = Find_Hint("JGS_PATHPOINT_3", tostring(hint))
		four = Find_Hint("JGS_PATHPOINT_4", tostring(hint))
		five = Find_Hint("JGS_PATHPOINT_5", tostring(hint))
		six = Find_Hint("JGS_PATHPOINT_6", tostring(hint))
		seven = Find_Hint("JGS_PATHPOINT_7", tostring(hint))
		eight = Find_Hint("JGS_PATHPOINT_8", tostring(hint))
		nine = Find_Hint("JGS_PATHPOINT_9", tostring(hint))
	local pathlist = { one, two, three, four, five, six, seven, eight, nine }
	local pathtarget = 1
	local incremented = false
		while not pursuing_target do
		  if not VictoryStarted and not DefeatStarted then
			pathpoint = nil
			while not TestValid(pathpoint) do
				if pathtarget > 9 then 
					pathtarget = 1
				end
				pathpoint = pathlist[pathtarget]
				if not TestValid(pathpoint) then
					pathtarget = pathtarget + 1
				end
			end
			incremented = false
			for k, unit in pairs(unitlist) do
				if TestValid(unit) and unit.Get_Owner() == rebel_player then 
					unit.Attack_Move(pathpoint.Get_Position()) 
					--MessageBox("%s", tostring(pathpoint.Get_Type().Get_Name()))
					--MessageBox("%s testing...", tostring(unit.Get_Type().Get_Name()))
					if unitlist[k].Get_Distance(pathpoint) < 150 then
						if not incremented then
							pathtarget = pathtarget + 1
							incremented = true
							--MessageBox("%s new point", tostring(hint))
						end
					end
					closest_enemy = Find_Nearest(unitlist[k], underworld_player, true)	
					if unitlist[k].Get_Distance(closest_enemy) < 100 then
						--pursuing_target = true
					end
				end
			end
		  end
  		  Sleep(2)
		end
		--Create_Thread("Hunt_Underworld",unitlist)
end
