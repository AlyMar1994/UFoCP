---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class StoryEvent
local StoryEvent = {}

---@param reward_type string
function StoryEvent.Set_Reward_Type(reward_type)
end

---Sets Reward_Param(X+1) as Y (X is 0 for Reward_Param1). Unlike Set_Event_Parameter this command cannot take more than 2 parameters.
---@param parameter_index number
---@param value any
function StoryEvent.Set_Reward_Parameter(parameter_index, value)
end

---Sets Event_Param(X+1) as Y (X is 0 for Event_Param1). Can take more than 2 parameters to set e.g. multiple object types for a single event parameter.
---@param event_index number
---@param ... any
function StoryEvent.Set_Event_Parameter(event_index, ...)
end

---Sets the dialog file.
---@param dialog_file_name string Name of the Dialogfile without file extension
function StoryEvent.Set_Dialog(dialog_file_name)
end

---Clears all Dialog texts added with Add_Dialog_Text from event.
function StoryEvent.Clear_Dialog_Text()
end

---The text will be formatted with any additional parameters given.
---@param text_id string Text Key from DAT File
---@param value_1 any
---@param value_2 any
---@overload fun(text_id: string)
---@overload fun(text_id: string, value_1: any)
---@overload fun(text_id: string, value_1: any, value_2: any)
function StoryEvent.Add_Dialog_Text(text_id, value_1, value_2)
end