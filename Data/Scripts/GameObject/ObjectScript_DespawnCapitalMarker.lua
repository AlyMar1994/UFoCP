-- ============================================================================
-- STAR WARS: Empire at War - Forces of Corruption Unofficial Patch Source File
-- Original Author: Galyana
--			Author: jsuzu
--			Date:   05-22-2026
--		Revision:   1
-- ============================================================================

require("PGStateMachine")

function Definitions()
	ServiceRate = 1
	Define_State("State_Init", State_Init);
end

function State_Init(message)
	if message == OnEnter then
		Sleep(300) -- Give the AI 5 minutes to get to tech 2 (can be tuned per mod)
		Object.Despawn()
		ScriptExit()
	end
end
