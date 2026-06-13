-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Rebel_Act_III.lua#6 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Rebel_Act_III.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 36323 $
--
--          $DateTime: 2006/01/12 16:55:15 $
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
		Rebel_ActIII_Mission_Ten_Begin = Setup_Trigger_Planet
	}
	
	flag_mothma_params_set = false
end

-- The mission trigger system is wherever Mon Mothma happens to be.
function Setup_Trigger_Planet(message)
	if message == OnUpdate then
		if not flag_mothma_params_set then
			han_solo_list = Find_All_Objects_Of_Type("Han_Solo_Team")
			if han_solo_list then
				han_solo_object = han_solo_list[1]
				
				--Verify the object, since Find_All_Objects_Of_Type will return an empty (though valid) table
				--if it finds nothing
				if TestValid(han_solo_object) then 
					mon_mothma_list = Find_All_Objects_Of_Type("Mon_Mothma_Team")
					if mon_mothma_list then
						mon_mothma_object = mon_mothma_list[1]
				
						--Verify the object, since Find_All_Objects_Of_Type will return an empty (though valid) table
						--if it finds nothing
						if TestValid(mon_mothma_object) then
							mon_mothma_location = mon_mothma_object.Get_Planet_Location()
							han_solo_location = han_solo_object.Get_Planet_Location()
							if mon_mothma_location == han_solo_location then
								Story_Event("MOTHMA_PARAMS_SET")
								--MessageBox("flag_mothma_params_set")
								flag_mothma_params_set = true
							end
						end
					end
				end
			end
		end
	end
end

function Story_Mode_Service()
end



