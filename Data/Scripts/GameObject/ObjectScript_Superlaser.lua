-- ============================================================================
-- STAR WARS: Empire at War - Forces of Corruption Unofficial Patch Source File
-- Original Author: Galyana
--			Author: jsuzu
--			Date:   10-24-2026
--		Revision:   2
-- ============================================================================

require("PGStateMachine")

function Definitions()
	ServiceRate = 1

	Define_State("State_Init", State_Init);
	Define_State("State_AI_Autofire", State_AI_Autofire)

	ability_name = "SUPER_LASER"
	difficulty = nil
	times_fired = 0
end

function State_Init(message)
	if message == OnEnter then
		-- prevent this from doing anything in galactic mode
		if Get_Game_Mode() ~= "Space" then
			ScriptExit()
		end

		-- AM1994 (10-24-26): This is too hard for new players.  Kill the
		-- script for now.
		-- PlayerObject doesn't exist in this context, so we have to get
		-- the owner of the Death Star's difficulty.
		difficulty = Object.Get_Owner().Get_Difficulty()
		DebugMessage("%s -- Game difficulty: %s", tostring(Script), tostring(difficulty))
		if difficulty == "Easy" then
			ScriptExit()
		end

		-- AI only
		if Object.Get_Owner().Is_Human() then
			ScriptExit()
		else
			Object.Set_Single_Ability_Autofire(ability_name, false) -- Prevents the AI from using this ability outside of this script
			Set_Next_State("State_AI_Autofire")
		end
	end
end

function State_AI_Autofire(message)
	if message == OnEnter then
		if difficulty == "Normal" then
			Sleep(30)
		else
			Sleep(5) -- At least play out hyperspace and intro cinematics first
		end
	end

	if message == OnUpdate then
		if Object.Is_Ability_Ready(ability_name) then
			if times_fired >= 1 and difficulty == "Normal" then
				DebugMessage("%s -- DEATH STAR: We've already fired %s times, giving the player some room for %s difficulty...", tostring(Script), tostring(times_fired), tostring(difficulty))
				Sleep(60) -- DS recharge is 60s, sleep for effectively 2 min.
			end

			local enemy = FindDeadlyEnemy(Object)
			if not TestValid(enemy) then
				enemy = Find_Nearest(Object, "Frigate | Capital", Object.Get_Owner(), false)
			end

			if TestValid(enemy) then
				if enemy.Is_Category("Frigate | Capital") then
					Object.Activate_Ability(ability_name, enemy)
					times_fired = times_fired + 1
					DebugMessage("%s -- DEATH STAR: Found target %s!  We've fired %s times...", tostring(Script), tostring(enemy), tostring(times_fired))
					Sleep(10) -- Chargeup (75 frames) | Ability max duration (300 frames)
				end
			end
		end
	end
end
