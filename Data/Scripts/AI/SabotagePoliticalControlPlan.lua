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

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	IgnoreTarget = true;
	Category = "Weaken_Planet"
	TaskForce = {
	{
		"BountyForce"						
		,"Bounty_Hunter_Team_E | Bounty_Hunter_Team_R = 1"
	}
	}
	
	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function BountyForce_Thread()
	DebugMessage("%s -- In BountyForce_Thread.", tostring(Script))
	Sleep(1)

	AssembleForce(BountyForce)
	Sleep(1)
	BlockOnCommand(BountyForce.Move_To(Target))
	BountyForce.Set_Plan_Result(true)
	LandUnits(BountyForce)
	DebugMessage("%s -- BountyForce Done!  Exiting Script!", tostring(Script))
	ScriptExit()
end

function BountyForce_No_Units_Remaining()
	ScriptExit()
end