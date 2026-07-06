---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class TaskForce
local TaskForce = {}

---*******************---
--- GENERAL FUNCTIONS ---
---*******************---

---Returns all units that are part of the task force. WARNING: The units may not be valid.
---@return table<number, GameObject> 
function TaskForce.Get_Unit_Table()
end

---Returns the number of units in a task force.
---@return number 
function TaskForce.Get_Force_Count()
end

---Assemble the taskforce at the given stage by building units or collecting them from the freestore.
---@param stage PlanetObject|nil The planet to produce the taskforce on.
---@param unknown boolean|nil TODO: Find out what this does.
function TaskForce.Produce_Force(stage, unknown)
end

---Releases a given unit from the task force.
---@param game_object GameObject The object to release.
function TaskForce.Release_Unit(game_object)
end

---Adjusts whether the Goal the task force is associated with can be removed before it's been achieved.
---@param is_removable boolean
function TaskForce.Set_As_Goal_System_Removable(is_removable)
end

---Releases the specified amount of units from the taskforce
---@param percentage number The percentage of forces to release (0.0 - 1.0).
function TaskForce.Release_Forces(percentage)
end

---Sets plan to successful (true) or failed (false)
---@param result boolean The result of the plan.
function TaskForce.Set_Plan_Result(result)
end

---Returns the name of the goal that activated the script the taskforce is part of.
---@return string
function TaskForce.Get_Goal_Type_Name()
end

---Check if all required units are available in the freestore
---@return boolean
function TaskForce.Are_All_Units_On_Free_Store()
end

---Add all units from the freestore to the taskforce
function TaskForce.Collect_All_Free_Units()
end

---Adds a unit to the taskforce
---@param game_object GameObject
function TaskForce.Add_Force(game_object)
end

---Returns the type of the unit at the given index of the taskforce
---@param unit_index number
---@return GameObjectType
function TaskForce.Get_Type_Of_Unit(unit_index)
end

---********************---
--- GALACTIC FUNCTIONS ---
---********************---

---Returns the task force's staging area.
---@return PlanetObject|Position @The task force's staging area.
function TaskForce.Get_Stage()
end

---Lands the task force's units
function TaskForce.Land_Units()
end

---Launches the task force's units into orbit.
function TaskForce.Launch_Units()
end

---Starts a ground invasion (seems to require very specific circumstances to work). 
---Returns a block status whose result indicates whether the invasion was successful. GC only
---@return boolean
function TaskForce.Invade()
end

---@param unknown boolean
function TaskForce.Test_Target_Contrast(unknown)
end

---Forms a fleet object with the taskforces units. Returns a FormationBlockStatus whose result is the created fleet.
---@return CommandBlock
function TaskForce.Form_Units()
end

---Moves the taskforce to the planet.
---@param planet PlanetObject
function TaskForce.Move_To(planet)
end

---Activates the DEPLOY ability in GC.
function TaskForce.Activate_Ability()
end

---Initiate a raid on the given planet.
---@param planet PlanetObject
function TaskForce.Raid(planet)
end

---Returns if the taskforce can perform raids
---@return boolean
function TaskForce.Is_Raid_Capable()
end

---********************---
--- TACTICAL FUNCTIONS ---
---********************---

---Attaches a given Targeting Priority Set to all units in the TaskForce that match the given Category Mask.
---@param targeting_priority_set_name string The name of the Targeting Priority Set as defined in the XML.
---@param category_mask string The Category Mask of the units contained within the TaskForce to attach the Targeting Priority Set to.
function TaskForce.Set_Targeting_Priorities(targeting_priority_set_name, category_mask)
end

---Returns the distance from the task force to the given target GameObject, AITargetLocation or Position.
---@param target GameObject|AITargetLocation|Position The object to get the distance to.
---@return number
function TaskForce.Get_Distance(target)
end

--Orders the task force to reinforce (at) a given target.
---@param target GameObject|Position The target to reinforce (usually a position).
---@param wait_time number|nil
function TaskForce.Reinforce(target, wait_time)
end

---Orders the task force to move to a given target.
---@param target GameObject|Position The target to move to (usually a position).
---@param threat number|nil
---@param obstacles string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
function TaskForce.Move_To(target, threat, obstacles)
end

---Orders the task force to attack move to a given target.
---@param target GameObject|Position The target to move to (usually a position).
---@param threat number|nil
---@param obstacles string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
function TaskForce.Attack_Move(target, threat, obstacles)
end

---Orders the task force to guard the given target.
---@param target GameObject|TaskForce 
---@param threat number|nil
---@param obstacles string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
function TaskForce.Guard_Target(target, threat, obstacles)
end

---Orders the task force to attack the given target.
---@param target GameObject 
---@param threat number|nil
---@param obstacles string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
function TaskForce.Attack_Target(target, threat, obstacles)
end

---Orders the task force to attack the given targets hardpoint.
---@param target GameObject 
---@param hardpoint_type string
---@param threat number|nil
function TaskForce.Attack_Target(target, hardpoint_type, threat)
end

---Activates or deactivates a given ability.
---@param ability_name string The ability to (de-)activate.
---@param should_activate boolean Activates the ability if true, deactivates if false.
function TaskForce.Activate_Ability(ability_name, should_activate)
end

---@return number
function TaskForce.Get_Self_Threat_Sum()
end

---@return number
function TaskForce.Get_Self_Threat_Max()
end

function TaskForce.Clear_Opportunity_Fire_Event_Subscriptions()
end

function TaskForce.Remove_Opportunity_Fire_Event_Subscription()
end

function TaskForce.Add_Opportunity_Fire_Event_Subscription()
end

function TaskForce.Unblock_Goal_Proposal()
end

function TaskForce.Block_Goal_Proposal()
end

---Triggers a retreat
function TaskForce.Withdraw_Units()
end

---Makes all units in the taskforce leave their garrison
function TaskForce.Leave_Garrison()
end

---Checks if the taskforce can garrison inside the game_object
---@param game_object GameObject
---@return boolean
function TaskForce.Can_Garrison(game_object)
end

---Garrisons the taskforce inside the game_object
---@param game_object GameObject
function TaskForce.Garrison(game_object)
end

---Sets all abilities on autofire
function TaskForce.Set_All_Abilities_Autofire()
end

---Sets the given ability to either autofire or not
---@param ability_name string
---@param set_autofire boolean
function TaskForce.Set_Single_Ability_Autofire(ability_name, set_autofire)
end

---Scales each unit's AI power by its health and category contrast vs the other and returns the difference. 
---Negative value means the other unit is stronger, positive means this unit is stronger.
---@param game_object GameObject
---@return number
function TaskForce.Get_AI_Power_Vs_Unit(game_object)
end

---Overrides the Targeting_Stickiness_Time_Threshold
---@param time number
function TaskForce.Set_Targeting_Stickiness_Time_Threshold(time)
end

---Gets all build pads belonging to the taskforces player
---@return GameObject[]
function TaskForce.Get_Reserved_Build_Pads()
end

---Builds something on the taskforces units (build pads)
---@return CommandBlock
function TaskForce.Build_All()
end

---Makes the taskforce move to the given direction and minimum distance from the position.
---@param position Position
---@param direction "left"|"right"|"front"|"back"
---@param min_distance number
---@param threat number
---@param unknown boolean|nil
---@return CommandBlock
function TaskForce.Prepare_Ambush(position, direction, min_distance, threat, unknown)
end

---Probably returns the closest enemy to the taskforce
---@param unknown string
---@param unknown2 any
---@return GameObject
function TaskForce.Find_Closest_Enemy(unknown, unknown2)
end

---Enables/Disables Taskforce to go into attack position
---@param enable boolean
function TaskForce.Enable_Attack_Positioning(enable)
end

---Makes units move around the given target.
---@param target AITargetLocation
function TaskForce.Explore_Area(target)
end

---Fires the ground to space or plasma weapon on the target.
---@param object_type_name string
---@param target GameObject|AITargetLocation
function TaskForce.Fire_Special_Weapon(object_type_name, target)
end

---Builds the object type on the game object (build pad)
---@param object_type_name string
---@param game_object GameObject
function TaskForce.Build(object_type_name, game_object)
end

---Fires the orbital bombardement on the position.
---@param position Position
function TaskForce.Fire_Orbital_Bombardment(position)
end

---Fires the bombing run on the target.
---@param target GameObject|AITargetLocation
function TaskForce.Bombing_Run(target)
end

---@param planet PlanetObject
---@param unknown number
function TaskForce.Refit_To_Definition(planet, unknown)
end