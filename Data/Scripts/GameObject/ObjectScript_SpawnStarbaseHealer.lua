-- ============================================================================
-- STAR WARS: Empire at War - Forces of Corruption Unofficial Patch Source File
-- Original Author: Galyana
--			Author: jsuzu
--			Date:   05-22-2026
--		Revision:   1
-- ============================================================================

require("PGStateMachine")
require("PGSpawnUnits")

function Definitions()
	ServiceRate = 1
	Define_State("State_Init", State_Init);
end

function State_Init(message)
	local heal_marker = Find_Object_Type("Generic_Starbase_Healing_Marker")
	local capital_marker = Find_Object_Type("Generic_Capital_Ship_Marker")
	local marker_position = Object.Get_Position()
	local player = Object.Get_Owner()

	if message == OnEnter then
		Sleep(1) -- Ensure everything is actually spawned in

		-- We don't want additional objects spawning if a new level 1 base is constructed
		if GetCurrentTime() >= 30 then ScriptExit() end

		-- Spawn dummy capital ship marker for AI fix
		-- Despawned via lua script attached to marker as tech up will kill this script
		ship = Create_Generic_Object(capital_marker, marker_position, player)

		-- Only spawn the healer if our health is below 100%
		if Object.Get_Health() < 1.0 then
			healer = Create_Generic_Object(heal_marker, marker_position, player)
			Sleep(5)
			healer.Despawn()
		end

		ScriptExit()
	end
end
