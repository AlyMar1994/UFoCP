# UFoCP
## Unofficial Forces of Corruption Patch
- Version: v1.0.1.####
- License: TBA

---
The Unofficial Forces of Corruption Patch is a one-does-all community-made patch for Petroglyph Games' 2006 hit RTS "STAR WARS: Empire at War – Forces of Corruption."  The goal of UFoCP is to correct as many errors as possible to whatever limit is available within Petroglyph's "Alamo" engine in one convenient package.

You must legally own the [Steam](https://store.steampowered.com/app/32470/STAR_WARS_Empire_at_War__Gold_Pack/) updated version of the STAR WARS: Empire at War - Gold Pack to work on UFoCP.  Retail or GOG may work, though not supported.  Nor is the Mac or Linux-emulated version.

## Prerequisities
This project is Windows OS restricted.  The outdated Apple version of the game is unsupported, along with any emulated Linux ports.

### Editors
#### Programming
Anything which properly parses/interprets [Lua](https://www.lua.org/) and [XML](https://www.w3.org/xml) will function correctly.  This includes (but is not limited to) the following:
- [Notepad++](https://notepad-plus-plus.org/)
- [Sublime Text](https://www.sublimetext.com/)
- [Visual Studio Code](https://code.visualstudio.com/)

In addition, Visual Studio Code has many plugins that are supported and assist with mod development.  That includes:
- [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko
- [XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) by Red Hat
- [vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format) by Koihik

#### Mapping
TED maps are created/edited through Petroglyph's [Map Editor](https://modtools.petrolution.net/tools/MapEditor).

#### Modeling
UFoCP uses ALO/ALA v2 model formats.  Forces of Corruption and Petroglyph's second game Universe at War uses these two formats for models and animations inherently.

When installing the Map Editor an Autodesk 3DS Max 8 and 9 versions of Petroglyph's official plugin are provided within the game's files.  3DS Max 8 and 9 cannot be bought by legal means anymore.  The app itself is glitchy on modern computers, making 3DS Max an unrecommended model editor.  However, Gaukler has created a Blender plugin that interprets ALO and ALA effectively, including quality-of-life errors/warnings.  This can be found [here](https://github.com/Gaukler/Blender-ALAMO-Plugin).  This plugin DOES NOT support ALA v1 included with Empire at War, and will require an animation converter found [here](https://modtools.petrolution.net/tools/AnimationConverter).

A model viewer is recommended.  A relatively simple and effective viewer is available [here](http://modtools.petrolution.net/tools/AloViewer).

#### Texturing
[Adobe Photoshop](https://www.adobe.com/products/photoshop.html) is recommended for more powerful editing tools.  It is expensive though, despite cracked versions existing everywhere.  Photoshop will need [NVIDIA's image processing plugin](https://developer.nvidia.com/nvidia-texture-tools-exporter) to support the DDS format.  Here are some decent alternatives.
- [Paint.NET](https://www.getpaint.net/)
- [GIMP](https://www.gimp.org/)

## Links
- Bug Reports: https://github.com/AlyMar1994/UFoCP/issues
- Steam: https://steamcommunity.com/sharedfiles/filedetails/?id=1548018187
- ModDB: https://www.moddb.com/mods/unofficial-forces-of-corruption-patch
- Nexus: https://www.nexusmods.com/starwarsempireatwar/mods/1856