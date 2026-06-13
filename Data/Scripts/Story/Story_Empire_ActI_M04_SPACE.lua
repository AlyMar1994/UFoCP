-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M04_SPACE.lua#10 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Empire_ActI_M04_SPACE.lua $
--
--    Original Author: James_Richmond
--
--            $Author: Joseph_Gernert $
--
--            $Change: 36026 $
--
--          $DateTime: 2006/01/05 17:48:43 $
--
--          $Revision: #10 $
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
		Empire_M04_Begin = State_Empire_M04_Begin
		,Empire_A01_M04_Begin_End = State_Empire_A01_M04_Begin_End
		,Empire_A01_M04_Intro_Text_00 = State_Empire_A01_M04_Intro_Text_00
		,Empire_A01_M04_Intro_End_00 = State_Empire_A01_M04_Intro_End_00
		,Empire_A01_M04_Intro_Text_01 = State_Empire_A01_M04_Intro_Text_01
		,Empire_A01_M04_Intro_End_01 = State_Empire_A01_M04_Intro_End_01
		,Empire_A01_M04_Intro_Text_02 = State_Empire_A01_M04_Intro_Text_02 
		,Empire_A01_M04_Intro_End_02 = State_Empire_A01_M04_Intro_End_02
		,Empire_A01_M04_Intro_Text_03 = State_Empire_A01_M04_Intro_Text_03
		,Empire_A01_M04_Intro_End_03 = State_Empire_A01_M04_Intro_End_03
	}
end


function State_Empire_M04_Begin(message)
	if message == OnEnter then
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
	
		-- MessageBox("Act 1 - Mission 4: Empire_M04_Begin beginning")
		
		-- Start AI initially suspended so the rebels don't attact the acclamator right away
		Suspend_AI(1)
		-- Lock out the controls as we are going to be letterboxed
		Lock_Controls(1)
		
		Letter_Box_In(0)
		-- Find the hint objects
        space_entry_pos = Find_Hint("GENERIC_MARKER_SPACE", "entryposition")
		Acclamatormove_pos = Find_Hint("GENERIC_MARKER_SPACE", "acclamatormove")
		xwingmove_pos1 = Find_Hint("GENERIC_MARKER_SPACE", "xwingmarker1")
		xwingmove_pos2 = Find_Hint("GENERIC_MARKER_SPACE", "xwingmarker2")
        evasive_pos = Find_Hint("GENERIC_MARKER_SPACE", "evasivepos")
        tantiveIV = Find_Hint("CORELLIAN_CORVETTE", "storytantive4")
        acclamator = Find_Hint("ACCLAMATOR_ASSAULT_SHIP", "storyacclamator")
		xwing_1 = Find_Hint("Rebel_X-Wing_Squadron", "xwing1")
      	xwing_2 = Find_Hint("Rebel_X-Wing_Squadron", "xwing2")
		TantiveIV_Move = Find_Hint("GENERIC_MARKER_SPACE", "corvettemove")
		TantiveIV_Move2 = Find_Hint("GENERIC_MARKER_SPACE", "corvettemove2")


	-- keep acclamator from moving before space warp

	acclamator.Suspend_Locomotor(true)
        
        -- Prevent the acclamator from firing on the rebels until the story catches the fact that they are there

        -- tantiveIV.Prevent_Opportunity_Fire(true)
        -- acclamator.Prevent_Opportunity_Fire(true)

        -- Pre cinematic setup		
		
		-- Set the tactical camera starting position so we can transition to it later
		Point_Camera_At(evasive_pos)
		
		-- Start the cinematic camera
		Start_Cinematic_Camera()
		
		-- Get an initial shot of the acclamator ship
		
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, linkobject, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(acclamator, 300, 5, 100, 1, 0, 0, 0)
		
		-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, linkobject, use_object_rotation, cinematic_animation)
		Set_Cinematic_Target_Key(acclamator, 0, 0, 0, 0, 0, 0, 0)
		
		
		-- Hyperspace in acclamator


		acclamator.Cinematic_Hyperspace_In(60)
		tantiveIV.Face_Immediate(TantiveIV_Move)

		-- Fade the scene in
		Fade_Screen_In(1)

		Sleep(3)


		-- acclamator.Suspend_Locomotor(false)
		acclamator.Move_To(Acclamatormove_pos)
		tantiveIV.Move_To(TantiveIV_Move)
		xwing_1.Move_To(xwingmove_pos1)
		xwing_2.Move_To(xwingmove_pos2)
		
		
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		Transition_Cinematic_Camera_Key(acclamator, 10, 500, -15, 320, 1, acclamator, 0, 0)
		
		Transition_Cinematic_Target_Key(acclamator, 10, 700, 0, 135, 1, acclamator, 0, 0)
		-- Transition_Cinematic_Target_Key(tantiveIV, 10, 0, 0, 0, 1, tantiveIV, 0, 0)

		-- Let the establishing shot of the acclamator progress 4/5 before we start the dialog	
		
		Sleep(4)
		
		-- Tell the story xml it is okay to continue with the dialog
		Story_Event("LUA_FINSHED_BEGIN")
	end
end

 -- ****************************************************		
 -- Opening Cinematic Complete
 -- ****************************************************
function State_Empire_A01_M04_Begin_End(message)
	if message == OnEnter then
	end
end


-- ****************************************************		
-- First text sequence placed on screen
-- ****************************************************
function State_Empire_A01_M04_Intro_Text_00(message)
	if message == OnEnter then
		
	end
end

-- ****************************************************		
-- First Text Sequence removed, 2nd sequence about to start
-- ****************************************************
function State_Empire_A01_M04_Intro_End_00(message)
	if message == OnEnter then

		-- The second dialog text should come on top of the first one
		-- so no delay here
		
		

	-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(tantiveIV, 200, -10,  250, 1, 0, 0, 0)
	
	-- Set_Cinematic_Target_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
	Set_Cinematic_Target_Key(tantiveIV, 0, 0, 0, 0, tantiveIV, 0, 0)
	
	Sleep(3)

             
		Story_Event("LUA_FINSHED_00")

	end

end



-- ****************************************************		
-- Second Text sequence placed on screen
-- ****************************************************
function State_Empire_A01_M04_Intro_Text_01(message)
	if message == OnEnter then
		
	end
end

-- ****************************************************		
-- Second Text sequence removed from screen third sequence about to start
-- ****************************************************
function State_Empire_A01_M04_Intro_End_01(message)
	if message == OnEnter then
		
		Story_Event("LUA_FINSHED_01")
	end
end

-- ****************************************************		
-- Third text sequence placed on screen
-- ****************************************************
function State_Empire_A01_M04_Intro_Text_02(message)
	if message == OnEnter then
		
		Sleep(3)
	end
end

-- ****************************************************		
-- Third text sequence removed from screen fourth sequence about to start
-- ****************************************************
function State_Empire_A01_M04_Intro_End_02(message)
	if message == OnEnter then

		Story_Event("LUA_FINSHED_02")

	end
end



-- ****************************************************		
-- Fourth text sequence placed on screen
-- ****************************************************
function State_Empire_A01_M04_Intro_Text_03(message)
	if message == OnEnter then
		
		-- Have the acclamator do its evasive manuever
        	acclamator.Move_To(evasive_pos)

		
		-- Set_Cinematic_Camera_Key(target_pos, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation, cinematic_animation)
		Set_Cinematic_Camera_Key(acclamator, -50, 1200, 0, 1, 0, 0, 0)
		
		-- Transition_Cinematic_Camera_Key(target_pos, time, x_dist, y_pitch, z_yaw, euler, pobj, use_object_rotation,cinematic_animation)
		Set_Cinematic_Target_Key(tantiveIV, 0, 0, 0, 1, tantiveIV, 0, 0)

		
	
	end
end

-- ****************************************************		
-- Fourth text sequence removed from screen intro sequence about to end
-- ****************************************************
function State_Empire_A01_M04_Intro_End_03(message)
	if message == OnEnter then
	
		-- End the cinetic camera mode
		Resume_Hyperspace_In()
		Point_Camera_At(acclamator)
		Transition_To_Tactical_Camera(2)
		Letter_Box_Out(2)
		Sleep(2)
		End_Cinematic_Camera()
		Lock_Controls(0)
		Suspend_AI(0)
		
	end
end
