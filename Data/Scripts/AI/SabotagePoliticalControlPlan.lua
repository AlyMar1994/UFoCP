-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SabotagePoliticalControlPlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SabotagePoliticalControlPlan.lua $
--
--    Original Author: James Yarrow
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

-- AM1994 12/15/2024 - Disable this plan as a part of UFoCP #408.
-- Because political control/political fighting was cut from the
-- game, Bounty Hunters no longer affect political control.  This
-- plan forces the AI to over-buy useless BHs that aren't apart
-- of DeployUnitOnTarget, and sit on planets.
-- Prefer the AI spend money more wisely on smugglers or other
-- forms of unit expansion.

function Definitions()
	--DebugMessage("%s -- In Definitions", tostring(Script))

	IgnoreTarget = true
	--Category = "Weaken_Planet"
	Category = "AlwaysOff"
	TaskForce = {
	{
		"BountyForce"
		--,"Bounty_Hunter_Team_E | Bounty_Hunter_Team_R = 1"
	}
	}

	--DebugMessage("%s -- Done Definitions", tostring(Script))
end

function BountyForce_Thread()
	--DebugMessage("%s -- In BountyForce_Thread.", tostring(Script))
	--Sleep(1)

	--AssembleForce(BountyForce)
	--Sleep(1)
	--BlockOnCommand(BountyForce.Move_To(Target))
	--BountyForce.Set_Plan_Result(true)
	--LandUnits(BountyForce)
	--DebugMessage("%s -- BountyForce Done!  Exiting Script!", tostring(Script))
	DebugMessage("%s -- Script disabled!  Exiting Script!", tostring(Script))
	ScriptExit()
end

function BountyForce_No_Units_Remaining()
	ScriptExit()
end
