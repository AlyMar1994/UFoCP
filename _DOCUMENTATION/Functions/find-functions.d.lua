---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Returns the first GameObject of the given type name
---@param type_name string A type name as specified in the XML code
---@return GameObject|nil
function Find_First_Object(type_name)
end

---Returns a table of all GameObjects. Can be filtered by property, player and category in different combinations.
---@param player PlayerWrapper The owner of the objects to find
---@param property string A Property Name as specified in the XML code
---@param type_name string A type name as specified in the XML code
---@param object_type GameObjectType A type name as specified in the XML code
---@param category string A Category Mask as specified in the XML code, can be piped with | like "Infantry | Vehicle"
---@return GameObject[]
---@overload fun(property: string): GameObject[]
---@overload fun(type_name: string): GameObject[]
---@overload fun(object_type: GameObjectType): GameObject[]
---@overload fun(property: string, player: PlayerWrapper): GameObject[]
---@overload fun(type_name: string, player: PlayerWrapper): GameObject[]
---@overload fun(player: PlayerWrapper): GameObject[]
---@overload fun(player: PlayerWrapper, category: string): GameObject[]
function Find_All_Objects_Of_Type(property, player, category, type_name, object_type)
end

---Returns the GameObject nearest to the source object matching the given input
---@param taskforce TaskForce
---@param source_object GameObject The GameObject to which the nearest object shall be found
---@param category string Limits the result to the given category
---@param player PlayerWrapper
---@param allied boolean Limits the result to allied or enemy units
---@overload fun(source_object: GameObject, type_name: string): GameObject|nil
---@overload fun(source_object: GameObject, player: PlayerWrapper, allied: boolean): GameObject|nil
---@overload fun(source_object: GameObject, categry: string, player: PlayerWrapper, allied: boolean): GameObject|nil
---@overload fun(taskforce: TaskForce, type_name: string): GameObject|nil
---@overload fun(taskforce: TaskForce, player: PlayerWrapper, allied: boolean): GameObject|nil
---@overload fun(taskforce: TaskForce, categry: string, player: PlayerWrapper, allied: boolean): GameObject|nil
---@return GameObject|nil
function Find_Nearest(source_object, taskforce, category, player, allied)
end

---@param planet_name string The name of the planet
---@return PlanetObject|nil
---Returns the PlanetObject matching the given planet name
function FindPlanet(planet_name)
end

---Finds a path between two planets for the given player
---@param player PlayerWrapper The player for whom the path is to be found
---@param start_planet PlanetObject The starting planet
---@param end_planet PlanetObject The destination planet
---@return PlanetObject[]|nil
function Find_Path(player, start_planet, end_planet)
end

---Returns the PlayerWrapper matching the given faction name.
---Find_Player("local") will always return the local human player.
---@param faction_name string The name of the faction
---@overload fun(faction_name: "local"): PlayerWrapper
---@return PlayerWrapper|nil
function Find_Player(faction_name)
end

---Returns the GameObjectType matching the given type name
---@param type_name string The type name
---@return GameObjectType|nil
function Find_Object_Type(type_name)
end

---Returns the GameObject with the given hint. Hints can be set in the map editor.
---@param type_name string
---@param hint string
---@return GameObject|nil
function Find_Hint(type_name, hint)
end

---Returns all GameObjects with a hint. Hints can be set in the map editor.
---@return GameObject[]
function Find_All_Objects_With_Hint()
end

---Finds the game object that currently attacks the given game object and deals the highest damage.
---@param target GameObject|TaskForce
---@return GameObject
function FindDeadlyEnemy(target)
end

---Finds the game object that currently attacks the given game object and deals the highest damage.
---@param target GameObject|TaskForce
---@param range number
---@param player PlayerWrapper
---@return GameObject
function FindDeadlyEnemy(target, range, player)
end

---Returns the nearest space field of the given type. Space field types can probably be piped together for "or" condition.
---@param target GameObject|Position|TaskForce
---@param obstacle_type string Possible values: "Asteroid" "Nebula" "Ion_Storm" and also piped together or upper case
---@return GameObject
function Find_Nearest_Space_Field(target, obstacle_type)
end

---Returns position and combined threat of units (from the unit list) in range of the position.
---@param unit_list GameObject[]
---@param distance number
---@return Position
---@return number
function Find_Best_Local_Threat_Center(unit_list, distance)
end

---Returns the most defended position for the given game object of the given player. Tactical only.
---@param game_object GameObject
---@param player PlayerWrapper
---@return Position
function Get_Most_Defended_Position(game_object, player)
end

---Tactical only. Projects to a new position from X through Y. In pseudo code the returned position is Y.position + X.range * (Y.position - X.position).normalize.
---@param game_object GameObject
---@param target GameObject|TaskForce|Position
---@return Position
function Project_By_Unit_Range(game_object, target)
end