-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/ObjectScript_MissileShield.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/ObjectScript_MissileShield.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 51104 $
--
--          $DateTime: 2006/08/10 18:18:02 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStateMachine")

function Definitions()
	ServiceRate = 1

	Define_State("State_Init", State_Init);
	Define_State("State_AI_Autofire", State_AI_Autofire)
	Define_State("State_Human_No_Autofire", State_Human_No_Autofire)
	Define_State("State_Human_Autofire", State_Human_Autofire)

	ability_name = "MISSILE_SHIELD"
end

function State_Init(message)
	if message == OnEnter then
		-- prevent this from doing anything in galactic mode
		if Get_Game_Mode() ~= "Space" then
			ScriptExit()
		end

		if Object.Get_Owner().Is_Human() then
			Set_Next_State("State_Human_No_Autofire")
		else
			interdicting = false
			Set_Next_State("State_AI_Autofire")
		end
	end
end

function State_AI_Autofire(message)
	if message == OnUpdate then
		if Object.Is_Ability_Ready(ability_name) then
			enemy = FindDeadlyEnemy(Object)
			if TestValid(enemy) then
				projectile_types = enemy.Get_All_Projectile_Types()
				for _, projectile in pairs(projectile_types) do
					if projectile.Is_Affected_By_Missile_Shield() or projectile.Is_Affected_By_Laser_Defense() then
						Object.Activate_Ability(ability_name, true)
						Register_Timer(Cancel_Missile_Shield, 90)
						return
					end
				end
			end
		end

		-- Land units can change hands
		if Object.Get_Owner().Is_Human() then
			Set_Next_State("State_Human_No_Autofire")
		end

		-- Interdictor stuff goes here
		repeat
			-- The AI may not yet be initialized
			Sleep(1)
			enemy_is_retreating = EvaluatePerception("Enemy_Retreating", Object.Get_Owner())
		until (enemy_is_retreating ~= nil)

		-- Prevent the enemy from retreating, if they're trying to
		if (enemy_is_retreating ~= 0) and (not interdicting) then
			interdicting = true
			Sleep(GameRandom(3, 8))

			DebugMessage("%s -- %s trying to interdict!", tostring(Script), tostring(Object))

			Object.Activate_Ability("INTERDICT", true)
			Register_Timer(Cancel_Interdiction, 20)
		end
	end
end

function Cancel_Missile_Shield()
	Object.Activate_Ability(ability_name, false)
end

function Cancel_Interdiction()
	Object.Activate_Ability("INTERDICT", false)
	interdicting = false
end

function State_Human_No_Autofire(message)
	if message == OnUpdate then
		if Object.Is_Ability_Autofire(ability_name) then
			Set_Next_State("State_Human_Autofire")
		end
	end
end

function State_Human_Autofire(message)
	if message == OnUpdate then
		if Object.Is_Ability_Autofire(ability_name) then
			if Object.Is_Ability_Ready(ability_name) then
				enemy = FindDeadlyEnemy(Object)
				if TestValid(enemy) then
					projectile_types = enemy.Get_All_Projectile_Types()
					if projectile_types then
						for _, projectile in pairs(projectile_types) do
							if projectile.Is_Affected_By_Missile_Shield() or projectile.Is_Affected_By_Laser_Defense() then
								Object.Activate_Ability(ability_name, true)
								return
							end
						end
					end
				end
			end
		else
			Set_Next_State("State_Human_No_Autofire")
		end
	end
end
