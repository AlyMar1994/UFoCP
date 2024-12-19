-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SiphonCreditsPlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/SiphonCreditsPlan.lua $
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

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	IgnoreTarget = true;
	Category = "Weaken_Planet"
	TaskForce = {
	{
		"SmugglerForce",
		"DenyHeroAttach",
		"Smuggler_Team_E | Smuggler_Team_R = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function SmugglerForce_Thread()
	DebugMessage("%s -- In SmugglerForce_Thread.", tostring(Script))

	-- AM1994 12/19/2024 - The AI finds these vibes immaculate and will do this as much
	-- as physically possible.  Due to the way the perception is now, values range from
	-- 0.45052 to 0.78771 (with around median of 0.64948).  0.64 is preferred for right
	-- now as those *should* be the more important money generators and not lead to AI
	-- spam.
	if EvaluatePerception("Suitable_Smuggler_Target", PlayerObject, Target) < 0.64 then -- was 0.5
		ScriptExit()
	end

	Sleep(1)

	AssembleForce(SmugglerForce)
	Sleep(1)
	BlockOnCommand(SmugglerForce.Move_To(Target))

	-- Landing a hero deploys it, removing it from the game and killing the script.  So,
	-- we have to indicate success before we land the unit, even though she hasn't deployed.
	-- If a hero killer gets her before she deploys, the plan should die before setting itself successful.
	SmugglerForce.Set_Plan_Result(true)
	LandUnits(SmugglerForce)

	DebugMessage("%s -- SmugglerForce Done!  Exiting Script!", tostring(Script))
	ScriptExit()
end

function SmugglerForce_No_Units_Remaining()
	ScriptExit()
end
