---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class FleetObject: GameObject
local FleetObject = {}

---Destroys a percentage of the fleet's units.
---@param percentage number must be between 0 and 1
function FleetObject.Destroy_Contained_Objects(percentage)
end

---Only for fleets with land units in orbit over an enemy planet (is used in FoC campaign but doesn't seem to work in regular GC)
function FleetObject.Invade()
end

---@return PlanetObject
function FleetObject.Get_Parent_Object()
end

---Enforce check if a space battle should be initiated, e.g. after spawning a fleet at an enemy planet.
function FleetObject.Force_Test_Space_Conflict()
end

---@param object_type GameObjectType
function FleetObject.Contains_Object_Type(object_type)
end