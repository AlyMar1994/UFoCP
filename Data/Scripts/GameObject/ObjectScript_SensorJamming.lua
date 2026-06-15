-- ============================================================================
-- STAR WARS: Empire at War - Forces of Corruption Unofficial Patch Source File
-- Original Author: Galyana
--			Author: jsuzu
--			Date:   06-15-2026
--		Revision:   2
-- ============================================================================

require("PGStateMachine")

function Definitions()
	ServiceRate = 1

	Define_State("State_Init", State_Init);
	Define_State("State_AI_Autofire", State_AI_Autofire)
	Define_State("State_Human_No_Autofire", State_Human_No_Autofire)
	Define_State("State_Human_Autofire", State_Human_Autofire)

	ability_name = "SENSOR_JAMMING"
	stealth_ability = "STEALTH"
end

function State_Init(message)
	if message == OnEnter then
		-- prevent this from doing anything in galactic mode
		if Get_Game_Mode() == "Galactic" then
			ScriptExit()
		end

		if Object.Get_Owner().Is_Human() then
			Set_Next_State("State_Human_No_Autofire")
		else
			Register_Prox(Object, Unit_Prox, 700)
			Set_Next_State("State_AI_Autofire")
		end
	end
end

function State_AI_Autofire(message)
	if message == OnUpdate then
		-- Land units can change hands
		if Object.Get_Owner().Is_Human() then
			Object.Cancel_Event_Object_In_Range(Unit_Prox)
			Set_Next_State("State_Human_No_Autofire")
		end
	end
end

function State_Human_No_Autofire(message)
	if message == OnUpdate then
		if Object.Is_Ability_Autofire(ability_name) then
			Register_Prox(Object, Unit_Prox, 700)
			Set_Next_State("State_Human_Autofire")
		end
	end
end

function State_Human_Autofire(message)
	if message == OnUpdate then
		if not Object.Is_Ability_Autofire(ability_name) then
			Object.Cancel_Event_Object_In_Range(Unit_Prox)
			Set_Next_State("State_Human_No_Autofire")
		end
	end
end

function Unit_Prox(self_obj, trigger_obj)
	if not trigger_obj.Get_Owner().Is_Enemy(Object.Get_Owner()) then
		return
	end

	-- ignore stealthed enemies
	if trigger_obj.Is_Ability_Active(stealth_ability) then
		return
	end

	if trigger_obj.Get_Owner().Is_Enemy(Object.Get_Owner()) then
		if Object.Is_Ability_Ready(ability_name) then
			projectile_types = trigger_obj.Get_All_Projectile_Types()
			for _, projectile in pairs(projectile_types) do
				if projectile.Is_Affected_By_Missile_Shield() or projectile.Is_Affected_By_Laser_Defense() then
					Object.Activate_Ability(ability_name, true)
					return
				end
			end
		end
	end
end
