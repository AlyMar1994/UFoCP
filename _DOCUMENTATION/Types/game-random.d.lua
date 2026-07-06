---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class GameRandom
GameRandom = {}

---Returns random float between 0 and 1
---@return number
function GameRandom.Get_Float()
end

---Returns random float between lower_bound and upper_bound
---@param lower_bound number
---@param upper_bound number
---@return number
function GameRandom.Get_Float(lower_bound, upper_bound)
end

---Returns random integer between lower_bound and upper_bound (inclusive). 
---Unlike GameRandom this appears to be properly random and can be used to randomize setups but will also almost certainly cause sync issues in multiplayer.
---@param lower_bound number
---@param upper_bound number
---@return number
function GameRandom.Free_Random(lower_bound, upper_bound)
end