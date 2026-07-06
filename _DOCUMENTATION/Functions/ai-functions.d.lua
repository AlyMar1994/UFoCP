---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Evaluates a perception and returns the result. target is needed if and only if the perception uses Variable_Target.
---@param perception_name string The name of the perception to evaluate 
---@param player PlayerWrapper The player for whom the perception is evaluated. Uses Variable_Self in Perception
---@param target GameObject|PlanetObject|nil The target object for the perception. Uses Variable_Target in Perception
---@return number
function EvaluatePerception(perception_name, player, target)
end

---For tactical battles. Evaluates the perception at GC level. 
---Implicitly sets Variable_Target to the location of the current battle.
---@param perception_name string
---@param player PlayerWrapper|nil
function Evaluate_In_Galactic_Context(perception_name, player)
end

---@param player PlayerWrapper
---@param object any
---@param amount number
---@param status CommandBlock|nil
---@return CommandBlock
function Apply_Markup(player, object, amount, status)
end

---Abandons all goals for the given player except the one that resulted in this call (techincally, it abandons plans). 
---Does not abandon goals flagged by Is_Goal_System_Removable.
---@param player PlayerWrapper
function Purge_Goals(player)
end

---Gives a goal a desire bonus for a given time frame. Used for AI perceptual equations.
---@param player PlayerWrapper
---@param goal_name string
---@param target AITargetLocation|GameObject
---@param bonus number
---@param time_limit number
---@return CommandBlock
function GiveDesireBonus(player, goal_name, target, bonus, time_limit)
end

---Find a target for a taskforce. 
---Tries to find the one that the perception returns the highest value on.
---@param taskforce TaskForce
---@param perception_name string
---@param goal_application_flag GoalApplicationFlag
---@param probability number
---@param range number|nil If value is nil, range is unlimited
---@overload fun(taskforce: TaskForce, perception_name: string, goal_application_flag: "Tactical_Location", probability: number, range: number|nil): Position
---@return GameObjectType
function FindTarget(taskforce, perception_name, goal_application_flag, probability, range)
end
