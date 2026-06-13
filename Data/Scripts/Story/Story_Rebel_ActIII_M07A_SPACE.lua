-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M07A_SPACE.lua#9 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIII_M07A_SPACE.lua $
--
--    Original Author: Eric_Yiskis
--
--            $Author: Joseph_Gernert $
--
--            $Change: 30437 $
--
--          $DateTime: 2005/10/28 11:13:55 $
--
--          $Revision: #9 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")


------------------------------------------------------------------------------------------------------------------------
-- Definitions -- This function is called once when the script is first created.
------------------------------------------------------------------------------------------------------------------------

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Rebel_A3_M07A_Begin = State_Rebel_A3_M07A_Begin
		,Rebel_A3_M07A_Intro_HANSOLO_DIALOG_Remove_Text = State_Intro_HANSOLO_DIALOG_Remove_Text
	}
   
	player_notified = false
	init_done = false
	tractor_beam_timer_active = false
	falcon_near_death = 0.3
	unit_list = {}
	
	end_cine_falcon = {
		"MOV_Millenium_Falcon"	}
	
	flag_falcon_captured = false
	flag_player_won	= false
	flag_engines_offline = false
	
end

------------------------------------------------------------------------------------------------------------------------
-- State_Rebel_A3_M07A_Begin -- Get the mission started
------------------------------------------------------------------------------------------------------------------------

function State_Rebel_A3_M07A_Begin(message)
	if message == OnEnter then
	
		--MessageBox("OnEnter State_Rebel_A3_M07A_Begin")

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		
		-- Get Players
		empire = Find_Player("Empire")
		rebel = Find_Player("Rebel")
		player = rebel

		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		unit_list = Find_All_Objects_Of_Type("STAR_DESTROYER_TRACTOR_FIGHTERS")				
		star_destroyer = unit_list[1]
		
		unit_list = Find_All_Objects_Of_Type("MILLENIUM_FALCON_BACKWARDS")				
		falcon = unit_list[1]
		
		starbase = Find_Hint("EMPIRE_STAR_BASE_4", "starbase")
		destroyer_2 = Find_Hint("STAR_DESTROYER", "guard1")
		destroyer_3 = Find_Hint("STAR_DESTROYER", "guard2")
		
		if not starbase then
			MessageBox("Couldn't Find starbase!")
		end
		
		--jdg removing target-of-opportunity from falcon
		falcon.Prevent_Opportunity_Fire(true)
		starbase.Prevent_Opportunity_Fire(true)
		destroyer_2.Prevent_Opportunity_Fire(true)
		destroyer_3.Prevent_Opportunity_Fire(true)
		destroyer_2.Guard_Target(destroyer_2.Get_Position())
		destroyer_3.Guard_Target(destroyer_3.Get_Position())
		
		
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- If falcon is destroyed, mission is over!
		
		Register_Death_Event(falcon,Falcon_Death)
		Register_Death_Event(star_destroyer,Star_Destroyer_Death)
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		-- Have the Star Destroyer tractor-beam the falcon
		capture_range = 200
		star_destroyer.Activate_Ability("TRACTOR_BEAM",falcon)
		--star_destroyer.Move_To(star_destroyer.Get_Position())
		--Register_Prox(star_destroyer,Prox_Star_Destroyer,capture_range,rebel)
		
		--jdg smoke-and-mirrors here...make destroyer and falcon move toward starbase
		destroyer_goto = Find_Hint("GENERIC_MARKER_SPACE", "destroyer-goto")
		falcon_goto = Find_Hint("GENERIC_MARKER_SPACE", "falcon-goto")
		
		if not destroyer_goto then
			MessageBox("Couldn't Find destroyer_goto!")
		end
		
		if not falcon_goto then
			MessageBox("Couldn't Find falcon_goto!")
		end
		star_destroyer.Prevent_AI_Usage(true)
		--falcon.Prevent_AI_Usage(true)
		star_destroyer.Move_To(destroyer_goto)
		falcon.Move_To(falcon_goto)
		falcon.Set_Selectable(false)
		
		Create_Thread("Thread_Falcon_Orders", falcon)
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	
		-- We have to give the star destroyer time to activate the tractor beam.
		-- We also don't want the star destroyer to be moving while we hyperspace in...
		Register_Timer(Start_Service,10) 
		
		-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

		Create_Thread("Intro_Cinematic")
	end
end

function Thread_Falcon_Orders( unit_list )
	Formation_Move(unit_list, falcon_goto)
	if not flag_player_won and not flag_engines_offline then
		flag_falcon_captured = true
		unit_list.Despawn()
		Story_Event("FALCON_CAPTURED") 
	end
end



function Intro_Cinematic()

	--MessageBox("intro_cinematic function hit")
	-- Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)

	Start_Cinematic_Camera()
	
	Set_Cinematic_Camera_Key(star_destroyer, 1200, 3, 145, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(star_destroyer, 0, 0, 0, 0, 0, 0, 0)	

	
	
	Fade_Screen_In(1)
	Sleep(1)
	
	Story_Event("M7A_INTRO_OFFICER_DIALOG_GO") 
	--Imperial Officer: Smuggler scum!  We've got you now!  
	--Prepare to be boarded!
	
	Sleep(2)
	Resume_Hyperspace_In() 
	Transition_Cinematic_Camera_Key(falcon, 6.0, 375, 15, 310, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(falcon, 2.5, 0, 0, 0, 0, 0, 0, 0)
	
	Sleep(2)
	Story_Event("M7A_INTRO_HANSOLO_DIALOG_GO") 
	
end

function State_Intro_HANSOLO_DIALOG_Remove_Text(message)
	if message == OnEnter then
		closest_unit = Find_Nearest(falcon, player, true) 
		Story_Event("M7A_INTRO_TASK_TEXT_GO") 
		Sleep(3)
		
		Point_Camera_At(closest_unit)
		Transition_To_Tactical_Camera(2)
		Letter_Box_Out(2)
		Sleep(2)
		End_Cinematic_Camera()

		Suspend_AI(0)
		Lock_Controls(0)
		
		Add_Radar_Blip(star_destroyer, "blip_star_destroyer")
		star_destroyer.Highlight(true)
	end
end 



------------------------------------------------------------------------------------------------------------------------
-- Start_Service()
------------------------------------------------------------------------------------------------------------------------

function Start_Service()

	if TestValid(star_destroyer) then
		--star_destroyer.Move_To(falcon.Get_Position())
	end
	
	init_done = true
	
end

------------------------------------------------------------------------------------------------------------------------
-- Prox_Star_Destroyer()
------------------------------------------------------------------------------------------------------------------------

--function Prox_Star_Destroyer(prox_obj, trigger_obj)
--	if trigger_obj == falcon then
--		Story_Event("FALCON_CAPTURED")
--		star_destroyer.Cancel_Event_Object_In_Range(Prox_Star_Destroyer)
--		star_destroyer.Move_To(star_destroyer.Get_Position())
--	end
--end

------------------------------------------------------------------------------------------------------------------------
-- Falcon_Death()
------------------------------------------------------------------------------------------------------------------------

function Falcon_Death()
	if not flag_falcon_captured and not flag_player_won then
		Story_Event("FALCON_DESTROYED")
	end	
end

------------------------------------------------------------------------------------------------------------------------
-- Star_Destroyer_Death()
------------------------------------------------------------------------------------------------------------------------

function Star_Destroyer_Death()
	--Story_Event("FALCON_FREE_OF_TRACTOR")
	flag_player_won = true
	Create_Thread("Ending_Cinematic")
	falcon.Make_Invulnerable(true)
end

function Ending_Cinematic()

	--flag_player_won = true
	--MessageBox("intro_cinematic function hit")
	Fade_Screen_Out(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	
	Cancel_Fast_Forward()
	rebel = Find_Player("Rebel")
	unit_list = Find_All_Objects_Of_Type(rebel)
	for i, unit in pairs(unit_list) do
		unit.Set_Selectable(false)
	end
	
	--despawn backwards falcon and replace with MOV version one MILLENNIUM_FALCON
	falcon_pos = falcon.Get_Position()
	cine_falcon = SpawnList(end_cine_falcon, falcon_pos, player, false, true)
	
	if not cine_falcon then
		MessageBox("Couldn't Find cine_falcon!")
	end
	
	cine_falcon_face = Find_Hint("GENERIC_MARKER_SPACE","cine-falcon-face")
	falcon_escape_spot = Find_Hint("GENERIC_MARKER_SPACE","falcon-escape-spot")
	
	if not cine_falcon_face then
		MessageBox("Couldn't Find cine_falcon_face!")
	end
	
	for i,unit in pairs(cine_falcon) do
		unit.Face_Immediate(cine_falcon_face)
		unit.Move_To(falcon_escape_spot)
	end
	
	falcon.Despawn()
	
	redundant_falcon = Find_First_Object("MOV_Millenium_Falcon")
	
	if not redundant_falcon then
		MessageBox("Couldn't Find redundant_falcon!")
	end
	
	--hiding/despawning the defense satellites if needed
	laser_satellites_list = Find_All_Objects_Of_Type("DEFENSE_SATELLITE_LASER")
	missile_satellites_list = Find_All_Objects_Of_Type("DEFENSE_SATELLITE_MISSILE")
	
	for i,laser_satellites in pairs(laser_satellites_list) do
		if TestValid(laser_satellites) then
			laser_satellites.Despawn()
		end
	end
	
	for i,missile_satellites in pairs(missile_satellites_list) do
		if TestValid(missile_satellites) then
			missile_satellites.Despawn()
		end
	end

	Start_Cinematic_Camera()
	Sleep(2)
	Set_Cinematic_Camera_Key(redundant_falcon, 200, 3, 145, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(redundant_falcon, 0, 0, 0, 0, redundant_falcon, 0, 0)	
	
	Fade_Screen_In(1)
	Sleep(1)
	
	Story_Event("FALCON_FREE_OF_TRACTOR") 
	
	Sleep(4)
	
	
	
	redundant_falcon.Hyperspace_Away()
	Sleep(1)
	Story_Event("PLAYER_WINS") 
	
end

------------------------------------------------------------------------------------------------------------------------
-- Tractor_Beam_Timer()
------------------------------------------------------------------------------------------------------------------------

function Tractor_Beam_Timer()

	-- Reset checking code
	tractor_beam_timer_active = false

	-- The Star Destroyer was not able to re-establish the tractor beam
	if TestValid(falcon) and not falcon.Is_Under_Effects_Of_Ability("TRACTOR_BEAM") then
		--star_destroyer.Cancel_Event_Object_In_Range(Prox_Star_Destroyer)
		--Story_Event("FALCON_FREE_OF_TRACTOR")
		flag_player_won = true
		Create_Thread("Ending_Cinematic")
	end

end

------------------------------------------------------------------------------------------------------------------------
-- Story_Mode_Service() - gets serviced each frame
------------------------------------------------------------------------------------------------------------------------

-- Here is an opportunity for updates outside of an event
function Story_Mode_Service()

	if not init_done then
		return
	end
	
	if TestValid(falcon) and TestValid(star_destroyer) then
		if not falcon.Is_Under_Effects_Of_Ability("TRACTOR_BEAM") and not flag_player_won then
			flag_player_won = true
			Create_Thread("Ending_Cinematic")
		end
	end
	
	if TestValid(falcon) and TestValid(star_destroyer) then
		if not tractor_beam_timer_active and not falcon.Is_Under_Effects_Of_Ability("TRACTOR_BEAM") and not flag_player_won then
			star_destroyer.Activate_Ability("TRACTOR_BEAM",falcon)
			tractor_beam_timer_active = true
			Register_Timer(Tractor_Beam_Timer,3)
		end
	end
	
	--check if falcon has been attacked...make it NOT a target-of-opp
	if TestValid(falcon) and falcon.Get_Shield() < 0.9 then
		falcon.Prevent_Opportunity_Fire(true)
		starbase.Prevent_Opportunity_Fire(true)
	end
	
	if TestValid(star_destroyer) and not star_destroyer.Are_Engines_Online() and not flag_engines_offline then
		if TestValid(falcon) then
			flag_engines_offline = true
			--MessageBox("star destroyers engines gone...falcon stops moving")
			--falcon.Move_To(falcon.Get_Position())
			--star_destroyer.Move_To(star_destroyer.Get_Position())
			falcon.Stop()
			star_destroyer.Stop()
		end
		
	end

	

		
	-- Tell the player when the falcon will soon be destroyed
	if not player_notified then
		if TestValid(falcon) and falcon.Get_Hull() < falcon_near_death then
			Story_Event("FALCON_NEAR_DEATH")
			player_notified = true
		end
	end								 
end

------------------------------------------------------------------------------------------------------------------------
