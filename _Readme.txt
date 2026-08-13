 ______                                         __    _____                                   _    _               
|  ____|                                       / _|  / ____|                                 | |  (_)              
| |__     ___   _ __   ___   ___  ___    ___  | |_  | |       ___   _ __  _ __  _   _  _ __  | |_  _   ___   _ __  
|  __|   / _ \ | '__| / __| / _ \/ __|  / _ \ |  _| | |      / _ \ | '__|| '__|| | | || '_ \ | __|| | / _ \ | '_ \ 
| |     | (_) || |   | (__ |  __/\__ \ | (_) || |   | |____ | (_) || |   | |   | |_| || |_) || |_ | || (_) || | | |
|_|      \___/ |_|    \___| \___||___/  \___/ |_|    \_____| \___/ |_|   |_|    \__,_|| .__/  \__||_| \___/ |_| |_|
                                                                                      | |                          
                                                                                      |_|                          
 _    _                 __   __  _        _         _   _____          _          _                _____                    _                  
| |  | |               / _| / _|(_)      (_)       | | |  __ \        | |        | |              |  __ \                  | |                 
| |  | | _ __    ___  | |_ | |_  _   ___  _   __ _ | | | |__) |  __ _ | |_   ___ | |__    ______  | |__) |  ___   __ _   __| | _ __ ___    ___ 
| |  | || '_ \  / _ \ |  _||  _|| | / __|| | / _` || | |  ___/  / _` || __| / __|| '_ \  |______| |  _  /  / _ \ / _` | / _` || '_ ` _ \  / _ \
| |__| || | | || (_) || |  | |  | || (__ | || (_| || | | |     | (_| || |_ | (__ | | | |          | | \ \ |  __/| (_| || (_| || | | | | ||  __/
 \____/ |_| |_| \___/ |_|  |_|  |_| \___||_| \__,_||_| |_|      \__,_| \__| \___||_| |_|          |_|  \_\ \___| \__,_| \__,_||_| |_| |_| \___|

~ By the UFCP Team. ~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thank you for downloading the Unofficial Forces of Corruption Patch!

v2.3.0.1712 is a huge milestone (that I probably could've held for a larger, more cele-
bratory release).  This update almost fully* brings the base game's Galactic Conquests
(SP and MPGCs) into FoC, more than a handful of AI fixes to support reimplementing
the Black Sun Pirate and neutral planets, and many fixes to broken elements of the Rebel
and Empire campaigns.  Multiple audio fixes from last update have also been adjusted to
fix some annoyances with VO frequency, in addition to multiple model and particle optimi-
zations.

The restored EaW content was mostly handled by cha20202, ported from his mod "EAW
Campaigns & Conquests to FOC Conversion," and is responsible for multiple bugfixes and
improvements to the scripting and mapping.  In addition, all GCs now included in UFCP
inherit his "alternate history" style GCs, which allow you to use the opposite roster
of heroes from EaW (or vice-versa from FoC).
(For example, instead of getting Thrawn and the Arc Hammer in Empire-side Equal Footing,
you now only get Darth Vader's TIE squadron; or in Alderaan's Demise, you *can* now get
Thrawn and the Arc Hammer.)

As an extra bonus, Random Story Events (or, "Interventions") have been re-enabled for all
GCs with EaW heroes.  This has been a popular want since Day One:tm: of UFCP, all the way
back to v1.0, and I'm glad to have these beautiful little flavor events back in GC.
Support for FoC Hero GCs may be an option in the future, but I'm currently theorizing how
to deal with the Consortium lacking them.

Last, but certainly not least, due to arcane forces cursed background coding, the victory/
failure videos now play when winning or losing a GC (including for the campaigns)!  These
broke sometime during FoC's release and haven't been fixed by Petro yet, so for the mean-
time, we're using a complex set of campaign Story Event watchers in the background to
trigger the videos when needed.  They work pretty seamlessly!

Known issues are recorded on the GitHub, hopefully to be solved for the upcoming patches.
If you find any bugs or have anything to report or ask for, make sure to visit the GitHub!

I hope you enjoy UFCP!  Send patches.
~AlyMar1994

*: Certain aspects, such as the original Death Star, could not be reimplemented b/c the
Empire player in MPGCs would be able to build both Death Stars without a good way to
lock one or the other.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREDITS:
Modeling:
- .lany
-- P_Corrupt_Planet2 - More performant corruption particle

- galyana
-- UB_Barracks - Fixed Consortium Barracks spawn bone
-- UB_Droidworks - Fixed Consortium Droidworks spawn bones
-- NV_PSkiff_Underworld - Fixed Consortium Pirate Skiff not using Consortium infantry
-- NV_SwampSpeeder_U - Fixed shadow mesh (v2.1)
-- UV_CanderousAssaultTank - Fixed/improved Canderous Assault Tanks animations, collision and model data (v2.1)
-- UV_Vengeance_HP_RGT_TB - Fixed Vengeance Frigate turbolaser mesh
-- W_Bush_Swmp00 - New swamp bush model
-- RB_Station_03_HP03_IC - Fixed lv.3 station ion cannon tower
-- UV_CrusaderClassCorvette + PE_CrusaderEngines - Fixed Crusader-class engine particles
-- UV_KedalbeBattleship + UV_KedalbeBattleship_HP_E_00/01 - Fixed Keldabe-class engine particles
-- RB_OfficerAcademy + EB_OfficerAcademy - Fixed Officer Academy spawn bones and meshes
-- RV_BWing + PTE_BWing - Fixed B-wing engine particle meshes
-- RV_XWing + PTE_XWing, RV_Rogue_Squad - Fixed X-wing engine particle meshes

- irampagingrhin0
-- NV_JediCruiser - Fixed Venator shield/bumpmap mesh

- theshyshallot
-- UB_XX_Station - Fixed Consortium space station models having irregular collision
-- RB/UB_TLTower - Fixed red muzzle flashes for Consortium & Rebel turbolaser tower models
-- NV_SwampSpeeder_U - Fixed Consortium swamp speeder models not using Consortium infantry (v2.0)
-- UV_CanderousAssaultTank - Fixed Canderous Assault Tank shadow mesh/collision boxes (v2.0)


Scripting:
- __pox__
-- Extra info regarding Flush_G() and clearing loaded global tables.

- cha20202
-- Script reworks to re-enable the EaW GCs and story campaigns.

- galyana
-- ObjectScript_Interdictor - Improved AI script enabling the and improve Missile Shield usage.
-- ObjectScript_MissileShield - Improved AI script improving Missile Shield usage.
-- ObjectScript_SensorJamming - New AI script enabling the Sensor Jamming ability for AI and autofire.


Text:
- Jorritkarwehr & arch_fallen
-- Creating the .DAT Assembler; arch_fallen for creating a UI for it (https://github.com/Vardamir117/datassembler / https://discord.com/channels/401148449241956353/413428854510845953/738243575976034337)

- mike.nl (Mike Lankamp)
-- DAT String Editor (https://modtools.petrolution.net/tools/StringEditor)

- Unknown Users/Contributors (SabanYanko.com)
-- Japanese localization for Forces of Corruption. (https://sabanyanko.web.fc2.com/starwarsempireatwarfoc/)


Texturing:
- .lany
-- UV_CrusaderClassCorvette.dds - Inspiration for new team coloring
-- NV_IPV1.dds - Inspiration for new team coloring
-- I_Minimap_Empire_Dock.tga - Minimap icon for the drydock props

- cha20202
-- I_Button_Mustafarian.tga - Tooltip icon for Mustafarians

- Galyana
-- NV_IPV1.dds - Inspiration for new team coloring
-- I_Hard_Point... .dds - New HD hard point reticles

- evilbobthebob
-- 16x Anisotropic Filtering shaders (https://discord.com/channels/401148449241956353/413428854510845953/483771208178073601)
-- Method to generate map previews


Misc:
- Empire at War Community Server (discord.gg/empireatwar)
-- General support, community feedback, bug reporting, etc., etc.

- Empire at War Modder's Hub
-- General/technical support, etc., etc.

- Secrets of a Fallen Empire
-- General support, extra bugfixes, etc., etc.

- Kad (_lgr_)
-- .MEG Cooker from Yuuzhan Vong at War
-- General support on UFoCP's GitHub.

- Iosevka Contributors et al.
-- Iosevka font by Contribs. et al (79 people as of 06/2026!), at https://github.com/be5invis/Iosevka
-- Open source font (SIL Open Font License v1.1/OFL-1.1 License, http://scripts.sil.org/OFL) used for
	"EXPANSION" and variants on the recreated EAW/FOC logos used on the loading screen/main menu.

- Thomas Phinney, Vassil Kateliev & Brandon Buerkle
-- Science Gothic font by Thomas Phinney, Vassil Kateliev & Brandon Buerkle, at https://fonts.google.com/specimen/Science+Gothic
-- Open source font (SIL Open Font License v1.1/OFL-1.1 License, http://scripts.sil.org/OFL) used for
	the Russian and Ukrainian EaW/FoC logos.

- artakana
-- Dela Gothic One by artakana, at https://fonts.google.com/specimen/Dela+Gothic+One
-- Open source font (SIL Open Font License v1.1/OFL-1.1 License, http://scripts.sil.org/OFL) used for
	the Japanese EaW/FoC logos.

- Herman Schechkin's ASCII-Generator.site (https://github.com/hermanTenuki/ASCII-Generator.site)
-- UFoCP's wonderful ASCII logos in the changelogs and Readme.txt, using the "big" setting.