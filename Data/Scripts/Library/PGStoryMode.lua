-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Library/PGStoryMode.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Library/PGStoryMode.lua $
--
--    Original Author: Brian Hayes
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

require("PGStateMachine")
require("PGSpawnUnits")
require("PGMoveUnits")

-- Story mode scripts shouldn't pool themselves.
ScriptPoolCount = 0

function PG_Story_Mode_Init()

	Define_State("PG_Story_State_Init", PG_Story_State_Init);

	if StoryModeEvents ~= nil then
		for key,value in pairs(StoryModeEvents) do
			if type(value) == "function" then
				Define_State(key, value)
			else
				DebugMessage("%s--Invalid function object for Storyevent: %s, got a \"%s\" instead.", tostring(Script), tostring(key), type(value))
			end
		end
	end
end

function Story_Event_Trigger(name)

	if StoryModeEvents == nil then
		return
	end

	DebugMessage("%s--In Story_Event_Trigger: %s", tostring(Script), name)

	local event = StoryModeEvents[name]
	if event ~= nil then
		if type(event) == "function" then
			if Get_Current_State() == Get_Next_State() then
				DebugMessage("%s--Setting next state %s", tostring(Script), name)
				Set_Next_State(name)
			end
		end
	end
end

function PG_Story_State_Init(message)
	if message == OnEnter then
		DebugMessage("%s -- PG_Story_State_Init(OnEnter)", tostring(Script))
	elseif message == OnUpdate then
	elseif message == OnExit then
	end

end


