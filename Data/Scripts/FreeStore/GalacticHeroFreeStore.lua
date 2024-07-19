-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/FreeStore/GalacticHeroFreeStore.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/FreeStore/GalacticHeroFreeStore.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgcommands")

function Definitions()
	DebugMessage("%s -- Defining custom freestore movement perceptions", tostring(Script))

	-- Table which maps heroes to perceptions for systems they like to hang out on when not in active use
	-- The boolean is for whether or not the hero prefers to stay in space, if he has a choice
	-- Generally, this is to find the system where their abilities provide the best defensive or infrastructure bonuses
	CustomUnitPlacement = {
		EMPEROR_PALPATINE_TEAM = {"Is_Home_Planet", false}
		,GRAND_MOFF_TARKIN_TEAM = {"Is_Home_Planet", true}
		,DARTH_TEAM = {nil, false}
		,GENERAL_VEERS_TEAM = {nil, false}
		,BOBA_FETT_TEAM = {nil, true}
		,PIET_TEAM = {nil, true}
		,ACCUSER_STAR_DESTROYER = {nil, true}
		,ARC_HAMMER = {"Is_Home_Planet", true}
		,DARTH_TEAM_EXECUTOR = {nil, true}
		,ADMONITOR_STAR_DESTROYER = {nil, true}

		,MON_MOTHMA_TEAM = {"Is_Home_Planet", false}
		,HOME_ONE = {nil, true}
		,HAN_SOLO_TEAM = {nil, false}
		,OBI_WAN_TEAM = {nil, false}
		,DROIDS_TEAM = {nil, false}
		,LUKE_TEAM = {nil, true}
		,RED_SQUADRON = {nil, true}
		,LUKE_SKYWALKER_JEDI_TEAM = {nil, false}
		,GARM_BEL_IBLIS_TEAM = {nil, false}
		,YODA_TEAM = {nil,false}
		,ROGUE_SQUADRON_SPACE = {nil,true}
		,SUNDERED_HEART = {nil, true}

		,BOSSK_TEAM = {nil, true}
		,IG88_TEAM = {nil, true}
		,SILRI_TEAM = {nil, false}
		,URAI_FEN_TEAM = {nil, false}
		,TYBER_ZANN_TEAM = {nil, true}
	}

end

function Find_Custom_Target(object)
	object_type = object.Get_Type()
	object_type_name = object_type.Get_Name()

	unit_entry = CustomUnitPlacement[object_type_name]

	if unit_entry then
		perception = unit_entry[1]
		prefers_space = unit_entry[2]
		if perception then
			target = FindTarget.Reachable_Target(PlayerObject, perception, "Friendly", "No_Threat", 1.0, object)
			if TestValid(target) then
				return target
			end
		end

		if prefers_space then
			return Find_Space_Unit_Target(object)
		else
			return Find_Ground_Unit_Target(object)
		end
	else
		DebugMessage("%s -- Error: Type %s not found in CustomUnitPlacement table.", tostring(Script), object_type_name)
	end
end
