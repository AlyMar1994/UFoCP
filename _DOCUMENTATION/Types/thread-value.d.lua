---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class ThreadValue
ThreadValue = {}

---Gets the value set for value_id.
---@param value_id string
---@return any
function ThreadValue.Get(value_id)
end

---Set a value for identifier value_id. This value is specific to a thread as defined by Create_Thread.
---@param value_id string
---@param value any
function ThreadValue.Set(value_id, value)
end

---Sets value for identifier value_id to nil.
---@param value_id string
function ThreadValue.Reset(value_id)
end