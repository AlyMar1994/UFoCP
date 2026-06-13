-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIV_M12_GALACTIC.lua#8 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Rebel_ActIV_M12_GALACTIC.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Mike_Lytle $
--
--            $Change: 35245 $
--
--          $DateTime: 2005/12/14 18:45:55 $
--
--          $Revision: #8 $
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
		Rebel_A4_M12_Begin = State_Rebel_A4_M12_Begin
		,Rebel_A4_M12_Hunt = State_Rebel_A4_M12_Hunt
	}
	
	death_star_fleet = {
		"Death_Star"
		,"Darth_Team"
		,"STAR_DESTROYER"
		,"STAR_DESTROYER"
		,"STAR_DESTROYER"
		
	}
	
	death_star_move_delay = 25

	-- For memory pool cleanup hints

end

function State_Rebel_A4_M12_Begin(message)
	if message == OnEnter then
		--MessageBox("m12 begin")
		empire_player = Find_Player("Empire")
		death_star_unit_list = SpawnList(death_star_fleet, FindPlanet("AlderaanEAW"), empire_player, false, false)
		death_star_fleet = Assemble_Fleet(death_star_unit_list)
		if not death_star_fleet then
			--MessageBox("Can't find death star; aborting")
			ScriptExit()
		end
		
		death_star_list = Find_All_Objects_Of_Type("Death_Star")
		death_star = death_star_list[1]
		death_star.Override_Max_Speed(0.20)

		--MessageBox("feedback: DS spawned on Alderaan and attacking")
        death_star.Set_Check_Contested_Space(false)
		death_star_fleet.Activate_Ability("Death_Star")
        death_star.Set_Check_Contested_Space(true)
	end
end

function State_Rebel_A4_M12_Hunt(message)
	if message == OnEnter then
		DeathStar_Attack()
	end
end


function DeathStar_Attack()
	if TestValid(death_star_fleet) then
		
		-- Find the endpoints of the DeathStar path to the system holding Mon Mothma
		target_planet = FindTarget.Reachable_Target(empire_player, "Has_Mon_Mothma", "Enemy | Friendly | Neutral", "Any", 1.0)
		if not target_planet then
			--MessageBox("Mon mothma is not in the galaxy.  Win condition?")
			ScriptExit()
		end
		
		current_planet = death_star_fleet.Get_Parent_Object()
		if not current_planet then
			--MessageBox("Error, wasn't on a planet; trying again later.")
			Sleep(5)
		else
			-- Move one step on the path and fire the DeathStar ability
			--MessageBox("target_planet: %s   current_planet:%s", tostring(target_planet), tostring(current_planet))
			ds_path = Find_Path(empire_player, current_planet, target_planet)
			next_planet = ds_path[2]
			BlockOnCommand(death_star_fleet.Move_To(next_planet))
			--MessageBox("Fire death star here")
            death_star_list = Find_All_Objects_Of_Type("Death_Star")
		    death_star = death_star_list[1]

            death_star.Set_Check_Contested_Space(false)
			death_star_fleet.Activate_Ability("Death_Star")
            death_star.Set_Check_Contested_Space(true)
		end

		Register_Timer(DeathStar_Attack, death_star_move_delay)
	end
end



function Story_Mode_Service()


end

