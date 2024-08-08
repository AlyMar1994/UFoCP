# UFoCP
## Unofficial Forces of Corruption Patch
- Version: v2.0.0.####
- License: TBA
---
The Unofficial Forces of Corruption Patch is a one-does-all community patch for Petroglyph Games' 2006 RTS "STAR WARS: Empire at War – Forces of Corruption."  The goal of UFoCP is to correct as many errors as possible to whatever limit is available within Petroglyph's Alamo engine in one convenient package.

You must legally own the [Steam](https://store.steampowered.com/app/32470/STAR_WARS_Empire_at_War__Gold_Pack/) updated version of the STAR WARS: Empire at War - Gold Pack to work on UFoCP.  Retail or GOG may work, though they are unsupported.

## Prerequisities
This project is Windows restricted.  The outdated Mac version of the game is unsupported, along with any Linux emulations.  This doesn't mean the patch won't work with those versions, more that there will be no support should anything go wrong.

### Editors
#### Programming
Anything which properly parses [Lua](https://www.lua.org/) and [XML](https://www.w3.org/xml) will function correctly.  This includes (but is not limited to):
- [Notepad++](https://notepad-plus-plus.org/)
- [Sublime Text](https://www.sublimetext.com/)
- [Visual Studio Code](https://code.visualstudio.com/)

In addition, plugins that assist with mod development exist (mainly for VSC).  That includes:
- [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko
- [EaW EmmyLua Docs](https://github.com/AlamoEngine-Tools/eaw-emmyluadoc)
- [XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) by Red Hat
- [vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format) by Koihik

#### Mapping
TED maps are modified through the official map editor.  An update was released for it to support the latest Steam version.

The map editor occasionally has problems interpreting mod content, and may delete some files when opened in a mod folder.  An additional, optional patch exists which fixes this on the download page.
- [FoC Map Editor](https://modtools.petrolution.net/tools/MapEditor)
- [Official Update](http://www.petroglyphgames.com/eawmodtool/)

#### Modeling
Forces of Corruption and Petroglyph's second game Universe at War uses ALO/ALA 2.0 for models and animations.

When installing the map editor, an Autodesk 3DS Max 8 and 9 version of Petroglyph's official plugin are provided within the game's files.  3DS Max 8 and 9 cannot be aquired legally anymore.  The app itself is glitchy on modern computers, making 3DS Max an unrecommended model editor.

[Gaukler](https://github.com/Gaukler) created a Blender plugin that interprets ALO and ALA effectively, including quality-of-life warnings, and was updated subsequently by the maintainers at [AlamoEngine-Tools](https://github.com/AlamoEngine-Tools).  This plugin DOES NOT support ALA 1.0 included with Empire at War, and will require an animation converter.
- [ALAMO Plugin](https://github.com/AlamoEngine-Tools/Mirror-Blender-Alamo-Plugin)
- [Animation Converter](https://modtools.petrolution.net/tools/AnimationConverter)
- [ALOViewer](http://modtools.petrolution.net/tools/AloViewer)

#### Texturing
Forces of Corruption and the repo works with TGA, DDS, ICO and PNG (with DDS and TGA having advanced transparency settings to work with team coloring and texture blending).  Multiple texture editors exist and will work:
- [Adobe Photoshop](https://www.adobe.com/products/photoshop.html)
- [Adobe Photoshop - NVIDIA's DDS Support](https://developer.nvidia.com/nvidia-texture-tools-exporter)
- [Paint.NET](https://www.getpaint.net/)
- [GIMP](https://www.gimp.org/)

## Links
- Discord: https://discord.gg/empireatwar
- Bug Reports: https://github.com/AlyMar1994/UFoCP/issues
- Steam: https://steamcommunity.com/sharedfiles/filedetails/?id=1548018187
- ModDB: https://www.moddb.com/mods/unofficial-forces-of-corruption-patch
- Nexus: https://www.nexusmods.com/starwarsempireatwar/mods/1856
