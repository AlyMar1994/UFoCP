---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class PlayerWrapper
---A wrapper around a player (AI or human) taking control of a faction.
local PlayerWrapper = {}

---Tests whether a PlayerWrapper is human.
---@return boolean
function PlayerWrapper.Is_Human()
end

---Tests whether a player object is an enemy of another player object.
---@param player PlayerWrapper
---@return boolean
function PlayerWrapper.Is_Enemy(player)
end

---Gives the player the specified amount of money. Negative amounts will remove money.
---@param amount number
function PlayerWrapper.Give_Money(amount)
end

---@return number
function PlayerWrapper.Get_ID()
end

---@param player PlayerWrapper
---@return boolean
function PlayerWrapper.Is_Ally(player)
end

---@return number
function PlayerWrapper.Get_Tech_Level()
end

---Returns the displayed faction name
---@return string
function PlayerWrapper.Get_Name()
end

---Returns the xml faction name
---@return string
function PlayerWrapper.Get_Faction_Name()
end

---@return Difficulty
function PlayerWrapper.Get_Difficulty()
end

---@param object_type GameObjectType
function PlayerWrapper.Unlock_Tech(object_type)
end

---@param object_type GameObjectType
function PlayerWrapper.Lock_Tech(object_type)
end

---@param tech_level number
function PlayerWrapper.Set_Tech_Level(tech_level)
end

---Enables or disables Advisor Hints.
---@param mode TacticalGameMode
---@param enable boolean
function PlayerWrapper.Enable_Advisor_Hints(mode, enable)
end

---Returns an enemy player
---(I suspect it only ever returns Rebel or Empire, in any case there is not much point using it 
---outside the base EaW though it might be related to the Primary Enemy tag)
---@return PlayerWrapper
function PlayerWrapper.Get_Enemy()
end

---Forces player to select object
---@param game_object GameObject
function PlayerWrapper.Select_Object(game_object)
end

---Activates the AI for that player
function PlayerWrapper.Enable_As_Actor()
end

---Starts retreat if it is allowed. Returns true if it was successful, false otherwise.
---@return boolean
function PlayerWrapper.Retreat()
end

---Options are weighted by their inverse slice cost (cheaper things are more likely to be unlocked). 
---Returns the unlocked object type.
---@return GameObjectType
function PlayerWrapper.Give_Random_Sliceable_Tech()
end

---Allies the given player to the calling player.
---Gets reset with any game mode changes, in particular at the end of every tactical battle!
---@param player PlayerWrapper
function PlayerWrapper.Make_Ally(player)
end

---Makes the given player an enemy to the calling player.
---Gets reset with any game mode changes, in particular at the end of every tactical battle!
---@param player PlayerWrapper
function PlayerWrapper.Make_Enemy(player)
end

---Returns the player's space station in space tactical
---@return GameObject
function PlayerWrapper.Get_Space_Station()
end

---Team ID in skirmish
---@return number
function PlayerWrapper.Get_Team()
end

---Clan ID in skirmish
---@return number
function PlayerWrapper.Get_Clan_ID()
end

---GameSpy ID in skirmish
---@return number
function PlayerWrapper.Get_GameSpy_Stats_Player_ID()
end

---Removes/gives the orbital bombardement to the player
---@param should_remove boolean
function PlayerWrapper.Remove_Orbital_Bombardment(should_remove)
end

---Disables/Enables the orbital bombardement of the player
---@param should_disable boolean
function PlayerWrapper.Disable_Orbital_Bombardment(should_disable)
end

---@param unknown boolean
function PlayerWrapper.Set_Sabotage_Tutorial(unknown)
end

---@param unknown boolean
function PlayerWrapper.Set_Black_Market_Tutorial(unknown)
end

---Disables/Enables the bombing run of the player
---@param should_disable boolean
function PlayerWrapper.Disable_Bombing_Run(should_disable)
end

---Returns current credits of player
---@return number
function PlayerWrapper.Get_Credits()
end

---For AI player (with galactic AI) only. Releases credits for spending in (land only?) mode.
---@param amount number|nil
function PlayerWrapper.Release_Credits_For_Tactical(amount)
end