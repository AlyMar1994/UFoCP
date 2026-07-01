-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/GameObject/Mauler.lua#1 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/GameObject/Mauler.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Steve_Copeland $
--
--            $Change: 33179 $
--
--          $DateTime: 2005/11/22 18:46:28 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStateMachine")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Define_State("State_Init", State_Init);

	unit_trigger_number = 3
	divert_range = 300
	min_threat_to_use_ability = 400
	area_of_effect = 150
	ability_name = "SELF_DESTRUCT"
end


function State_Init(message)
	if message == OnEnter then
		--MessageBox("%s--Object:%s", tostring(Script), tostring(Object))

		-- Bail out if this is a human player
		if Object.Get_Owner().Is_Human() then
			ScriptExit()
		end

		-- prevent this from doing anything in galactic mode
		if Get_Game_Mode() ~= "Land" then
			return
		end

		-- Register a proximity around the unit at the range he might be willing to chase a unit to use an ability
		--MessageBox("%s-- registering prox", tostring(Script))
		rebel_player = Find_Player("REBEL")
		Register_Prox(Object, Unit_Prox, divert_range, rebel_player)

	elseif message == OnUpdate then

		-- Track the number of fighters within the prox, resetting each service.
		nearby_unit_count = 0
		recent_enemy_units = {}
	end

end


-- If an enemy enters the prox, han may want to chase them down for stun
function Unit_Prox(self_obj, trigger_obj)

	DebugMessage("%s -- In Prox", tostring(Script))

	if not trigger_obj then
		DebugMessage("Warning: prox received a nil trigger_obj .")
		return
	end

	-- If we haven't seen this unit recently, track him
	if recent_enemy_units[trigger_obj] == nil then
		recent_enemy_units[trigger_obj] = trigger_obj
		nearby_unit_count = nearby_unit_count + 1

		DebugMessage("%s -- Nearby unit count %d", tostring(Script), nearby_unit_count)
    
		if (nearby_unit_count >= unit_trigger_number) then
			ConsiderDivertAndAOE(Object, ability_name, area_of_effect, recent_enemy_units, min_threat_to_use_ability)
		end
	end
end




