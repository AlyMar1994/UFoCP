---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Sets the active environment of the current map. 
---@param environment_index number index of the environment according to map editor
function Set_New_Environment(environment_index)
end

---Turn on weather effects.
function Force_Weather()
end

---Enables or disables distance fog.
---@param enable boolean
function Enable_Distance_Fog(enable)
end

---Enables or disables fog.
---@param enable boolean
function Enable_Fog(enable)
end

---Creates a lightning effect from LightningEffectTypes.xml between the two given positions. Returns a LightningEffectBlockStatus. Duration of the effect may be limited.
---@param effect_name string
---@param source_position Position
---@param target_position Position
function Play_Lightning_Effect(effect_name, source_position, target_position)
end