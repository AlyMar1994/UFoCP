-- Planet Counter with Galaxy-Day Counter
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Republic at War.
--
--
--  8888888b.                            888      888 d8b               
--	888   Y88b                           888      888 Y8P               
--	888    888                           888      888                   
--	888   d88P .d88b.  88888b.  888  888 88888b.  888 888  .d8888b      
--	8888888P" d8P  Y8b 888 "88b 888  888 888 "88b 888 888 d88P"         
--	888 T88b  88888888 888  888 888  888 888  888 888 888 888           
--	888  T88b Y8b.     888 d88P Y88b 888 888 d88P 888 888 Y88b.         
--	888   T88b "Y8888  88888P"   "Y88888 88888P"  888 888  "Y8888P      
--	                   888                                              
--	                   888                                              
--	                   888                                              
--
--
--	         888    
--	         888    
--	         888    
--	 8888b.  888888 
--	    "88b 888    
--	.d888888 888    
--	888  888 Y88b.  
--	"Y888888  "Y888 
--
--
--
--     
--	888       888                  
--	888   o   888                  
--	888  d8b  888                  
--	888 d888b 888  8888b.  888d888 
--	888d88888b888     "88b 888P"   
--	88888P Y88888 .d888888 888     
--	8888P   Y8888 888  888 888     
--	888P     Y888 "Y888888 888     
--
-- Original Author: Small_Pox
-- 			Author: Anakin_Sklavenwalker
-- 			Author: cha20202
--
--/////////////////////////////////////////////////////////////////////////////////////////////////


require("PGStateMachine")
require("PGStoryMode")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
   	StoryModeEvents = 
	{ 
		Universal_Story_Start = GC_Start
		,Death_Star_Created = State_Death_Star_Created
		,Death_Star_Destroyed = State_Death_Star_Destroyed 
	}
	
	definition = true
	
	ds_active = false
	
	ds_ready = false
	
	final_planet = nil

	time_over = false
end



function GC_Start(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		
		Kuat = Find_First_Object ("Kuat")
		Fresia = Find_First_Object ("Fresia")
		Fondor = Find_First_Object ("Fondor")
		
		Register_Timer(Time_Up, 900)
		full_planet_list = FindPlanet.Get_All_Planets()
		
		rebel = Find_Player("Rebel")

	elseif message == OnUpdate then
		num_empire_planet_count = 0
		for i, planet in pairs(full_planet_list) do
			if planet.Get_Owner() == empire then 
				num_empire_planet_count = num_empire_planet_count + 1
			end
		end
		
		num_rebel_planet_count = 0
		for i, planet in pairs(full_planet_list) do
			if planet.Get_Owner() == rebel then 
				num_rebel_planet_count = num_rebel_planet_count + 1
			end
		end
		
		if not time_over then
			if ds_active and num_rebel_planet_count > 1 then
				ds_ready = false
			end
			
			-- Constant check to see if ds is used and victorious, defeat done using XML event
			if ds_active and num_rebel_planet_count < 2 then
				if not ds_ready then
					for k, planet in pairs(full_planet_list) do
						if planet.Get_Owner() == rebel then 
							final_planet = planet
							ds_ready = true
						end
					end
				end
				
				if ds_ready and final_planet.Is_Planet_Destroyed() and num_rebel_planet_count == 0 then
					Story_Event("Win_GC_Death_Star")
					ScriptExit()
				elseif num_rebel_planet_count == 0 then
					Story_Event("Win_GC")
					ScriptExit()
				end
			end		
		end
		
		if not time_over then
			if num_rebel_planet_count == 0 then
				Story_Event("Win_GC")
				ScriptExit()
			end			
		end

		if not time_over then
			if num_empire_planet_count == 0 then
				Story_Event("Lose_GC")
				ScriptExit()
			end			
		end
		
		if not time_over then
			if Kuat.Get_Owner() == rebel and Fresia.Get_Owner() == rebel and Fondor.Get_Owner() == rebel then
				Story_Event("Lose_GC")
				ScriptExit()
			end
		end
	end
end

function State_Death_Star_Created(message)
	if message == OnEnter then
		ds_active = true
	end
end

-- Only exists if Death Star is NOT a win condition
function State_Death_Star_Destroyed(message)
	if message == OnEnter then
		ds_active = false
	end
end

function Time_Up()
	time_over = true
	if time_over then 
		Story_Event("Lose_GC")
		ScriptExit()
	end
end