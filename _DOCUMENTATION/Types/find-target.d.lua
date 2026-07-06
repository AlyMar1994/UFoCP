---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class FindTarget
FindTarget = {}

---Find a target for an AI player. Tries to find the one that the perception returns the highest value on. 
---The given probability determines the probability of finding the best target.
---@param player PlayerWrapper
---@param perception string
---@param goal_application_flag GoalApplicationFlag
---@param reachability Reachability
---@param probability number
---@param ai_target AITargetLocation
---@param range number
---@overload fun(player: PlayerWrapper, perception: string, goal_application_flag: GoalApplicationFlag, reachability: Reachability, probability: number, ai_target: AITargetLocation): AITargetLocation
---@overload fun(player: PlayerWrapper, perception: string, goal_application_flag: "Tactical_Location", reachability: Reachability, probability: number): Position
---@return AITargetLocation
function FindTarget.Reachable_Target(player, perception, goal_application_flag, reachability, probability, ai_target, range)
end

---Calcualtes the perception for all targets, returns the target with the highest value.
---@param taskforce TaskForce
---@param targets GameObject[]|AITargetLocation[]
---@param perception_name string
---@return GameObject|AITargetLocation
function FindTarget.Best_Of(taskforce, targets, perception_name)
end