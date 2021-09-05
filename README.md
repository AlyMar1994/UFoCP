# UFoCP
## Unofficial Forces of Corruption Patch
The Unofficial Forces of Corruption Patch is a one-does all community made patch for Petroglyph Games' 2006 hit RTS "STAR WARS: Empire at War – Forces of Corruption."  The goal of UFoCP is to correct as many errors as possible to whatever limit is available within Petroglyph's "Alamo" engine, in one convenient package.

To join, you must legally own the [Steam](https://store.steampowered.com/app/32470/STAR_WARS_Empire_at_War__Gold_Pack/) updated version of the STAR WARS: Empire at War - Gold Pack.  Retail or GOG may work, but is not supported.  Nor is the Apple, or Linux-emulated version.

---

- Version: v1.0.1.####
- License: TBA

---

## Prerequisities
This project is Windows OS restricted.  The outdated Apple version of the game is unsupported, along with any emulated Linux ports.

### Editors
#### Programming
Anything which properly parses/interprets [Lua](https://www.lua.org/) and [XML](https://www.w3.org/xml) will function correctly.  This includes (but is not limited to) the following:
- [Notepad++](https://notepad-plus-plus.org/)
- [Sublime Text](https://www.sublimetext.com/)
- [Visual Studio Code](https://code.visualstudio.com/)

In addition, Visual Studio Code has a variety of plugins which are supported and assist with mod development.  This includes:
- [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko
- [XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) by Red Hat
- [vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format) by Koihik

#### Mapping
Mapping is handled through Petroglyph's [map editor](https://modtools.petrolution.net/tools/MapEditor).

#### Modeling
UFoCP utilizes the .ALO and .ALA v2 model format.  This is utilized by Forces of Corruption, and Petroglyph's second game Universe at War.

When installing the map editor, an Autodesk 3DS Max 8 & 9 version of a model editor plugin is provided within the main directory.  These versions of 3DS Max cannot be acquired by legal means anymore, and are unfortunately buggy.  This makes 3DS Max an unrecommended model editor.  However, Gaukler has created a Blender plugin which interprets ALO and ALA effectively, including warnings and errors and imrpovement to customization for better practices when modeling.  This can be found [here](https://github.com/Gaukler/Blender-ALAMO-Plugin).  This plugin DOES NOT support .ALA v1 included with Empire at War.

A model viewer is also recommended when testing new models.  A relatively simple and effective model viewer can be found [here](http://modtools.petrolution.net/tools/AloViewer).

#### Texturing
[Adobe Photoshop](https://www.adobe.com/products/photoshop.html) is recommended for more powerful editing tools.  However, it is expensive, despite cracked versions existing everywhere.  Photoshop will need NVIDIA's image processing plugin to support the .DDS format.  Here are some decent alternatives.  Please use one of these.
- [Paint.NET](https://www.getpaint.net/)
- [GIMP](https://www.gimp.org/)

## Links
- Bug Reports: https://github.com/AlyMar1994/UFoCP/issues
- Steam: https://steamcommunity.com/sharedfiles/filedetails/?id=1548018187
- ModDB: https://www.moddb.com/mods/unofficial-forces-of-corruption-patch
- Nexus: https://www.nexusmods.com/starwarsempireatwar/mods/1856