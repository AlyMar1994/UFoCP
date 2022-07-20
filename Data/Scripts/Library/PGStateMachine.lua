-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGStateMachine.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGStateMachine.lua $
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

require("pgcommands")

--
-- Define_State -- Define a new state in the state machine table.
--
-- @param state This is the tag used to identify the state.  Usually 
--			a text value or a number
-- @param function_value This is the function value that will process
--			all the messages associated with the given state.
-- @since 4/22/2005 7:26:01 PM -- BMH
-- 
function Define_State(state, function_value)
	local curproc = StateMachine[state]
	if curproc == nil then
		StateMachineIndexes[DefineStateIndex] = state
		StateMachineIndexLookup[state] = DefineStateIndex
		DefineStateIndex = DefineStateIndex + 1
	end
	
	StateMachine[state] = function_value
	
	if NextState == nil then
		NextState = state
	end
end


--
-- Advance_State -- Advance to the next state based on the 
-- 	order of state definition
--
-- @since 4/22/2005 7:26:01 PM -- BMH
-- 
function Advance_State()
	NextState = StateMachineIndexes[CurrentStateIndex + 1]
end


--
-- Set_Next_State -- Set the next state to transition to.
--
-- @param state tag specifying the state to transition to.
-- @since 4/22/2005 7:26:01 PM -- BMH
-- 
function Set_Next_State(state)
	if state == nil or StateMachine[state] ~= nil then
		NextState = state
	end
end


--
-- Get_Current_State -- Returns what the current state is.
--
-- @return object detailing what the current state is.
-- @since 4/22/2005 7:12:14 PM -- BMH
-- 
function Get_Current_State()
	return CurrentState
end


--
-- Get_Next_State -- Returns what the next state will be.
--
-- @return object detailing what the next state will be.
-- @since 4/22/2005 7:12:14 PM -- BMH
-- 
function Get_Next_State()
	return NextState
end


--
-- Process_States -- This function is called to advance the State Machine through it's states
--
-- @since 4/22/2005 7:12:14 PM -- BMH
-- 
function Process_States()

	while NextState ~= nil do
		_curproc = StateMachine[NextState]
		if type(_curproc) == "function" then
			CurrentState = NextState
			CurrentStateIndex = StateMachineIndexLookup[CurrentState]
			_curproc(OnEnter)
			while CurrentState == NextState do
				_curproc(OnUpdate)
				if CurrentState == NextState then
					PumpEvents()
				end
			end
			_curproc(OnExit)
			DebugMessage("%s -- Advancing state from %s to %s.", tostring(Script), tostring(CurrentState), tostring(NextState))
		else
			ScriptError("%s -- Invalid State: %s, Function: %s", tostring(Script), tostring(NextState), tostring(_curproc))
			NextState = nil
		end
	end
end


--
-- Base_Definitions -- This function is called once when the script is first created.
--
-- @since 4/22/2005 6:04:55 PM -- BMH
-- 
function Base_Definitions()
	DebugMessage("%s -- In Base_Definitions", tostring(Script))

	Common_Base_Definitions()

	StateMachine = {}
	StateMachineIndexes = {}
	StateMachineIndexLookup = {}
	OnEnter = 1
	OnUpdate = 2
	OnExit = 3
	CurrentStateIndex = 1
	DefineStateIndex = 1
	NextState = nil
	CurrentState = nil
	_curproc = nil
	StoryModeEvents = nil

	-- This controls how often the script is serviced.
	-- So try to process 5 times a second
	ServiceRate = 0.2

	if Definitions then
		Definitions()
	end

	if PG_Story_Mode_Init then
		PG_Story_Mode_Init()
	end
end


--
-- main -- This is the main thread function for this script.
-- Upon return from this function the script will finish and be
-- destroyed by the system.
--
-- @since 4/22/2005 6:04:55 PM -- BMH
-- 
function main()

	-- Enter your list of commands to execute here...
	Process_States()

	DebugMessage("%s -- Exiting.", tostring(Script))
	-- ScriptExit will end the script no matter what state it's in.
	ScriptExit()
end

