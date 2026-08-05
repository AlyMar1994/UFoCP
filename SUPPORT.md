# Support
## General Support
Releases are done, typically, at the 13th of every month (exceptions being if Aly is on break, or if testing of new stuff isn't done).  If a release isn't done on a month, it's typically pushed to the next month, unless a hotfix is needed.

For basically all questions and concerns, the repo's primary maintainer can be contacted on Discord, specifically on the Empire at War Community Discord (linked at the bottom of README.md), with "@alymar1994."  I don't shy away from pings, just ask your question in any of the "#ufcp-" prefixed channels.  Misc. questions can be opened in the Issues tab.

### Asking Quality Questions
(section shamelessly stolen from ![remarkjs](https://github.com/remarkjs/.github/blob/main/support.md) )

* Don't fall for the [XY problem][https://meta.stackexchange.com/questions/66377/what-is-the-xy-problem/66378#66378]
* Search to find out if a similar question has been asked
* Screenshots can help, but if there's important text such as code or error messages in them, please also provide those as text
* The more time you put into asking your question, the better we can help you

---

## Language Support
As of v2.4.0.XXXX, all languages are supported by UFCP as provided.  Supported languages have _fully translated_ text included, unlike pre-2.4 versions, which only had English text ported to the respective languages.  We are always in need of and accepting translators/freetime translation help in Pull Requests from those who wish to assist.

To change the game's language, the parameter `LANGUAGE=[Language Name]` can be used, but the [Language Name] passthrough _must be the English name of that language._

**NOTE:** The engine natively supports English, French (Français), German (Deutsch), Italian (Italiano), Polish (Polski), Russian (Русский) and Spain Spanish (Español).  Non-native languages _can_ be displayed - in the mod's `data/text` folder, the "MasterTextFile_ENGLISH.dat" file has to be backed up somewhere, and the unsupported language file must be renamed to "MasterTextFile_ENGLISH.dat."  Instructions and quirks for non-native languages in local tongue are below:

### 日本（日本語）
「Unofficial Forces of Corruption Patch」では、バージョン2.2.0.1520以降、日本語が公式にはサポートされていないものの、利用可能な言語オプションとして追加されています。この翻訳は、日本のリアルタイムストラテジーゲームフォーラム「sabanyanko.web.fc2.com」から入手したもので、作成者は不明です。

ダウンロードしたMODで日本語に対応させるには、「MasterTextFile_ENGLISH.dat」を「MasterTextFile_ENGLISH.dat.bak」にリネームしてください。次に、「MasterTextFile_JAPANESE.dat」を「MasterTextFile_ENGLISH.dat」にリネームしてください。将来的には、Petroglyph社に対し、「LANGUAGE=JAPANESE」の起動オプションを再有効化するよう要望できることを願っています。

また、MODのファイル内には、ロード画面やメインメニューのタイトルを日本語化したバージョンが含まれています。これらを使用するには、（前述の通り）「Splash.dds」と「Menuback_Overlay.dds」の名前を変更し、「Splash_Japanese.dds」と「Menuback_Overlay_Japanese.dds」をそれぞれの英語版の名前に変更する必要があります。

### Россия (русский)
Unofficial Forces of Corruption Patch (UFCP) изначально поддерживает русский язык, поскольку он встроенно поддерживается в игровом движке. Однако при использовании параметра командной строки «LANGUAGE=RUSSIAN» игра отключает свой собственный научно-фантастический шрифт и вместо него использует шрифт Arial. Это жестко запрограммировано и не может быть отключено, что вступает в конфликт с файлом пользовательского шрифта, предоставляемым UFCP.

Если вас это беспокоит, чтобы включить поддержку пользовательского шрифта, переименуйте файл «MasterTextFile_ENGLISH.dat» в «MasterTextFile_ENGLISH.dat.bak», затем переименуйте файл «MasterTextFile_RUSSIAN.dat» в «MasterTextFile_ENGLISH.dat». Мы надеемся, что в будущем сможем обратиться к Petroglyph с просьбой отключить эту жестко запрограммированную замену шрифтов. Обратите внимание, что использование этого метода приведёт к отключению пользовательской графики для экрана загрузки и главного меню на русском языке, если эти файлы не будут также переименованы.

### Україна (українська)
Наразі Unofficial Forces of Corruption Patch (UFCP) не підтримує українську мову як опцію. Я не маю дозволу від автора цього перекладу на його включення до цього модифікації і хочу дочекатися, поки його отримаю.

Однак, починаючи з версії 2.2.0.1520, UFCP містить екран завантаження та титульний екран головного меню, локалізовані українською мовою. Щоб ними скористатися, потрібно перейменувати файли «Splash.dds» та «Menuback_Overlay.dds» і/або створити їх резервну копію в безпечному місці. Потім, щоб вони працювали, файли «Splash_Ukrainian.dds» та «Menuback_Overlay_Ukrainian.dds» потрібно перейменувати на їхні англійські еквіваленти.
