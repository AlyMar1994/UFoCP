---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class StoryPlot
local StoryPlot = {}

---@param event_name string
---@return StoryEvent
function StoryPlot.Get_Event(event_name)
end

---Suspends the plot
function StoryPlot.Suspend()
end

---Activates the plot
function StoryPlot.Activate()
end

---Resets all events of the plot
function StoryPlot.Reset()
end