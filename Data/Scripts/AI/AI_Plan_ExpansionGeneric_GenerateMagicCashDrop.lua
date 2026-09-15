-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/AI_Plan_ExpansionGeneric_GenerateMagicCashDrop.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/AI_Plan_ExpansionGeneric_GenerateMagicCashDrop.lua $
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

require("PGEvents")

function Definitions()
	Category = "Generate_Magic_Cash_Drop | Skirmish_Generate_Magic_Cash_Drop_Space | Skirmish_Generate_Magic_Cash_Drop_Land"
	AllowFreeStoreUnits = false
	MagicPlan = true
	MagicPlanStealing = false
	IgnoreTarget = true
	TaskForce =
	{
		{
			"ReserveForce",
			"DenyHeroAttach",
			"TaskForceRequired"
		}
	}
end

function ReserveForce_Thread()
	ReserveForce.Set_As_Goal_System_Removable(false)
	PlayerObject.Give_Money(6000)
	Sleep(120)
	ScriptExit()
end
