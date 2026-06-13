-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_I.lua#5 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_I.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 29829 $
--
--          $DateTime: 2005/10/21 14:02:11 $
--
--          $Revision: #5 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		ActI_Fondor_Rebels_00 = State_ActI_Fondor_Rebels_00
	}
	
	unit_typename_list = {
		"Y-Wing_Squadron"
		,"Y-Wing_Squadron"
		,"Rebel_Tank_Buster_Squad"
	}
	
end

-- jdg 8/21/05 disabling for now
function State_ActI_Fondor_Rebels_00(message)
	if message == OnEnter then
		-- MessageBox("lua handler for State_ActI_Fondor_Rebels_00")
		rebel_player = Find_Player("Rebel")
		empire_player = Find_Player("Empire")
		fondor_planet = FindPlanet("Fondor")
		empire_player.Enable_Advisor_Hints("Space",false)
		empire_player.Enable_Advisor_Hints("Land",false)
		unit_list = SpawnList(unit_typename_list, fondor_planet, rebel_player, false, false)
		--unit_fleet = Assemble_Fleet(unit_list) -- This will assemble the units in space
	end
end


function Story_Mode_Service()

end
