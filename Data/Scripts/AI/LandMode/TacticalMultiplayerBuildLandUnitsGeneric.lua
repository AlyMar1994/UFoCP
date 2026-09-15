-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/LandMode/TacticalMultiplayerBuildLandUnitsGeneric.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/AI/LandMode/TacticalMultiplayerBuildLandUnitsGeneric.lua $
--
--    Original Author: James Yarrow
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

require("PGEvents")

function Definitions()
	Category = "Tactical_Multiplayer_Build_Land_Units_Generic"
	AllowFreeStoreUnits = false
	IgnoreTarget = true
	TaskForce =
	{
		{
			"ReserveForce",
			"DenySpecialWeaponAttach",
			"DenyHeroAttach",
			"RC_Level_Two_Tech_Upgrade | RC_Level_Three_Tech_Upgrade = 0,1",
			"EC_Level_Two_Tech_Upgrade | EC_Level_Three_Tech_Upgrade = 0,1",
			"UC_Level_Two_Tech_Upgrade | UC_Level_Three_Tech_Upgrade = 0,1",
			"Boba_Fett_Team_Land_MP | Darth_Team_Land_MP | General_Veers_Team | Emperor_Palpatine_Team | Mara_Jade_Team = 0,1",
			"Han_Solo_Team_Land_MP | Obi_Wan_Team | Katarn_Team | Yoda_Team | Luke_Skywalker_Jedi_Team | Garm_Bel_Iblis_Team = 0,1",
			"Urai_Fen_Team | Bossk_Team | Silri_Team | Tyber_Zann_Team | IG88_Team = 0,1",
			"Rebel_Infiltrator_Team | RN_Rebel_Pod_Walker_Company | Rebel_Pirate_Skiff_Team | Rebel_Pirate_Swamp_Speeder_Team | Rebel_Pod_Walker_Company | Rebel_Infantry_Squad | Rebel_Tank_Buster_Squad | Rebel_Artillery_Brigade | Rebel_Light_Tank_Brigade | Rebel_Heavy_Tank_Brigade = 0,3",
			"EN_Imperial_Pod_Walker_Company | Empire_Pirate_Skiff_Team | Empire_Pirate_Swamp_Speeder_Team | Imperial_Stormtrooper_Squad | Imperial_Artillery_Corp | Imperial_Anti_Infantry_Brigade | Imperial_Armor_Group | Imperial_Heavy_Scout_Squad | Imperial_Heavy_Assault_Company | Imperial_Light_Scout_Squad | DarkTrooper_P1_Company | DarkTrooper_P2_Company | DarkTrooper_P3_Company | Noghri_Assassin_Squad = 0,3",
			"Canderous_Assault_Tank_Company | Destroyer_Droid_Company | Underworld_Disruptor_Merc_Squad | MAL_Rocket_Vehicle_Company | Underworld_Merc_Squad | Night_Sister_Company | MZ8_Pulse_Cannon_Tank_Company | Underworld_Pod_Walker_Company | Underworld_Skiff_Team | Underworld_Swamp_Speeder_Team = 0,3",
			"Rebel_Speeder_Wing | Gallofree_HTT_Company | Rebel_MDU_Company = 0,1",
			"HAV_Juggernaut_Company | Lancet_Air_Wing | Imperial_Anti_Aircraft_Company | Empire_MDU_Company = 0,1",
			"Vornskr_Wolf_Pack | F9TZ_Cloaking_Transport_Company | Underworld_MDU_Company = 0,1",
			"-Droids_Team"
		}
	}
	RequiredCategories = { "Infantry | Vehicle | LandHero | Upgrade" }
end

function ReserveForce_Thread()
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)
	BlockOnCommand(ReserveForce.Produce_Force())

	-- Give some time to accumulate money.
	local tech_level = PlayerObject.Get_Tech_Level()
	local min_credits = 2000
	local max_sleep_seconds = 30
	if tech_level == 2 then
		min_credits = 3000
		max_sleep_seconds = 45
	elseif tech_level >= 3 then
		min_credits = 4000
		max_sleep_seconds = 60
	end

	local current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end

	ScriptExit()
end
