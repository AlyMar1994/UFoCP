---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Starts the function function_name (more precisely, the function at _G[function_name]) 
---in a new thread on the next frame with params and returns the thread ID (an integer). 
---If params is a table, its contents will be copied into a new list which is given to the function, the keys of the original table will be lost.
---@param function_name string
---@param params any
---@return number thread_id
function Create_Thread(function_name, params)
end

---Seems to be the same as Create_Thread
---@param function_name string
---@param params any
---@return number thread_id
function Thread(function_name, params)
end

---Gets the value set for value_id.
---@param value_id string
---@return any
function ThreadValue(value_id)
end