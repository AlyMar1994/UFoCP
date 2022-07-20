-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGBaseDefinitions.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGBaseDefinitions.lua $
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

require("PGBase")

BAD_WEIGHT = -1000000000000000000.0
BIG_FLOAT = 1000000000000000000.0

-- Set the garbage collection threshold to 256k
collectgarbage(256)

function Common_Base_Definitions()
	-- Clear out the thread specific values.
	ThreadValue.Reset()
	
	-- Clear out any thread events.
	GetEvent.Reset()

	TimerTable = {}
	DeathTable = {}
	ProxTable = {}
	AttackedTable = {}
	CurrentEvent = nil
	EventParams = nil
	block = nil
	break_block = false
	YieldCount = 0
	AITarget = nil
	Object = nil
	Target = nil
	FreeStore = nil
	PlayerObject = nil
	LastService = nil
	Budget = nil
	enemy = nil
	taskforce = nil
	tfObj = nil
	stage = nil
	UnitType = nil
	invade_status = nil
	path = nil
	InvasionActive = false
	unit = nil

	hide_target = nil
	healer = nil
	xfire_pos = nil
	kite_pos = nil
	friendly = nil
	
	block_table = {}
	
	lib_anti_idle_block = nil

end


-- base constructor
function Base_Definitions()

	Common_Base_Definitions()
	
	if Definitions then
		Definitions()
	end
end

function Evaluator_Clean_Up()
	Target = nil
	PlayerObject = nil

	if Clean_Up then
		Clean_Up()
	end
end

-- Returns true if the entire list is not in some kind of obscuring field
function UnitListIsObscured(unit_list)
	for i, unit in pairs(unit_list) do
		if not (unit.Is_In_Nebula() or unit.Is_In_Asteroid_Field() or unit.Is_In_Ion_Storm()) then
			return false
		end
	end
	return true
end


-- Remove all invalid or dead units from a list and return it.
function Cull_Unit_List(unit_list)
	for k, unit in pairs(unit_list) do
		if not TestValid(unit) then
			unit_list[k] = nil
		end
	end
	return unit_list
end
