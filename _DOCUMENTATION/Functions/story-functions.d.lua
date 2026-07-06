---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Trigger a STORY_AI_NOTIFICATION XML event
---@param event_name string The name of the story event to trigger
---@param object GameObject|PlanetObject The object associated with the story event
---@overload fun(event_name: string)
---@overload fun(event_name: string, object: GameObject|PlanetObject)
function Story_Event(event_name, object)
end

---@param plot_name string The name of the story plot to retrieve
---@return StoryPlot
function Get_Story_Plot(plot_name)
end

---Checks if corresponding reward type TRIGGER_AI has fired. 
---@param player PlayerWrapper
---@param flag_name string
---@param object GameObject|PlanetObject|nil
---@param reset boolean Resets the flag if set to true
function Check_Story_Flag(player, flag_name, object, reset)
end