-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/CrushPlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/CrushPlan.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGTaskForce")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 2

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	GlobalContrastScale = 3.0
	PerFailureContrastAdjust = 0.5

	Category = "Conquer_Opponent"
	TaskForce = {
	{
		"MainForce"
		,"MinimumTotalSize = 10"
		,"MinimumTotalForce = 8000"
		, "Infantry | Vehicle | Air | Fighter | Bomber | Corvette | Frigate | Super | Capital = 100%"
	}
	}
	RequiredCategories =	{
								"Infantry",
								"Corvette | Frigate | Capital | Super"
							}


	DebugMessage("%s -- Done Definitions", tostring(Script))

	LandSecured = false
end

function MainForce_Thread()

	difficulty = "Easy"
	if PlayerObject then
		difficulty = PlayerObject.Get_Difficulty()
	end
	sleep_duration = DifficultyBasedMinPause(difficulty)

	--Let's not even do this on easy: the AI force can just be too overwhelming
	if difficulty == "Easy" or difficulty == "Normal" then
		ScriptExit()
	end

	-- Since we're using plan failure to adjust contrast, we're
	-- only concerned with failures in battle. Default the
	-- plan to successful and then
	-- only on the event of our task force being killed is the
	-- plan set to a failed state.
	MainForce.Set_Plan_Result(true)

	if MainForce.Are_All_Units_On_Free_Store() == true then
		AssembleForce(MainForce)
	else
		BlockOnCommand(MainForce.Produce_Force());
		return
	end

	BlockOnCommand(MainForce.Move_To(Target))

	if MainForce.Get_Force_Count() == 0 then
		MainForce.Set_Plan_Result(false)
		Sleep(sleep_duration)
		ScriptExit()
	end

	if Invade(MainForce) == false then
		MainForce.Set_Plan_Result(false)
		Sleep(sleep_duration)
		ScriptExit()
	end

	-- This plan has all but succeeded; make sure AI systems don't remove it
	MainForce.Set_As_Goal_System_Removable(false)
	MainForce.Test_Target_Contrast(false)

	FundBases(PlayerObject, Target)

	LandSecured = true
	MainForce.Release_Forces(1.0)
	if (not GalacticAttackAllowed(difficulty, 2)) then
		Sleep(sleep_duration)
	end
	ScriptExit()
end

function MainForce_Production_Failed(failed_object_type)
	ScriptExit()
end

function MainForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) or (PlayerObject.Get_Difficulty() == "Hard") then
			ScriptExit()
		end
	end
end

function MainForce_No_Units_Remaining()
	if not LandSecured then
		MainForce.Set_Plan_Result(false)
		--Don't exit since we need to sleep to enforce delays between AI attacks (can't be done inside an event handler)
	end
end
