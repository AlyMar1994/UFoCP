## Prerequisities
To work on UFCP, you may need a combination of the following tools (depending on what area of the mod you wish to work on):

### Workspaces
#### Debugging
The official debugging client was released around 2020, and has been recently updated multiple times for and after the 64-bit Patch.  It's a drag-and-drop set of files for both EaW and FoC that enables console commands, a variety of logging and debugging features to diagnose game-related problems.  Instructions are included within the download.
- [Debugging Client](https://petroglyphgames.com/eawmodtool/) [(Direct Download)](http://www.petroglyphgames.com/eawmodtool/EAW_FOC_Debug_Kit_64.zip)

#### Programming
Anything which properly parses [Lua](https://www.lua.org/) and [XML](https://www.w3.org/xml) will work.  This includes (but not limited to):
- [Visual Studio Code](https://code.visualstudio.com/)
- [Notepad++](https://notepad-plus-plus.org/)
- [Sublime Text](https://www.sublimetext.com/)

In addition, plugins that assist with mod development exist (mainly for VSC).  That includes:
- [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) by sumneko
- [EaW EmmyLua Docs](https://github.com/AlamoEngine-Tools/eaw-emmyluadoc)
- [XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) by Red Hat
- [vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format) by Koihik

#### Mapping
TED maps are Terrain Editor Data modified through the official map editor.  An update was initially released to support updates on Steam, but it's been updated again with new bugfixes, and is now completely unlocked.  All developer-mode tools (Cinematics, Paths, Animation, etc.) have now been unlocked and is available for modders on Petroglyph's official website.
- [Developer Map Editor](http://www.petroglyphgames.com/eawmodtool/) [(Direct Download)](https://www.petroglyphgames.com/eawmodtool/FOCMapEditor.msi)

#### Modeling
Forces of Corruption and Petroglyph's second game Universe at War uses ALO/ALA 2.0 for models and animations.

When installing the map editor, an Autodesk 3DS Max 8 and 9 version of Petroglyph's official plugin are provided within the game's files.  3DS Max 8 and 9 cannot be aquired legally anymore.  The app itself is also buggy on modern computers, making 3DS Max an unrecommended model editor.

[Gaukler](https://github.com/Gaukler) created a Blender plugin that interprets ALO and ALA effectively, including quality-of-life warnings, and has currently been maintained by [evilbobthebob](https://github.com/andrewfullard).  This plugin DOES NOT support ALA 1.0 included with Empire at War, and will require Mike.nl's animation converter.
- [ALAMO Plugin](https://github.com/andrewfullard/Blender-ALAMO-Plugin)
- [Animation Converter](https://modtools.petrolution.net/tools/AnimationConverter)
- [Model Viewer (ALOViewer)](https://github.com/gryttr/alo-viewer)

#### Texturing
Forces of Corruption, and this repo, works with TGA, DDS, ICO and PNG (with DDS and TGA having advanced transparency settings to work with team coloring and texture blending).  Multiple texture editors exist and will work, but note that Paint(dot)NET is unable to correctly work with the alpha layers of most of FoC's textures.
- [Adobe Photoshop](https://www.adobe.com/products/photoshop.html)
- [Adobe Photoshop - NVIDIA DDS Support](https://developer.nvidia.com/nvidia-texture-tools-exporter)
- [Affinity by Canva](https://www.affinity.studio/download) (Warning: Does not yet support DDS.)
- [GIMP](https://www.gimp.org/)
- [Paint(dot)NET](https://www.getpaint.net/)