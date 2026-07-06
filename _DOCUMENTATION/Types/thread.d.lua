---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class Thread
Thread = {}

---Seems to be the same as Create_Thread
---@param function_name string
---@param params any
---@return number thread_id
function Thread.Create(function_name, params)
end

---Kills the thread with the given id
---@param thread_id number
function Thread.Kill(thread_id)
end

---Kills all threads.
function Thread.Kill_All()
end

---Returns true, if the thread with the given id is active.
---@param thread_id number
---@return boolean
function Thread.Is_Thread_Active(thread_id)
end

---Returns the name of the threat with the given id.
---@param thread_id number
---@return string
function Thread.Get_Name(thread_id)
end

---Returns the ID of the current thread.
---@return number
function Thread.Get_Current_ID()
end