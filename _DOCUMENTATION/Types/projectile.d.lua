---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class Projectile: GameObjectType
local Projectile = {}

---This is used only for projectile types. True for projectile categories Rocket and MPTL Rocket.
---@return boolean
function Projectile.Is_Affected_By_Missile_Shield()
end

---This is used only for projectile types. True for projectile categories Missile, Rocket and MPTL Rocket.
---@return boolean
function Projectile.Is_Affected_By_Laser_Defense()
end