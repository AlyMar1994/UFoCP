-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/interdictor.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/interdictor.lua $
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

require("PGStateMachine")


function Definitions()

	--MessageBox("script attached!")
	Define_State("State_Init", State_Init)
	
	ServiceRate = 1

end

function State_Init(message)

	-- prevent this from doing anything in galactic mode
	--MessageBox("%s, mode %s", tostring(Script), Get_Game_Mode())
	if Get_Game_Mode() ~= "Space" then
		ScriptExit()
	end

	-- Bail out if this is a human player
	if Object.Get_Owner().Is_Human() then
		ScriptExit()
	end
		
	if message == OnEnter then
		--MessageBox("%s--Object:%s", tostring(Script), tostring(Object))


		--rebel_player = Find_Player("REBEL")
		interdicting = false
		using_missile_shield = false
		cancelling_shield = false
		marauder = Find_Object_Type("Marauder_Missile_Cruiser")
		broadside = Find_Object_Type("Broadside_Class_Cruiser")

	elseif message == OnUpdate then

		repeat
		
			-- The AI may not yet be initialized
			Sleep(1)
			enemy_is_retreating = EvaluatePerception("Enemy_Retreating", Object.Get_Owner())
		until (enemy_is_retreating ~= nil)

		-- Prevent the enemy from retreating, if they're trying to
		if (enemy_is_retreating ~= 0) and (not interdicting) then
			interdicting = true
			Sleep(GameRandom(3,8))
			--MessageBox("trying to interdict")
			Object.Activate_Ability("INTERDICT", true)
			Register_Timer(Cancel_Interdiction, 20)
		end
		
		-- Use the missile shield if we're being attacked by a rocket boat
		if Under_Missile_Attack() and (not using_missile_shield) then
			using_missile_shield = true
			Object.Activate_Ability("MISSILE_SHIELD", true)
		elseif using_missile_shield and (not cancelling_shield) then
			cancelling_shield = true	
			Register_Timer(Cancel_Missile_Shield, 30)
			
		end

	end
end

function Cancel_Interdiction()
	Object.Activate_Ability("INTERDICT", false)
	interdicting = false
end

function Under_Missile_Attack()
	deadly_enemy = FindDeadlyEnemy(Object)
	if TestValid(deadly_enemy) then
		enemy_type = deadly_enemy.Get_Type()
		if TestValid(deadly_enemy) and (enemy_type == marauder or enemy_type == broadside) then
			return true
		end
	end
	return false
end

function Cancel_Missile_Shield()
	cancelling_shield = false
	
	if Under_Missile_Attack() then
		return
	end
	
	Object.Activate_Ability("MISSILE_SHIELD", false)
	using_missile_shield = false 	
end
