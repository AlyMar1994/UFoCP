-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/DeathStarUsePlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/DeathStarUsePlan.lua $
--
--    Original Author: Steve_Copeland
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

require("pgevents")

-- Death Star Usage

function Definitions()
	
	Category = "Death_Star_Use"
	MinContrastScale = 0.75
	MaxContrastScale = 1.75
	TaskForce = {
	{
		"DeathStarForce"
		,"Frigate | Capital | Corvette | Bomber | Fighter | Super = 100%"
	}
	}

	RequiredCategories = { "Super" }

	difficulty = "Easy"
	if PlayerObject then
		difficulty = PlayerObject.Get_Difficulty()
	end
	sleep_duration = DifficultyBasedMinPause(difficulty)

end

function DeathStarForce_Thread()
	
	AssembleForce(DeathStarForce)
	BlockOnCommand(DeathStarForce.Move_To(Target))

	if DeathStarForce.Get_Force_Count() == 0 then
		Sleep(sleep_duration)
		ScriptExit()
	end

	-- Landing a hero deploys it, removing it from the game and killing the script.  So,
	-- we have to indicate success before we land the unit, even though it hasn't deployed.
	-- If a hero killer gets her before she deploys, the plan should die before setting itself successful.	
	DeathStarForce.Set_Plan_Result(true)	
	BlockOnCommand(LandUnits(DeathStarForce))

	-- This plan has all but succeeded; make sure AI systems don't remove it
	DeathStarForce.Set_As_Goal_System_Removable(false)	
	DeathStarForce.Test_Target_Contrast(false)	

	if (not GalacticAttackAllowed(difficulty, 2)) then
		Sleep(sleep_duration)
	end
	ScriptExit()
end

function DeathStarForce_No_Units_Remaining(tf)
	--Do nothing
end

function DeathStarForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Do nothing
end
