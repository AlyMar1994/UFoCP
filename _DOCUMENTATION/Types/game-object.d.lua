---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class GameObject
---A wrapper around a single instance of a generic GameObjectType
local GameObject = {}

---*******************---
--- GENERAL FUNCTIONS ---
---*******************---

---Gets the type of the current game object wrapper.
---@return GameObjectType
function GameObject.Get_Type()
end

---Tests if a GameObject has 1..n flags of the bitfield defined in GameObjectPropertiesType.xml set. Valid inputs are single items `"Turret"` or many `"Turret | InBase"`.
---@param propertyFlag string A string representation of 1..n properties.
---@return boolean
function GameObject.Has_Property(propertyFlag)
end

---Returns the owner of the game object.
---@return PlayerWrapper
function GameObject.Get_Owner()
end

---Returns the current position of the object in the world.
---@return Position
function GameObject.Get_Position()
end

---Tests whether a given game object has a given category mask assigned to it.
---@param category_mask string The category mask to test for. Can be a single mask, or a combination: "CAPITAL" or "CAPITAL | SPACE_HERO"
---@return boolean
function GameObject.Is_Category(category_mask)
end

---Returns a number between 0 and 1 representing the current percentage of hull points left.
---@return number
function GameObject.Get_Hull()
end

---Same as Get_Hull
---@return number
function GameObject.Get_Health()
end

---Returns a number between 0 and 1 representing the current percentage of shield points left.
---@return number
function GameObject.Get_Shield()
end

---Returns a number between 0 and 1 representing the current percentage of energy left.
---@return number
function GameObject.Get_Energy()
end

---Returns the distance in ingame units to the target.
---@param target Position|GameObject|PlanetObject|TaskForce
---@return number
function GameObject.Get_Distance(target)
end

---Despawns the GameObject
function GameObject.Despawn()
end

function GameObject.Play_SFX_Event(sfxEventName)
end

---@return boolean
function GameObject.Is_Transport()
end

---Returns the abstract type of the object. 
---For teams the corresponding ground company, for transports the transported unit. 
---For all others it is just the normal game object type.
---@return GameObjectType
function GameObject.Get_Game_Scoring_Type()
end

---Used on on units with the CAPTURE_POINT behavior
---@param should_disable boolean
function GameObject.Disable_Capture(should_disable)
end

---Makes the unit take the given amount of damage. If hardpoint name is given, only damages the hardpoint.
---@param damage_amount number
---@param hardpoint_name string|nil
function GameObject.Take_Damage(damage_amount, hardpoint_name)
end

---Transfers ownership of a GameObject over to another Player
---@param new_owner PlayerWrapper The PlayerWrapper the ownership will be transfered to
function GameObject.Change_Owner(new_owner)
end

---Enables or disables a behavior defined in the XML entry of the GameObject
---Refer to behavior.txt
---@param behavior_id number The ID of the behavior
---@param enable boolean Enables the behavior if set to true. Disables it if it's false.
function GameObject.Enable_Behavior(behavior_id, enable)
end

---For units in GC it's the fleet, for ground forces it's the planet, for fighters it's the squadron.
---@return GameObject|PlanetObject|FleetObject
function GameObject.Get_Parent_Object()
end

---Returns the Planet the GameObject is located on. Can be nil if the GameObject is in Hyperspace
---@return PlanetObject|nil
function GameObject.Get_Planet_Location()
end


---Makes the GameObject visible or invisible
---@param hidden boolean Determines whether the GameObject is visible or invisible
function GameObject.Hide(hidden)
end

---Plays an animation on a GameObject. The animation must be present in the 3D model
---@param animation_name string The name of the animation
---@param should_repeat boolean Determines whether the animation gets repeated
---@param animation_index number
function GameObject.Play_Animation(animation_name, should_repeat, animation_index)
end

---Returns the rate of damage taken by the GameObject
---@return number
function GameObject.Get_Rate_Of_Damage_Taken()
end

---Estimated time until the unit dies given the current rate of damage.
---@return number
function GameObject.Get_Time_Till_Dead()
end

---Returns the unit projectile type.
---@return Projectile
function GameObject.Get_Current_Projectile_Type()
end

---Returns a list of all projectile types the unit can potentially fire. 
---This includes unit projectiles and all projectiles fired from HardPoints.
---@return Projectile[]
function GameObject.Get_All_Projectile_Types()
end

---Returns true, if the unit has any HARD_POINT_ENGINE alive. 
---If unit has no HARD_POINT_ENGINE specified, this is always true.
---@return boolean
function GameObject.Are_Engines_Online()
end

---Sets the max speed of the unit to the given value
---@param max_speed number
function GameObject.Override_Max_Speed(max_speed)
end

---Makes unit hyperspace into battle with delay by X frames 
---(spawning many units with different delays at the same time seems spawns all units with the same delay anyway)
---@param delay number in frames
function GameObject.Cinematic_Hyperspace_In(delay)
end

---Makes unit leave into hyperspace.
---@param delete_in_gc boolean|nil If X is true, the unit gets deleted from GC. Default is true.
function GameObject.Hyperspace_Away(delete_in_gc)
end

---Cancels the units hyperspace animation.
function GameObject.Cancel_Hyperspace()
end

---Allow or prevent AI usage. 
---In tactical battles this crashes the game if the unit has no active AI! 
---When the factions AI changes, the unit is AI usable again.
---@param should_prevent boolean
function GameObject.Prevent_AI_Usage(should_prevent)
end

---Marks object to not be cleaned up by Do_End_Cinematic_Cleanup.
---@param should_be_in_end_cinematic boolean
function GameObject.In_End_Cinematic(should_be_in_end_cinematic)
end

---Teleport the object to position. Also removes it from a garrison if necessary.
---@param position Position
function GameObject.Teleport(position)
end

---Teleport the object to game_object and make it face the same way. Also removes the object it from a garrison if necessary.
---@param game_object GameObject
function GameObject.Teleport_And_Face(game_object)
end

---Make unit face toward position immediately
---@param position Position
function GameObject.Face_Immediate(position)
end

---Make unit turn to face toward position
---@param position Position
---@return CommandBlock
function GameObject.Turn_To_Face(position)
end

---Prevent automatically firing at targets in range
---@param should_prevent boolean
function GameObject.Prevent_Opportunity_Fire(should_prevent)
end

---Completely prevent a unit from firing
---@param should_prevent boolean
function GameObject.Prevent_All_Fire(should_prevent)
end

---Stops object from taking any damage
---@param should_be_invulnerable boolean
function GameObject.Make_Invulnerable(should_be_invulnerable)
end

---Make the unit/fleet not trigger space tactical battles
---@param should_start_battle boolean
function GameObject.Set_Check_Contested_Space(should_start_battle)
end

---Returns true, if object is inside an asteroid field
---@return boolean
function GameObject.Is_In_Asteroid_Field()
end

---Returns true, if object is inside an ion storm
---@return boolean
function GameObject.Is_In_Ion_Storm()
end

---Returns true, if object is inside a nebula
---@return boolean
function GameObject.Is_In_Nebula()
end

---@param enable boolean
function GameObject.Enable_Dynamic_LOD(enable)
end

---An object in limbo should be invisible, uncontrollable and ignored by other objects, however it only seems to work partially.
---@param in_limbo boolean
function GameObject.Set_In_Limbo(in_limbo)
end

---@return boolean
function GameObject.Is_Selectable()
end

---Sets a unit to be selectable or not selectable by the player
---@param is_selectable boolean
function GameObject.Set_Selectable(is_selectable)
end

---Plays ambient moving SFX event
function GameObject.Play_Cinematic_Engine_Flyby()
end

---Plays an SFX event. For max_volume = 0 the sound is played normally, for higher values it becomes louder over time until it reaches full volume. 
---Caution: only a limited number of SFX events can be played at a time (defined by the Max_Instances tag of the preset). 
---Trying to play more than the allowed number will crash the script, even if the command is called for different units or from different scripts.
---@param event_name string
---@param max_volume number|nil
function GameObject.Play_SFX_Event(event_name, max_volume)
end

---Stops the given SFX event
---@param event_name string
---@param fade_out_time number|nil
function GameObject.Stop_SFX_Event(event_name, fade_out_time)
end

---Attach a particle effect to the object, optionally to a particular bone. 
---@param object_type GameObjectType|string
---@param bone_name string|nil
---@return GameObject
function GameObject.Attach_Particle_Effect(object_type, bone_name)
end

---Show or hide the given emitter
---@param emitter_name string
---@param should_show boolean
function GameObject.Show_Emitter(emitter_name, should_show)
end

---Put a small arrow highlight on top of the object with a height offset.
---@param show_highlight boolean
---@param vertical_offset number|nil
function GameObject.Highlight_Small(show_highlight, vertical_offset)
end

---Put a arrow highlight on top of the object with a height offset.
---@param show_highlight boolean
---@param vertical_offset number|nil
function GameObject.Highlight(show_highlight, vertical_offset)
end

---Keep a unit from dying (it can still be damaged)
---@param should_be_unkillable boolean
function GameObject.Set_Cannot_Be_Killed(should_be_unkillable)
end

---@return string
function GameObject.Get_Hint()
end

---Fire death star in tactical
function GameObject.Fire_Tactical_Superweapon()
end

---Test if death star is ready to fire
function GameObject.Is_Tactical_Superweapon_Ready()
end

---@param bone_name string
---@return Position
function GameObject.Get_Bone_Position(bone_name)
end

---Prevents selling the built structure
---@param should_prevent boolean
function GameObject.Lock_Build_Pad_Contents(should_prevent)
end

---Get contained objects in fleets, transports, flagships or teams
---@return number
function GameObject.Get_Contained_Object_Count()
end

---Use in tactical. This kills the corresping GC object
function GameObject.Mark_Parent_Mode_Object_For_Death()
end

---Determines likelihood that the cinematic camera will focus on the object.
---@param importance number
function GameObject.Set_Importance(importance)
end

---Requires behavior TACTICAL_SELL.
function GameObject.Sell()
end

---Requires behavior TACTICAL_BUILD_OBJECTS, i.e. the object must be a build pads or MDU. 
---Also works for objects that are still under construction.
function GameObject.Get_Build_Pad_Contents()
end

---@return GameObject
function GameObject.Get_Contained_Heroes()
end

---@return boolean
function GameObject.Contains_Hero()
end


---Overrides the Targeting_Stickiness_Time_Threshold
---@param time number
function GameObject.Set_Targeting_Stickiness_Time_Threshold(time)
end

---Object needs UNIT_AI behavior
---@param prefer_ground boolean
function GameObject.Set_Prefer_Ground_Over_Space(prefer_ground)
end

---Use on buildpads and MDUs. Build pad must be empty. 
---Returns if the build could be started. Doesn't cost credits even if game rules are respected.
---@param object_type GameObjectType|string
---@param respect_rules boolean|nil Default: true
---@return boolean
function GameObject.Build(object_type, respect_rules)
end

---*******************---
--- ABILITY FUNCTIONS ---
---*******************---

---Activates or deactivates a given ability.
---@param ability_name string The ability to (de-)activate.
---@param should_activate boolean Activates the ability if true, deactivates if false.
function GameObject.Activate_Ability(ability_name, should_activate)
end

---Activates the ability at the given target.
---@param ability_name string
---@param target GameObject|Position
function GameObject.Activate_Ability(ability_name, target)
end

---GC only. Deploys the unit, i.e., activates its galactic ability if it has one. 
---If used on a fleet, only the objects in the fleet of the given type will be deployed.
---@param object_type GameObjectType|string
function GameObject.Activate_Ability(object_type)
end

---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Autofire(ability_name)
end

---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Ready(ability_name)
end

---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Active(ability_name)
end

function GameObject.Should_Switch_Weapons(target)
end

---Finishes ability cooldown.
function GameObject.Reset_Ability_Counter()
end

---Enables/Disables the specified ability to autofire
---@param ability_name string
---@param enable boolean
function GameObject.Set_Single_Ability_Autofire(ability_name, enable)
end

---Enables/Disables autofire for all abilities
---@param enable boolean
function GameObject.Set_All_Abilities_Autofire(enable)
end

---Returns if the given ability is on autofire
---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Autofire(ability_name)
end

---Returns if the given ability is active
---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Active(ability_name)
end

---Returns if the given ability is ready to be used
---@param ability_name string
---@return boolean
function GameObject.Is_Ability_Ready(ability_name)
end

---Returns if the unit has the given ability
---@param ability_name string
---@return boolean
function GameObject.Has_Ability(ability_name)
end

---Forces the given ability to recharge.
---@param ability_name string
---@param recharge_time number|nil if nil, the default recharge time is used
function GameObject.Force_Ability_Recharge(ability_name, recharge_time)
end

---Cancels the gioven ability
---@param ability_name string
function GameObject.Cancel_Ability(ability_name)
end

---Returns if the given unit is under the effect of the given ability.
---For Ion_Shot true is returned, if the unit is currently stunned by any projectile.
---@param ability_name "TRACTOR_BEAM"|"ION_CANNON_SHOT"
function GameObject.Is_Under_Effects_Of_Ability(ability_name)
end

---*******************---
--- COMMAND FUNCTIONS ---
---*******************---

---Returns a game object if the unit has an attack target, nil else.
---@return GameObject|nil
function GameObject.Get_Attack_Target()
end

---Tests whether a unit has active orders.
---@return boolean
function GameObject.Has_Active_Orders()
end

---Tests whether a unit has a current attack target.
---@return boolean
function GameObject.Has_Attack_Target()
end

---Returns true if the unit can currently move (is false e.g. during hyperspace in). 
---In galactic it essentially checks that the object is a fleet and stationed at a planet.
---@return boolean
function GameObject.Can_Move()
end

---Orders the GameObject to move to the given target. Returns a CommandBlock is marked as finished when the GameObject has arrived at target
---@param target Position|GameObject|PlanetObject
---@return CommandBlock
function GameObject.Move_To(target)
end

---Moves the units to target in formation. 
---@param unit_list GameObject[]
---@param target Position|GameObject
---@param collision_type string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
---@param threat number|nil
---@return CommandBlock
function GameObject.Move_To(unit_list, target, collision_type, threat)
end

---@param target Position|GameObject
---@return CommandBlock
function GameObject.Attack_Move(target)
end

---@param unit_list GameObject[]
---@param target Position|GameObject
---@param collision_type string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
---@param threat number|nil
---@return CommandBlock
function GameObject.Attack_Move(unit_list, target, collision_type, threat)
end

---@param game_object GameObject
---@return CommandBlock
function GameObject.Attack_Target(game_object)
end

---@param unit_list GameObject[]
---@param game_object GameObject
---@return CommandBlock
function GameObject.Attack_Target(unit_list, game_object)
end

---@param unit_list GameObject[]
---@param target Position|GameObject
---@param collision_type string|nil "Asteroid"|"Nebula"|"Ion_Storm" can be piped together and uppercase
---@param threat number|nil
---@return CommandBlock
function GameObject.Guard_Target(unit_list, target, collision_type, threat)
end

---Stops the unit
function GameObject.Stop()
end

---Movability on or off
---@param enable boolean
function GameObject.Suspend_Locomotor(enable)
end

---If the movement is locked, the unit cannot be diverted. Returns whether or not the unit could be diverted
---@param position Position
---@param threat number|nil
---@return boolean
function GameObject.Divert(position, threat)
end

---@return boolean
function GameObject.Is_On_Diversion()
end

---Locks the unit to finish its current order.
---Only for units belonging to AI players
function GameObject.Lock_Current_Orders()
end

---Unlocks the unit from finishing its current order.
---Only for units belonging to AI players
function GameObject.Unlock_Current_Orders()
end

---Determines if a unit is strong against another unit by using the Set_Contrast_Values() function in PGAICommands. 
---If the highest contrast value is smaller than 1 it returns false, if its greater than 1, it returns true
---@param game_object GameObject
---@return boolean
function GameObject.Is_Good_Against(game_object)
end

---Can the unit land on planet
---@param planet PlanetObject
---@return boolean
function GameObject.Can_Land_On_Planet(planet)
end

---@param ai_target AITargetLocation
---@return CommandBlock
function GameObject.Explore_Area(ai_target)
end

---Scales each unit's AI power by its health and category contrast vs the other and returns the difference. 
---Negative value means the other unit is stronger, positive means this unit is stronger.
---@param target GameObject|AITargetLocation
---@return number
function GameObject.Get_AI_Power_Vs_Unit(target)
end

---Only for objects that have the behavior SPECIAL_WEAPON, LOBBING_SUPERWEAPON or DUMMY_STAR_BASE. 
---In the latter case the starbase needs a hardpoint that is a special weapon. 
---Destroys any objects with the DUMMY_DESTROY_AFTER_SPECIAL_WEAPON_FIRED behavior of the user. Returns itself.
---@param target GameObject|AITargetLocation
---@param player PlayerWrapper
---@return GameObject
function GameObject.Fire_Special_Weapon(target, player)
end

---Sets the targeting priority of the Gameobject from the sets in TARGETINGPRIORITYSETFILES.XML
---@param targeting_priority_set string
function GameObject.Set_Targeting_Priorities(targeting_priority_set)
end

---Deletes the wrapped reference thereby making the object invalid.
function GameObject.Release()
end

---********************---
--- GARRISON FUNCTIONS ---
---********************---

---@return boolean
function GameObject.Is_In_Garrison()
end

---@return boolean
function GameObject.Has_Garrison()
end

---@return GameObject[]
function GameObject.Get_Garrisoned_Units()
end

function GameObject.Set_Garrison_Spawn(boolean)
end

---Eject all garrisoned units
function GameObject.Eject_Garrison()
end

---Make a garrisoned unit leave its garrison
function GameObject.Leave_Garrison()
end

---@return boolean
function GameObject.Can_Garrison_Fire()
end

---Can the unit be garrisoned in game_object
---@param game_object GameObject
---@return boolean
function GameObject.Can_Garrison(game_object)
end

---Garrison the unit in game_object
---@param game_object GameObject
function GameObject.Garrison(game_object)
end

---*******************---
--- PROXY FUNCTIONS ---
---*******************---

---Calls X(self, trigger_object) continually for each trigger_object affiliated with Z in range.
---comment
---@param callback_function function
---@param range number|nil
---@param player PlayerWrapper|nil
function GameObject.Event_Object_In_Range(callback_function, range, player)
end

---@param callback_function function
function GameObject.Cancel_Event_Object_In_Range(callback_function)
end

---Handles any proximity events set by Event_Object_In_Range
function GameObject.Service_Wrapper()
end
