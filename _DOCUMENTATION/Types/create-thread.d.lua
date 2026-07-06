---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class Create_Thread
Create_Thread = {}

---Kills the thread with the given id
---@param thread_id number
function Create_Thread.Kill(thread_id)
end

---Kills all threads.
function Create_Thread.Kill_All()
end

---Returns true, if the thread with the given id is active.
---@param thread_id number
---@return boolean
function Create_Thread.Is_Thread_Active(thread_id)
end

---Returns the name of the threat with the given id.
---@param thread_id number
---@return string
function Create_Thread.Get_Name(thread_id)
end

---Returns the ID of the current thread.
---@return number
function Create_Thread.Get_Current_ID()
end