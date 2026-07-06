---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Sets the visibility of the given GUI component.
---@param component_name string
---@param visibility boolean
function GUI_Component_Visibility(component_name, visibility)
end

---Enables or disables the given GUI component.
---@param component_name string
---@param enable boolean
function GUI_Component_Enable(component_name, enable)
end

---Sets the text of the given GUI component.
---@param component_name string 
---@param text_id string Text Id frm DAT file
function GUI_Component_Text(component_name, text_id)
end

---Sets the color of the given GUI component.
---@param component_name string
---@param red number Normalized value between 0 and 1. 1 meaning 255.
---@param green number Normalized value between 0 and 1. 1 meaning 255.
---@param blue number Normalized value between 0 and 1. 1 meaning 255.
---@param alpha number Normalized value between 0 and 1. 1 meaning 255.
function GUI_Component_Color(component_name, red, green, blue, alpha)
end

---Sets the color of the given GUI components text.
---@param component_name string
---@param red number Normalized value between 0 and 1. 1 meaning 255.
---@param green number Normalized value between 0 and 1. 1 meaning 255.
---@param blue number Normalized value between 0 and 1. 1 meaning 255.
---@param alpha number Normalized value between 0 and 1. 1 meaning 255.
function GUI_Text_Color(component_name, red, green, blue, alpha)
end

---Sets the icon of the given GUI component. Also sets the color f the icon.
---@param component_name string
---@param icon_name string
---@param red number Normalized value between 0 and 1. 1 meaning 255.
---@param green number Normalized value between 0 and 1. 1 meaning 255.
---@param blue number Normalized value between 0 and 1. 1 meaning 255.
---@param alpha number Normalized value between 0 and 1. 1 meaning 255.
function GUI_Button_Icon(component_name, icon_name, red, green, blue, alpha)
end

---Makes the given GUI component blink.
---@param component_name string
---@param blink_on boolean 
---@param blink_off boolean
---@param restart_blink boolean
function GUI_Component_Blink(component_name, blink_on, blink_off, restart_blink)
end

---Makes the given GUI component flash.
---@param component_name string
---@param perpetual boolean
---@param duration number 
---@param flash_count number 
function GUI_Component_Flash(component_name, perpetual, duration, flash_count)
end

---Stops the flashing of the given GUI component.
---@param component_name string
function GUI_Component_Stop_Flash(component_name)
end

---Plays an animation on the given GUI component.
---@param component_name string 
---@param animation string
---@param animation_index number
---@param loop boolean
function GUI_Component_Play_Anim(component_name, animation, animation_index, loop)
end

---Stops the animation on the given GUI component.
---@param component_name string
function GUI_Component_Stop_Anim(component_name)
end