-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M10_SPACE.lua#4 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M10_SPACE.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 29877 $
--
--          $DateTime: 2005/10/22 13:27:24 $
--
--          $Revision: #4 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")


--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_ActIII_M10_Begin = State_Rebel_ActIII_M10_Begin

	}
	
	chase_unit = nil
	start_marker = nil
	next_marker = nil
	end_marker = nil
end

function State_Rebel_ActIII_M10_Begin(message)
	if message == OnEnter then
		--MessageBox("entering State_Rebel_ActIII_M10_Begin")

		start_marker = Find_Hint("GENERIC_MARKER_SPACE", "start")
		if not start_marker then
			--MessageBox("can't find start marker")
			return
		end
		
		--chase_unit_type = Find_Object_Type("Grand_Moff_Tarkin_Team")
		chase_unit_type = Find_Object_Type("Shuttle_Tyderium")
		--MessageBox("chase_unit_type: %s", tostring(chase_unit_type))
		chase_unit_list = Spawn_Unit(chase_unit_type, start_marker, start_marker.Get_Owner(), false, true)
		chase_unit = chase_unit_list[1]
		if not TestValid(chase_unit) then
			--MessageBox("can't find chase unit")
			return
		end
		
        chase_unit.Prevent_AI_Usage(true)
		next_marker_num = 1
		while TestValid(chase_unit) do
			next_marker = Find_Hint("GENERIC_MARKER_SPACE", tostring(next_marker_num))
			if not next_marker then
				break
			end

			--MessageBox("moving to marker %d", next_marker_num)
			BlockOnCommand(chase_unit.Move_To(next_marker))
			next_marker_num = next_marker_num + 1
			
			--TODO: remove this when we get unit based blocking Move_To and other commands
			Sleep(20)
		end
		
		end_marker = Find_Hint("GENERIC_MARKER_SPACE", "end")
		BlockOnCommand(chase_unit.Move_To(end_marker))
		
		Sleep(30)
		
		--MessageBox("Spawning destroyer")
		Spawn_Unit(Find_Object_Type("Star_Destroyer"), end_marker, end_marker.Get_Owner())
   
	elseif message == OnUpdate then
		
	elseif message == OnExit then
	end
end

