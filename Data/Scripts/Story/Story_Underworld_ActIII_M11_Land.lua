-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActIII_M11_LAND.lua#1 $
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
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/Story/Story_Underworld_ActIII_M11_LAND.lua $
--
--    Original Author: Jeff_Stewart
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

require("PGSpawnUnits")
require("PGStoryMode")
require("JGS_FunctionLib") -- added library of commonly used functions

function Definitions()
	--MessageBox("Defined")
	StoryModeEvents =
	{
		Underworld_A03M11_Begin = State_Underworld_A03M11_Begin,
		Mission_Chatter_00_Done = State_Mission_Chatter_00_Done,
		Mission_Chatter_01_Done = State_Mission_Chatter_01_Done,
		Mission_Chatter_02_Done = State_Mission_Chatter_02_Done,
		Mission_Chatter_03_Done = State_Mission_Chatter_03_Done,
		Mission_Chatter_04_Done = State_Mission_Chatter_04_Done,
		Mission_Chatter_05_Done = State_Mission_Chatter_05_Done,
		Mission_Chatter_06_Done = State_Mission_Chatter_06_Done,
		Mission_Chatter_07_Done = State_Mission_Chatter_07_Done,
		Mission_Chatter_08_Done = State_Mission_Chatter_08_Done,
		Mission_Chatter_09_Done = State_Mission_Chatter_09_Done,
		Mission_Chatter_10_Done = State_Mission_Chatter_10_Done,
		Mission_Chatter_11_Done = State_Mission_Chatter_11_Done,
		Mission_Chatter_12_Done = State_Mission_Chatter_12_Done,
		Mission_Chatter_13_Done = State_Mission_Chatter_13_Done,
		Mission_Chatter_14_Done = State_Mission_Chatter_14_Done,
		Mission_Chatter_15_Done = State_Mission_Chatter_15_Done,
		Mission_Chatter_16_Done = State_Mission_Chatter_16_Done,
		Mission_Chatter_17_Done = State_Mission_Chatter_17_Done,
		Mission_Chatter_18_Done = State_Mission_Chatter_18_Done,
		Mission_Chatter_19_Done = State_Mission_Chatter_19_Done,
		Mission_Chatter_20_Done = State_Mission_Chatter_20_Done,
		Mission_Chatter_21_Done = State_Mission_Chatter_21_Done,
		Mission_Chatter_22_Done = State_Mission_Chatter_22_Done,
		Mission_Chatter_23_Done = State_Mission_Chatter_23_Done,
		Mission_Chatter_24_Done = State_Mission_Chatter_24_Done,
		Mission_Chatter_25_Done = State_Mission_Chatter_25_Done,
		Mission_Chatter_26_Done = State_Mission_Chatter_26_Done,
		Mission_Chatter_27_Done = State_Mission_Chatter_27_Done,
		Mission_Chatter_28_Done = State_Mission_Chatter_28_Done,
		Mission_Chatter_29_Done = State_Mission_Chatter_29_Done,
		Mission_Chatter_30_Done = State_Mission_Chatter_30_Done,
		Mission_Chatter_31_Done = State_Mission_Chatter_31_Done,
		Mission_Chatter_32_Done = State_Mission_Chatter_32_Done,
		Mission_Chatter_33_Done = State_Mission_Chatter_33_Done,
		Mission_Chatter_34_Done = State_Mission_Chatter_34_Done,
		Mission_Chatter_35_Done = State_Mission_Chatter_35_Done,
		Mission_Chatter_36_Done = State_Mission_Chatter_36_Done,
		Mission_Chatter_37_Done = State_Mission_Chatter_37_Done,
		Mission_Chatter_38_Done = State_Mission_Chatter_38_Done,
		Mission_Chatter_39_Done = State_Mission_Chatter_39_Done,
		Mission_Chatter_40_Done = State_Mission_Chatter_40_Done,
		Mission_Chatter_41_Done = State_Mission_Chatter_41_Done,
		Mission_Chatter_42_Done = State_Mission_Chatter_42_Done,
		Mission_Chatter_43_Done = State_Mission_Chatter_43_Done,
		Mission_Chatter_44_Done = State_Mission_Chatter_44_Done,
		Mission_Chatter_45_Done = State_Mission_Chatter_45_Done,
		Mission_Chatter_46_Done = State_Mission_Chatter_46_Done,
		Mission_Chatter_47_Done = State_Mission_Chatter_47_Done,
		Mission_Chatter_48_Done = State_Mission_Chatter_48_Done,
		Mission_Chatter_49_Done = State_Mission_Chatter_49_Done,
		Mission_Chatter_50_Done = State_Mission_Chatter_50_Done,
		Mission_Chatter_51_Done = State_Mission_Chatter_51_Done,
		Mission_Chatter_52_Done = State_Mission_Chatter_52_Done,
		Mission_Chatter_53_Done = State_Mission_Chatter_53_Done,
		Mission_Chatter_54_Done = State_Mission_Chatter_54_Done,
		Mission_Chatter_55_Done = State_Mission_Chatter_55_Done
	}
end


function State_Underworld_A03M11_Begin(message)
	if message == OnEnter then

		Fade_Screen_Out(0)

		State_Mission_00_Done = false
		State_Mission_01_Done = false
		State_Mission_02_Done = false
		State_Mission_03_Done = false
		State_Mission_04_Done = false
		State_Mission_05_Done = false
		State_Mission_06_Done = false
		State_Mission_07_Done = false
		State_Mission_08_Done = false
		State_Mission_09_Done = false
		State_Mission_10_Done = false
		State_Mission_11_Done = false
		State_Mission_12_Done = false
		State_Mission_13_Done = false
		State_Mission_14_Done = false
		State_Mission_15_Done = false
		State_Mission_16_Done = false
		State_Mission_17_Done = false
		State_Mission_18_Done = false
		State_Mission_19_Done = false
		State_Mission_20_Done = false
		State_Mission_21_Done = false
		State_Mission_22_Done = false
		State_Mission_23_Done = false
		State_Mission_24_Done = false
		State_Mission_25_Done = false
		State_Mission_26_Done = false
		State_Mission_27_Done = false
		State_Mission_28_Done = false
		State_Mission_29_Done = false
		State_Mission_30_Done = false
		State_Mission_31_Done = false
		State_Mission_32_Done = false
		State_Mission_33_Done = false
		State_Mission_34_Done = false
		State_Mission_35_Done = false
		State_Mission_36_Done = false
		State_Mission_37_Done = false
		State_Mission_38_Done = false
		State_Mission_39_Done = false
		State_Mission_40_Done = false
		State_Mission_41_Done = false
		State_Mission_42_Done = false
		State_Mission_43_Done = false
		State_Mission_44_Done = false
		State_Mission_45_Done = false
		State_Mission_46_Done = false
		State_Mission_47_Done = false
		State_Mission_48_Done = false
		State_Mission_49_Done = false
		State_Mission_50_Done = false
		State_Mission_51_Done = false
		State_Mission_52_Done = false
		State_Mission_53_Done = false
		State_Mission_54_Done = false
		State_Mission_55_Done = false

		neutral_player = Find_Player("Neutral")
		empire_player = Find_Player("Empire")
		underworld_player = Find_Player("Underworld")
		hostile_player = Find_Player("Hostile")

		Setup_Cinematic_Definitions()

		-- name and register prox and death values for operating doors in mission
		endcinebox = Find_Hint("UM05_BLACK_COVER_GIANT", "endcinecover") --
		endcinebox1 = Find_Hint("UM05_BLACK_COVER_GIANT", "endcinebox1") --
		int_sky=Find_First_Object("GIRDER_SKY_INTERIOR")
		ext_sky=Find_Hint("PROP_CORUSCANT_SKYDOME","extskydome")
		thesithartifact = Find_First_Object("UM05_CINE_HOLOCRON")

		thebunker = Find_Hint("GARRISON_BUNKER_CAPTURABLE", "bunker") --
		doora = Find_Hint("UM05_MOVING_DOOR", "doora") --
		doorbspawn = Find_Hint("STORY_TRIGGER_ZONE", "doorbspawn")
		doorc1 = Find_Hint("UM05_MOVING_DOOR", "doorc1") --
		doorc2 = Find_Hint("UM05_MOVING_DOOR", "doorc2") --
		doord = Find_Hint("UM05_MOVING_DOOR", "doord")
		doore = Find_Hint("UM05_MOVING_DOOR", "doore") --
		doore2spawn = Find_Hint("STORY_TRIGGER_ZONE", "doore2spawn")
		doorfspawn = Find_Hint("STORY_TRIGGER_ZONE", "doorfspawn")
		doorg = Find_Hint("UM05_MOVING_DOOR", "doorg")
		doorh = Find_Hint("UM05_MOVING_DOOR", "doorh") --
		doori = Find_Hint("UM05_MOVING_DOOR", "doori")
		doorj = Find_Hint("UM05_MOVING_DOOR", "doorj") --
		doorjspawn = Find_Hint("STORY_TRIGGER_ZONE", "doorjspawn")
		doork = Find_Hint("UM05_MOVING_DOOR", "doork") --
		vaulta = Find_Hint("UM05_MOVING_DOOR", "vaultdoora") --
		vaultb = Find_Hint("UM05_MOVING_DOOR", "vaultdoorb") --
		adeptonedoor = Find_Hint("UM05_MOVING_DOOR", "adeptonedoor") --
		vaultcover = Find_Hint("UM05_BLACK_COVER", "openedvault") --

		consoleb = Find_Hint("UMP_INTERFACE_NODE", "consoleb")
		consoled = Find_Hint("UMP_INTERFACE_NODE", "consoled")
		consolee = Find_Hint("UMP_INTERFACE_NODE", "consolee") --
		consoleg = Find_Hint("UMP_INTERFACE_NODE", "consoleg")
		consolei = Find_Hint("UMP_INTERFACE_NODE", "consolei")
		consolej = Find_Hint("UMP_INTERFACE_NODE", "consolej") --
		consolek = Find_Hint("UMP_INTERFACE_NODE", "consolek") --
		consolevault = Find_Hint("UMP_INTERFACE_NODE", "consolevault") --
		consolesecret = Find_Hint("UMP_INTERFACE_NODE", "secretsithconsole") --

		Register_Death_Event(consolesecret, Open_SithDoor)
		Register_Death_Event(consolevault, PartFive_OpenVault)
		Register_Death_Event(consolek, Open_Door_k)
		Register_Death_Event(consolej, Open_Door_j)
		Register_Death_Event(consolee, Open_Door_e)

		camstart_one = Find_Hint("STORY_TRIGGER_ZONE", "partone-camerastart")
		camstart_two = Find_Hint("STORY_TRIGGER_ZONE", "parttwo-camerastart")
		camstart_three = Find_Hint("STORY_TRIGGER_ZONE", "partthree-camerastart")
		camstart_four = Find_Hint("STORY_TRIGGER_ZONE", "partfour-camerastart")
		camstart_five = Find_Hint("STORY_TRIGGER_ZONE", "partfive-camerastart")
		camstart_six = Find_Hint("STORY_TRIGGER_ZONE", "partsix-camerastart")

		-- name and register death events for required heroes
		tyber_zann = Find_Nearest(doora,"TYBER_ZANN_CAMPAIGN")
		Register_Death_Event(tyber_zann, Tyber_Destroyed)
		tyber_zann.Prevent_AI_Usage(true)
		urai_fen = Find_Nearest(doora,"URAI_FEN")
		Register_Death_Event(urai_fen, Urai_Destroyed)
		urai_fen.Prevent_AI_Usage(true)
		silri = Find_Nearest(doora,"SILRI")
		Register_Death_Event(silri, Silri_Destroyed)
		silri.Prevent_AI_Usage(true)

		hallguard1 = Find_Hint("IMP_GUARD_TEAM", "hallguard1")
		hallguard2 = Find_Hint("IMP_GUARD_TEAM", "hallguard2")
		hallguard3 = Find_Hint("IMP_GUARD_TEAM", "hallguard3")
		hallguard4 = Find_Hint("IMP_GUARD_TEAM", "hallguard4")
		hallguard5 = Find_Hint("IMP_GUARD_TEAM", "hallguard5")
		hallguard6 = Find_Hint("IMP_GUARD_TEAM", "hallguard6")
		hallguard7 = Find_Hint("IMP_GUARD_TEAM", "hallguard7")
		hallguard8 = Find_Hint("IMP_GUARD_TEAM", "hallguard8")
		hallguard9 = Find_Hint("IMP_GUARD_TEAM", "hallguard9")
		hallguard10 = Find_Hint("IMP_GUARD_TEAM", "hallguard10")
		hallguard11 = Find_Hint("IMP_GUARD_TEAM", "hallguard11")
		hallguard12 = Find_Hint("IMP_GUARD_TEAM", "hallguard12")
		hallguard13 = Find_Hint("IMP_GUARD_TEAM", "hallguard13")
		hallguard14 = Find_Hint("IMP_GUARD_TEAM", "hallguard14")
		hallguard15 = Find_Hint("IMP_GUARD_TEAM", "hallguard15")
		hallguard16 = Find_Hint("IMP_GUARD_TEAM", "hallguard16")

		range = 200
		Register_Prox(hallguard3, Prox_HallGuard_3, range, underworld_player)
		Register_Prox(hallguard4, Prox_HallGuard_4, range, underworld_player)
		Register_Prox(hallguard5, Prox_HallGuard_5, range, underworld_player)
		Register_Prox(hallguard6, Prox_HallGuard_6, range, underworld_player)
		Register_Prox(hallguard7, Prox_HallGuard_7, range, underworld_player)
		Register_Prox(hallguard8, Prox_HallGuard_8, range, underworld_player)
		Register_Prox(hallguard9, Prox_HallGuard_9, range, underworld_player)
		Register_Prox(hallguard10, Prox_HallGuard_10, range, underworld_player)
		Register_Prox(hallguard11, Prox_HallGuard_11, range, underworld_player)
		Register_Prox(hallguard12, Prox_HallGuard_12, range, underworld_player)
		Register_Prox(hallguard13, Prox_HallGuard_13, range, underworld_player)
		Register_Prox(hallguard14, Prox_HallGuard_14, range, underworld_player)
		Register_Prox(hallguard15, Prox_HallGuard_15, range, underworld_player)
		Register_Prox(hallguard16, Prox_HallGuard_16, range, underworld_player)

		-- Register prox events for battle chatter and game events
		bactatank = Find_Nearest(doork, "EMPIRE_BUILDABLE_BACTA_TANK")
		Register_Death_Event(bactatank, PartOne_BactaGone)
		monitors_guards1 = Find_All_Objects_With_Hint("monitorsguards1")
		monitorguardsa = Find_Hint("STORMTROOPER_TEAM", "monitorguardsa")
		monitorguardsb = Find_Hint("STORMTROOPER_TEAM", "monitorguardsb")
		monitorguardsc = Find_Hint("STORMTROOPER_TEAM", "monitorguardsc")
		adeptonespawna = Find_Hint("STORY_TRIGGER_ZONE", "adeptonespawna")
		adeptonespawnb = Find_Hint("STORY_TRIGGER_ZONE", "adeptonespawnb")
		adeptonespawnc = Find_Hint("STORY_TRIGGER_ZONE", "adeptonespawnc")
		adepttwospawn = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawn")
		adeptfourspawn = Find_Hint("STORY_TRIGGER_ZONE", "adeptfourspawn")
		Register_Prox(adeptonespawna, Prox_IntroAdeptOne, 200, underworld_player)

		extraguys = Find_Hint("STORY_TRIGGER_ZONE", "extraguys")
		monitorsa = Find_Hint("EXPLODING_CONTAINER", "monitorsa")
		monitorsb1 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb1")
		monitorsb2 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb2")
		monitorsb3 = Find_Hint("UMP_INTERFACE_NODE", "monitorsb3")
		monitorsb4 = Find_Hint("UMP_INTERFACE_NODE", "monitorsb4")
		monitorsb5 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb5")
		monitorsb6 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb6")
		monitorsb7 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb7")
		monitorsb8 = Find_Hint("DROID_INTERFACE_STATION", "monitorsb8")
		Register_Death_Event(monitorsa, PartOne_MonitorsDead)

		highlightsithroom = Find_Hint("STORY_TRIGGER_ZONE", "highlightsithroom")
		sithwall = Find_Hint("UM05_MOVING_DOOR", "secretsithdoor") --

		holocron = Find_Hint("STORY_TRIGGER_ZONE", "sithholocron") --
		Register_Prox(holocron, Prox_SithHolocron, 75, underworld_player)

		nodea = Find_Hint("UM05_POWER_NODE", "powernodea")
		Register_Death_Event(nodea, PartThree_Node_A)
		nodeb = Find_Hint("UM05_POWER_NODE", "powernodeb")
		Register_Death_Event(nodeb, PartThree_Node_B)
		nodec = Find_Hint("UM05_POWER_NODE", "powernodec")
		Register_Death_Event(nodec, PartThree_Node_C)
		noded = Find_Hint("UM05_POWER_NODE", "powernoded")
		Register_Death_Event(noded, PartThree_Node_D)
		uraimeet = Find_Hint("STORY_TRIGGER_ZONE", "uraimeet")
		meetspot = Find_Hint("STORY_TRIGGER_ZONE", "tyberuraimeet") --
		adepttwospawna = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawna") --
		adepttwospawnb = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawnb") --
		adepttwospawnc = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawnc") --
		adepttwospawnd = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawnd") --
		adepttwospawne = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawne") --
		adepttwospawnf = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawnf") --
		adepttwospawng = Find_Hint("STORY_TRIGGER_ZONE", "adepttwospawng") --
		blowreactor = Find_Hint("STORY_TRIGGER_ZONE", "blowreactor")

		cuddlesstartfour = Find_Hint("STORY_TRIGGER_ZONE", "cuddlesstartfour")
		silristartfour = Find_Hint("STORY_TRIGGER_ZONE", "silristartfour")

		noticetroopers = Find_Hint("STORY_TRIGGER_ZONE", "noticetroopers") --
		activatetroopers = Find_Hint("STORY_TRIGGER_ZONE", "activatetroopers") --
		partfivetyber = Find_Hint("STORY_TRIGGER_ZONE", "partfive-tyber") --
		partfivesilri = Find_Hint("STORY_TRIGGER_ZONE", "partfive-silri") --
		partfivecuddles = Find_Hint("STORY_TRIGGER_ZONE", "partfive-cuddles") --
		partfivemdus = Find_Hint("STORY_TRIGGER_ZONE", "partfive-mdus") --
		partfiveextras = Find_Hint("STORY_TRIGGER_ZONE", "partfive-extras") --

		dt1 = Find_Hint("UM05_PROP_DTP_I", "dt1") --
		dt2 = Find_Hint("UM05_PROP_DTP_II", "dt2") --
		dt3 = Find_Hint("UM05_PROP_DTP_III", "dt3") --
		dt4 = Find_Hint("UM05_PROP_DTP_I", "dt4") --
		dt5 = Find_Hint("UM05_PROP_DTP_II", "dt5") --
		dt6 = Find_Hint("UM05_PROP_DTP_III", "dt6") --
		dt7 = Find_Hint("UM05_PROP_DTP_I", "dt7") --
		dt8 = Find_Hint("UM05_PROP_DTP_II", "dt8") --
		dt9 = Find_Hint("UM05_PROP_DTP_III", "dt9") --

		guardspawna = Find_Hint("STORY_TRIGGER_ZONE", "guardsa") --
		guardspawnb = Find_Hint("STORY_TRIGGER_ZONE", "guardsb") --
		mduspawn = Find_Hint("STORY_TRIGGER_ZONE", "mduspawn") --
		mdua = Find_Hint("STORY_TRIGGER_ZONE", "mdu1") --
		mdub = Find_Hint("STORY_TRIGGER_ZONE", "mdu2") --
		mduc = Find_Hint("STORY_TRIGGER_ZONE", "mdu3") --
		getmdu = Find_Hint("STORY_TRIGGER_ZONE", "getmdus") --
		Register_Prox(getmdu, Prox_GetMDUs, 75, underworld_player)
		movegroup = Find_Hint("STORY_TRIGGER_ZONE", "partfive-movegroup") --
		Register_Prox(movegroup, Prox_MoveGroup, 75, underworld_player)
		partfoursilri = Find_Hint("STORY_TRIGGER_ZONE", "partfive-silrispawn")
		partfourcuddles = Find_Hint("STORY_TRIGGER_ZONE", "partfive-cuddlesspawn")
		partfourmeet = Find_Hint("STORY_TRIGGER_ZONE", "partfivemeet")
		redguard1 = Find_Hint("IMP_GUARD_TEAM", "redguard1")
		redguard2 = Find_Hint("IMP_GUARD_TEAM", "redguard2")
		adeptthreespawn = Find_Hint("STORY_TRIGGER_ZONE", "adeptthreespawn")

		partvaultcamerastart = Find_Hint("STORY_TRIGGER_ZONE", "partvault-camerastart")
		urai_door = Find_Hint("STORY_TRIGGER_ZONE", "uraiworkdoor")
		spawnlefta = Find_Hint("STORY_TRIGGER_ZONE", "spawntroopsa")
		movetroopsa1 = Find_Hint("STORY_TRIGGER_ZONE", "movetroopsa1")
		movetroopsa2 = Find_Hint("STORY_TRIGGER_ZONE", "movetroopsa2")
		movetroopsa3 = Find_Hint("STORY_TRIGGER_ZONE", "movetroopsa3")
		spawnrightb = Find_Hint("STORY_TRIGGER_ZONE", "spawntroopsb")
		movetroopsb = Find_Hint("STORY_TRIGGER_ZONE", "movetroopsb")
		spawnrightc = Find_Hint("STORY_TRIGGER_ZONE", "spawntroopsc")
		movetroopsc = Find_Hint("STORY_TRIGGER_ZONE", "movetroopsc")
		landinga = Find_Hint("STORY_TRIGGER_ZONE", "landinga")
		landingb = Find_Hint("STORY_TRIGGER_ZONE", "landingb")
		landingc = Find_Hint("STORY_TRIGGER_ZONE", "landingc")
		landingd = Find_Hint("STORY_TRIGGER_ZONE", "landingd")
		landinge = Find_Hint("STORY_TRIGGER_ZONE", "landinge")

		urai_comp = Find_Hint("STORY_TRIGGER_ZONE", "uraiworkcomputer")
		invault = Find_Hint("STORY_TRIGGER_ZONE", "insidevault")
		Register_Prox(invault, Prox_InsideVault, 75, underworld_player)
		vault = Find_Hint("STORY_TRIGGER_ZONE", "reachedvault")
		--Register_Prox(vault, Prox_ReachedVault, 20, underworld_player)

		partsix_mdus = Find_Hint("STORY_TRIGGER_ZONE", "partsix-mdus")
		partsix_tyber = Find_Hint("STORY_TRIGGER_ZONE", "partsix-tyber")
		partsix_urai = Find_Hint("STORY_TRIGGER_ZONE", "partsix-urai")
		partsix_other = Find_Hint("STORY_TRIGGER_ZONE", "partsix-other")
		introadeptfour = Find_Hint("STORY_TRIGGER_ZONE", "introadeptfour")

		exitdoor = Find_Hint("STORY_TRIGGER_ZONE", "reachedexit") --
		Register_Prox(exitdoor, Prox_ReachedExit, 75, underworld_player)
		breakwall = Find_Hint("STORY_TRIGGER_ZONE", "breakwall") --
		juggernaut = Find_Hint("HAV_JUGGERNAUT", "juggernaut") --
		juggernaut.Set_Selectable(false)

		stopspawns = Find_Hint("STORY_TRIGGER_ZONE", "partsix-stopspawns")
		Register_Prox(stopspawns, Prox_StopSpawns, 100, underworld_player)

		missiles1 = Find_Hint("STORY_TRIGGER_ZONE", "missiles1")
		missiles2 = Find_Hint("STORY_TRIGGER_ZONE", "missiles2")
		missiles3 = Find_Hint("STORY_TRIGGER_ZONE", "missiles3")
		missiles4 = Find_Hint("STORY_TRIGGER_ZONE", "missiles4")
		missiles5 = Find_Hint("STORY_TRIGGER_ZONE", "missiles5")
		missiles6 = Find_Hint("STORY_TRIGGER_ZONE", "missiles6")
		missiles7 = Find_Hint("STORY_TRIGGER_ZONE", "missiles7")
		missiles8 = Find_Hint("STORY_TRIGGER_ZONE", "missiles8")

		mt3 = Create_Generic_Object("UNDERWORLD_TORPEDO_TURRET", missiles3.Get_Position(), neutral_player)
		mt4 = Create_Generic_Object("UNDERWORLD_TORPEDO_TURRET", missiles4.Get_Position(), neutral_player)
		mt5 = Create_Generic_Object("UNDERWORLD_TORPEDO_TURRET", missiles5.Get_Position(), neutral_player)
		mt6 = Create_Generic_Object("UNDERWORLD_TORPEDO_TURRET", missiles6.Get_Position(), neutral_player)

		-- setup end cinematic flags and camera positions


		-- set up some global mission state flags

		MissionPartOneStarted = false
		MissionPartOneDone = false
		VictoryCondition_BackdoorOpen = false
		VictoryCondition_MonitorControls = false
		VictoryCondition_AdeptsSpawned = false
		VictoryCondition_AdeptOneDead = false
		VictoryCondition_BactaGone = false

		MissionPartTwoStarted = false
		MissionPartTwoDone = false
		VictoryCondition_HolocronFound = false

		MissionPartThreeStarted = false
		MissionPartThreeDone = false
		VictoryCondition_Blown_A = false
		VictoryCondition_Blown_B = false
		VictoryCondition_Blown_C = false
		VictoryCondition_Blown_D = false
		VictoryCondition_GeneratorDead = false
		VictoryCondition_AdeptTwoDead = false
		VictoryCondition_EndTwo = false
		VictoryCondition_MeetTyber = false
		VictoryCondition_AdeptTwoSpawned = false

		MissionPartFourStarted = false
		MissionPartFourDone = false
		VictoryCondition_ReachedDoorE2 = false
		VictoryCondition_DarkTroopersSpawned = false
		VictoryCondition_DarkTroopersDead = false
		VictoryCondition_EndedFour = false
		VictoryCondition_AdeptThreeSpawned = false
		VictoryCondition_AdeptThreeDead = false

		MissionPartFiveStarted = false
		MissionPartFiveDone = false
		VictoryCondition_GuardsSpawned = false
		VictoryCondition_GuardsDead = false
		VictoryCondition_GotAccessCodes = false
		VictoryCondition_SeenVault = false

		MissionPartSixStarted = false
		MissionPartSixDone = false
		VictoryCondition_AdeptFourDead = false
		VictoryCondition_UraiBreakWall = false
		VictoryCondition_InJuggernaut = false
		VictoryCondition_StopSpawns = false
		VictoryCondition_ReachedExit = false

		DefeatCondition_TyberDead = false
		DefeatCondition_UraiDead = false
		DefeatCondition_SilriDead = false

		VictoryStarted = false
		DefeatStarted = false

		current_cine_id = nil
		CINE_Intro_Active = false
		CINE_Active_Adept_One = false
		CINE_Active_Intro_Silri = false
		CINE_Active_Urai_Nodes = false
		CINE_Active_Silri_Troopers = false
		CINE_Active_Grouped_Up = false
		CINE_Active_Outside_Vault = false
		CINE_Active_Final_Adept = false

		underworld_player.Disable_Bombing_Run(false)
		underworld_player.Disable_Orbital_Bombardment(true)
		underworld_player.Remove_Orbital_Bombardment(true)

		current_cine_id = Create_Thread("CINE_Start_Mission")
		--current_cine_id = Create_Thread("CINE_Adept_One")
		--current_cine_id = Create_Thread("CINE_Intro_Silri")
		--current_cine_id = Create_Thread("CINE_Urai_Nodes")
		--current_cine_id = Create_Thread("CINE_Silri_Troopers")
		--current_cine_id = Create_Thread("CINE_Grouped_Up")
		--current_cine_id = Create_Thread("CINE_Outside_Vault_Setup")
		--current_cine_id = Create_Thread("CINE_Final_Adept")

		Create_Thread("Main")
	elseif message == OnUpdate then
		--Do Nothing
	elseif message == OnExit then
		--Do Nothing
	end
end

function Main()
	while true do
		if MissionPartOneStarted and not MissionPartOneDone then
			if VictoryCondition_MonitorControls and VictoryCondition_AdeptOneDead then
				if TestValid(consolej) then
					if consolej.Get_Owner() ~= hostile_player then
						consolej.Change_Owner(hostile_player)
						consolej.Highlight(true)
						Add_Radar_Blip(consolej, "consolej")
					end
				end
				if not TestValid(doorj) then
					MissionPartOneDone = true
					MissionPartTwoStart = true
					Story_Event("UM11_MONITORSDISABLED")
					current_cine_id = Create_Thread("CINE_Intro_Silri")
				end
			end
			if VictoryCondition_AdeptsSpawned then
				if not VictoryCondition_AdeptOneDead then
					if not TestValid(adeptonea) and
						not TestValid(adeptoneb) and
						not TestValid(adeptonec) then
						VictoryCondition_AdeptOneDead = true
						Open_AdeptOneDoor()
						Story_Event("UM11_OBJECTIVE_02_DONE")
					end
				end
			end
		end
		if MissionPartTwoStarted then
			if not MissionPartTwoDone then
				if VictoryCondition_HolocronFound then
					MissionPartTwoDone = true
					MissionPartThreeStart = true
					Story_Event("UM11_FOUNDHOLOCRON")
					Create_Thread("MissionObjective_PartThree")
				end
			end
		end
		if MissionPartThreeStarted then
			if not MissionPartThreeDone then
				if VictoryCondition_Blown_A and
					VictoryCondition_Blown_B and
					VictoryCondition_Blown_C and
					VictoryCondition_Blown_D then
					if not VictoryCondition_GeneratorDead then
						VictoryCondition_GeneratorDead = true
						turrets = Find_All_Objects_Of_Type("EMPIRE_ANTI_INFANTRY_TURRET")
						for k, unit in pairs(turrets) do
							if TestValid(unit) then
								if unit.Get_Owner() == empire_player then
									unit.Take_Damage(9999)
								end
							end
						end
						Story_Event("UM11_OBJECTIVE_04_DONE")
					end
				end
				if VictoryCondition_AdeptTwoSpawned then
					if not VictoryCondition_AdeptTwoDead then
						if not TestValid(adepttwoa) and
						   not TestValid(adepttwob) and
						   not TestValid(adepttwoc) and
						   not TestValid(adepttwod) and
						   not TestValid(adepttwoe) and
						   not TestValid(adepttwof) and
						   not TestValid(adepttwog) and
						   --not TestValid(adepttwoh) and
						   --not TestValid(adepttwoi) and
						   --not TestValid(adepttwoj) and
						   --not TestValid(adepttwok) and
						   --not TestValid(adepttwol) and
						   --not TestValid(adepttwom) and
						   not TestValid(adepttwon) then
							Story_Event("UM11_OBJECTIVE_05_DONE")
							VictoryCondition_AdeptTwoDead = true
						end
					end
				end
				if VictoryCondition_GeneratorDead and VictoryCondition_AdeptTwoDead then
					if not VictoryCondition_EndTwo then
						VictoryCondition_EndTwo = true
						Create_Thread("PartThree_UraiDone")
					end
				end
				if VictoryCondition_MeetTyber then
					MissionPartThreeDone = true
					MissionPartFourStart = true
					current_cine_id = Create_Thread("CINE_Silri_Troopers")
				end
			end
		end
		if MissionPartFourStarted then
			if not MissionPartFourDone then
				if VictoryCondition_DarkTroopersSpawned then
					if not TestValid(dt1a) and
						not TestValid(dt2a) and
						not TestValid(dt3a) and
						not TestValid(dt4a) and
						not TestValid(dt5a) and
						not TestValid(dt6a) and
						not TestValid(dt7a) and
						not TestValid(dt8a) and
						not TestValid(dt9a) then
						if not VictoryCondition_DarkTroopersDead then
							Story_Event("UM11_OBJECTIVE_06A_DONE")
							VictoryCondition_DarkTroopersDead = true
							Create_Thread("PartFive_SetupGroup")
						end
					end
				end
				if VictoryCondition_DarkTroopersDead and VictoryCondition_EndedFour then
					MissionPartFourDone = true
					MissionPartFiveStarted = true
					Create_Thread("MissionObjective_PartFive")
				end
			end
		end
		if MissionPartFiveStarted then
			if not MissionPartFiveDone then
				if VictoryCondition_AdeptThreeSpawned then
					if not VictoryCondition_AdeptThreeDead then
						if not TestValid(adeptthreea) and
							not TestValid(adeptthreeb) and
							not TestValid(adeptthreec) then
							Story_Event("UM11_OBJECTIVE_07_DONE")
							VictoryCondition_AdeptThreeDead = true
						end
					end
				end
				if VictoryCondition_GuardsSpawned then
					if not TestValid(troopsa) and
					   not TestValid(troopsb) and
					   not TestValid(troopsc) and
					   not TestValid(troopsd) and
					   not TestValid(troopse) then
						if not VictoryCondition_GuardsDead then
						   	VictoryCondition_GuardsDead = true
							Create_Thread("Open_Door_h")
							urai_comp.Highlight(true)
							Add_Radar_Blip(urai_comp, "urai_comp")
							consolevault.Change_Owner(hostile_player)
							Story_Event("CHATTER_51")
						end
					end
				end
				if VictoryCondition_AdeptThreeDead and
				   VictoryCondition_GuardsSpawned and
				   VictoryCondition_GuardsDead and
				   VictoryCondition_GotAccessCodes and
				   VictoryCondition_SeenVault then
					MissionPartFiveDone = true
					MissionPartSixStart = true
					Create_Thread("MissionObjective_PartSix")
				end
			end
		end
		if MissionPartSixStarted then
			if not MissionPartSixDone then
				if VictoryCondition_AdeptFourDead then
					if not VictoryCondition_UraiBreakWall then
						VictoryCondition_UraiBreakWall = true
						Create_Thread("PartSix_OpenExit")
					end
				end
				if VictoryCondition_AdeptFourDead and VictoryCondition_UraiBreakWall and VictoryCondition_ReachedExit then
					MissionPartSixDone = true
				end
			end
		end
		if MissionPartOneDone and
		   MissionPartTwoDone and
		   MissionPartThreeDone and
		   MissionPartFourDone and
		   MissionPartFiveDone and
		   MissionPartSixDone then
			if VictoryCondition_MonitorControls and
			   VictoryCondition_AdeptOneDead and
			   VictoryCondition_HolocronFound and
			   VictoryCondition_GeneratorDead and
			   VictoryCondition_AdeptTwoDead and
			   VictoryCondition_DarkTroopersDead and
			   VictoryCondition_GuardsDead and
			   VictoryCondition_GotAccessCodes and
			   VictoryCondition_AdeptFourDead and
			   VictoryCondition_UraiBreakWall and
			   VictoryCondition_ReachedExit	then
				if not VictoryStarted then
					Story_Event("UM11_OBJECTIVE_01_DONE")
					VictoryStarted = true
					Create_Thread("EndMissionVictory")
				end
			end
		end
		if DefeatCondition_TyberDead or DefeatCondition_UraiDead or DefeatCondition_SilriDead then
			if not DefeatStarted then
				DefeatStarted = true
				Create_Thread("EndMissionDefeat")
			end
		end
		Sleep(.5)
	end
end




function Setup_Cinematic_Definitions()
	cambalconypos = Find_Hint("STORY_TRIGGER_ZONE", "cambalconypos")
	cambalconylook = Find_Hint("STORY_TRIGGER_ZONE", "cambalconylook")
	camcitypos = Find_Hint("STORY_TRIGGER_ZONE", "camcitypos")
	camcitylook = Find_Hint("STORY_TRIGGER_ZONE", "camcitylook")
	camwindowpos = Find_Hint("STORY_TRIGGER_ZONE", "camwindowpos")
	cambalcsilri = Find_Hint("STORY_TRIGGER_ZONE", "cambalcsilri")
	cambalctyber = Find_Hint("STORY_TRIGGER_ZONE", "cambalctyber")
	cambalcurai = Find_Hint("STORY_TRIGGER_ZONE", "cambalcurai")
	camentrancepos = Find_Hint("STORY_TRIGGER_ZONE", "camentrancepos")
	camentrancelook = Find_Hint("STORY_TRIGGER_ZONE", "camentrancelook")

	cinbtyberstart = Find_Hint("STORY_TRIGGER_ZONE", "cinbtyberstart")
	cinbtybergoto = Find_Hint("STORY_TRIGGER_ZONE", "cinbtybergoto")
	cinbirds1 = Find_Hint("BIRD_LIGHT_COLOR", "birds1")
	cinbirds2 = Find_Hint("BIRD_LIGHT_COLOR", "birds2")
	cinbirds3 = Find_Hint("BIRD_LIGHT_COLOR", "birds3")
	cinbirds4 = Find_Hint("BIRD_LIGHT_COLOR", "birds4")

	cinbarguys1 = Find_Hint("URBAN_CIVILIAN_A", "cinbarguys1")
	cinbarguys2 = Find_Hint("URBAN_CIVILIAN_A", "cinbarguys2")
	cinbarguys3 = Find_Hint("URBAN_CIVILIAN_B", "cinbarguys3")
	cinbarguys4 = Find_Hint("URBAN_CIVILIAN_C", "cinbarguys4")
	cinbarguys5 = Find_Hint("TWILEK_FEMALE", "cinbarguys5")
	cinbarguys6 = Find_Hint("TWILEK_FEMALE", "cinbarguys6")
	cinbarguys7 = Find_Hint("SWAMP_CIVILIAN_B", "cinbarguys7")
	cinbarguys8 = Find_Hint("MON_CALAMARI_CIVILIAN", "cinbarguys8")

	balconytyber = Find_Hint("STORY_TRIGGER_ZONE", "balconytyber")
	balconysilri = Find_Hint("STORY_TRIGGER_ZONE", "balconysilri")
	balconyurai = Find_Hint("STORY_TRIGGER_ZONE", "balconyurai")

	cambalconypan = Find_Hint("STORY_TRIGGER_ZONE", "cambalconypan")
	camintropos = Find_Hint("STORY_TRIGGER_ZONE", "camintropos")
	camintrolook = Find_Hint("STORY_TRIGGER_ZONE", "camintrolook")
	camintrofloorpos = Find_Hint("STORY_TRIGGER_ZONE", "camintrofloorpos")
	camintrofloorpan = Find_Hint("STORY_TRIGGER_ZONE", "camintrofloorpan")
	camintrofloorlook = Find_Hint("STORY_TRIGGER_ZONE", "camintrofloorlook")

	introtyber = Find_Hint("STORY_TRIGGER_ZONE", "introtyber")
	introguard = Find_Hint("STORY_TRIGGER_ZONE", "introguard")

	camadeptonepos = Find_Hint("STORY_TRIGGER_ZONE", "camadeptonepos")
	camadeptonelook = Find_Hint("STORY_TRIGGER_ZONE", "camadeptonelook")
	camonepos = Find_Hint("STORY_TRIGGER_ZONE", "camonepos")
	camonelook = Find_Hint("STORY_TRIGGER_ZONE", "camonelook")
	camonepospan = Find_Hint("STORY_TRIGGER_ZONE", "camonepospan")
	camonelookpan = Find_Hint("STORY_TRIGGER_ZONE", "camonelookpan")

	cineadeptonespawns = Find_Hint("STORY_TRIGGER_ZONE", "cineadeptonespawns")
	cineadeptonemouse = Find_Hint("STORY_TRIGGER_ZONE", "cineadeptonemouse")
	cineadeptonetyber = Find_Hint("STORY_TRIGGER_ZONE", "cineadeptonetyber")
	cinemousegoto1 = Find_Hint("STORY_TRIGGER_ZONE", "cinemousegoto1")
	cinemousegoto2 = Find_Hint("STORY_TRIGGER_ZONE", "cinemousegoto2")
	cinemousegoto3 = Find_Hint("STORY_TRIGGER_ZONE", "cinemousegoto3")

	camintrosilripos = Find_Hint("STORY_TRIGGER_ZONE", "camintrosilripos")
	camintrosilrilook = Find_Hint("STORY_TRIGGER_ZONE", "camintrosilrilook")
	camsilriadeptpos = Find_Hint("STORY_TRIGGER_ZONE", "camsilriadeptpos")
	camsilriadeptlook = Find_Hint("STORY_TRIGGER_ZONE", "camsilriadeptlook")
	camtwirlsilristart = Find_Hint("STORY_TRIGGER_ZONE", "camtwirlsilristart")
	camtwirlsilriend = Find_Hint("STORY_TRIGGER_ZONE", "camtwirlsilriend")
	camfightpos = Find_Hint("STORY_TRIGGER_ZONE", "camfightpos")
	camfightlook = Find_Hint("STORY_TRIGGER_ZONE", "camfightlook")
	camadeptdiepos = Find_Hint("STORY_TRIGGER_ZONE", "camadeptdiepos")

	cinesilri = Find_Hint("STORY_TRIGGER_ZONE", "cinesilri")
	cinesilriadept = Find_Hint("STORY_TRIGGER_ZONE", "cinesilriadept")
	cinesilriadeptmoveto = Find_Hint("STORY_TRIGGER_ZONE", "cinesilriadeptmoveto")
	cinerancorsummon = Find_Hint("STORY_TRIGGER_ZONE", "cinerancorsummon")

	camholeposstart = Find_Hint("STORY_TRIGGER_ZONE", "camholeposstart")
	camholelookstart = Find_Hint("STORY_TRIGGER_ZONE", "camholelookstart")
	camholeposend = Find_Hint("STORY_TRIGGER_ZONE", "camholeposend")
	camholelookend = Find_Hint("STORY_TRIGGER_ZONE", "camholelookend")
	camuraifaceoffpos = Find_Hint("STORY_TRIGGER_ZONE", "camuraifaceoffpos")
	camuraifaceofflook = Find_Hint("STORY_TRIGGER_ZONE", "camuraifaceofflook")
	camholopos = Find_Hint("STORY_TRIGGER_ZONE", "camholopos")
	camhololook = Find_Hint("STORY_TRIGGER_ZONE", "camhololook")
	camocronpos = Find_Hint("STORY_TRIGGER_ZONE", "camocronpos")
	camocronlook = Find_Hint("STORY_TRIGGER_ZONE", "camocronlook")

	sithholofx = Find_Hint("STORY_TRIGGER_ZONE", "sithholofx")
	cuddlesholospawn = Find_Hint("STORY_TRIGGER_ZONE", "cuddlesholospawn")
	silriholospawn = Find_Hint("STORY_TRIGGER_ZONE", "silriholospawn")
	cineadepttwospawn = Find_Hint("STORY_TRIGGER_ZONE", "cineadepttwospawn")
	cineadepttwomoveto = Find_Hint("STORY_TRIGGER_ZONE", "cineadepttwomoveto")

	camsilrileavepos = Find_Hint("STORY_TRIGGER_ZONE", "camsilrileavepos")
	camsilrileavelook = Find_Hint("STORY_TRIGGER_ZONE", "camsilrileavelook")
	camsilrileavepos = Find_Hint("STORY_TRIGGER_ZONE", "camsilrileavepos")
	camsilrileavelook = Find_Hint("STORY_TRIGGER_ZONE", "camsilrileavelook")

	camdddpos = Find_Hint("STORY_TRIGGER_ZONE", "camdddpos")
	camdddlook = Find_Hint("STORY_TRIGGER_ZONE", "camdddlook")
	camfindsilripos = Find_Hint("STORY_TRIGGER_ZONE", "camfindsilripos")
	camfindsilrilook = Find_Hint("STORY_TRIGGER_ZONE", "camfindsilrilook")
	cammeetsilripos = Find_Hint("STORY_TRIGGER_ZONE", "cammeetsilripos")
	cammeetsilrilook = Find_Hint("STORY_TRIGGER_ZONE", "cammeetsilrilook")

	silridddspawn = Find_Hint("STORY_TRIGGER_ZONE", "silridddspawn")
	cuddlesdddspawn = Find_Hint("STORY_TRIGGER_ZONE", "cuddlesdddspawn")
	trooperdddspawn = Find_Hint("STORY_TRIGGER_ZONE", "trooperdddspawn")
	cineddduraispawn = Find_Hint("STORY_TRIGGER_ZONE", "cineddduraispawn")
	cinedddtyberspawn = Find_Hint("STORY_TRIGGER_ZONE", "cinedddtyberspawn")
	uraidddgoto = Find_Hint("STORY_TRIGGER_ZONE", "uraidddgoto")
	tyberdddgoto = Find_Hint("STORY_TRIGGER_ZONE", "tyberdddgoto")

	camuraiworkpos = Find_Hint("STORY_TRIGGER_ZONE", "camuraiworkpos")
	camuraiworklook = Find_Hint("STORY_TRIGGER_ZONE", "camuraiworklook")
	camdoorclosepos = Find_Hint("STORY_TRIGGER_ZONE", "camdoorclosepos")
	camdoorcloselook = Find_Hint("STORY_TRIGGER_ZONE", "camdoorcloselook")
	camoutvtyberpos = Find_Hint("STORY_TRIGGER_ZONE", "camoutvtyberpos")
	camoutvtyberlook = Find_Hint("STORY_TRIGGER_ZONE", "camoutvtyberlook")

	fivesilrirunto = Find_Hint("STORY_TRIGGER_ZONE", "fivesilrirunto")
	fivetyberrunto = Find_Hint("STORY_TRIGGER_ZONE", "fivetyberrunto")
	fivecuddlesrunto = Find_Hint("STORY_TRIGGER_ZONE", "fivecuddlesrunto")
	fivemdusrunto = Find_Hint("STORY_TRIGGER_ZONE", "fivemdusrunto")
	fiveextrasrunto = Find_Hint("STORY_TRIGGER_ZONE", "fiveextrasrunto")
	fiveuraispawn = Find_Hint("STORY_TRIGGER_ZONE", "fiveuraispawn")

	camlastpos = Find_Hint("STORY_TRIGGER_ZONE", "camlastpos")
	camlastlook = Find_Hint("STORY_TRIGGER_ZONE", "camlastlook")
	camlastpan = Find_Hint("STORY_TRIGGER_ZONE", "camlastpan")
	camstraightdown1 = Find_Hint("STORY_TRIGGER_ZONE", "camstraightdown1")
	camstraightdown2 = Find_Hint("STORY_TRIGGER_ZONE", "camstraightdown2")
	camstraightdown3 = Find_Hint("STORY_TRIGGER_ZONE", "camstraightdown3")
	camstraightdown4 = Find_Hint("STORY_TRIGGER_ZONE", "camstraightdown4")
	camsilrityberpos = Find_Hint("STORY_TRIGGER_ZONE", "camsilrityberpos")
	camsilrityberlook = Find_Hint("STORY_TRIGGER_ZONE", "camsilrityberlook")

	lasttyberspawn = Find_Hint("STORY_TRIGGER_ZONE", "lasttyberspawn")
	lasttybergoto = Find_Hint("STORY_TRIGGER_ZONE", "lasttybergoto")
	lastsilrispawn = Find_Hint("STORY_TRIGGER_ZONE", "lastsilrispawn")
	lastsilrigoto = Find_Hint("STORY_TRIGGER_ZONE", "lastsilrigoto")
	lasturaispawn = Find_Hint("STORY_TRIGGER_ZONE", "lasturaispawn")
	lasturaigoto = Find_Hint("STORY_TRIGGER_ZONE", "lasturaigoto")
	lastcuddlesspawn = Find_Hint("STORY_TRIGGER_ZONE", "lastcuddlesspawn")
	lastcuddlesgoto = Find_Hint("STORY_TRIGGER_ZONE", "lastcuddlesgoto")
	lastadeptspawn = Find_Hint("STORY_TRIGGER_ZONE", "lastadeptspawn")
	lasttele1 = Find_Hint("STORY_TRIGGER_ZONE", "lasttele1")
	lasttele2 = Find_Hint("STORY_TRIGGER_ZONE", "lasttele2")
	lasttele3 = Find_Hint("STORY_TRIGGER_ZONE", "lasttele3")
	lasttele4 = Find_Hint("STORY_TRIGGER_ZONE", "lasttele4")

	finaltyberspot = Find_Hint("STORY_TRIGGER_ZONE", "finaltyberspot")
	finalsilrispot = Find_Hint("STORY_TRIGGER_ZONE", "finalsilrispot")
	finaluraispot = Find_Hint("STORY_TRIGGER_ZONE", "finaluraispot")
	finalcuddlesspot = Find_Hint("STORY_TRIGGER_ZONE", "finalcuddlesspot")
	finalextrasspot = Find_Hint("STORY_TRIGGER_ZONE", "finalextrasspot")
	finalmdusspot = Find_Hint("STORY_TRIGGER_ZONE", "finalmdusspot")

	endcinecampos = Find_Hint("STORY_TRIGGER_ZONE", "endcinecampos")
	endcinecamlook = Find_Hint("STORY_TRIGGER_ZONE", "endcinecamlook")

	endcinejugger = Find_Hint("HAV_JUGGERNAUT", "endcinejugger")
	endcinejuggergoto = Find_Hint("STORY_TRIGGER_ZONE", "endcinejuggergoto")
end

-- delay a short time and then start the game
function CINE_Start_Mission()
	Cancel_Fast_Forward()
	CINE_Intro_Active = true

	Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	Play_Music("Structure_Cantina_Music_Event")

	endcinebox.Hide(true)
	endcinebox1.Hide(true)
	int_sky.Hide(true)
	ext_sky.Hide(false)

	tyber_zann.Hide(true)
	tyber_zann.Prevent_All_Fire(true)

	cin_tyber = Create_Generic_Object("TYBER_ZANN_CAMPAIGN", introtyber.Get_Position(), underworld_player)
	cin_tyber.Suspend_Locomotor(true)
	cin_tyber.Prevent_All_Fire(true)
	cin_tyber.Face_Immediate(introguard)
	cin_guard = Create_Generic_Object("GENERIC_FIELD_COMMANDER_EMPIRE", introguard.Get_Position(), empire_player)
	cin_tyber.Suspend_Locomotor(true)
	cin_guard.Prevent_All_Fire(true)
	cin_guard.Face_Immediate(introtyber)

	cin_btyber = Create_Generic_Object("TYBER_ZANN_CAMPAIGN", balconytyber.Get_Position(), neutral_player)
	cin_btyber.Teleport_And_Face(balconytyber)
	cin_bsilri = Create_Generic_Object("SILRI", balconysilri.Get_Position(), neutral_player)
	cin_bsilri.Teleport_And_Face(balconysilri)
	cin_burai = Create_Generic_Object("URAI_FEN", balconyurai.Get_Position(), neutral_player)
	cin_burai.Teleport_And_Face(balconyurai)

	cinbarguys1.Suspend_Locomotor(true)
	cinbarguys2.Suspend_Locomotor(true)
	cinbarguys3.Suspend_Locomotor(true)
	cinbarguys4.Suspend_Locomotor(true)
	cinbarguys5.Suspend_Locomotor(true)
	cinbarguys6.Suspend_Locomotor(true)
	cinbarguys7.Suspend_Locomotor(true)
	cinbarguys8.Suspend_Locomotor(true)
	Sleep(1.5)

	Fade_Screen_In(1)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camcitypos, 0, 0, 75, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camcitylook, 0, 0, 75, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camwindowpos, 10, -5, -5, 205, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(cin_bsilri, 10, 0, 0, 0, 0, 0, 0, 0)
	Sleep(10)

	cin_btyber.Play_Animation("cinematic", true, 2)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_41")
	while not State_Mission_41_Done	do Sleep(.5) end

	Set_Cinematic_Camera_Key(cambalconypos, 0, 0, 50, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cambalconylook, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalconypan, 4, 0, 0, 50, 0, 0, 0, 0)
	cin_btyber.Play_Animation("cinematic", true, 2)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_42")
	while not State_Mission_42_Done	do Sleep(.5) end

	-- camera focus urai
	Set_Cinematic_Camera_Key(cin_btyber, 40, 45, 45, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_burai, 0, 0, 5, 0, 0, 0, 0)
	--Transition_Cinematic_Camera_Key(cambalcurai, 3, 0, 0, 37, 0, 0, 0, 0)
	cin_btyber.Play_Animation("idle", true, 0)
	cin_burai.Play_Animation("cinematic", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_43")
	while not State_Mission_43_Done	do Sleep(.5) end

	-- camera focus tyber
	Set_Cinematic_Camera_Key(cambalctyber, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_btyber, 0, 0, 7, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalctyber, 3, 0, 0, 32, 0, 0, 0, 0)
	cin_btyber.Play_Animation("cinematic", true, 2)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_44")
	while not State_Mission_44_Done	do Sleep(.5) end

	-- camera focus silri
	cin_bsilri.Turn_To_Face(cin_btyber)
	Set_Cinematic_Camera_Key(cambalcsilri, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_bsilri, 0, 0, 5, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalcsilri, 3, 0, 0, 37, 0, 0, 0, 0)
	cin_btyber.Play_Animation("idle", true, 0)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("cinematic", true, 0)
	Story_Event("CHATTER_45")
	while not State_Mission_45_Done	do Sleep(.5) end

	-- camera focus tyber
	Set_Cinematic_Camera_Key(cambalctyber, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_btyber, 0, 0, 7, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalctyber, 3, 0, 0, 32, 0, 0, 0, 0)
	cin_btyber.Play_Animation("cinematic", true, 2)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_46")
	while not State_Mission_46_Done	do Sleep(.5) end

	-- camera focus silri
	cin_bsilri.Turn_To_Face(cin_btyber)
	Set_Cinematic_Camera_Key(cambalcsilri, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_bsilri, 0, 0, 5, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalcsilri, 3, 0, 0, 37, 0, 0, 0, 0)
	cin_btyber.Play_Animation("idle", true, 0)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("cinematic", true, 0)
	Story_Event("CHATTER_47")
	while not State_Mission_47_Done	do Sleep(.5) end

	cin_bsilri.Suspend_Locomotor(false)
	cin_bsilri.Move_To(cambalconypos)

	Sleep(2)

	-- camera focus urai
	--Set_Cinematic_Camera_Key(cambalcurai, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Camera_Key(cin_btyber, 40, 45, 45, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_burai, 0, 0, 5, 0, 0, 0, 0)
	--Transition_Cinematic_Camera_Key(cambalcurai, 3, 0, 0, 37, 0, 0, 0, 0)
	cin_btyber.Play_Animation("idle", true, 0)
	cin_burai.Play_Animation("cinematic", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_48")
	while not State_Mission_48_Done	do Sleep(.5) end

	-- camera focus tyber
	Set_Cinematic_Camera_Key(cambalctyber, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_btyber, 0, 0, 7, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(cambalctyber, 3, 0, 0, 32, 0, 0, 0, 0)
	cin_btyber.Play_Animation("cinematic", true, 2)
	cin_burai.Play_Animation("idle", true, 0)
	cin_bsilri.Play_Animation("idle", true, 0)
	Story_Event("CHATTER_49")
	while not State_Mission_49_Done	do Sleep(.5) end

	Fade_Screen_Out(2)
	Sleep(2)
	Stop_All_Music()
	Resume_Mode_Based_Music()

	int_sky.Hide(false)
	ext_sky.Hide(true)

	cin_btyber.Teleport_And_Face(cinbtyberstart)
	cin_btyber.Override_Max_Speed(.7)
	cin_btyber.Move_To(cinbtybergoto)

	Set_Cinematic_Camera_Key(camentrancepos, 0, 0, 100, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camentrancelook, 0, 0, 0, 0, 0, 0, 0)
	Fade_Screen_In(1)
	Sleep(1)

	Transition_Cinematic_Camera_Key(camentrancepos, 3, 0, 0, 110, 0, 0, 0, 0)
	Sleep(3)

	Fade_Screen_Out(1)
	Sleep(1)
	Fade_Screen_In(1)
	Set_Cinematic_Camera_Key(camintrofloorpos, 0, 0, 2, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camintrofloorlook, 0, 0, 8, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camintrofloorpan, 5, 0, 0, 14, 0, 0, 0, 0)
	Sleep(2)
	Story_Event("CHATTER_12")
	while not State_Mission_12_Done	do Sleep(.5) end

	Set_Cinematic_Camera_Key(camintropos, 0, 0, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camintrolook, 0, 0, 5, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(cin_tyber, 5, 0, 0, 10, 0, 0, 0, 0)
	Sleep(1)

	cin_tyber.Prevent_All_Fire(false)
	cin_tyber.Attack_Target(cin_guard)
	Sleep(1)
	cin_guard.Take_Damage(9999)

	Sleep(1)
	Story_Event("CHATTER_13")

	while not State_Mission_13_Done	do Sleep(.5) end

	Fade_Screen_Out(1)
	Sleep(1)
	Create_Thread("Intro_Cine_Cleanup")
end

function Intro_Cine_Cleanup()
	CINE_Intro_Active = false
	current_cine_id = nil

	tyber_zann.Prevent_All_Fire(false)
	tyber_zann.Hide(false)

	ext_sky.Hide(true)
	int_sky.Hide(false)
	endcinebox.Hide(false)
	endcinebox1.Hide(false)

	if TestValid(cin_tyber) then cin_tyber.Despawn() end
	if TestValid(cin_guard) then cin_guard.Despawn() end
	if TestValid(cin_btyber) then cin_btyber.Despawn() end
	if TestValid(cin_bsilri) then cin_bsilri.Despawn() end
	if TestValid(cin_burai) then cin_burai.Despawn() end

	if TestValid(cinbarguys1) then cinbarguys1.Despawn() end
	if TestValid(cinbarguys2) then cinbarguys2.Despawn() end
	if TestValid(cinbarguys3) then cinbarguys3.Despawn() end
	if TestValid(cinbarguys4) then cinbarguys4.Despawn() end
	if TestValid(cinbarguys5) then cinbarguys5.Despawn() end
	if TestValid(cinbarguys6) then cinbarguys6.Despawn() end
	if TestValid(cinbarguys7) then cinbarguys7.Despawn() end
	if TestValid(cinbarguys8) then cinbarguys8.Despawn() end

	if TestValid(cinbirds1) then cinbirds1.Despawn() end
	if TestValid(cinbirds2) then cinbirds2.Despawn() end
	if TestValid(cinbirds3) then cinbirds3.Despawn() end
	if TestValid(cinbirds4) then cinbirds4.Despawn() end

	Stop_All_Music()
	Resume_Mode_Based_Music()

	End_Cinematic_Camera()
	Letter_Box_Out(0)
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(1)

	Create_Thread("MissionObjective_PartOne")
	--juggernaut.Despawn()
	--Create_Thread("EndMissionVictory")
end

function Story_Handle_Esc()
	if CINE_Intro_Active then
		CINE_Intro_Active = false
		Thread.Kill(current_cine_id)
		Create_Thread("Intro_Cine_Cleanup")
	end
--	if CINE_Active_Adept_One then
--		CINE_Active_Adept_One = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Adept_One_Cleanup")
--	end
--	if CINE_Active_Intro_Silri then
--		CINE_Active_Intro_Silri = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Intro_Silri_Cleanup")
--	end
--	if CINE_Active_Urai_Nodes then
--		CINE_Active_Urai_Nodes = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Urai_Nodes_Cleanup")
--	end
--	if CINE_Active_Silri_Troopers then
--		CINE_Active_Silri_Troopers = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Silri_Troopers_Cleanup")
--	end
--	if CINE_Active_Grouped_Up then
--		CINE_Active_Grouped_Up = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Grouped_Up_Cleanup")
--	end
--	if CINE_Active_Outside_Vault then
--		CINE_Active_Outside_Vault = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Outside_Vault_Cleanup")
--	end
--	if CINE_Active_Final_Adept then
--		CINE_Active_Final_Adept = false
--		Thread.Kill(current_cine_id)
--		Create_Thread("CINE_Final_Adept_Cleanup")
--	end
end

-- all functions for opening/closing doors
function Open_Vault()
	vaulta.Play_Animation("Cinematic",false,1)
	vaultb.Play_Animation("Cinematic",false,1)
	Register_Timer(Remove_Vault,2)
	Story_Event("CHATTER_51")
end
function Remove_Vault()
	vaulta.Despawn()
	vaultb.Despawn()
end

function Open_Door_i()
	Register_Timer(Remove_Door_i,2)
	doori.Play_Animation("Cinematic",false,1)
end
function Remove_Door_i()
	doori.Highlight(false)
	Remove_Radar_Blip("doori")
	doori.Despawn()
end

function Open_Door_k()
	Register_Timer(Remove_Door_k,2)
	doork.Play_Animation("Cinematic",false,1)
end
function Remove_Door_k()
	doork.Despawn()
	VictoryCondition_BackdoorOpen = true
	Create_Thread("Hunt_Underworld", monitors_guards1 )
end

function Open_Door_j()
	consolej.Highlight(false)
	Remove_Radar_Blip("consolej")

	Register_Timer(Remove_Door_j,2)
	doorj.Play_Animation("Cinematic",false,1)
	Fade_Screen_Out(2)
end
function Remove_Door_j()
	doorj.Despawn()
end

function Open_Door_c()
	Register_Timer(Remove_Door_c,2)
	doorc1.Play_Animation("Cinematic",false,1)
	doorc2.Play_Animation("Cinematic",false,1)
end
function Remove_Door_c()
	doorc1.Despawn()
	doorc2.Despawn()
end

function Open_Door_e()
	Register_Timer(Remove_Door_e,2)
	doore.Play_Animation("Cinematic",false,1)

	consolee.Highlight(false)
	Remove_Radar_Blip("consolee")
	highlightsithroom.Highlight(true)
	Add_Radar_Blip(highlightsithroom, "highlightsithroom")
end
function Remove_Door_e()
	doore.Despawn()
end

function Open_Door_f()
	Register_Timer(Remove_Door_f,2)
	doorf.Play_Animation("Cinematic",false,1)
end
function Remove_Door_f()
	doorf.Despawn()
end

function Open_Door_h()
	Register_Timer(Remove_Door_h,2)
	doorh.Play_Animation("Cinematic",false,1)
end
function Remove_Door_h()
	doorh.Despawn()
end

function Open_Door_a()
	Register_Timer(Remove_Door_a,2)
	doora.Play_Animation("Cinematic",false,1)
end
function Remove_Door_a()
	doora.Despawn()
end

function Open_Panel()
	Register_Timer(Remove_Panel,2)
	panel.Play_Animation("Cinematic",false,1)
end
function Remove_Panel()
	panel.Despawn()
end

function Open_AdeptOneDoor()
	Register_Timer(Remove_AdeptOneDoor, 2)
	adeptonedoor.Play_Animation("Cinematic",false,1)
end
function Remove_AdeptOneDoor()
	adeptonedoor.Despawn()
	Create_Thread("Hunt_Underworld", {monitorguardsc})
end

function Open_SithDoor()
	-- when wall is destroyed, remove black covers
	highlightsithroom.Highlight(false)
	Remove_Radar_Blip("highlightsithroom")
	holocron.Highlight(true)
	Add_Radar_Blip(holocron, "holocron")
	Register_Timer(Remove_SithDoor,2)
	sithwall.Play_Animation("Cinematic",false,1)
end
function Remove_SithDoor()
	sithwall.Despawn()
end

--mission objective and flow handlers
function MissionObjective_PartOne()
	doorh.Play_Animation("Cinematic",false,2)
	adeptonedoor.Play_Animation("Cinematic",false,0)
	sithwall.Play_Animation("Cinematic",false,0)
	doork.Play_Animation("Cinematic",false,0)
	doori.Play_Animation("Cinematic",false,0)
	doorj.Play_Animation("Cinematic",false,0)
	doorc1.Play_Animation("Cinematic",false,0)
	doorc2.Play_Animation("Cinematic",false,0)
	doore.Play_Animation("Cinematic",false,0)
	doora.Play_Animation("Cinematic",false,0)
	vaulta.Play_Animation("Cinematic",false,0)
	vaultb.Play_Animation("Cinematic",false,0)

	silri.Set_In_Limbo(true)
	silri.Hide(true)
	silri.Set_Selectable(false)
	silri.Make_Invulnerable(true)

	urai_fen.Set_In_Limbo(true)
	urai_fen.Hide(true)
	urai_fen.Set_Selectable(false)
	urai_fen.Make_Invulnerable(true)

	juggernaut.Change_Owner(neutral_player)
	juggernaut.Make_Invulnerable(true)

	Fade_Screen_In(1)
	Point_Camera_At(tyber_zann)
	underworld_player.Select_Object(tyber_zann)

	Fade_Screen_In(1)
	Sleep(1)

	MissionPartOneStarted = true
	Story_Event("UM11_INTROCINE_DONE")
	Story_Event("UM11_OBJECTIVE_01")
	Create_Thread("PartOne_GuardSpawn")

	monitorsa.Highlight(true)
	Add_Radar_Blip(monitorsa, "monitorsa")

	Register_Timer(Hint_BribeDoor, 8)
	Story_Event("UM11_HINT_09")
	Story_Event("SET_CREDITS")
end

function Hint_BribeDoor()
	if not VictoryCondition_BackdoorOpen then
		Story_Event("UM11_HINT_00")
		Register_Timer(Hint_BribeDoor, 15)
	end
end

-- if tyber kills the guards behind the fence, spawn some more
-- stop spawning when tyber has breached the door
function PartOne_GuardSpawn()
	guardspawn = Find_Hint("STORY_TRIGGER_ZONE", "bribedguardsspawn")
	guardmove = Find_Hint("STORY_TRIGGER_ZONE", "bribedguardsmoveto")
	bribableguards = Spawn_Unit(Find_Object_Type("IMPERIAL_MINI_STORMTROOPER_SQUAD"), guardspawn.Get_Position(), empire_player)
	for k, unit in pairs(bribableguards) do
		if TestValid(unit) then
			unit.Prevent_AI_Usage(true)
			unit.Move_To(guardmove)
		end
	end
	while TestValid(doork) do
		members = 0
		for k, unit in pairs(bribableguards) do
			if TestValid(unit) then
				members = members + 1
			end
		end
		if members == 0 then
			bribableguards = Spawn_Unit(Find_Object_Type("IMPERIAL_MINI_STORMTROOPER_SQUAD"), guardspawn.Get_Position(), empire_player)
			for k, unit in pairs(bribableguards) do
				if TestValid(unit) then
					unit.Prevent_AI_Usage(true)
					unit.Move_To(guardmove)
				end
			end
		end
		Sleep(2)
	end
end

function PartOne_BactaGone()
	--do something
	--MessageBox("Yay!")
	VictoryCondition_BactaGone = true
	moreguards = Spawn_Unit(Find_Object_Type("IMPERIAL_MEDIUM_STORMTROOPER_SQUAD"), guardspawn.Get_Position(), empire_player)
	--enable this later wtf did it break?
	--Create_Thread("Hunt_Underworld", moreguards)
end

function PartOne_MonitorsDead()
	--monitorsb.Despawn()
	VictoryCondition_MonitorControls = true
	monitorsa.Highlight(false)
	Remove_Radar_Blip("monitorsa")
	Story_Event("UM11_OBJECTIVE_01_DONE")
	Story_Event("CHATTER_16")
	Create_Thread("Destroy_Monitors")
end

function Destroy_Monitors()
	monitorsb1.Take_Damage(9999)
	Sleep(.25)
	monitorsb2.Take_Damage(9999)
	Sleep(.15)
	monitorsb3.Take_Damage(9999)
	Sleep(.15)
	monitorsb4.Take_Damage(9999)
	Sleep(.25)
	monitorsb5.Take_Damage(9999)
	Sleep(.15)
	monitorsb6.Take_Damage(9999)
	Sleep(.15)
	monitorsb7.Take_Damage(9999)
	Sleep(.25)
	monitorsb8.Take_Damage(9999)
end

function Prox_IntroAdeptOne(self_obj, trigger_obj)
	if VictoryCondition_BackdoorOpen then
		if trigger_obj.Get_Owner() == underworld_player then
			current_cine_id = Create_Thread("CINE_Adept_One")
			self_obj.Cancel_Event_Object_In_Range(Prox_IntroAdeptOne)
		end
	end
end

function CINE_Adept_One()
	Cancel_Fast_Forward()
	CINE_Active_Adept_One = true
	Fade_Screen_Out(0)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	tyber_zann.Prevent_All_Fire(true)
	tyber_zann.Hide(true)

	cin_tyber2 = Create_Generic_Object("TYBER_ZANN_CAMPAIGN", cineadeptonetyber.Get_Position(), neutral_player)
	cin_tyber2.Face_Immediate(adeptonespawnb)

	adeptonedoor.Play_Animation("Cinematic", false, 2)
	cin_mouse1 = Create_Generic_Object("UMP_CINE_MOUSEDROID", cineadeptonemouse.Get_Position(), neutral_player)
	cin_mouse2 = Create_Generic_Object("UMP_CINE_MOUSEDROID", cineadeptonemouse.Get_Position(), neutral_player)
	cin_mouse3 = Create_Generic_Object("UMP_CINE_MOUSEDROID", cineadeptonemouse.Get_Position(), neutral_player)
	cin_mouse1.Move_To(cinemousegoto1)
	cin_mouse2.Move_To(cinemousegoto2)
	cin_mouse3.Move_To(cinemousegoto3)

	cin_adepts1 = Create_Generic_Object("UM05_ADEPTONECINE", adeptonespawna.Get_Position(), neutral_player)
	cin_adepts2 = Create_Generic_Object("UM05_ADEPTONECINE", adeptonespawnb.Get_Position(), neutral_player)
	cin_adepts3 = Create_Generic_Object("UM05_ADEPTONECINE", adeptonespawnc.Get_Position(), neutral_player)
	cin_adepts1.Face_Immediate(cin_tyber2)
	cin_adepts2.Face_Immediate(cin_tyber2)
	cin_adepts3.Face_Immediate(cin_tyber2)

	Sleep(1)
	Fade_Screen_In(1)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)

	Set_Cinematic_Camera_Key(camadeptonepos, 0, 0, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camadeptonelook, 0, 0, -10, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camadeptonepos, 5, 0, 0, 16, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camadeptonelook, 5, 0, 0, -13, 0, 0, 0, 0)
	Story_Event("CHATTER_14")

	while not State_Mission_14_Done	do Sleep(.5) end

	adeptonedoor.Play_Animation("Cinematic",false,3)
	Set_Cinematic_Camera_Key(camonepos, 0, 0, 16, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camonelook, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camonepospan, 5, 0, 0, 20, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camonelookpan, 5, 0, 0, 0, 0, 0, 0, 0)
	cin_tyber2.Play_Animation("cinematic", true, 2)
	Story_Event("CHATTER_15")

	while not State_Mission_15_Done	do Sleep(.5) end

	cin_adepts1.Change_Owner(empire_player)
	cin_adepts2.Change_Owner(empire_player)
	cin_adepts3.Change_Owner(empire_player)
	cin_adepts1.Suspend_Locomotor(true)
	cin_adepts2.Suspend_Locomotor(true)
	cin_adepts3.Suspend_Locomotor(true)
	cin_tyber2.Change_Owner(underworld_player)

	cin_adepts2.Attack_Target(cin_tyber2)
	Sleep(.5)
	cin_adepts1.Attack_Target(cin_tyber2)
	Sleep(.25)
	cin_adepts3.Attack_Target(cin_tyber2)
	Sleep(1)

	cin_tyber2.Change_Owner(neutral_player)
	Sleep(1)

	Create_Thread("CINE_Adept_One_Cleanup")
end

function CINE_Adept_One_Cleanup()
	CINE_Active_Adept_One = false
	current_cine_id = nil
	Fade_Screen_Out(1)
	Sleep(1)
	adeptonea = Create_Generic_Object("UM05_ADEPTONE", adeptonespawna.Get_Position(), empire_player)
	adeptonea.Override_Max_Speed(.75)
	adeptoneb = Create_Generic_Object("UM05_ADEPTONE", adeptonespawnb.Get_Position(), empire_player)
	adeptoneb.Override_Max_Speed(.65)
	adeptonec = Create_Generic_Object("UM05_ADEPTONE", adeptonespawnc.Get_Position(), empire_player)
	adeptonec.Override_Max_Speed(.7)
	VictoryCondition_AdeptsSpawned = true

	tyber_zann.Prevent_All_Fire(false)
	tyber_zann.Hide(false)

	if TestValid(cin_tyber2) then cin_tyber2.Despawn() end
	if TestValid(cin_mouse1) then cin_mouse1.Despawn() end
	if TestValid(cin_mouse2) then cin_mouse2.Despawn() end
	if TestValid(cin_mouse3) then cin_mouse3.Despawn() end
	if TestValid(cin_adepts1) then cin_adepts1.Despawn() end
	if TestValid(cin_adepts2) then cin_adepts2.Despawn() end
	if TestValid(cin_adepts3) then cin_adepts3.Despawn() end

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)

	Fade_Screen_In(1)
	Point_Camera_At(tyber_zann)
	underworld_player.Select_Object(tyber_zann)

	Fade_Screen_In(1)
	Sleep(1)



	Register_Timer(Hint_AdeptOne1, 15)
	adeptonedoor.Play_Animation("Cinematic",false,0)
	Story_Event("UM11_OBJECTIVE_02")
end

function Hint_AdeptOne1()
	if not VictoryCondition_AdeptOneDead then
		Story_Event("UM11_HINT_01")
		Register_Timer(Hint_AdeptOne2, 10)
	end
end

function Hint_AdeptOne2()
	if not VictoryCondition_AdeptOneDead then
		Story_Event("UM11_HINT_08")
		Register_Timer(Hint_AdeptOne1, 10)
	end
end

function Kill_Off_Stormies()
	thebunker.Take_Damage(9999)
	Sleep(1)
	extras = Find_All_Objects_Of_Type("STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
end

function MissionObjective_PartTwo()
	MissionPartTwoStarted = true
	Create_Thread("Kill_Off_Stormies")
	extras = Find_All_Objects_Of_Type("STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			--if unit.Get_Owner() == underworld_player then
				-- Used to move them, now we don't because moving teams ends up with funky (fonky) results
				unit.Take_Damage(9999)
			--end
		end
	end
	extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			--if unit.Get_Owner() == underworld_player then
				-- Used to move them, now we don't because moving teams ends up with funky (fonky) results
				unit.Take_Damage(9999)
			--end
		end
	end
	extras = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			if unit.Get_Owner() == underworld_player then
				unit.Set_In_Limbo(true)
				unit.Set_Selectable(false)
			end
		end
	end
	silri.Set_In_Limbo(false)
	silri.Hide(false)
	silri.Set_Selectable(true)
	silri.Make_Invulnerable(false)
	tyber_zann.Set_In_Limbo(true)
	tyber_zann.Hide(true)
	tyber_zann.Set_Selectable(false)
	tyber_zann.Make_Invulnerable(true)

	Fade_Screen_In(1)
	Point_Camera_At(silri)
	underworld_player.Select_Object(silri)

	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
	else
		silri.Activate_Ability("SUMMON", silri)
	end

	Fade_Screen_In(1)
	Sleep(1)
	Story_Event("UM11_OBJECTIVE_03")

	consolee.Highlight(true)
	Add_Radar_Blip(consolee, "consolee")
	Register_Timer(Hint_SilriHurt, 10)
	Story_Event("UM11_HINT_10")
end


function CINE_Intro_Silri()
	Cancel_Fast_Forward()
	CINE_Active_Intro_Silri = true

	silri.Hide(true)
	silri.Prevent_All_Fire(true)

	--Fade_Screen_Out(1)
	--Sleep(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	cin_silri = Create_Generic_Object("SILRI", cinesilri.Get_Position(), neutral_player)
	cin_sadept = Create_Generic_Object("UM05_ADEPTTWOCINE", cinesilriadept.Get_Position(), neutral_player)
	cin_rancor = Create_Generic_Object("UM05_CUDDLES_THE_RANCOR", cinerancorsummon.Get_Position(), neutral_player)
	cin_silri.Prevent_AI_Usage(true)

	cin_sadept.Override_Max_Speed(.25)
	cin_sadept.Move_To(cinesilriadeptmoveto)

	cin_silri.Teleport_And_Face(cinesilri)
	cin_rancor.Turn_To_Face(cin_sadept)
	Fade_Screen_In(1)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camtwirlsilristart, 0, 0, 18, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_silri, 0, 0, 14, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camtwirlsilriend, 12, 0, 0, 18, 0, 0, 0, 0)
	Story_Event("CHATTER_05")
	cin_silri.Play_Animation("cinematic", false, 0)
	Sleep(1)
	cin_sadept.Face_Immediate(cin_silri)

	while not State_Mission_05_Done	do Sleep(.5) end

	cin_sadept.Suspend_Locomotor(true)
	cin_silri.Play_Animation("idle", false, 2)

	Set_Cinematic_Camera_Key(camintrosilripos, 0, 0, 12, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camintrosilrilook, 0, 0, -14, 0, 0, 0, 0)
	Sleep(.25)
	cin_silri.Turn_To_Face(cin_sadept)
	cin_silri.Play_Animation("idle", false, 0)
	Story_Event("CHATTER_06")

	while not State_Mission_06_Done	do Sleep(.5) end

	cin_silri.Suspend_Locomotor(true)
	cin_rancor.Suspend_Locomotor(true)
	Set_Cinematic_Camera_Key(camsilriadeptpos, 0, 0, 17, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camsilriadeptlook, 0, 0, -15, 0, 0, 0, 0)
	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_07")

	while not State_Mission_07_Done	do Sleep(.5) end

	cin_sadept.Override_Max_Speed(1)
	Set_Cinematic_Camera_Key(camintrosilripos, 0, 0, 11, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camintrosilrilook, 0, 0, -12, 0, 0, 0, 0)
	cin_sadept.Change_Owner(empire_player)
	cin_silri.Change_Owner(underworld_player)
	cin_sadept.Attack_Target(cin_silri)
	cin_silri.Play_Animation("idle", false, 0)
	Story_Event("CHATTER_08")

	while not State_Mission_08_Done	do Sleep(.5) end

	Transition_Cinematic_Camera_Key(cin_sadept, 2, 0, 0, 18, 0, cin_sadept, 0, 0)
	Transition_Cinematic_Target_Key(cin_silri, 2, 0, 0, 6, 0, cin_silri, 0, 0)
	cin_rancor.Play_Animation("idle", false, 1)
	cin_sadept.Suspend_Locomotor(false)
	cin_sadept.Attack_Target(cin_silri)
	cin_silri.Turn_To_Face(cin_sadept)
	Sleep(1.5)

	cin_silri.Play_Animation("attack", false, 0)
	Set_Cinematic_Camera_Key(camfightpos, 0, 0, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camfightlook, 0, 0, 0, 0, 0, 0, 0)
	Sleep(1.5)
	cin_sadept.Take_Damage(9999)
	Sleep(.5)
	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_02")

	Set_Cinematic_Camera_Key(camadeptdiepos, 0, 0, 18, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cin_silri, 0, 0, 8, 0, 0, 0, 0)

	while not State_Mission_02_Done	do Sleep(.5) end

	Story_Event("CHATTER_03")

	while not State_Mission_03_Done	do Sleep(.5) end
	cin_silri.Play_Animation("idle", false, 0)

	Fade_Screen_Out(1)
	Sleep(1)
	Create_Thread("CINE_Intro_Silri_Cleanup")
end

function CINE_Intro_Silri_Cleanup()
	CINE_Active_Intro_Silri = false
	current_cine_id = nil

	silri.Prevent_All_Fire(false)
	silri.Hide(false)

	if TestValid(cin_sadept) then cin_sadept.Despawn() end
	if TestValid(cin_silri) then cin_silri.Despawn() end
	if TestValid(cin_rancor) then cin_rancor.Despawn() end

	End_Cinematic_Camera()
	Letter_Box_Out(0)
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(1)

	Create_Thread("MissionObjective_PartTwo")
	Register_Prox(noticetroopers, Prox_NoticeTroopers, 150, underworld_player)
end

function Prox_NoticeTroopers(self_obj, trigger_obj)
	if trigger_obj == silri then
		Story_Event("CHATTER_01")
		self_obj.Cancel_Event_Object_In_Range(Prox_NoticeTroopers)
	end
end

function Hint_SilriHurt()
	Story_Event("UM11_HINT_02")
end

function Prox_SithHolocron(self_obj, trigger_obj)
	-- when silri gets the holocron...
	if trigger_obj == silri then
		holocron.Highlight(false)
		Remove_Radar_Blip("holocron")
		Register_Timer(PartTwo_HolocronFound, 2)
		Fade_Screen_Out(2)
		self_obj.Cancel_Event_Object_In_Range(Prox_SithHolocron)
		Story_Event("UM11_OBJECTIVE_03_DONE")
	end
end

function PartTwo_HolocronFound()
	VictoryCondition_HolocronFound = true
end

function MissionObjective_PartThree()
	MissionPartThreeStarted = true
	silri.Set_In_Limbo(true)
	silri.Hide(true)
	silri.Set_Selectable(false)
	silri.Make_Invulnerable(true)
	urai_fen.Set_In_Limbo(false)
	urai_fen.Hide(false)
	urai_fen.Set_Selectable(true)
	urai_fen.Make_Invulnerable(false)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Set_In_Limbo(true)
		cuddles.Hide(true)
		cuddles.Make_Invulnerable(true)
		cuddles.Set_Selectable(false)
	end
	current_cine_id = Create_Thread("CINE_Urai_Nodes")
end

function CINE_Urai_Nodes()
	Cancel_Fast_Forward()
	CINE_Active_Urai_Nodes = true

	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	-- Silri gets her holocron --

	silri.Hide(true)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Hide(true)
	end

	cin_silri = Create_Generic_Object("SILRI", silriholospawn.Get_Position(), neutral_player)
	cin_cuddles = Create_Generic_Object("CUDDLES_THE_RANCOR", cuddlesholospawn.Get_Position(), neutral_player)
	cin_silri.Face_Immediate(holocron)
	cin_cuddles.Face_Immediate(holocron)
	cin_silri.Suspend_Locomotor(true)
	cin_fx = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", sithholofx.Get_Position(), neutral_player)
	--cin_fx.Attach_Particle_Effect("BLAST_CHARGING_EFFECT")
	silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_All_Fire(true)


	Sleep(1)
	Fade_Screen_In(1)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camholopos, 0, 0, 60, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camhololook, 0, 0, 10, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camocronpos, 5, 0, 0, 35, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camocronlook, 5, 0, 0, -5, 0, 0, 0, 0)

	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_04")

	while not State_Mission_04_Done	do Sleep(.5) end

	Story_Event("CHATTER_00")

	while not State_Mission_00_Done	do Sleep(.5) end
	cin_silri.Play_Animation("idle", false, 0)

	Fade_Screen_Out(2)
	Sleep(2)

	-- introduce urai fen --

	Fade_Screen_In(2)

	Set_Cinematic_Camera_Key(camholeposend, 0, 0, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camholelookend, 0, 0, 6, 0, 0, 0, 0)
	cin_uadept = Create_Generic_Object("UM05_ADEPTTWOCINE", cineadepttwospawn.Get_Position(), neutral_player)
	cin_uadept.Override_Max_Speed(.5)
	cin_uadept.Move_To(cineadepttwomoveto)
	Transition_Cinematic_Camera_Key(camuraifaceoffpos, 5, 0, 0, 20, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camuraifaceofflook, 5, 0, 0, -10, 0, 0, 0, 0)
	Sleep(2.5)

	urai_fen.Turn_To_Face(cin_uadept)
	Sleep(2)
	cin_uadept.Turn_To_Face(urai_fen)
	urai_fen.Suspend_Locomotor(true)
	Sleep(1)
	cin_uadept.Suspend_Locomotor(true)
	cin_uadept.Change_Owner(empire_player)
	urai_fen.Change_Owner(underworld_player)
	cin_uadept.Attack_Target(urai_fen)

	urai_fen.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_17")

	while not State_Mission_17_Done	do Sleep(.5) end
	urai_fen.Play_Animation("idle", false, 0)
	Sleep(1)

	Fade_Screen_Out(1)
	Sleep(1)

	Create_Thread("CINE_Urai_Nodes_Cleanup")
end

function CINE_Urai_Nodes_Cleanup()
	CINE_Active_Urai_Nodes = false
	current_cine_id = nil

	thesithartifact.Despawn()

	Fade_Screen_In(1)

	Point_Camera_At(urai_fen)
	underworld_player.Select_Object(urai_fen)

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)

	urai_fen.Suspend_Locomotor(false)

	if TestValid(cin_uadept) then cin_uadept.Despawn() end
	if TestValid(cin_silri) then cin_silri.Despawn() end
	if TestValid(cin_cuddles) then cin_cuddles.Despawn() end
	if TestValid(cin_fx) then cin_fx.Despawn() end

	Create_Thread("PartThree_IntroAdeptTwo")

	Fade_Screen_In(1)
	Sleep(1)

	Story_Event("UM11_OBJECTIVE_04")

	nodea.Highlight(true)
	Add_Radar_Blip(nodea, "nodea")
	nodeb.Highlight(true)
	Add_Radar_Blip(nodeb, "nodeb")
	nodec.Highlight(true)
	Add_Radar_Blip(nodec, "nodec")
	noded.Highlight(true)
	Add_Radar_Blip(noded, "noded")

	Register_Timer(Hint_UraiHeal, 8)
	Story_Event("UM11_HINT_11")
end

function Hint_UraiHeal()
	if not VictoryCondition_AdeptTwoDead then
		Story_Event("UM11_HINT_03")
		Register_Timer(Hint_UraiHeal, 15)
	end
end

function PartThree_Node_A()
	Create_Thread("PartThree_Blow_A")
	VictoryCondition_Blown_A = true
	nodea.Highlight(false)
	Remove_Radar_Blip("nodea")
	Create_Thread("PartThree_KilledNode")
end
function PartThree_Node_B()
	Create_Thread("PartThree_Blow_B")
	VictoryCondition_Blown_B = true
	nodeb.Highlight(false)
	Remove_Radar_Blip("nodeb")
	Create_Thread("PartThree_KilledNode")
end
function PartThree_Node_C()
	Create_Thread("PartThree_Blow_C")
	VictoryCondition_Blown_C = true
	nodec.Highlight(false)
	Remove_Radar_Blip("nodec")
	Create_Thread("PartThree_KilledNode")
end
function PartThree_Node_D()
	Create_Thread("PartThree_Blow_D")
	VictoryCondition_Blown_D = true
	noded.Highlight(false)
	Remove_Radar_Blip("noded")
	Create_Thread("PartThree_KilledNode")
end

function PartThree_KilledNode()
	Story_Event("CHATTER_18")
end


function PartThree_Blow_A()
	blowa = Find_Hint("STORY_TRIGGER_ZONE", "blowa-a")
	blowb = Find_Hint("STORY_TRIGGER_ZONE", "blowa-b")
	blowc = Find_Hint("STORY_TRIGGER_ZONE", "blowa-c")
	blowd = Find_Hint("STORY_TRIGGER_ZONE", "blowa-d")
	blowe = Find_Hint("STORY_TRIGGER_ZONE", "blowa-e")
	blowf = Find_Hint("STORY_TRIGGER_ZONE", "blowa-f")
	blowg = Find_Hint("STORY_TRIGGER_ZONE", "blowa-g")
	blowh = Find_Hint("STORY_TRIGGER_ZONE", "blowa-h")
	blowreactor = Find_Hint("STORY_TRIGGER_ZONE", "blowreactor")
	explode = "THERMAL_DETONATOR_EXPLOSION"
	effect = "STUNNED_PARTICLE_EFFECT"
	ablowa = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowa.Get_Position(), neutral_player)
	ablowb = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowb.Get_Position(), neutral_player)
	ablowc = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowc.Get_Position(), neutral_player)
	ablowd = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowd.Get_Position(), neutral_player)
	ablowe = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowe.Get_Position(), neutral_player)
	ablowf = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowf.Get_Position(), neutral_player)
	ablowg = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowg.Get_Position(), neutral_player)
	ablowh = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowh.Get_Position(), neutral_player)
	ablowr = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowreactor.Get_Position(), neutral_player)
	Sleep(.05)
	ablowa.Attach_Particle_Effect(effect)
	ablowa.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowb.Attach_Particle_Effect(effect)
	ablowb.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowc.Attach_Particle_Effect(effect)
	ablowc.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowd.Attach_Particle_Effect(effect)
	ablowd.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowe.Attach_Particle_Effect(effect)
	ablowe.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowf.Attach_Particle_Effect(effect)
	ablowf.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowg.Attach_Particle_Effect(effect)
	ablowg.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowh.Attach_Particle_Effect(effect)
	ablowh.Attach_Particle_Effect(explode)
	Sleep(.05)
	ablowr.Attach_Particle_Effect(explode)
	--MessageBox("Ok")
end

function PartThree_Blow_B()
	--do nothing
	blowa = Find_Hint("STORY_TRIGGER_ZONE", "blowb-a")
	blowb = Find_Hint("STORY_TRIGGER_ZONE", "blowb-b")
	blowc = Find_Hint("STORY_TRIGGER_ZONE", "blowb-c")
	blowd = Find_Hint("STORY_TRIGGER_ZONE", "blowb-d")
	blowe = Find_Hint("STORY_TRIGGER_ZONE", "blowb-e")
	blowf = Find_Hint("STORY_TRIGGER_ZONE", "blowb-f")
	blowg = Find_Hint("STORY_TRIGGER_ZONE", "blowb-g")
	blowh = Find_Hint("STORY_TRIGGER_ZONE", "blowb-h")
	blowi = Find_Hint("STORY_TRIGGER_ZONE", "blowb-i")
	blowj = Find_Hint("STORY_TRIGGER_ZONE", "blowb-j")
	blowreactor = Find_Hint("STORY_TRIGGER_ZONE", "blowreactor")
	explode = "THERMAL_DETONATOR_EXPLOSION"
	effect = "STUNNED_PARTICLE_EFFECT"
	bblowa = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowa.Get_Position(), neutral_player)
	bblowb = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowb.Get_Position(), neutral_player)
	bblowc = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowc.Get_Position(), neutral_player)
	bblowd = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowd.Get_Position(), neutral_player)
	bblowe = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowe.Get_Position(), neutral_player)
	bblowf = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowf.Get_Position(), neutral_player)
	bblowg = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowg.Get_Position(), neutral_player)
	bblowh = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowh.Get_Position(), neutral_player)
	bblowi = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowi.Get_Position(), neutral_player)
	bblowj = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowj.Get_Position(), neutral_player)
	bblowr = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowreactor.Get_Position(), neutral_player)
	Sleep(.05)
	bblowa.Attach_Particle_Effect(effect)
	bblowa.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowb.Attach_Particle_Effect(effect)
	bblowb.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowc.Attach_Particle_Effect(effect)
	bblowc.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowd.Attach_Particle_Effect(effect)
	bblowd.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowe.Attach_Particle_Effect(effect)
	bblowe.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowf.Attach_Particle_Effect(effect)
	bblowf.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowg.Attach_Particle_Effect(effect)
	bblowg.Attach_Particle_Effect(explode)
	Sleep(.15)
	bblowh.Attach_Particle_Effect(effect)
	bblowh.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowi.Attach_Particle_Effect(effect)
	bblowi.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowj.Attach_Particle_Effect(effect)
	bblowj.Attach_Particle_Effect(explode)
	Sleep(.05)
	bblowr.Attach_Particle_Effect(explode)
	--MessageBox("Ok")
end

function PartThree_Blow_C()
	--do nothing
	blowa = Find_Hint("STORY_TRIGGER_ZONE", "blowc-a")
	blowb = Find_Hint("STORY_TRIGGER_ZONE", "blowc-b")
	blowc = Find_Hint("STORY_TRIGGER_ZONE", "blowc-c")
	blowd = Find_Hint("STORY_TRIGGER_ZONE", "blowc-d")
	blowe = Find_Hint("STORY_TRIGGER_ZONE", "blowc-e")
	blowf = Find_Hint("STORY_TRIGGER_ZONE", "blowc-f")
	blowg = Find_Hint("STORY_TRIGGER_ZONE", "blowc-g")
	blowh = Find_Hint("STORY_TRIGGER_ZONE", "blowc-h")
	blowi = Find_Hint("STORY_TRIGGER_ZONE", "blowc-i")
	blowj = Find_Hint("STORY_TRIGGER_ZONE", "blowc-j")
	blowk = Find_Hint("STORY_TRIGGER_ZONE", "blowc-k")
	blowl = Find_Hint("STORY_TRIGGER_ZONE", "blowc-l")
	blowm = Find_Hint("STORY_TRIGGER_ZONE", "blowc-m")
	blown = Find_Hint("STORY_TRIGGER_ZONE", "blowc-n")
	explode = "THERMAL_DETONATOR_EXPLOSION"
	effect = "STUNNED_PARTICLE_EFFECT"
	cblowa = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowa.Get_Position(), neutral_player)
	cblowb = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowb.Get_Position(), neutral_player)
	cblowc = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowc.Get_Position(), neutral_player)
	cblowd = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowd.Get_Position(), neutral_player)
	cblowe = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowe.Get_Position(), neutral_player)
	cblowf = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowf.Get_Position(), neutral_player)
	cblowg = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowg.Get_Position(), neutral_player)
	cblowh = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowh.Get_Position(), neutral_player)
	cblowi = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowi.Get_Position(), neutral_player)
	cblowj = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowj.Get_Position(), neutral_player)
	cblowk = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowk.Get_Position(), neutral_player)
	cblowl = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowl.Get_Position(), neutral_player)
	cblowm = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowm.Get_Position(), neutral_player)
	cblown = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blown.Get_Position(), neutral_player)
	cblowr = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowreactor.Get_Position(), neutral_player)
	Sleep(.05)
	cblowa.Attach_Particle_Effect(effect)
	cblowa.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowb.Attach_Particle_Effect(effect)
	cblowb.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowc.Attach_Particle_Effect(effect)
	cblowc.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowd.Attach_Particle_Effect(effect)
	cblowd.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowe.Attach_Particle_Effect(effect)
	cblowe.Attach_Particle_Effect(explode)
	Sleep(.15)
	cblowf.Attach_Particle_Effect(effect)
	cblowf.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowg.Attach_Particle_Effect(effect)
	cblowg.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowh.Attach_Particle_Effect(effect)
	cblowh.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowi.Attach_Particle_Effect(effect)
	cblowi.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowj.Attach_Particle_Effect(effect)
	cblowj.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowk.Attach_Particle_Effect(effect)
	cblowk.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowl.Attach_Particle_Effect(effect)
	cblowl.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowm.Attach_Particle_Effect(effect)
	cblowm.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblown.Attach_Particle_Effect(effect)
	cblown.Attach_Particle_Effect(explode)
	Sleep(.05)
	cblowr.Attach_Particle_Effect(explode)
	--MessageBox("Ok")
end

function PartThree_Blow_D()
	--do nothing
	blowa = Find_Hint("STORY_TRIGGER_ZONE", "blowd-a")
	blowb = Find_Hint("STORY_TRIGGER_ZONE", "blowd-b")
	blowc = Find_Hint("STORY_TRIGGER_ZONE", "blowd-c")
	blowd = Find_Hint("STORY_TRIGGER_ZONE", "blowd-d")
	blowe = Find_Hint("STORY_TRIGGER_ZONE", "blowd-e")
	blowf = Find_Hint("STORY_TRIGGER_ZONE", "blowd-f")
	blowg = Find_Hint("STORY_TRIGGER_ZONE", "blowd-g")
	blowh = Find_Hint("STORY_TRIGGER_ZONE", "blowd-h")
	blowi = Find_Hint("STORY_TRIGGER_ZONE", "blowd-i")
	blowj = Find_Hint("STORY_TRIGGER_ZONE", "blowd-j")
	blowk = Find_Hint("STORY_TRIGGER_ZONE", "blowd-k")
	blowl = Find_Hint("STORY_TRIGGER_ZONE", "blowd-l")
	blowm = Find_Hint("STORY_TRIGGER_ZONE", "blowd-m")
	blown = Find_Hint("STORY_TRIGGER_ZONE", "blowd-n")
	blowo = Find_Hint("STORY_TRIGGER_ZONE", "blowd-o")
	blowreactor = Find_Hint("STORY_TRIGGER_ZONE", "blowreactor")
	explode = "THERMAL_DETONATOR_EXPLOSION"
	effect = "STUNNED_PARTICLE_EFFECT"
	dblowa = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowa.Get_Position(), neutral_player)
	dblowb = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowb.Get_Position(), neutral_player)
	dblowc = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowc.Get_Position(), neutral_player)
	dblowd = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowd.Get_Position(), neutral_player)
	dblowe = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowe.Get_Position(), neutral_player)
	dblowf = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowf.Get_Position(), neutral_player)
	dblowg = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowg.Get_Position(), neutral_player)
	dblowh = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowh.Get_Position(), neutral_player)
	dblowi = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowi.Get_Position(), neutral_player)
	dblowj = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowj.Get_Position(), neutral_player)
	dblowk = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowk.Get_Position(), neutral_player)
	dblowl = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowl.Get_Position(), neutral_player)
	dblowm = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowm.Get_Position(), neutral_player)
	dblown = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blown.Get_Position(), neutral_player)
	dblowo = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowo.Get_Position(), neutral_player)
	dblowr = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", blowreactor.Get_Position(), neutral_player)
	Sleep(.05)
	dblowa.Attach_Particle_Effect(effect)
	dblowa.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowb.Attach_Particle_Effect(effect)
	dblowb.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowc.Attach_Particle_Effect(effect)
	dblowc.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowd.Attach_Particle_Effect(effect)
	dblowd.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowe.Attach_Particle_Effect(effect)
	dblowe.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowf.Attach_Particle_Effect(effect)
	dblowf.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowg.Attach_Particle_Effect(effect)
	dblowg.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowh.Attach_Particle_Effect(effect)
	dblowh.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowi.Attach_Particle_Effect(effect)
	dblowi.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowj.Attach_Particle_Effect(effect)
	dblowj.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowk.Attach_Particle_Effect(effect)
	dblowk.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowl.Attach_Particle_Effect(effect)
	dblowl.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowm.Attach_Particle_Effect(effect)
	dblowm.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblown.Attach_Particle_Effect(effect)
	dblown.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowo.Attach_Particle_Effect(effect)
	dblowo.Attach_Particle_Effect(explode)
	Sleep(.05)
	dblowr.Attach_Particle_Effect(explode)
	--MessageBox("Ok")
end

function PartThree_IntroAdeptTwo()
	-- this adept is easiest killed by timing the reactor hits to trap him in the explosions
	adepttwoa = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawna.Get_Position(), empire_player)
	adepttwoa.Override_Max_Speed(.8)
	adepttwob = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawnb.Get_Position(), empire_player)
	adepttwob.Override_Max_Speed(.7)
	adepttwoc = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawnc.Get_Position(), empire_player)
	adepttwoc.Override_Max_Speed(.6)
	adepttwod = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawnd.Get_Position(), empire_player)
	adepttwod.Override_Max_Speed(.8)
	adepttwoe = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawne.Get_Position(), empire_player)
	adepttwoe.Override_Max_Speed(.7)
	adepttwof = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawnf.Get_Position(), empire_player)
	adepttwof.Override_Max_Speed(.6)
	adepttwog = Create_Generic_Object("UM05_ADEPTTWO", adepttwospawng.Get_Position(), empire_player)
	adepttwog.Override_Max_Speed(.8)
	--adepttwoh = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawna.Get_Position(), empire_player)
	--adepttwoh.Override_Max_Speed(1)
	--adepttwoi = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawnb.Get_Position(), empire_player)
	--adepttwoi.Override_Max_Speed(.9)
	--adepttwoj = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawnc.Get_Position(), empire_player)
	--adepttwoj.Override_Max_Speed(.7)
	--adepttwok = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawnd.Get_Position(), empire_player)
	--adepttwok.Override_Max_Speed(1)
	--adepttwol = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawne.Get_Position(), empire_player)
	--adepttwol.Override_Max_Speed(.75)
	--adepttwom = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawnf.Get_Position(), empire_player)
	--adepttwom.Override_Max_Speed(.8)
	adepttwon = Create_Generic_Object("UM05_ADEPTTHREE", adepttwospawng.Get_Position(), empire_player)
	adepttwon.Override_Max_Speed(.7)
	VictoryCondition_AdeptTwoSpawned = true
	Story_Event("UM11_OBJECTIVE_05")
end

function PartThree_UraiDone()
	-- urai emerges from the maintenance hatch and meets up with Tyber
	Story_Event("CHATTER_19")
	Sleep(2)
	Fade_Screen_Out(2)
	Sleep(2)
	VictoryCondition_MeetTyber = true
end

function CINE_Silri_Troopers()
	Cancel_Fast_Forward()
	CINE_Active_Silri_Troopers = true

	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	silri.Hide(true)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Hide(true)
	end
	if TestValid(sithwall) then
		sithwall.Despawn()
	end

	cin_silri = Create_Generic_Object("SILRI", silriholospawn.Get_Position(), neutral_player)
	cin_cuddles = Create_Generic_Object("CUDDLES_THE_RANCOR", cuddlesholospawn.Get_Position(), neutral_player)
	cin_silri.Face_Immediate(holocron)
	cin_cuddles.Face_Immediate(holocron)
	silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_All_Fire(true)
	Sleep(1)

	Fade_Screen_In(1)
	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camocronpos, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camocronlook, 0, 0, -5, 0, 0, 0, 0)
	Sleep(.5)
	cin_silri.Turn_To_Face(cin_cuddles)
	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_29")
	Sleep(.5)
	cin_cuddles.Turn_To_Face(cin_silri)

	while not State_Mission_29_Done	do Sleep(.5) end

	Story_Event("CHATTER_40")

	cin_silri.Move_To(camsilrileavepos)
	cin_cuddles.Move_To(camsilrileavepos)
	Set_Cinematic_Camera_Key(camsilrileavepos, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camsilrileavelook, 0, 0, -15, 0, 0, 0, 0)

	while not State_Mission_40_Done	do Sleep(.5) end

	Fade_Screen_Out(2)
	Sleep(2)
	Create_Thread("CINE_Silri_Troopers_Cleanup")
end

function CINE_Silri_Troopers_Cleanup()
	CINE_Active_Silri_Troopers = false
	current_cine_id = nil

	if TestValid(cin_silri) then cin_silri.Despawn() end
	if TestValid(cin_cuddles) then cin_cuddles.Despawn() end

	silri.Teleport_And_Face(silristartfour)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Teleport_And_Face(cuddlesstartfour)
	end

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)

	Create_Thread("MissionObjective_PartFour")
end

function MissionObjective_PartFour()
	if VictoryCondition_MeetTyber then
		ablowa.Despawn()
		ablowb.Despawn()
		ablowc.Despawn()
		ablowd.Despawn()
		ablowe.Despawn()
		ablowf.Despawn()
		ablowg.Despawn()
		ablowh.Despawn()
		ablowr.Despawn()

		bblowa.Despawn()
		bblowb.Despawn()
		bblowc.Despawn()
		bblowd.Despawn()
		bblowe.Despawn()
		bblowf.Despawn()
		bblowg.Despawn()
		bblowh.Despawn()
		bblowr.Despawn()

		cblowa.Despawn()
		cblowb.Despawn()
		cblowc.Despawn()
		cblowd.Despawn()
		cblowe.Despawn()
		cblowf.Despawn()
		cblowg.Despawn()
		cblowh.Despawn()
		cblowi.Despawn()
		cblowj.Despawn()
		cblowk.Despawn()
		cblowl.Despawn()
		cblowm.Despawn()
		cblown.Despawn()
		cblowr.Despawn()

		dblowa.Despawn()
		dblowb.Despawn()
		dblowc.Despawn()
		dblowd.Despawn()
		dblowe.Despawn()
		dblowf.Despawn()
		dblowg.Despawn()
		dblowh.Despawn()
		dblowi.Despawn()
		dblowj.Despawn()
		dblowk.Despawn()
		dblowl.Despawn()
		dblowm.Despawn()
		dblown.Despawn()
		dblowo.Despawn()
		dblowr.Despawn()
	end

	doore2 = Create_Generic_Object("UM05_MOVING_DOOR", doore2spawn.Get_Position(), neutral_player)
	doore2.Play_Animation("Cinematic",false,3)
	doore2.Teleport_And_Face(doore2spawn)

	MissionPartFourStarted = true
	silri.Set_In_Limbo(false)
	silri.Hide(false)
	silri.Set_Selectable(true)
	silri.Make_Invulnerable(false)
	urai_fen.Set_In_Limbo(true)
	urai_fen.Hide(true)
	urai_fen.Set_Selectable(false)
	urai_fen.Make_Invulnerable(true)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Set_In_Limbo(false)
		cuddles.Hide(false)
		cuddles.Make_Invulnerable(false)
		cuddles.Set_Selectable(true)
	end
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
	else
		silri.Activate_Ability("SUMMON", silri)
	end

	Fade_Screen_In(1)
	Point_Camera_At(silri)
	underworld_player.Select_Object(silri)

	Fade_Screen_In(1)
	Sleep(1)

	Story_Event("UM11_OBJECTIVE_06")
	Register_Prox(activatetroopers, Prox_ActivateTroopers, 75, underworld_player)
	Story_Event("UM11_HINT_10")

	Sleep(1)
	doore2.Despawn()
	doore2 = Create_Generic_Object("UM02_KILLABLE_DOOR", doore2spawn.Get_Position(), underworld_player)
	doore2.Teleport_And_Face(doore2spawn)
	doore2.Teleport_And_Face(doore2spawn)
	doore2.Set_Selectable(false)
	doore2.Make_Invulnerable(true)

	doore2.Highlight(true)
	Add_Radar_Blip(doore2, "doore2")

end

function Prox_ActivateTroopers(self_obj, trigger_obj)
	if trigger_obj == silri then
		Create_Thread("PartFour_ReleaseTroopers")
		Register_Timer(Hint_SilriCuddles, 1)
		Story_Event("CHATTER_50")
		self_obj.Cancel_Event_Object_In_Range(Prox_ActivateTroopers)
		Story_Event("UM11_OBJECTIVE_06A")
	end
end

function Hint_SilriCuddles()
	if not VictoryCondition_DarkTroopersDead then
		Story_Event("UM11_HINT_04")
		Register_Timer(Hint_SilriCuddles, 15)
	end
end


function PartFour_ReleaseTroopers()
	dt1.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(6)
	dt1a = Create_Generic_Object("DARK_TROOPER_PHASEI", dt1.Get_Position(), empire_player)
	dt1.Despawn()
	dt1a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt1a.Attack_Move(silri) end
	dt2.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(6)
	dt2a = Create_Generic_Object("DARK_TROOPER_PHASEII", dt2.Get_Position(), empire_player)
	dt2.Despawn()
	dt2a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt2a.Attack_Move(silri) end
	dt3.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(6)
	dt3a = Create_Generic_Object("DARK_TROOPER_PHASEIII", dt3.Get_Position(), empire_player)
	dt3.Despawn()
	dt3a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt3a.Attack_Move(silri) end
	dt4.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(5)
	dt4a = Create_Generic_Object("DARK_TROOPER_PHASEI", dt4.Get_Position(), empire_player)
	dt4.Despawn()
	dt4a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt4a.Attack_Move(silri) end
	dt5.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(5)
	dt5a = Create_Generic_Object("DARK_TROOPER_PHASEII", dt5.Get_Position(), empire_player)
	dt5.Despawn()
	dt5a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt5a.Attack_Move(silri) end
	dt6.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(4)
	dt6a = Create_Generic_Object("DARK_TROOPER_PHASEIII", dt6.Get_Position(), empire_player)
	dt6.Despawn()
	dt6a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt6a.Attack_Move(silri) end
	dt7.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(4)
	dt7a = Create_Generic_Object("DARK_TROOPER_PHASEI", dt7.Get_Position(), empire_player)
	dt7.Despawn()
	dt7a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt7a.Attack_Move(silri) end
	dt8.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(4)
	dt8a = Create_Generic_Object("DARK_TROOPER_PHASEII", dt8.Get_Position(), empire_player)
	dt8.Despawn()
	dt8a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt8a.Attack_Move(silri) end
	dt9.Attach_Particle_Effect("STUNNED_PARTICLE_EFFECT")
	Sleep(3)
	dt9a = Create_Generic_Object("DARK_TROOPER_PHASEIII", dt9.Get_Position(), empire_player)
	dt9.Despawn()
	dt9a.Prevent_AI_Usage(true)
	if TestValid(silri) then dt9a.Attack_Move(silri) end
	VictoryCondition_DarkTroopersSpawned = true
end

function PartFive_SetupGroup()
	doore2.Highlight(false)
	Remove_Radar_Blip("doore2")
	current_cine_id = Create_Thread("CINE_Grouped_Up")
end

function CINE_Grouped_Up()
	Cancel_Fast_Forward()
	CINE_Active_Grouped_Up = true

	if TestValid(dt1) then dt1.Despawn() end
	if TestValid(dt2) then dt2.Despawn() end
	if TestValid(dt3) then dt3.Despawn() end
	if TestValid(dt4) then dt4.Despawn() end
	if TestValid(dt5) then dt5.Despawn() end
	if TestValid(dt6) then dt6.Despawn() end
	if TestValid(dt7) then dt7.Despawn() end
	if TestValid(dt8) then dt8.Despawn() end
	if TestValid(dt9) then dt9.Despawn() end

	Fade_Screen_Out(1)
	Sleep(1)
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	silri.Hide(true)
	silri.Prevent_AI_Usage(true)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Hide(true)
	end

	cin_urai = Create_Generic_Object("URAI_FEN", cineddduraispawn.Get_Position(), neutral_player)
	cin_tyber = Create_Generic_Object("TYBER_ZANN_CAMPAIGN", cinedddtyberspawn.Get_Position(), neutral_player)
	cin_urai.Face_Immediate(silridddspawn)
	cin_tyber.Face_Immediate(silridddspawn)

	cin_silri = Create_Generic_Object("SILRI", silridddspawn.Get_Position(), neutral_player)
	cin_cuddles = Create_Generic_Object("CUDDLES_THE_RANCOR", cuddlesdddspawn.Get_Position(), neutral_player)
	cin_trooper = Create_Generic_Object("DARK_TROOPER_PHASEIII", trooperdddspawn.Get_Position(), neutral_player)
	cin_silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_All_Fire(true)
	cin_silri.Face_Immediate(trooperdddspawn)
	cin_cuddles.Face_Immediate(trooperdddspawn)
	cin_silri.Suspend_Locomotor(true)
	Sleep(1)
	cin_trooper.Take_Damage(9999)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camdddpos, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camdddlook, 0, 0, -5, 0, 0, 0, 0)
	Fade_Screen_In(1)
	Sleep(3.5)
	cin_silri.Suspend_Locomotor(false)
	cin_silri.Turn_To_Face(cin_cuddles)
	Sleep(.5)
	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_11")
	cin_cuddles.Turn_To_Face(cin_silri)
	Sleep(1)
	cin_silri.Suspend_Locomotor(true)
	Sleep(1)
	doora.Play_Animation("Cinematic", false, 1)
	Sleep(1)

	Set_Cinematic_Camera_Key(camfindsilripos, 0, 0, 22, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camfindsilrilook, 0, 0, -22, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camfindsilripos, 3, 0, 0, 26, 0, 0, 0, 0)
	Sleep(1)
	cin_silri.Play_Animation("idle", false, 0)
	cin_silri.Suspend_Locomotor(false)
	cin_silri.Turn_To_Face(cin_tyber)
	Sleep(1)
	cin_silri.Suspend_Locomotor(true)
	cin_cuddles.Turn_To_Face(cin_tyber)
	doora.Despawn()

	while not State_Mission_11_Done	do Sleep(.5) end

	Set_Cinematic_Camera_Key(camdddpos, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camdddlook, 0, 0, -10, 0, 0, 0, 0)
	cin_urai.Override_Max_Speed(.75)
	cin_tyber.Override_Max_Speed(.75)
	cin_urai.Move_To(uraidddgoto)
	cin_tyber.Move_To(tyberdddgoto)
	Story_Event("CHATTER_30")

	while not State_Mission_30_Done	do Sleep(.5) end

	Set_Cinematic_Camera_Key(cammeetsilripos, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(cammeetsilrilook, 0, 0, -0, 0, 0, 0, 0)
	cin_silri.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_31")

	while not State_Mission_31_Done	do Sleep(.5) end
	cin_silri.Play_Animation("idle", false, 0)

	Set_Cinematic_Camera_Key(camfindsilripos, 0, 0, 26, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camfindsilrilook, 0, 0, -22, 0, 0, 0, 0)
	Sleep(1)
	cin_urai.Play_Animation("cinematic", false, 0)
	Story_Event("CHATTER_32")
	Sleep(1)

	cin_urai.Override_Max_Speed(1)
	cin_tyber.Override_Max_Speed(1)
	cin_silri.Suspend_Locomotor(false)
	cin_silri.Move_To(partfourmeet)
	cin_cuddles.Move_To(partfourmeet)
	cin_tyber.Move_To(partfourmeet)
	cin_urai.Move_To(partfourmeet)

	while not State_Mission_32_Done	do Sleep(.5) end

	Fade_Screen_Out(1)
	Sleep(1)
	Create_Thread("CINE_Grouped_Up_Cleanup")
end

function CINE_Grouped_Up_Cleanup()
	CINE_Active_Grouped_Up = false
	current_cine_id = nil

	if TestValid(cin_urai) then cin_urai.Despawn() end
	if TestValid(cin_tyber) then cin_tyber.Despawn() end
	if TestValid(cin_silri) then cin_silri.Despawn() end
	if TestValid(cin_cuddles) then cin_cuddles.Despawn() end
	if TestValid(cin_trooper) then cin_trooper.Despawn() end
	if TestValid(doora) then doora.Despawn() end

	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
	else
		silri.Activate_Ability("SUMMON", silri)
	end

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)

	Create_Thread("PartFour_StartFive")
end

function PartFour_StartFive()
	if not VictoryCondition_ReachedDoorE2 then
		if TestValid(doore2) then
			doore2.Highlight(false)
			Remove_Radar_Blip("doore2")
		end
		VictoryCondition_ReachedDoorE2 = true
	end
	MissionPartFourStarted = true
	VictoryCondition_DarkTroopersDead = true
	VictoryCondition_EndedFour = true
end

function Kill_Off_Extras()
	extras = Find_All_Objects_With_Hint("hallguard3")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard4")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard5")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard6")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard7")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard8")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard9")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard10")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard11")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard12")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
	extras = Find_All_Objects_With_Hint("hallguard13")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			unit.Take_Damage(9999)
		end
	end
end

function MissionObjective_PartFive()
	silri.Set_In_Limbo(false)
	silri.Hide(false)
	silri.Make_Invulnerable(false)
	silri.Set_Selectable(true)
	silri.Teleport_And_Face(partfoursilri)
	silri.Move_To(partfourmeet)
	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
		cuddles.Set_In_Limbo(false)
		cuddles.Teleport_And_Face(partfourcuddles)
		cuddles.Move_To(partfourmeet)
		cuddles.Hide(false)
		cuddles.Set_Selectable(true)
		cuddles.Make_Invulnerable(false)
	end
	Create_Thread("Kill_Off_Extras")
	extras = Find_All_Objects_Of_Type("STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			if unit.Get_Owner() == underworld_player then
				unit.Set_In_Limbo(false)
				unit.Teleport_And_Face(extraguys)
				unit.Set_Selectable(true)
				unit.Hide(false)
				unit.Make_Invulnerable(false)
			end
		end
	end
	extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			if unit.Get_Owner() == underworld_player then
				unit.Set_In_Limbo(false)
				unit.Teleport_And_Face(extraguys)
				unit.Set_Selectable(true)
				unit.Hide(false)
				unit.Make_Invulnerable(false)
			end
		end
	end
	extras = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
	for k, unit in pairs(extras) do
		if TestValid(unit) then
			if unit.Get_Owner() == underworld_player then
				unit.Teleport_And_Face(extraguys)
				unit.Set_Selectable(true)
				unit.Make_Invulnerable(false)
			end
		end
	end
	urai_fen.Set_In_Limbo(false)
	urai_fen.Hide(false)
	urai_fen.Set_Selectable(true)
	urai_fen.Make_Invulnerable(false)
	urai_fen.Teleport_And_Face(uraimeet)
	urai_fen.Move_To(partfourmeet)
	tyber_zann.Set_In_Limbo(false)
	tyber_zann.Hide(false)
	tyber_zann.Set_Selectable(true)
	tyber_zann.Make_Invulnerable(false)
	tyber_zann.Teleport_And_Face(meetspot)
	tyber_zann.Move_To(partfourmeet)

	doorj = Create_Generic_Object("UM05_MOVING_DOOR", doorjspawn.Get_Position(), neutral_player)
	doorj.Teleport_And_Face(doorjspawn)
	doorj.Play_Animation("Cinematic",false,3)

	Fade_Screen_In(1)
	--Point_Camera_At(camstart_five)
	mdu_one = Create_Generic_Object("UNDERWORLD_MOBILE_DEFENSE_UNIT", mdua.Get_Position(), empire_player)
	mdu_one.Prevent_Opportunity_Fire(true)
	mdu_one.Suspend_Locomotor(true)
	mdu_two = Create_Generic_Object("UNDERWORLD_MOBILE_DEFENSE_UNIT", mdub.Get_Position(), empire_player)
	mdu_two.Prevent_Opportunity_Fire(true)
	mdu_two.Suspend_Locomotor(true)
	mdu_three = Create_Generic_Object("UNDERWORLD_MOBILE_DEFENSE_UNIT", mduc.Get_Position(), empire_player)
	mdu_three.Prevent_Opportunity_Fire(true)
	mdu_three.Suspend_Locomotor(true)

	Point_Camera_At(tyber_zann)
	underworld_player.Select_Object(tyber_zann)
	underworld_player.Select_Object(urai_fen)
	underworld_player.Select_Object(silri)

	Fade_Screen_In(1)
	Sleep(1)

	range = 200
	Register_Prox(hallguard1, Prox_HallGuard_1, range, underworld_player)
	Register_Prox(hallguard2, Prox_HallGuard_2, range, underworld_player)

	movegroup.Highlight(true)
	Add_Radar_Blip(movegroup, "movegroup")
	Story_Event("UM11_OBJECTIVE_08")
	Create_Thread("PartFive_SpawnAdepts")
	Create_Thread("Hunt_Underworld", { redguard1 })
	Create_Thread("Hunt_Underworld", { redguard2 })
end

function PartFive_SpawnAdepts()
	adeptthreea = Create_Generic_Object("UM05_ADEPTTHREE", adeptthreespawn.Get_Position(), empire_player)
	adeptthreea.Override_Max_Speed(1)
	Register_Prox(adeptthreea, Prox_AdeptsTaunts, 100, underworld_player)
	adeptthreeb = Create_Generic_Object("UM05_ADEPTTHREE", adeptthreespawn.Get_Position(), empire_player)
	adeptthreeb.Override_Max_Speed(.8)
	adeptthreec = Create_Generic_Object("UM05_ADEPTTHREE", adeptthreespawn.Get_Position(), empire_player)
	adeptthreec.Override_Max_Speed(.6)
	VictoryCondition_AdeptThreeSpawned = true
	Story_Event("UM11_OBJECTIVE_07")
end

function Prox_AdeptsTaunts(self_obj, trigger_obj)
	if trigger_obj == silri then
		if TestValid(adeptthreea) or TestValid(adeptthreeb) or TestValid(adeptthreec) then
			Story_Event("CHATTER_09")
		end
		while not State_Mission_09_Done	do Sleep(.5) end
		if TestValid(silri) then
			Story_Event("CHATTER_10")
		end
		self_obj.Cancel_Event_Object_In_Range(Prox_AdeptsTaunts)
	end
end


function Prox_GetMDUs(self_obj, trigger_obj)
	if trigger_obj == tyber_zann then
		mdu_one.Change_Owner(underworld_player)
		mdu_one.Suspend_Locomotor(false)
		mdu_one.Move_To(partsix_mdus)
		mdu_two.Change_Owner(underworld_player)
		mdu_two.Suspend_Locomotor(false)
		mdu_two.Move_To(partsix_mdus)
		mdu_three.Change_Owner(underworld_player)
		mdu_three.Suspend_Locomotor(false)
		mdu_three.Move_To(partsix_mdus)
		mdu_one.Highlight(true)
		Add_Radar_Blip(mdu_one, "mdu_one")
		mdu_two.Highlight(true)
		Add_Radar_Blip(mdu_two, "mdu_two")
		mdu_three.Highlight(true)
		Add_Radar_Blip(mdu_three, "mdu_three")
		Register_Timer(PartFive_ShowMDUs, 9)
		self_obj.Cancel_Event_Object_In_Range(Prox_GetMDUs)
		Story_Event("CHATTER_20")
	end
end

function PartFive_ShowMDUs()
	mdu_one.Highlight(false)
	Remove_Radar_Blip("mdu_one")
	mdu_two.Highlight(false)
	Remove_Radar_Blip("mdu_two")
	mdu_three.Highlight(false)
	Remove_Radar_Blip("mdu_three")
end

function Prox_MoveGroup(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld_player then
		movegroup.Highlight(false)
		Remove_Radar_Blip("movegroup")
		self_obj.Cancel_Event_Object_In_Range(Prox_MoveGroup)
		Create_Thread("CINE_Outside_Vault_Setup")
	end
end

function CINE_Outside_Vault_Setup()

	Suspend_AI(1)
	Lock_Controls(1)
	Fade_Screen_Out(1)
	Sleep(1)
	Letter_Box_In(0)

		doorf = Create_Generic_Object("UM05_MOVING_DOOR", doorfspawn.Get_Position(), neutral_player)
		doorf.Teleport_And_Face(doorfspawn)

		--urai_fen.Set_Selectable(false)
		urai_fen.Teleport_And_Face(fiveuraispawn)
		urai_fen.Move_To(urai_door)
		tyber_zann.Teleport_And_Face(partfivetyber)
		tyber_zann.Move_To(fivetyberrunto)
		silri.Teleport_And_Face(partfivesilri)
		silri.Move_To(fivesilrirunto)
		cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
		if TestValid(cuddles) then
			cuddles.Teleport_And_Face(partfivecuddles)
			cuddles.Move_To(fivecuddlesrunto)
		end
		extras = Find_All_Objects_Of_Type("STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(partfiveextras)
					unit.Move_To(fiveextrasrunto)
				end
			end
		end
		extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(partfiveextras)
				end
			end
		end
		extras = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(partfiveextras)
				end
			end
		end
		mdus = Find_All_Objects_Of_Type("UNDERWORLD_MOBILE_DEFENSE_UNIT")
		for k, unit in pairs(mdus) do
			if TestValid(unit) then
				--JSY: don't move MDUs that have been built on.  The teleport and face separates them from the built object
				--and then the Move_To crashes the script
				if not TestValid(unit.Get_Build_Pad_Contents()) then
					if unit.Get_Owner() == underworld_player then
						unit.Activate_Ability("DEPLOY", false)
						unit.Teleport_And_Face(partfivemdus)
						unit.Move_To(fivemdusrunto)
					end
				else
					if unit.Get_Owner() == underworld_player then
						unit.Take_Damage(9999)
						if TestValid(unit) then
							unit.Despawn()
						end
						newunit=Create_Generic_Object("UNDERWORLD_MOBILE_DEFENSE_UNIT",partfivemdus.Get_Position(),underworld_player)
						newunit.Move_To(fivemdusrunto)
					end
				end
			end
		end
		current_cine_id = Create_Thread("CINE_Outside_Vault")
end

function CINE_Outside_Vault()
	Cancel_Fast_Forward()
	CINE_Active_Outside_Vault = true

	Start_Cinematic_Camera()
	doorf.Play_Animation("Cinematic",false,2)
	doorh.Play_Animation("Cinematic",false,2)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camdoorclosepos, 0, 0, 40, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camdoorcloselook, 0, 0, 10, 0, 0, 0, 0)
	Fade_Screen_In(1)
	Sleep(1.5)
	doorh.Play_Animation("Cinematic",false,3)
	Sleep(.5)
	doorf.Play_Animation("Cinematic",false,3)
	Sleep(.5)

	Set_Cinematic_Camera_Key(camuraiworkpos, 0, 0, 30, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camuraiworklook, 0, 0, -10, 0, 0, 0, 0)
	tyber_zann.Play_Animation("cinematic", true, 2)
	Story_Event("CHATTER_21")

	while not State_Mission_21_Done	do Sleep(.5) end
	tyber_zann.Play_Animation("idle", true, 0)

	urai_fen.Turn_To_Face(doorh)
	urai_fen.Play_Animation("cinematic", true, 0)
	Story_Event("CHATTER_22")

	while not State_Mission_22_Done	do Sleep(.5) end
	urai_fen.Play_Animation("idle", true, 0)

	Set_Cinematic_Camera_Key(camoutvtyberpos, 0, 0, 20, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camoutvtyberlook, 0, 0, 0, 0, 0, 0, 0)
	tyber_zann.Play_Animation("cinematic", true, 2)
	Story_Event("CHATTER_26")

	while not State_Mission_26_Done	do Sleep(.5) end
	tyber_zann.Play_Animation("idle", true, 0)

	Fade_Screen_Out(1)
	Sleep(1)
	Create_Thread("CINE_Outside_Vault_Cleanup")
end

function CINE_Outside_Vault_Cleanup()
	CINE_Active_Outside_Vault = false
	current_cine_id = nil

	doorf.Despawn()
	doorf = Create_Generic_Object("UM02_KILLABLE_DOOR", doorfspawn.Get_Position(), underworld_player)
	doorf.Teleport_And_Face(doorfspawn)
	doorf.Teleport_And_Face(doorfspawn)
	doorf.Set_Selectable(false)
	doorf.Make_Invulnerable(true)

	Fade_Screen_In(1)
	Point_Camera_At(tyber_zann)
	underworld_player.Select_Object(tyber_zann)
	underworld_player.Select_Object(urai_fen)
	underworld_player.Select_Object(silri)

	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
	else
		silri.Activate_Ability("SUMMON", silri)
	end

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)
	Fade_Screen_In(1)
	Sleep(1)

	Create_Thread("PartFive_SpringTrap")
	Register_Timer(Hint_UseMDUs, 1)
end

function Hint_UseMDUs()
	if not VictoryCondition_GuardsDead then
		Story_Event("UM11_HINT_05")
		Register_Timer(Hint_UseMDUs, 20)
	end
end

function PartFive_SpringTrap()
	Sleep(3)
	troopsa = Create_Generic_Object("DARK_TROOPER_PHASEIII", spawnlefta.Get_Position(), empire_player)
	troopsa.Prevent_AI_Usage(true)
	troopsa.Move_To(movetroopsa1)
	Sleep(2)
	troopsb = Create_Generic_Object("DARK_TROOPER_PHASEIII", spawnrightb.Get_Position(), empire_player)
	troopsb.Prevent_AI_Usage(true)
	troopsb.Move_To(movetroopsb)
	Sleep(2)
	troopsd = Create_Generic_Object("DARK_TROOPER_PHASEIII", spawnlefta.Get_Position(), empire_player)
	troopsd.Prevent_AI_Usage(true)
	troopsd.Move_To(movetroopsa2)
	Sleep(2)
	troopsc = Create_Generic_Object("DARK_TROOPER_PHASEIII", spawnrightc.Get_Position(), empire_player)
	troopsc.Prevent_AI_Usage(true)
	troopsc.Move_To(movetroopsc)
	Sleep(2)
	troopse = Create_Generic_Object("DARK_TROOPER_PHASEIII", spawnlefta.Get_Position(), empire_player)
	troopse.Prevent_AI_Usage(true)
	troopse.Move_To(movetroopsa3)
	VictoryCondition_GuardsSpawned = true
	Create_Thread("PartFive_TroopsAttack")
end


function PartFive_TroopsAttack()
	Sleep(3)
	if TestValid(troopsa) then
		if troopsa.Is_Ability_Ready("JET_PACK") then
			troopsa.Activate_Ability("JET_PACK", landinga)
		end
	end
	Sleep(3)
	if TestValid(troopsb) then
		if troopsb.Is_Ability_Ready("JET_PACK") then
			troopsb.Activate_Ability("JET_PACK", landingb)
		end
	end
	Sleep(3)
	if TestValid(troopsc) then
		if troopsc.Is_Ability_Ready("JET_PACK") then
			troopsc.Activate_Ability("JET_PACK", landingc)
		end
	end
	Sleep(3)
	if TestValid(troopsd) then
		if troopsd.Is_Ability_Ready("JET_PACK") then
			troopsd.Activate_Ability("JET_PACK", landingd)
		end
	end
	Sleep(3)
	if TestValid(troopse) then
		if troopse.Is_Ability_Ready("JET_PACK") then
			troopse.Activate_Ability("JET_PACK", landinge)
		end
	end
	Sleep(1)
	Create_Thread("PartFive_TroopsUseMissiles")
end

function PartFive_TroopsUseMissiles()
	while not VictoryCondition_GuardsDead do
		if TestValid(troopsa) then
			if not troopsa.Is_Ability_Active("JET_PACK") then
				if troopsa.Is_Ability_Ready("DEPLOY") then
					troopsa.Activate_Ability("DEPLOY", true)
				end
			end
		end
		if TestValid(troopsb) then
			if not troopsb.Is_Ability_Active("JET_PACK") then
				if troopsb.Is_Ability_Ready("DEPLOY") then
					troopsb.Activate_Ability("DEPLOY", true)
				end
			end
		end
		if TestValid(troopsc) then
			if not troopsc.Is_Ability_Active("JET_PACK") then
				if troopsc.Is_Ability_Ready("DEPLOY") then
					troopsc.Activate_Ability("DEPLOY", true)
				end
			end
		end
		if TestValid(troopsd) then
			if not troopsd.Is_Ability_Active("JET_PACK") then
				if troopsd.Is_Ability_Ready("DEPLOY") then
					troopsd.Activate_Ability("DEPLOY", true)
				end
			end
		end
		if TestValid(troopse) then
			if not troopse.Is_Ability_Active("JET_PACK") then
				if troopse.Is_Ability_Ready("DEPLOY") then
					troopse.Activate_Ability("DEPLOY", true)
				end
			end
		end
		Sleep(2)
	end
end

function PartFive_OpenVault()
	urai_comp.Highlight(false)
	Remove_Radar_Blip("urai_comp")
	invault.Highlight(true)
	Add_Radar_Blip(invault, "invault")
	VictoryCondition_GotAccessCodes = true
	Create_Thread("Open_Vault")
end

function Prox_InsideVault(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld_player then
		Story_Event("UM11_OBJECTIVE_08_DONE")
		Open_Door_f()
		Open_Door_h()
		invault.Highlight(false)
		Remove_Radar_Blip("invault")
		VictoryCondition_SeenVault = true
		Create_Thread("PartFive_InVault")
		self_obj.Cancel_Event_Object_In_Range(Prox_InsideVault)
	end
end

function PartFive_InVault()
	Story_Event("CHATTER_27")
	while not State_Mission_27_Done	do Sleep(.5) end

	Story_Event("CHATTER_28")
	while not State_Mission_28_Done	do Sleep(.5) end

	Create_Thread("PartSix_StartAdeptFour")
end

function MissionObjective_PartSix()
	MissionPartSixStarted = true
	doora.Play_Animation("Cinematic",false,3)
	Story_Event("UM11_OBJECTIVE_09")
	doori.Highlight(true)
	Add_Radar_Blip(doori, "doori")
end

function PartSix_StartAdeptFour()
	doorb = Create_Generic_Object("UM05_MOVING_DOOR", doorbspawn.Get_Position(), neutral_player)
	doorb.Teleport_And_Face(doorbspawn)
	doorb.Play_Animation("Cinematic",false,3)
	current_cine_id = Create_Thread("CINE_Final_Adept")
end

function CINE_Final_Adept()
	Cancel_Fast_Forward()
	CINE_Active_Final_Adept = true

	Suspend_AI(1)
	Lock_Controls(1)

	Fade_Screen_Out(1)
	Sleep(1)

	doorf.Despawn()

		urai_fen.Teleport_And_Face(finaluraispot)
		urai_fen.Prevent_All_Fire(true)
		urai_fen.Hide(true)
		tyber_zann.Teleport_And_Face(finaltyberspot)
		tyber_zann.Prevent_All_Fire(true)
		tyber_zann.Hide(true)
		silri.Teleport_And_Face(finalsilrispot)
		silri.Prevent_All_Fire(true)
		silri.Prevent_AI_Usage(true)
		silri.Suspend_Locomotor(true)
		silri.Hide(true)
		cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
		if TestValid(cuddles) then
			cuddles.Teleport_And_Face(finalcuddlesspot)
			cuddles.Prevent_All_Fire(true)
			cuddles.Hide(true)
		end
		extras = Find_All_Objects_Of_Type("STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(finalextrasspot)
					unit.Prevent_All_Fire(true)
					unit.Hide(true)
				end
			end
		end
		extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(finalextrasspot)
					unit.Prevent_All_Fire(true)
					unit.Hide(true)
				end
			end
		end
		extras = Find_All_Objects_Of_Type("STORMTROOPER_TEAM")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Teleport_And_Face(finalextrasspot)
				end
			end
		end
		mdus = Find_All_Objects_Of_Type("UNDERWORLD_MOBILE_DEFENSE_UNIT")
		for k, unit in pairs(mdus) do
			if TestValid(unit) then
				--JSY: don't move MDUs that have been built on.  The teleport and face separates them from the built object
				--and then the Move_To crashes the script
				if not TestValid(unit.Get_Build_Pad_Contents()) then
					if unit.Get_Owner() == underworld_player then
						unit.Activate_Ability("DEPLOY", false)
						unit.Teleport_And_Face(finalmdusspot)
					end
				end
			end
		end
	Letter_Box_In(0)
	Start_Cinematic_Camera()

	cin_tele = Create_Generic_Object("UM05_ADEPTFOURCINE", lastadeptspawn.Get_Position(), neutral_player)
	cin_tyber = Create_Generic_Object("TYBER_ZANN_CAMPAIGN", lasttyberspawn.Get_Position(), neutral_player)
	cin_silri = Create_Generic_Object("SILRI", lastsilrispawn.Get_Position(), neutral_player)
	cin_urai = Create_Generic_Object("URAI_FEN", lasturaispawn.Get_Position(), neutral_player)
	cin_cuddles = Create_Generic_Object("UM05_CUDDLES_THE_RANCOR", lastcuddlesspawn.Get_Position(), neutral_player)
	cin_tyber.Move_To(lasttybergoto)
	cin_silri.Move_To(lastsilrigoto)
	cin_urai.Move_To(lasturaigoto)
	cin_cuddles.Move_To(lastcuddlesgoto)
	cin_tele.Turn_To_Face(cin_tyber)
	cin_silri.Prevent_AI_Usage(true)
	cin_silri.Prevent_All_Fire(true)

	Sleep(.5)

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(camlastpos, 0, 0, 50, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camlastlook, 0, 0, -5, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camlastpan, 5, 0, 0, 55, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camlastlook, 5, 0, 0, -10, 0, 0, 0, 0)
	Fade_Screen_In(1)
	Sleep(3)
	cin_tyber.Turn_To_Face(cin_tele)
	cin_urai.Turn_To_Face(cin_tele)
	cin_silri.Turn_To_Face(cin_tele)
	cin_cuddles.Turn_To_Face(cin_tele)
	Sleep(3)

	Story_Event("CHATTER_33")
	Set_Cinematic_Camera_Key(camstraightdown2, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camstraightdown4, 0, 0, 0, 0, 0, 0, 0)

	while not State_Mission_33_Done	do Sleep(.5) end

	cin_tyber.Play_Animation("cinematic", true, 2)
	Story_Event("CHATTER_34")
	Set_Cinematic_Camera_Key(camlastpan, 0, 0, 55, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camlastlook, 0, 0, -10, 0, 0, 0, 0)

	while not State_Mission_34_Done	do Sleep(.5) end
	cin_tyber.Play_Animation("idle", true, 0)

	Story_Event("CHATTER_35")
	Set_Cinematic_Camera_Key(camstraightdown2, 0, 0, 35, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camstraightdown4, 0, 0, 0, 0, 0, 0, 0)

	while not State_Mission_35_Done	do Sleep(.5) end

	Set_Cinematic_Camera_Key(camstraightdown1, 0, 0, 175, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camstraightdown3, 0, 0, 0, 0, 0, 0, 0)
	Transition_Cinematic_Camera_Key(camstraightdown2, 11, 0, 0, 40, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(camstraightdown4, 11, 0, 0, 0, 0, 0, 0, 0)
	Sleep(2)
	cin_fx1 = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", lasttele1.Get_Position(), neutral_player)
	cin_fx1.Attach_Particle_Effect("BOTHAN_STUN_GAS")
	Sleep(.15)
	cin_tele.Teleport_And_Face(lasttele1)
	cin_silri.Turn_To_Face(lasttele1)
	cin_urai.Turn_To_Face(lasttele1)
	Sleep(.5)
	cin_tyber.Turn_To_Face(lasttele1)
	Sleep(.5)
	cin_fx2 = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", lasttele2.Get_Position(), neutral_player)
	cin_fx2.Attach_Particle_Effect("BOTHAN_STUN_GAS")
	cin_urai.Turn_To_Face(lasttele2)
	Sleep(.15)
	cin_silri.Turn_To_Face(lasttele2)
	cin_tele.Teleport_And_Face(lasttele2)
	Sleep(.5)
	cin_tyber.Turn_To_Face(lasttele2)
	Sleep(.5)
	cin_fx3 = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", lasttele3.Get_Position(), neutral_player)
	cin_fx3.Attach_Particle_Effect("BOTHAN_STUN_GAS")
	Sleep(.15)
	cin_urai.Turn_To_Face(lasttele3)
	cin_tele.Teleport_And_Face(lasttele3)
	Sleep(.5)
	cin_tyber.Turn_To_Face(lasttele3)
	cin_silri.Turn_To_Face(lasttele3)
	Sleep(.5)
	cin_fx4 = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", lasttele4.Get_Position(), neutral_player)
	cin_fx4.Attach_Particle_Effect("BOTHAN_STUN_GAS")
	Sleep(.15)
	cin_tele.Teleport_And_Face(lasttele4)
	cin_tyber.Turn_To_Face(cin_tele)
	Sleep(.5)
	cin_fx5 = Create_Generic_Object("INVISIBLE_REVEAL_OBJECT", lastadeptspawn.Get_Position(), neutral_player)
	cin_fx5.Attach_Particle_Effect("BOTHAN_STUN_GAS")
	Sleep(.15)
	cin_urai.Turn_To_Face(cin_tele)
	cin_tele.Teleport_And_Face(lastadeptspawn)
	Sleep(.25)
	cin_silri.Turn_To_Face(cin_tele)
	cin_tyber.Turn_To_Face(cin_tele)
	cin_cuddles.Turn_To_Face(cin_tele)
	Sleep(4)
	cin_tele.Suspend_Locomotor(true)
	cin_tyber.Suspend_Locomotor(true)
	cin_tyber.Prevent_All_Fire(true)
	cin_tele.Change_Owner(empire_player)
	cin_tyber.Change_Owner(underworld_player)
	cin_tele.Attack_Target(cin_tyber)
	Sleep(1)
	cin_tyber.Change_Owner(neutral_player)
	cin_tele.Change_Owner(neutral_player)
	cin_silri.Play_Animation("cinematic", true, 0)
	Story_Event("CHATTER_36")

	while not State_Mission_36_Done	do Sleep(.5) end
	cin_silri.Play_Animation("idle", true, 0)

	Set_Cinematic_Camera_Key(camsilrityberpos, 0, 0, 25, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(camsilrityberlook, 0, 0, 0, 0, 0, 0, 0)
	cin_tyber.Play_Animation("cinematic", true, 2)
	Story_Event("CHATTER_37")
	cin_silri.Turn_To_Face(cin_tyber)
	Sleep(2)
	cin_tyber.Suspend_Locomotor(false)
	cin_tyber.Turn_To_Face(cin_silri)

	while not State_Mission_37_Done	do Sleep(.5) end
	cin_tyber.Play_Animation("idle", true, 0)

	Create_Thread("CINE_Final_Adept_Cleanup")
end

function CINE_Final_Adept_Cleanup()
	CINE_Active_Final_Adept = false
	current_cine_id = nil

		urai_fen.Prevent_All_Fire(false)
		urai_fen.Hide(false)
		tyber_zann.Prevent_All_Fire(false)
		tyber_zann.Hide(false)
		silri.Prevent_All_Fire(false)
		silri.Hide(false)
		silri.Suspend_Locomotor(false)
		cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
		if TestValid(cuddles) then
			cuddles.Prevent_All_Fire(false)
			cuddles.Hide(false)
		end
		extras = Find_All_Objects_Of_Type("STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Prevent_All_Fire(false)
					unit.Hide(false)
				end
			end
		end
		extras = Find_All_Objects_Of_Type("SQUAD_STORMTROOPER")
		for k, unit in pairs(extras) do
			if TestValid(unit) then
				if unit.Get_Owner() == underworld_player then
					unit.Prevent_All_Fire(false)
					unit.Hide(false)
				end
			end
		end

	if TestValid(cin_tyber) then cin_tyber.Despawn() end
	if TestValid(cin_urai) then cin_urai.Despawn() end
	if TestValid(cin_silri) then cin_silri.Despawn() end
	if TestValid(cin_cuddles) then cin_cuddles.Despawn() end
	if TestValid(cin_tele) then cin_tele.Despawn() end
	if TestValid(cin_fx1) then cin_fx1.Despawn() end
	if TestValid(cin_fx2) then cin_fx2.Despawn() end
	if TestValid(cin_fx3) then cin_fx3.Despawn() end
	if TestValid(cin_fx4) then cin_fx4.Despawn() end
	if TestValid(cin_fx5) then cin_fx5.Despawn() end

	cuddles = Find_Nearest(silri, "CUDDLES_THE_RANCOR")
	if TestValid(cuddles) then
	else
		silri.Activate_Ability("SUMMON", silri)
	end

	End_Cinematic_Camera()
	Letter_Box_Out(.5)
	Lock_Controls(0)
	Suspend_AI(0)

	Fade_Screen_In(1)
	Point_Camera_At(tyber_zann)
	underworld_player.Select_Object(tyber_zann)
	underworld_player.Select_Object(urai_fen)
	underworld_player.Select_Object(silri)

	Fade_Screen_In(1)
	Sleep(1)

	Create_Thread("PartSix_IntroAdeptFour")
end


function PartSix_IntroAdeptFour()
	-- this adept is easiest killed by
	adeptfour = Create_Generic_Object("UM05_ADEPTFOUR", adeptfourspawn.Get_Position(), empire_player)
	Register_Death_Event(adeptfour, PartSix_AdeptFourDead)
	Find_And_Attack({adeptfour})
	--adeptfour.Highlight(true)
	Add_Radar_Blip(adeptfour, "adeptfour")
	Create_Thread("PartSix_ReplenishMDUs")
	Story_Event("UM11_OBJECTIVE_10")
	Register_Timer(Hint_AdeptFour, 1)
	Story_Event("CHATTER_52")
end

function Hint_AdeptFour()
	if not VictoryCondition_AdeptFourDead then
		Story_Event("UM11_HINT_06")
		Register_Timer(Hint_AdeptFour, 20)
	end
end

function PartSix_AdeptFourDead()
	adeptfour.Highlight(false)
	Remove_Radar_Blip("adeptfour")
	VictoryCondition_AdeptFourDead = true
	Story_Event("UM11_OBJECTIVE_10_DONE")
end

function PartSix_ReplenishMDUs()
	while not VictoryCondition_AdeptFourDead do
		sixmdus = Find_All_Objects_Of_Type("UNDERWORLD_MOBILE_DEFENSE_UNIT")
		if table.getn(sixmdus) < 3 then
			newmdu = Create_Generic_Object("UNDERWORLD_MOBILE_DEFENSE_UNIT", mduspawn.Get_Position(), underworld_player)
			newmdu.Move_To(tyber_zann)
			newmdu.Prevent_Opportunity_Fire(true)
		end
		Sleep(2)
	end
end

function PartSix_OpenExit()
	-- when wall is destroyed, remove black covers
	juggernaut.Change_Owner(underworld_player)
	juggernaut.Set_Selectable(true)
	juggernaut.Enable_Behavior(24, true)
	juggernaut.Make_Invulnerable(false)
	juggernaut.Highlight(true)
	Add_Radar_Blip(juggernaut, "juggernaut")
	Create_Thread("Open_Door_i")
	Create_Thread("Open_Door_c")
	Create_Thread("PartSix_IsInJuggernaut")
	Create_Thread("PartSix_SpawnTroops")
	mt3.Change_Owner(empire_player)
	mt4.Change_Owner(empire_player)
	mt5.Change_Owner(empire_player)
	mt6.Change_Owner(empire_player)
	Story_Event("CHATTER_53")
end

function Prox_StopSpawns(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld_player then
		VictoryCondition_StopSpawns = true
		self_obj.Cancel_Event_Object_In_Range(Prox_StopSpawns)
	end
end

function PartSix_SpawnTroops()
	while not VictoryCondition_StopSpawns do
		-- spawn advancing troops to get mashed by juggernaut
		Sleep(6)
		evenmoreguys = Spawn_Unit(Find_Object_Type("IMPERIAL_MINI_STORMTROOPER_SQUAD"), exitdoor.Get_Position(), empire_player)
		Create_Thread("Hunt_Underworld", evenmoreguys)
	end
end

function PartSix_IsInJuggernaut()
	while not VictoryCondition_InJuggernaut do
		list = juggernaut.Get_Garrisoned_Units()
		if table.getn(list) > 0 then
			VictoryCondition_InJuggernaut = true
			juggernaut.Highlight(false)
			Remove_Radar_Blip("juggernaut")
			exitdoor.Highlight(true)
			Add_Radar_Blip(exitdoor, "exitdoor")
			Register_Timer(Hint_Juggernaut, 5)
			juggernaut.Override_Max_Speed(1.1)
			Story_Event("CHATTER_54")
		end
		Sleep(2)
	end
end

function Hint_Juggernaut()
	if not VictoryCondition_ReachedExit then
		Story_Event("UM11_HINT_07")
		Register_Timer(Hint_Juggernaut, 20)
		Story_Event("CHATTER_55")
	end
end

function Prox_ReachedExit(self_obj, trigger_obj)
	if trigger_obj.Get_Owner() == underworld_player then
		exitdoor.Highlight(false)
		Remove_Radar_Blip("exitdoor")
		self_obj.Cancel_Event_Object_In_Range(Prox_ReachedExit)
		VictoryCondition_ReachedExit = true
		Story_Event("UM11_OBJECTIVE_09_DONE")
		Story_Event("UM11_OBJECTIVE_06_DONE")
	end
end

function Tyber_Destroyed()
	DefeatCondition_TyberDead = true
	Story_Event("UM11_TYBERDEAD")
end

function Urai_Destroyed()
	DefeatCondition_UraiDead = true
	Story_Event("UM11_URAIDEAD")
end

function Silri_Destroyed()
	DefeatCondition_SilriDead = true
	Story_Event("UM11_SILRIDEAD")
end

function Find_And_Attack(attack_list)
	Create_Thread("Hunt_Underworld",attack_list)
end

function Prox_HallGuard_1(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_1)
end
function Prox_HallGuard_2(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_2)
end
function Prox_HallGuard_3(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_3)
end
function Prox_HallGuard_4(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_4)
end
function Prox_HallGuard_5(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_5)
end
function Prox_HallGuard_6(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_6)
end
function Prox_HallGuard_7(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_7)
end
function Prox_HallGuard_8(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_8)
end
function Prox_HallGuard_9(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_9)
end
function Prox_HallGuard_10(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_10)
end
function Prox_HallGuard_11(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_11)
end
function Prox_HallGuard_12(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_12)
end
function Prox_HallGuard_13(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_13)
end
function Prox_HallGuard_14(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_14)
end
function Prox_HallGuard_15(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_15)
end
function Prox_HallGuard_16(self_obj, trigger_obj)
	Create_Thread("Hunt_Underworld", { self_obj })
	self_obj.Cancel_Event_Object_In_Range(Prox_HallGuard_16)
end


-- delay a short time and then show game has been won VICTORY
function EndMissionVictory()
	Cancel_Fast_Forward()


	units = Find_All_Objects_Of_Type(underworld_player)
	for k, unit in pairs(units) do
		if TestValid(unit) then
			unit.Make_Invulnerable(true)
		end
	end

	Suspend_AI(1)
	Lock_Controls(1)
	Fade_Screen_Out(1)
	Sleep(1)

	ext_sky.Hide(false)
	int_sky.Hide(true)
	endcinebox.Hide(true)
	endcinebox1.Hide(true)

	Letter_Box_In(0)
	Start_Cinematic_Camera()

	if TestValid(juggernaut) then
		endcinejugger.Override_Max_Speed(1.5)
		endcinejugger.Move_To(endcinejuggergoto)
	else
		endcintyber=Create_Generic_Object("TYBER_ZANN_CAMPAIGN", Find_Hint("STORY_TRIGGER_ZONE","endcinetyber").Get_Position(), underworld_player);
		endcinurai=Create_Generic_Object("URAI_FEN", Find_Hint("STORY_TRIGGER_ZONE","endcineurai").Get_Position(), underworld_player);
		endcinsilri=Create_Generic_Object("SILRI", Find_Hint("STORY_TRIGGER_ZONE","endcinesilri").Get_Position(), underworld_player);
		endcincuddles=Create_Generic_Object("UM05_CUDDLES_THE_RANCOR", Find_Hint("STORY_TRIGGER_ZONE","endcinecuddles").Get_Position(), underworld_player);
		endcintyber.Prevent_AI_Usage(true)
		endcintyber.Prevent_All_Fire(true)
		endcintyber.Make_Invulnerable(true)
		endcinsilri.Prevent_AI_Usage(true)
		endcinsilri.Prevent_All_Fire(true)
		endcinsilri.Make_Invulnerable(true)
		endcinurai.Prevent_AI_Usage(true)
		endcinurai.Prevent_All_Fire(true)
		endcinurai.Make_Invulnerable(true)
		endcincuddles.Prevent_AI_Usage(true)
		endcincuddles.Prevent_All_Fire(true)
		endcincuddles.Make_Invulnerable(true)

		endcinejugger.Despawn()

		endcintyber.Override_Max_Speed(1.42)
		endcintyber.Move_To(endcinejuggergoto)
		endcinsilri.Override_Max_Speed(1.41)
		endcinsilri.Move_To(endcinejuggergoto)
		endcinurai.Override_Max_Speed(1.41)
		endcinurai.Move_To(endcinejuggergoto)
		endcincuddles.Override_Max_Speed(1.35)
		endcincuddles.Move_To(endcinejuggergoto)

	 	Sleep(.5)
	end

	chase_list = Find_All_Objects_With_Hint("endchase")
	for k, unit in pairs(chase_list) do
		if TestValid(unit) then
			unit.Override_Max_Speed(1.5)
			unit.Change_Owner(empire_player)
			unit.Attack_Move(endcinejuggergoto)
		end
	end

	-- Set_Cinematic_Camera_Key(target_pos, xoffset_dist, yoffset_pitch, zoffset_yaw, angles?, attach_object, use_object_rotation, cinematic_animation)
	Set_Cinematic_Camera_Key(endcinecampos, 0, 0, 50, 0, 0, 0, 0)
	Set_Cinematic_Target_Key(endcinecamlook, 0, 0, 0, 0, 0, 0, 0)

	Transition_Cinematic_Camera_Key(endcinecampos, 10, 0, 0, 75, 0, 0, 0, 0)
	Transition_Cinematic_Target_Key(endcinecamlook, 10, 0, 0, -15, 0, 0, 0, 0)
	--Sleep(1)

	Fade_Screen_In(1)
	Sleep(3)

	Story_Event("UM11_ENDMISSION_VICTORY")

	Sleep(3)
	Fade_Screen_Out(2)
	Sleep(2)
	End_Cinematic_Camera()
	Letter_Box_Out(0)
	Lock_Controls(0)
	Suspend_AI(0)
	underworld_player.Remove_Orbital_Bombardment(false)


end

-- delay a short time and then show game has been lost DEFEAT
function EndMissionDefeat()
	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)
	Story_Event("UM11_ENDMISSION_DEFEAT")
	underworld_player.Remove_Orbital_Bombardment(false)
end



















function State_Mission_Chatter_00_Done(message)
	if message == OnEnter then
		State_Mission_00_Done = true
	end
end
function State_Mission_Chatter_01_Done(message)
	if message == OnEnter then
		State_Mission_01_Done = true
	end
end
function State_Mission_Chatter_02_Done(message)
	if message == OnEnter then
		State_Mission_02_Done = true
	end
end
function State_Mission_Chatter_03_Done(message)
	if message == OnEnter then
		State_Mission_03_Done = true
	end
end
function State_Mission_Chatter_04_Done(message)
	if message == OnEnter then
		State_Mission_04_Done = true
	end
end
function State_Mission_Chatter_05_Done(message)
	if message == OnEnter then
		State_Mission_05_Done = true
	end
end
function State_Mission_Chatter_06_Done(message)
	if message == OnEnter then
		State_Mission_06_Done = true
	end
end
function State_Mission_Chatter_07_Done(message)
	if message == OnEnter then
		State_Mission_07_Done = true
	end
end
function State_Mission_Chatter_08_Done(message)
	if message == OnEnter then
		State_Mission_08_Done = true
	end
end
function State_Mission_Chatter_09_Done(message)
	if message == OnEnter then
		State_Mission_09_Done = true
	end
end

function State_Mission_Chatter_10_Done(message)
	if message == OnEnter then
		State_Mission_10_Done = true
	end
end
function State_Mission_Chatter_11_Done(message)
	if message == OnEnter then
		State_Mission_11_Done = true
	end
end
function State_Mission_Chatter_12_Done(message)
	if message == OnEnter then
		State_Mission_12_Done = true
	end
end
function State_Mission_Chatter_13_Done(message)
	if message == OnEnter then
		State_Mission_13_Done = true
	end
end
function State_Mission_Chatter_14_Done(message)
	if message == OnEnter then
		State_Mission_14_Done = true
	end
end
function State_Mission_Chatter_15_Done(message)
	if message == OnEnter then
		State_Mission_15_Done = true
	end
end
function State_Mission_Chatter_16_Done(message)
	if message == OnEnter then
		State_Mission_16_Done = true
	end
end
function State_Mission_Chatter_17_Done(message)
	if message == OnEnter then
		State_Mission_17_Done = true
	end
end
function State_Mission_Chatter_18_Done(message)
	if message == OnEnter then
		State_Mission_18_Done = true
	end
end
function State_Mission_Chatter_19_Done(message)
	if message == OnEnter then
		State_Mission_19_Done = true
	end
end

function State_Mission_Chatter_20_Done(message)
	if message == OnEnter then
		State_Mission_20_Done = true
	end
end
function State_Mission_Chatter_21_Done(message)
	if message == OnEnter then
		State_Mission_21_Done = true
	end
end
function State_Mission_Chatter_22_Done(message)
	if message == OnEnter then
		State_Mission_22_Done = true
	end
end
function State_Mission_Chatter_23_Done(message)
	if message == OnEnter then
		State_Mission_23_Done = true
	end
end
function State_Mission_Chatter_24_Done(message)
	if message == OnEnter then
		State_Mission_24_Done = true
	end
end
function State_Mission_Chatter_25_Done(message)
	if message == OnEnter then
		State_Mission_25_Done = true
	end
end
function State_Mission_Chatter_26_Done(message)
	if message == OnEnter then
		State_Mission_26_Done = true
	end
end
function State_Mission_Chatter_27_Done(message)
	if message == OnEnter then
		State_Mission_27_Done = true
	end
end
function State_Mission_Chatter_28_Done(message)
	if message == OnEnter then
		State_Mission_28_Done = true
	end
end
function State_Mission_Chatter_29_Done(message)
	if message == OnEnter then
		State_Mission_29_Done = true
	end
end

function State_Mission_Chatter_30_Done(message)
	if message == OnEnter then
		State_Mission_30_Done = true
	end
end
function State_Mission_Chatter_31_Done(message)
	if message == OnEnter then
		State_Mission_31_Done = true
	end
end
function State_Mission_Chatter_32_Done(message)
	if message == OnEnter then
		State_Mission_32_Done = true
	end
end
function State_Mission_Chatter_33_Done(message)
	if message == OnEnter then
		State_Mission_33_Done = true
	end
end
function State_Mission_Chatter_34_Done(message)
	if message == OnEnter then
		State_Mission_34_Done = true
	end
end
function State_Mission_Chatter_35_Done(message)
	if message == OnEnter then
		State_Mission_35_Done = true
	end
end
function State_Mission_Chatter_36_Done(message)
	if message == OnEnter then
		State_Mission_36_Done = true
	end
end
function State_Mission_Chatter_37_Done(message)
	if message == OnEnter then
		State_Mission_37_Done = true
	end
end
function State_Mission_Chatter_38_Done(message)
	if message == OnEnter then
		State_Mission_38_Done = true
	end
end
function State_Mission_Chatter_39_Done(message)
	if message == OnEnter then
		State_Mission_39_Done = true
	end
end
function State_Mission_Chatter_40_Done(message)
	if message == OnEnter then
		State_Mission_40_Done = true
	end
end
function State_Mission_Chatter_41_Done(message)
	if message == OnEnter then
		State_Mission_41_Done = true
	end
end
function State_Mission_Chatter_42_Done(message)
	if message == OnEnter then
		State_Mission_42_Done = true
	end
end
function State_Mission_Chatter_43_Done(message)
	if message == OnEnter then
		State_Mission_43_Done = true
	end
end
function State_Mission_Chatter_44_Done(message)
	if message == OnEnter then
		State_Mission_44_Done = true
	end
end
function State_Mission_Chatter_45_Done(message)
	if message == OnEnter then
		State_Mission_45_Done = true
	end
end
function State_Mission_Chatter_46_Done(message)
	if message == OnEnter then
		State_Mission_46_Done = true
	end
end
function State_Mission_Chatter_47_Done(message)
	if message == OnEnter then
		State_Mission_47_Done = true
	end
end
function State_Mission_Chatter_48_Done(message)
	if message == OnEnter then
		State_Mission_48_Done = true
	end
end
function State_Mission_Chatter_49_Done(message)
	if message == OnEnter then
		State_Mission_49_Done = true
	end
end
function State_Mission_Chatter_50_Done(message)
	if message == OnEnter then
		State_Mission_50_Done = true
	end
end
function State_Mission_Chatter_51_Done(message)
	if message == OnEnter then
		State_Mission_51_Done = true
	end
end
function State_Mission_Chatter_52_Done(message)
	if message == OnEnter then
		State_Mission_52_Done = true
	end
end
function State_Mission_Chatter_53_Done(message)
	if message == OnEnter then
		State_Mission_53_Done = true
	end
end
function State_Mission_Chatter_54_Done(message)
	if message == OnEnter then
		State_Mission_54_Done = true
	end
end
function State_Mission_Chatter_55_Done(message)
	if message == OnEnter then
		State_Mission_55_Done = true
	end
end
