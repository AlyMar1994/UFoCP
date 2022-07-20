-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGInterventions.lua#1 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/Library/PGInterventions.lua $
--
--    Original Author: Brian Hayes
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGBaseDefinitions")

function Definitions()
	TaskForce = {
	{
		"Intervention",
		"TaskForceRequired",
		"DenyHeroAttach",
	},
	}
	
	StartTime = GetCurrentTime()
	InterventionExclusionPeriod = 120.0

	MinContrastScale = 1.1
	MaxContrastScale = 1.5
	PerFailureContrastAdjust = 0.1
	EnemyContrastTypes = {}
	FriendlyContrastTypes = {}
	ContrastTypeScale = {}

	if Declare_Goal_Type then
		Declare_Goal_Type()
	end
	
end

function Wait_On_Flag(flag_name, location)
	while not Check_Story_Flag(PlayerObject, flag_name, location, true) do
		Sleep(1)
		if GetCurrentTime() - StartTime > InterventionExclusionPeriod then
			Intervention.Unblock_Goal_Proposal()
		end
	end		
end

function Begin_Intervention()

	if EvaluatePerception("Are_Interventions_Allowed", PlayerObject) == 0 then
		ScriptExit()
	end

	Intervention.Block_Goal_Proposal()
	Intervention.Set_As_Goal_System_Removable(false)
end

function End_Intervention()
	Intervention.Unblock_Goal_Proposal()
	Sleep(GameRandom(60, 300))
	ScriptExit()
end

function Select_Reward_Unit(reward_table, player, min_value)

	distribution = DiscreteDistribution.Create()
	
	for i,possible_reward in pairs(reward_table) do
	
		if not possible_reward.Is_Obsolete(player) and possible_reward.Is_Affiliated_With(player) then
	
			tech_difference = possible_reward.Get_Tech_Level() - player.Get_Tech_Level()
	
			if possible_reward.Is_Build_Locked(player) then 
				if tech_difference == 0 then
					distribution.Insert(possible_reward, 7.0)
				end
			else				
				if tech_difference <= 1 then
					distribution.Insert(possible_reward, 6.0 + tech_difference)
				end
			end	
					
		end
	end
	
	reward = distribution.Sample()
	
	if not reward then 
		return nil
	end
	
	reward_count = (min_value - 1) / reward.Get_Build_Cost() + 0.5
	
	if reward_count < 1 then 
		reward_count = 1
	elseif reward_count > 5 then
		reward_count = 5
	end
	
	return reward, reward_count

end