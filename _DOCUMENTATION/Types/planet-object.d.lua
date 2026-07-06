---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class PlanetObject: GameObject
local PlanetObject = {}

---@return boolean
function PlanetObject.Get_Is_Planet_AI_Usable()
end

---@return boolean
function PlanetObject.Is_Corrupted()
end

---Enforce check if a space battle should be initiated, e.g. after spawning a fleet at an enemy planet.
function PlanetObject.Force_Test_Space_Conflict()
end

---@return boolean
function PlanetObject.Is_Planet_Destroyed()
end

---Returns the indigenous unit type of that planet affiliated with player
---@param player PlayerWrapper
---@return GameObjectType
function PlanetObject.Get_Affiliated_Indigenous_Type(player)
end

---@return number
function PlanetObject.Get_Starbase_Level()
end

---@return GameObjectType
function PlanetObject.Get_Next_Starbase_Type()
end

---@return PlayerWrapper
function PlanetObject.Get_Final_Blow_Player()
end