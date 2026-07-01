-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/Sundered_Heart.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/Sundered_Heart.lua $
--
--    Original Author: Steve_Copeland
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

require("HeroPlanAttach")
require("PGStateMachine")


function Definitions()

	MinPlanAttachCost = 5000
	MaxPlanAttachCost = 0

	Attack_Ability_Type_Names = { "Fighter" }
	Attack_Ability_Weights = { 10 }

	Attack_Ability_Types = WeightedTypeList.Create()
	Attack_Ability_Types.Parse(Attack_Ability_Type_Names, Attack_Ability_Weights)

	-- Prefer task forces with these units.
	Escort_Ability_Type_Names = { "Fighter", "Corvette", "Frigate", "Capital" }
	Escort_Ability_Weights = { 2, 1, 2, 2 }
	Escort_Ability_Types = WeightedTypeList.Create()
	Escort_Ability_Types.Parse(Escort_Ability_Type_Names, Escort_Ability_Weights)

	ServiceRate = 1

	Define_State("State_Init", State_Init);

	unit_trigger_number = 3
	force_trigger_number = 10
	ability_range = 1000
	min_threat_to_use_ability = 1000
	ability_name = "WEAKEN_ENEMY"
	area_of_effect = 300
end

function Evaluate_Attack_Ability(target, goal)
	return Get_Target_Weight(target, Attack_Ability_Types, Attack_Ability_Weights)
end

function Get_Escort_Ability_Weights(goal)
	return Escort_Ability_Types
end

function State_Init(message)
	if message == OnEnter then
		--MessageBox("%s--Object:%s", tostring(Script), tostring(Object))

		-- prevent this from doing anything in galactic mode
		--MessageBox("%s, mode %s", tostring(Script), Get_Game_Mode())
		if Get_Game_Mode() ~= "Space" then
			ScriptExit()
		end

		-- Bail out if this is a human player
		if Object.Get_Owner().Is_Human() then
			ScriptExit()
		end

		-- Register a proximity around this unit
		Register_Prox(Object, Unit_Prox, ability_range)

	elseif message == OnUpdate then

		-- reset tracked units each service.
		nearby_unit_count = 0
		recent_enemy_units = {}
	end
end


-- If an enemy enters the prox, the unit may want to use the ability
function Unit_Prox(self_obj, trigger_obj)

	-- Note: we're explicitly tracking individual infantry here (as opposed to their parents, the squads)

	if not trigger_obj.Get_Owner().Is_Enemy(Object.Get_Owner()) then
		return
	end

	-- If we haven't seen this unit recently, track him
	if recent_enemy_units[trigger_obj] == nil then
		recent_enemy_units[trigger_obj] = trigger_obj
		nearby_unit_count = nearby_unit_count + 1

		DebugMessage("%s -- Nearby unit count %d", tostring(Script), nearby_unit_count)

		if Object.Is_Ability_Ready(ability_name) then
			DebugMessage("%s -- ability ready: %s", tostring(Script), ability_name)
			if (nearby_unit_count >= unit_trigger_number) then
				DebugMessage("%s -- met min trigger number", tostring(Script))
				aoe_pos, aoe_victim_threat = Find_Best_Local_Threat_Center(recent_enemy_units, area_of_effect)
				if (aoe_pos ~= nil) then
					if (aoe_victim_threat > min_threat_to_use_ability) then
						DebugMessage("%s -- met min threat triggered; activating ability", tostring(Script))
						Try_Ability(Object, ability_name, aoe_pos)
					end
					if (nearby_unit_count >= force_trigger_number) then
						DebugMessage("%s -- an excess of units nearby; activating ability", tostring(Script))
						Try_Ability(Object, ability_name, aoe_pos)
					end
				end
			end
		end
	end
end
