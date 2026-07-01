-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/ObjectScript_Silri.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/ObjectScript_Silri.lua $
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

-- This include order is important.  We need the state service defined in main to override the one in heroplanattach.
require("HeroPlanAttach")
require("PGStateMachine")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- only join plans that meet our expense requirements.
	MinPlanAttachCost = 5000
	MaxPlanAttachCost = 0

	-- Commander hit list.
	Attack_Ability_Type_Names = { "All" }
	Attack_Ability_Weights = { 1 }
	Attack_Ability_Types = WeightedTypeList.Create()
	Attack_Ability_Types.Parse(Attack_Ability_Type_Names, Attack_Ability_Weights)

	-- Prefer task forces with these units.
	Escort_Ability_Type_Names = { "All" }
	Escort_Ability_Weights = { 1 }
	Escort_Ability_Types = WeightedTypeList.Create()
	Escort_Ability_Types.Parse(Escort_Ability_Type_Names, Escort_Ability_Weights)
	
-- tactical behavior stuff

	ServiceRate = 1

	Define_State("State_Init", State_Init);
	Define_State("State_AI_Autofire", State_AI_Autofire)
	Define_State("State_Human_No_Autofire", State_Human_No_Autofire)
	Define_State("State_Human_Autofire", State_Human_Autofire)
	
	summon_ability_name = "SUMMON"
	drain_ability_name = "DRAIN_LIFE"
	unit_trigger_number = 10
	divert_range = 400
	min_threat_to_use_drain = 10
	drain_area_of_effect = 100

end

function Evaluate_Attack_Ability(target, goal)
	return Get_Target_Weight(target, Attack_Ability_Types, Attack_Ability_Weights)
end

function Get_Escort_Ability_Weights(goal)
	return Escort_Ability_Types
end

function HeroService()

end

function State_Init(message)
	if message == OnEnter then

		-- prevent this from doing anything in galactic mode
		if Get_Game_Mode() ~= "Land" then
			ScriptExit()
		end

		nearby_unit_count = 0
		recent_enemy_units = {}

		if Object.Get_Owner().Is_Human() then
			Register_Prox(Object, Unit_Prox, drain_area_of_effect)
			Set_Next_State("State_Human_No_Autofire")
		else
			Register_Prox(Object, Unit_Prox, divert_range)
			Set_Next_State("State_AI_Autofire")
			rancor_thread = Create_Thread("Must_Summon_More_Rancors")
		end
	end
end

function State_AI_Autofire(message)
	if message == OnUpdate then
		if Object.Get_Hull() < 1.0 and Object.Is_Ability_Ready(drain_ability_name) then
			ConsiderDivertAndAOE(Object, drain_ability_name, drain_area_of_effect, recent_enemy_units, min_threat_to_use_drain)
		end
		
		-- reset tracked units each service.
		nearby_unit_count = 0
		recent_enemy_units = {}
		
		--Need to be able to handle Silri changing hands even though she's a hero unit and so
		--normally immune to ownership changes: there's a case in the story campaign where this is an issue. 
		if Object.Get_Owner().Is_Human() then
			Create_Thread.Kill(rancor_thread)
			Object.Cancel_Event_Object_In_Range(Unit_Prox)
			Register_Prox(Object, Unit_Prox, drain_area_of_effect)
			Set_Next_State("State_Human_No_Autofire")
		end
	end		
end

function State_Human_No_Autofire(message)
	if message == OnUpdate then
		if Object.Is_Ability_Autofire(drain_ability_name) then
			Set_Next_State("State_Human_Autofire")
		end
		
		-- reset tracked units each service.
		nearby_unit_count = 0
		recent_enemy_units = {}
		
	end
end

function State_Human_Autofire(message)
	if message == OnUpdate then
	
		if Object.Is_Ability_Autofire(drain_ability_name) then
			if Object.Get_Hull() < 0.5 and nearby_unit_count > 2 then
				Object.Activate_Ability(drain_ability_name, true)
			end
		else
			Set_Next_State("State_Human_No_Autofire")
		end
		
		-- reset tracked units each service.
		nearby_unit_count = 0
		recent_enemy_units = {}
			
	end				
end

-- If an ally enters the prox, the unit may want to chase them down to use the ability
function Unit_Prox(self_obj, trigger_obj)

	if trigger_obj.Is_Category("Structure") then
		return
	end

	if not trigger_obj.Get_Owner().Is_Enemy(Object.Get_Owner()) then
		return
	end
	
	--Promote to parent object (infantry teams) for unit counting purposes
	if trigger_obj.Get_Parent_Object() then
		trigger_obj = trigger_obj.Get_Parent_Object()
	end
		
	if trigger_obj.Is_In_Garrison() then
		return
	end		
		
	-- If we haven't seen this unit recently, track him
	if recent_enemy_units[trigger_obj] == nil then
		recent_enemy_units[trigger_obj] = trigger_obj
		nearby_unit_count = nearby_unit_count + 1
	end
	
end

function Must_Summon_More_Rancors()
	
	while true do
	
		Sleep(15)
		
		if Object.Is_Ability_Ready(summon_ability_name) then
			
			cast_target = Find_Nearest(Object, Object.Get_Owner(), false)
			if TestValid(cast_target) and cast_target.Get_Distance(Object) < 150.0 then
				Object.Activate_Ability(summon_ability_name, cast_target)
			end
		end
	
	end			
	
end