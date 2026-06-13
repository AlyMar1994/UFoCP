-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIII_M08_SPACE.lua#19 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActIII_M08_SPACE.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Rich_Donnelly $
--
--            $Change: 35740 $
--
--          $DateTime: 2005/12/22 15:46:20 $
--
--          $Revision: #19 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

function Definitions()

	StoryModeEvents = 
	{
		Empire_M08_Begin = State_Empire_M08_Begin,
		Empire_M08_Battle_Start = State_Empire_M08_Battle_Start
	}

end

function State_Empire_M08_Begin(message)

	if message == OnEnter then

		kalast_left = false
	
		--First off, grab Falast.  If he's not here, then this ain't mission 8.
		falast = Find_First_Object("Moff_Falast_Star_Destroyer")
		if not TestValid(falast) then
			ScriptExit()
		end

		empire_player = Find_Player("Empire")
		Story_Event("FALAST_INTRO")
		falast.Prevent_AI_Usage(true)
		falast.Set_Cannot_Be_Killed(true)
	
		--Next we had better make sure that there's at least one interdictor present, otherwise
		--the elusive Moff is just going to scram
		interdictor_table = Find_All_Objects_Of_Type("Interdictor_Cruiser")
		
		if table.getn(interdictor_table) == 0 then
			falast.Make_Invulnerable(true)
			-- MessageBox("Feedback needed: player doesn't have an interdictor")
			closest_unit = Find_Nearest(falast, empire_player, true)
			falast.Teleport(closest_unit)
			Sleep(10)
			falast.Hyperspace_Away(true)
			Story_Event("MOFF_FALAST_RUNS")
		else
			-- MessageBox("Feedback needed: interdictor can trap Falast")
			Story_Event("MOFF_FALAST_TRAPPED")
		end
	end
end

function State_Empire_M08_Battle_Start(message)
	if message == OnEnter then

		kalast_left = false
	
		--record the current time so that we can give the player a window to get the interdictors online
		last_run_check_time = GetCurrentTime()
		
	elseif message == OnUpdate then
	
		if not TestValid(falast) then
			--MessageBox("Moff Falast should not be completely destroyable. Error.")
			ScriptExit()
		end
		
		if falast.Get_Hull() <= 0.25 then
			falast.Make_Invulnerable(true)
			Cancel_Fast_Forward() 
			Story_Event("MOFF_FALAST_DISABLED")
		elseif GetCurrentTime() - last_run_check_time > 30.0 then
		
			--Make sure that the player still has an active interdictor
			any_active = false
			for i,interdictor in pairs(interdictor_table) do
				if TestValid(interdictor) and interdictor.Is_Ability_Active("INTERDICT") then
					any_active = true
				end
			end
			
			if not any_active then
				if falast.Are_Engines_Online() then
					falast.Make_Invulnerable(true)
					if not kalast_left then
						kalast_left = true
						falast.Hyperspace_Away(true)
						Story_Event("MOFF_FALAST_RUNS")
					end
				else
					last_run_check_time = GetCurrentTime()
				end
			else
				last_run_check_time = GetCurrentTime()
			end
		end		
	end
end