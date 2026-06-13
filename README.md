# UFCP
## Unofficial Forces of Corruption Patch
- Version: v2.2.0.1520
- License: The UnLicense (with a special request, please see LICENSE)
---
The Unofficial Forces of Corruption Patch is a one-does-all community patch for Petroglyph Games' "STAR WARS: Empire at War – Forces of Corruption."  UFCP's objective is to correct as many errors/bugs/glitches as possible in one convenient package, to whatever limit is available, within Petroglyph's Alamo engine.

You must legally own the [Steam/updated version](https://store.steampowered.com/app/32470/STAR_WARS_Empire_at_War__Gold_Pack/) of the STAR WARS: Empire at War - Gold Pack to work on UFCP.  Retail or GOG may work, though they are unsupported[1].

* [1]: "Unsupported," as in: this project is restricted to Windows.  The outdated Mac version of the game is unsupported, along with Linux emulation via Proton or Wine.  This patch may work with those versions, but there will be no guarantee of support should anything go wrong.  The current Windows Steam release is semi-frequently updated, and supported with new bugfixes and modding features from Petroglyph.

## Language Support
Officially, only English and German text are "supported" by UFCP.  These are languages that have _fully translated_ text included.  **HOWEVER!**  If UFCP needs to add new strings for whatever reason, those are added to all languages as well _in English_.  We are currently accepting translators/freetime translation help in Pull Requests from those who wish to assist.

To change the game's language, the parameter `LANGUAGE=[Language Name]` can be used, but the Language Name passthrough MUST be the English name of that language.

**NOTE:** The engine natively supports English, French (Français), German (Deutsch), Italian (Italiano), Polish (Polski), Russian (Русский) and Spain Spanish (Español).  Non-native languages _can_ be displayed - to use them, the "MasterTextFile_ENGLISH.dat" file has to be backed up somewhere, and the unsupported language file must be renamed to "MasterTextFile_ENGLISH.dat."  Instructions for non-native languages in local tongue are below:

### 日本（日本語）
「Unofficial Forces of Corruption Patch」では、バージョン2.2.0.1520以降、日本語が公式にはサポートされていないものの、利用可能な言語オプションとして追加されています。この翻訳は、日本のリアルタイムストラテジーゲームフォーラム「sabanyanko.web.fc2.com」から入手したもので、作成者は不明です。

ダウンロードしたMODで日本語に対応させるには、「MasterTextFile_ENGLISH.dat」を「MasterTextFile_ENGLISH.dat.bak」にリネームしてください。次に、「MasterTextFile_JAPANESE.dat」を「MasterTextFile_ENGLISH.dat」にリネームしてください。将来的には、Petroglyph社に対し、「LANGUAGE=JAPANESE」の起動オプションを再有効化するよう要望できることを願っています。

また、MODのファイル内には、ロード画面やメインメニューのタイトルを日本語化したバージョンが含まれています。これらを使用するには、（前述の通り）「Splash.dds」と「Menuback_Overlay.dds」の名前を変更し、「Splash_Japanese.dds」と「Menuback_Overlay_Japanese.dds」をそれぞれの英語版の名前に変更する必要があります。

### Україна (українська)
Наразі Unofficial Forces of Corruption Patch (UFCP) не підтримує українську мову як опцію. Я не маю дозволу від автора цього перекладу на його включення до цього модифікації і хочу дочекатися, поки його отримаю.

Однак, починаючи з версії 2.2.0.1520, UFCP містить екран завантаження та титульний екран головного меню, локалізовані українською мовою. Щоб ними скористатися, потрібно перейменувати файли «Splash.dds» та «Menuback_Overlay.dds» і/або створити їх резервну копію в безпечному місці. Потім, щоб вони працювали, файли «Splash_Ukrainian.dds» та «Menuback_Overlay_Ukrainian.dds» потрібно перейменувати на їхні англійські еквіваленти.

## Links
- Discord: https://discord.gg/ArFEBEPhYQ
- Bug Reports: https://github.com/AlyMar1994/UFoCP/issues
- Steam: https://steamcommunity.com/sharedfiles/filedetails/?id=1548018187
- ModDB: https://www.moddb.com/mods/unofficial-forces-of-corruption-patch
- Nexus: https://www.nexusmods.com/starwarsempireatwar/mods/1856
