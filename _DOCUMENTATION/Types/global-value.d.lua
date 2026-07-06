---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class GlobalValue
GlobalValue = {}

---@param key string The key of the global value
---@return number|string|nil
---Returns the global value matching the given key
function GlobalValue.Get(key)
end

---@param key string The key of the global value
---@param value number|string|nil The value of the global value
---@return number|string|nil
---Sets the global value matching the given key with the given value
function GlobalValue.Set(key, value)
end