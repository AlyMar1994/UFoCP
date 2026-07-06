---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class GameObjectType
---A generic GameObjectType that represents a C++ GameObjectTypeClass
local GameObjectType = {}

---Retrieves the XML name of a GameObjectType
---@return string
function GameObjectType.Get_Name()
end

---Returns the AI_Combat_Power
---@return number
function GameObjectType.Get_Combat_Rating()
end

---@return boolean
function GameObjectType.Is_Hero()
end

---Returns the Build_Cost_Credits
---@return number
function GameObjectType.Get_Build_Cost()
end

---Returns the Tech_Level
---@return number
function GameObjectType.Get_Tech_Level()
end

---Returns the Required_Star_Base_Level
---@return number
function GameObjectType.Get_Base_Level()
end

---@param player PlayerWrapper
---@return boolean
function GameObjectType.Is_Affiliated_With(player)
end

---@param player PlayerWrapper
---@return boolean
function GameObjectType.Is_Build_Locked(player)
end

---@param player PlayerWrapper
---@return boolean
function GameObjectType.Is_Obsolete(player)
end

---Returns the Tactical_Build_Cost_Multiplayer
---@return number
function GameObjectType.Get_Tactical_Build_Cost()
end

---Returns the Score_Cost_Credits
---@return number
function GameObjectType.Get_Score_Cost_Credits()
end

---Returns the Targeting_Max_Attack_Distance
---@return number
function GameObjectType.Get_Max_Range()
end

---Returns the Targeting_Min_Attack_Distance
---@return number
function GameObjectType.Get_Min_Range()
end

---Gets the base bribe cost or, if the bribing object is supplied, the actual bribe cost after applying modifiers.
---@param game_object GameObject|nil
---@return number
function GameObjectType.Get_Bribe_Cost(game_object)
end