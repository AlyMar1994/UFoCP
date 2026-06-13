-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIV_M12_SPACE.lua#6 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIV_M12_SPACE.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Rich_Donnelly $
--
--            $Change: 29541 $
--
--          $DateTime: 2005/10/18 11:42:47 $
--
--          $Revision: #6 $
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
		Empire_A04M12_Begin = State_Empire_A04M12_Begin
	}
	
	reinforce_type_list_1 = {
		"Acclamator_Assault_Ship"
	}
	
	reinforce_delay = 30

	-- For memory pool cleanup hints
	reinforce_point = nil
end

function State_Empire_A04M12_Begin(message)
	if message == OnEnter then
		--MessageBox("State_Empire_A04M12_Begin")

		reinforce_point = Find_Hint("DEFENDING FORCES POSITION")
		rebel_player = Find_Player("Rebel")
		if not reinforce_point then
			--MessageBox("Didn't find DEFENDING FORCES POSITION marker, expected for all sandbox space maps; aborting")
			ScriptExit()
		end
		
		Register_Timer(Spawn_Reinforcements, reinforce_delay)
		
		death_star_list = Find_All_Objects_Of_Type("Death_Star")
		death_star = death_star_list[1]
		death_star.Override_Max_Speed(0.20)
	end
end

function Spawn_Reinforcements()
	--MessageBox("More reinforcements!")
	ReinforceList(reinforce_type_list_1, reinforce_point, rebel_player, true, true)
end

function Story_Mode_Service()

end


