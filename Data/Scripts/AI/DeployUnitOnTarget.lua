-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/DeployUnitOnTarget.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/DeployUnitOnTarget.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Category = "Remove_Smuggler"
	IgnoreTarget = true
	TaskForce = {
	{
		"BountyForce",
		"DenyHeroAttach",
		"Bounty_Hunter_Team_E | Bounty_Hunter_Team_R = 1"
	}
	}

end

function BountyForce_Thread()
	DebugMessage("%s -- In BountyForce_Thread.", tostring(Script))

	if EvaluatePerception("Needs_Smuggler_Removed", PlayerObject, AITarget) < 1.0 then
		DebugMessage("%s -- Unable to find target for BountyForce!", tostring(Script))
		ScriptExit()
	end

	--Goal is global so there's no staging area for AssembleForce, but since we're using a stealth unit we can stage at the target
	BlockOnCommand(BountyForce.Produce_Force(AITarget))

	-- Landing a hero deploys it, removing it from the game and killing the script.  So,
	-- we have to indicate success before we land the unit, even though she hasn't deployed.
	-- If a hero killer gets her before she deploys, the plan should die before setting itself successful.
	BountyForce.Set_Plan_Result(true)

	-- AM1994 12/17/2024 - Use Activate_Ability() instead of LandUnits.
	-- When trying to land a bounty hunter, the AI will instead rapidly
	-- land and send the BH to space without actually activating ability
	-- and prematurely complete the plan.  I don't know why landing a BH
	-- doesn't act like other abilities, but this seems to work.
	BountyForce.Activate_Ability()
	--BlockOnCommand(LandUnits(BountyForce))

	DebugMessage("%s -- Finished BountyForce_Thread.", tostring(Script))
	ScriptExit()
end

function BountyForce_No_Units_Remaining()
	DebugMessage("%s -- Prematurely lost BountyForce!  Exiting...", tostring(Script))
	ScriptExit()
end

function BountyForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end
