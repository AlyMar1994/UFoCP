---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Starts a retreat for the given player with all retreatable units. 
---The units are teleported to the retreat position and start moving. 
---At the end of the delay, they jump to hyperspace. Not cinematic camera is initiated. 
---Neither is there a retreat countdown nor will the battle end.
---@param player_id number
---@param delay number
function Start_Cinematic_Space_Retreat(player_id, delay)
end

---Ends cinematic mode.
function End_Cinematic_Mode()
end

---Starts cinematic mode.
function Start_Cinematic_Mode()
end

---Used for the opening cinematics of the campaigns.
---@param start_cinematic_environment boolean
function Set_Cinematic_Environment(start_cinematic_environment)
end

---Used for the opening cinematics of the campaigns. Simply moves the object up (in Z direction) by 20000 units.
---@param game_object GameObject
function Promote_To_Space_Cinematic_Layer(game_object)
end

---Returns the created transport.
---comment
---@param object_type_name string
---@param player_id number
---@param position Position
---@param angle number
---@param phase number
---@param anim_delta number
---@param idle_time number
---@param persists 0|1 1 for staying after cinamtic, 0 for despawn
---@param hint GameObject 
---@return GameObject
---@overload fun(object_type_name: string, player_id: number, position: Position, angle: number, phase: number, anim_delta: number, idle_time: number, persists: 0|1): GameObject
function Create_Cinematic_Transport(object_type_name, player_id, position, angle, phase, anim_delta, idle_time, persists, hint)
end

---Zooms in. Crashes the script if used when cinematic camera is off.
---@param transition number time for the transition to the zoomed state
---@param zoom number Zoom in for < 1, out for > 1
function Cinematic_Zoom(transition, zoom)
end

---Transitions to tactical camera.
---@param transition number
function Transition_To_Tactical_Camera(transition)
end

---Transition the camera position to a new position. 
---@param target Position|GameObject
---@param time number
---@param xoffset_dist number
---@param yoffset_pitch number
---@param zoffset_yaw number
---@param use_angles 0|1 If set to 1 switches xoffset_dist, yoffset_pitch, zoffset_yaw from cartesian coordinates to spherical coordinates.
---@param attach_object GameObject|0 When 0, parameters use_object_rotation and cinematic_animation are unused.
---@param use_object_rotation 0|1
---@param cinematic_animation 0|1
function Transition_Cinematic_Camera_Key(target, time, xoffset_dist, yoffset_pitch, zoffset_yaw, use_angles, attach_object, use_object_rotation, cinematic_animation)
end

---Set a camera position.
---@param target Position|GameObject
---@param xoffset_dist number
---@param yoffset_pitch number
---@param zoffset_yaw number
---@param use_angles 0|1 If set to 1 switches xoffset_dist, yoffset_pitch, zoffset_yaw from cartesian coordinates to spherical coordinates.
---@param attach_object GameObject|0 When 0, parameters use_object_rotation and cinematic_animation are unused.
---@param use_object_rotation 0|1
---@param cinematic_animation 0|1
function Set_Cinematic_Camera_Key(target, xoffset_dist, yoffset_pitch, zoffset_yaw, use_angles, attach_object, use_object_rotation, cinematic_animation)
end

---Transition the camera target (what the camera is pointing at) to a new position in given seconds.
---@param target Position|GameObject
---@param time number
---@param xoffset_dist number
---@param yoffset_pitch number
---@param zoffset_yaw number
---@param use_angles 0|1 If set to 1 switches xoffset_dist, yoffset_pitch, zoffset_yaw from cartesian coordinates to spherical coordinates.
---@param attach_object GameObject|0 When 0, parameters use_object_rotation and cinematic_animation are unused.
---@param use_object_rotation 0|1
---@param cinematic_animation 0|1
function Transition_Cinematic_Target_Key(target, time, xoffset_dist, yoffset_pitch, zoffset_yaw, use_angles, attach_object, use_object_rotation, cinematic_animation)
end

---Set a target position for the camera to point at. If attach_object is given, the camera will follow its movements.
---@param target Position|GameObject
---@param xoffset_dist number
---@param yoffset_pitch number
---@param zoffset_yaw number
---@param use_angles 0|1 If set to 1 switches xoffset_dist, yoffset_pitch, zoffset_yaw from cartesian coordinates to spherical coordinates.
---@param attach_object GameObject|0 When 0, parameters use_object_rotation and cinematic_animation are unused.
---@param use_object_rotation 0|1
---@param cinematic_animation 0|1
function Set_Cinematic_Target_Key(target, xoffset_dist, yoffset_pitch, zoffset_yaw, use_angles, attach_object, use_object_rotation, cinematic_animation)
end

---Ends the cinematic camera.
function End_Cinematic_Camera()
end

---Starts the cinematic camera.
---@param resume_sound boolean
---@overload fun()
function Start_Cinematic_Camera(resume_sound)
end

---Points camera on target.
---@param target GameObject|Position
function Point_Camera_At(target)
end

---Rotates the tactical camera to the new angle. The rotation takes the given amount of time. 
---The last parameter specifies whether to take the shortest way. Can be used during camera sequences but only affects the tactical camera.
---@param z_angle number
---@param time number
---@param use_shortest_way 0|1
function Rotate_Camera_To(z_angle, time, use_shortest_way)
end

---Rotates the tactical camera around the z axis by the given amount of degrees. 
---The sign of the angle determines the direction of the rotation. The rotation takes the given amount of time.
---@param z_angle number
---@param time number
function Rotate_Camera_By(z_angle, time)
end

---Zooms in the tactical camera.
---@param zoom number Zoom in for < 1, out for > 1
---@param is_instant 0|1 If 1, the zoom happens immediately, if it is 0 there is a short transition like zooming in manually.
function Zoom_Camera(zoom, is_instant)
end

---Makes the camera follow the gameobject.
---@param game_object GameObject
---@param unknown 0|1
function Camera_To_Follow(game_object, unknown)
end

---Scroll the tactical camera to the given position.
---@param target Position|GameObject
---@param game_object GameObject
---@overload fun(target: Position|GameObject)
function Scroll_Camera_To(target, game_object)
end

---Fade screen into blackness.
---@param time number
function Fade_Screen_Out(time)
end

---Fade screen from blackness.
---@param time number
function Fade_Screen_In(time)
end

---Turn off blackness from fade.
function Fade_Off()
end

---Make screen black immediately.
function Fade_On()
end

---Move black bars at the top and bottom out of the screen.
---@param time number
function Letter_Box_Out(time)
end

---Move black bars at the top and bottom into the screen
---@param time number
function Letter_Box_In(time)
end

---Get rid of black bars immediately.
function Letter_Box_Off()
end

---Show black bars immediately.
function Letter_Box_On()
end

---Hide and disables all units not marked by In_End_Cinematic. Ignores spce stations and structures.
function Do_End_Cinematic_Cleanup()
end