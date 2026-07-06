---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class FogOfWar
FogOfWar = {}

---Reveals the entire map for player.
---@param player PlayerWrapper
function FogOfWar.Reveal_All(player)
end

---Reveals FoW at position with radius for player.
---@param player PlayerWrapper
---@param position Position
---@param radius number
---@return FOWCell
function FogOfWar.Reveal(player, position, radius)
end

---Reveals FoW at position with radius for player for about 5 seconds.
---@param player PlayerWrapper
---@param position Position
---@param radius number
function FogOfWar.Temporary_Reveal(player, position, radius)
end

---Makes units visible that should be hidden by the Fog of War, if reveal is true.
---@param reveal boolean
function FogOfWar.Temporary_Reveal(reveal)
end