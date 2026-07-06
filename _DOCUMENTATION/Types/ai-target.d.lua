---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class AITargetLocation
local AITargetLocation = {}

---@return GameObject|PlanetObject
function AITargetLocation.Get_Game_Object()
end

---Returns the distance from this AITargetLocation to the given target GameObject or Position
---@param target GameObject|Position
function AITargetLocation.Get_Distance(target)
end