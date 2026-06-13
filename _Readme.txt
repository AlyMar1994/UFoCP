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

v2.2.0.1520 brings with it a host of new text fixes, various enhancements and MP
stability improvements.  This update was a bit of a doozy - so much (given some last-
minute bug requests) that I decided to hold off of publishing v2.2.0 on May 13th until
June.

MP stability should be greatly improved for Steam users.  More assertions were fixed, and
various objects are now removed upon death so they don't keep bogging down the network. In
addition, some maps (for both GC and Skirmish) are now net-positive in network performance,
as certain map props were switched out with MP-friendly versions.

On the enhancement side of things, Rogue Squadron has been rebalanced - ever since UFCP's
initial release, Rogue Squad has been derided as one of the worst performing units in the
Hero roster.  Now, they initially operate more similarly to Darth Vader & Black Squadron,
with Wedge being a powerful and tanky frontman for the high-damage and tanky wingmen.
Their abilities - Strike! and Lock S-Foils - have also been rebalanced.  Strike! no longer
gives all-round benefits, and each ability now only improves one area.  Strike! deals better
damage, firing speed and shield regen, while Lock S-Foils is now a better version of the
standard X-wing ability and increase speed multiplicatively.
Remember to bring corvettes!

Also of note are completely redone EaW/FoC game logos, which include special, fanmade,
localized versions (by yours truly) in Italian and Spanish (which were initially
included in vanilla), Polish, Russian, Japanese and Ukrainian.  The Japanese and
Ukrainian ones will require some file renaming to work.  This push was to get rid of
the AI-upscaled game logos that we were initially using - while AI-upscaling isn't seen
as bad as AI-generation, we wanted to avoid the trouble overall.  The localized logos
were also added since they are a popular change in translation mods (such as the Korean,
Chinese and Ukrainian translations) - I was already creating a template to try and match
the official logos as close as possible, I figured that it'd be a nice gift to those who
lament having to constantly see English (especially if they don't use the Latin alphabet).

There's a ton in this update so I'm not going to go into more detail here, see the
changelog.  However, it's worth noting that the official Petroglyph update (in 2016) that
improved the game's grass shaders have been removed.  While having them cast shadows and be
visible underwater was a treat, it broke skybox rendering.  See the GitHub for more details,
it looked **really bad!**  We don't like reverting official changes, but it's an unfortunate
situation.

Known issues are recorded on the GitHub, hopefully to be solved for the upcoming patches.
If you find any bugs or have anything to report or ask for, make sure to visit the GitHub!

I hope you enjoy UFCP!  Send patches.
~AlyMar1994

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREDITS:
Modeling:
- .lany
-- P_Corrupt_Planet2.alo - More performant corruption particle

- galyana
-- UB_Barracks.alo - Fixed Consortium Barracks spawn bone
-- UB_Droidworks.alo - Fixed Consortium Droidworks spawn bones
-- NV_PSkiff_Underworld - Fixed Consortium Pirate Skiff not using Consortium infantry
-- NV_SwampSpeeder_U - Fixed shadow mesh (v2.1)
-- UV_CanderousAssaultTank.alo - Fixed/improved Canderous Assault Tanks animations, collision and model data (v2.1)
-- UV_Vengeance_HP_RGT_TB.alo - Fixed Vengeance Frigate turbolaser mesh
-- W_Bush_Swmp00.alo - New swamp bush model
-- RB_Station_03_HP03_IC.alo - Fixed lv.3 station ion cannon tower

- irampagingrhin0
-- NV_JediCruiser.alo - Fixed Venator shield/bumpmap mesh

- theshyshallot
-- UB_XX_Station.alo - Fixed Consortium space station models having irregular collision
-- RB/UB_TLTower.alo - Fixed red muzzle flashes for Consortium & Rebel turbolaser tower models
-- NV_SwampSpeeder_U.alo - Fixed Consortium swamp speeder models not using Consortium infantry (v2.0)
-- UV_CanderousAssaultTank.alo - Fixed Canderous Assault Tank shadow mesh/collision boxes (v2.0)


Scripting:
- __pox__
-- Extra info regarding Flush_G() and clearing loaded global tables.


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

- Galyana
-- NV_IPV1.dds - Inspiration for new team coloring

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