-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/BuildAntiInfantryTurret.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/BuildAntiInfantryTurret.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 51272 $
--
--          $DateTime: 2006/08/12 10:24:05 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

-- Build a single turret.

function Definitions()
	
	Category = "Build_AntiInfantry_Turret"
	TaskForce = {
	{
		"MainForce"					
		,"TaskForceRequired"
		,"UC_Empire_Buildable_Anti_Infantry_Turret | UC_Rebel_Buildable_Anti_Infantry_Turret | UC_Pirate_Buildable_Anti_Infantry_Turret | UC_Hutt_Rapid_Fire_Laser_Turret = 1"
	}
	}

end

function MainForce_Thread()
	--MessageBox("%s -- Building a turret.", tostring(Script))
		
	-- Make sure we've ended up with a build location that's reasonably close to our original target
	pad_table = MainForce.Get_Reserved_Build_Pads()
	for i,pad in pad_table do
		if pad.Get_Distance(AITarget) > 120 then
			ScriptExit()
		end
	end
	
	-- Build the task force
	-- Blocking shouldn't be necessary, but we'll use it to ease watching the script	
	MainForce.Set_Plan_Result(true)
	BlockOnCommand(MainForce.Build_All())
	ScriptExit()
end


