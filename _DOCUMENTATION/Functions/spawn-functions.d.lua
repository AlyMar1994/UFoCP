---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Spawns a unit and returns a table containing only the unit
---@param unit_type GameObjectType The type of the unit
---@param location PlanetObject|GameObject|Position The location the unit is supposed to spawn at
---@param owner PlayerWrapper The owner of the unit
---@return GameObject[]
function Spawn_Unit(unit_type, location, owner)
end

---Spawns a unit with Hyperspace/landing Transport animation. Returns a CommandBlock with a table containing the spawned unit
---@param object_type GameObjectType The  GameObjectType of the unit to spawn
---@param location PlanetObject|GameObject|Position|nil The location the unit is supposed to spawn at. If nil, adds unit to reinforcement pool
---@param owner PlayerWrapper The owner of the unit
---@param allow_ai_usage boolean Determines whether the AI is allowed to control the unit
---@param ignore_reinforcement_rules boolean Ignores reinforcement rules when set to true
---@return CommandBlock
function Reinforce_Unit(object_type, location, owner, allow_ai_usage, ignore_reinforcement_rules) 
end

---This spawns the GameObjectType at location without regard for collision. 
---Be sure to use a position, using a GameObject can often crash the script.
---@param object_type GameObjectType The name or GameObjectType of the unit to spawn
---@param object_type_name string
---@param location PlanetObject|GameObject|Position The location the unit is supposed to spawn at. If nil, adds unit to reinforcement pool
---@param owner PlayerWrapper The owner of the unit
---@overload fun(object_type: GameObjectType, location: PlanetObject|GameObject|Position, owner: PlayerWrapper): GameObject
---@overload fun(object_type_name: string, location: PlanetObject|GameObject|Position, owner: PlayerWrapper): GameObject
---@return GameObject
function Create_Generic_Object(object_type, object_type_name, location, owner)
end

---Space only. Spawns a special weapon like "Ground_Ion_Cannon" and returns it. 
---Can be fired using Fire_Special_Weapon but is not available to the player even though according to the released source code it should be.
---@param object_type_name string
---@param player PlayerWrapper 
function Spawn_Special_Weapon(object_type_name, player)
end

---Spawns a unit from the reinforcement pool without hyperspace animation and returns a table containing the spawned unit. 
---Unit faces the center of the map(?). If no unit of the given type is in the reinforcement pool, nothing is spawned (no error). Respects collision.
---@param object_type GameObjectType
---@param position Position|GameObject
---@param player PlayerWrapper
---@return GameObject[]
function Spawn_From_Reinforcement_Pool(object_type, position, player)
end