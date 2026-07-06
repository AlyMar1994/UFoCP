---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---@class Budget
Budget = {}

---Flush the Budget of the given category (Like MajorItem)
---@param category_name string
function Budget.Flush_Category(category_name)
end

function Budget.Flush_All_Resources()
end

function Budget.Flush_Unallocated_Resources()
end

---@param amount number
---@param goal_name string
function Budget.Take_Resources_From_Goal(amount, goal_name)
end

---@param amount number
---@param goal_name string
function Budget.Give_Resources_To_Goal(amount, goal_name)
end

---@param wait_time number
---@return CommandBlock
function Budget.Wait_For_Unallocated_Resources(wait_time)
end

---@param wait_time number
---@return CommandBlock
function Budget.Wait_For_Spendable_Resources(wait_time)
end

---@param amount number
function Budget.Allocate_Resources(amount)
end

function Budget.Get_Spendable_Resources()
end

function Budget.Get_Unallocated_Resources()
end