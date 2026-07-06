---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field


---Returns the current game mode. 
---@return GameMode
function Get_Game_Mode()
end

---Returns true for GC Games
---@return boolean
function Is_Campaign_Game()
end

---Returns true for MP Games
---@return boolean
function Is_Multiplayer_Mode()
end

---Displays a game message
---@param message string The message to display
function Game_Message(message)
end

---Returns current time in seconds
---@return number
function GetCurrentTime()
end

---@param lower_bound number The lower bound of the random number (inclusive)   
---@param upper_bound number The upper bound of the random number (inclusive)
---@return number
function GameRandom(lower_bound, upper_bound)
end

---@param x number X coordinate
---@param y number Y coordinate
---@param z number Z coordinate
---@return Position
function Create_Position(x, y, z)
end

---Hides the given Object. 1 means hide, 0 means show.
---@param object GameObject
---@param hide number 1 for hide, 0 for show
function Hide_Object(object, hide)
end

---Hides the submesh of the given Object. 1 means hide, 0 means show.
---@param object GameObject
---@param hide number 1 for hide, 0 for show
---@param mesh_name string
function Hide_Sub_Object(object, hide, mesh_name)
end

---Compare strings without case sensitivity.
---@param string_1 string
---@param string_2 string
---@return boolean
function StringCompare(string_1, string_2)
end

---(Un)Lock all player controls
---@param lock_controls number 1 for lock, 0 for unlock
function Lock_Controls(lock_controls)
end

---Suspends all AIs
---@param suspend number 1 for turn off, 0 for turn on
function Suspend_AI(suspend)
end

---Stops fast forward
function Cancel_Fast_Forward()
end

---In tactical missions when reward parameter 9 of LINK_TACTICAL is set to 2, 
---this will trigger the arrival of the attacking fleet. 
---Fighter icons will appear on the map anyway and the fleet will be spawned if the player uses cinematic mode.
function Resume_Hyperspace_In()
end

---Displays the text entry as a droid advisor hint. 
---Since petro patch can also just display the given text. 
---@param text_id string text id of translation or plain text.
function Game_Message(text_id)
end

---Adds an objective to the bottom right.
---@param text_id string text id of translation to display.
---@param is_battle_info boolean if true adds text under Battle Information, if false adds text under Mission Objectives
function Add_Objective(text_id, is_battle_info)
end

---Adds a highlight to the given planet. 
---@param planet PlanetObject
---@param identifier string
function Add_Planet_Highlight(planet, identifier)
end

---Removes the highlight with the given identifier. 
---@param identifier string
function Remove_Planet_Highlight(identifier)
end

---Adds a radar blip to the given planet. 
---@param planet PlanetObject
function Add_Radar_Blip(planet)
end

---Removes the radar blip from the given planet. 
---@param planet PlanetObject
function Remove_Radar_Blip(planet)
end

---Adds a radar blip to the given object. 
---@param object GameObject|Position
---@param identifier string
function Add_Radar_Blip(object, identifier)
end

---Removes the radar blip from the given identifier. 
---@param identifier string
function Remove_Radar_Blip(identifier)
end

---Assembles the passed objects into a fleet and returns the fleet object.
---@param game_object_list GameObject[]
---@return FleetObject
function Assemble_Fleet(game_object_list)
end

---Returns if the given object or position is inside an asteroid field.
---@param target GameObject|Position
---@return boolean
function Is_Point_In_Asteroid_Field(target)
end

---Returns if the given object or position is inside an ion storm.
---@param target GameObject|Position
---@return boolean
function Is_Point_In_Ion_Storm(target)
end

---Returns if the given object or position is inside a nebula.
---@param target GameObject|Position
---@return boolean
function Is_Point_In_Nebula(target)
end

---Returns if the two given targets are on opposite side of the base shield.
---@param source GameObject|Position
---@param target GameObject|Position
---@param player PlayerWrapper
---@param is_friendly boolean depends on the given player
---@return boolean
---@overload fun(source: GameObject|Position, target: GameObject|Position): boolean
function Are_On_Opposite_Sides_Of_Shield(source, target, player, is_friendly)
end

---Triggers the retry dialog that allows the player to restart the mission or quit.
function Activate_Retry_Dialog()
end

---Returns a block status that is finished when the specified base level has been constructed.
---@param planet PlanetObject
---@param starbase_level number
---@return CommandBlock
function WaitForStarbase(planet, starbase_level)
end

---Returns a block status that is finished when the specified base level has been constructed.
---@param planet PlanetObject
---@param starbase_level number
---@return CommandBlock
function WaitForGroundbase(planet, starbase_level)
end

---Returns the next ground base level (amount of build ground structures)
---@param planet PlanetObject
---@return number
function GetNextGroundbaseType(planet)
end

---Returns the next starbase base level
---@param planet PlanetObject
---@return number
function GetNextStarbaseType(planet)
end