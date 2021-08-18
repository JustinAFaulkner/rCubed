package options
{
    import arc.ArcGlobals;
    import classes.Alert;
    import classes.Language;
    import classes.Playlist;
    import classes.chart.parse.ChartFFRLegacy;
    import classes.ui.BoxButton;
    import classes.ui.BoxCheck;
    import classes.ui.Prompt;
    import classes.ui.Text;
    import classes.ui.ValidatedText;
    import com.bit101.components.ComboBox;
    import com.bit101.components.Style;
    import com.flashfla.utils.sprintf;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import menu.MainMenu;

    public class SettingsTabMisc extends SettingsTabBase
    {

        private var _gvars:GlobalVariables = GlobalVariables.instance;
        private var _lang:Language = Language.instance;
        private var _avars:ArcGlobals = ArcGlobals.instance;
        private var _playlist:Playlist = Playlist.instance;

        private var startUpScreenSelections:Array = [];

        private var optionFPS:ValidatedText;
        private var forceJudgeCheck:BoxCheck;

        private var optionMPSize:ValidatedText;
        private var timestampCheck:BoxCheck;
        private var startUpScreenCombo:ComboBox;
        private var optionGameLanguages:Array;
        private var languageCombo:ComboBox;
        private var languageComboIgnore:Boolean;
        private var engineCombo:ComboBox;
        private var engineDefaultCombo:ComboBox;
        private var engineComboIgnore:Boolean;
        private var legacySongsCheck:BoxCheck;

        private var useCacheCheckbox:BoxCheck;
        private var autoSaveLocalCheckbox:BoxCheck;
        private var useVSyncCheckbox:BoxCheck;
        private var useWebsocketCheckbox:BoxCheck;
        private var openWebsocketOverlay:BoxButton;

        public function SettingsTabMisc(settingsWindow:SettingsWindow):void
        {
            super(settingsWindow);
        }

        override public function get name():String
        {
            return "misc";
        }

        override public function openTab():void
        {
            var i:int;
            var xOff:int = 15;
            var yOff:int = 15;

            /// Col 1
            //- Game Languages
            optionGameLanguages = [];
            var gameLanguageLabel:Text = new Text(container, xOff, yOff, _lang.string("options_game_language"));
            yOff += 20;

            var selectedLanguage:String = "";
            for (var id:String in _lang.indexed)
            {
                var lang:String = _lang.indexed[id];
                var lang_name:String = _lang.string2Simple("_real_name", lang) + (_lang.data[lang]['_en_name'] != _lang.data[lang]['_real_name'] ? (' / ' + _lang.string2Simple("_en_name", lang)) : '');
                optionGameLanguages.push({"label": lang_name, "data": lang});
                if (lang == _gvars.activeUser.language)
                {
                    selectedLanguage = lang_name;
                }
            }

            languageCombo = new ComboBox(container, xOff, yOff, selectedLanguage, optionGameLanguages);
            languageCombo.x = xOff;
            languageCombo.y = yOff;
            languageCombo.width = 200;
            languageCombo.openPosition = ComboBox.BOTTOM;
            languageCombo.fontSize = 11;
            languageCombo.addEventListener(Event.SELECT, languageSelect);
            setLanguage();
            yOff += 30;

            // Start Up Screen
            new Text(container, xOff, yOff, _lang.string("options_startup_screen"));
            yOff += 20;

            startUpScreenSelections = [];
            for (i = 0; i <= 2; i++)
            {
                startUpScreenSelections.push({"label": _lang.stringSimple("options_startup_" + i), "data": i});
            }

            startUpScreenCombo = new ComboBox(container, xOff, yOff, "Selection...", startUpScreenSelections);
            startUpScreenCombo.x = xOff;
            startUpScreenCombo.y = yOff;
            startUpScreenCombo.width = 200;
            startUpScreenCombo.openPosition = ComboBox.BOTTOM;
            startUpScreenCombo.fontSize = 11;
            startUpScreenCombo.addEventListener(Event.SELECT, startUpScreenSelect);
            yOff += 30;

            yOff += drawSeperator(container, xOff, 250, yOff, 0, 0);

            // Engine Framerate
            new Text(container, xOff, yOff, _lang.string("options_framerate"));
            yOff += 20;

            optionFPS = new ValidatedText(container, xOff, yOff, 120, 20, ValidatedText.R_INT_P, changeHandler);
            yOff += 30;

            CONFIG::vsync
            {
                new Text(container, xOff + 23, yOff, _lang.string("air_options_use_vsync"));
                useVSyncCheckbox = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
                yOff += 30;
            }

            yOff += drawSeperator(container, xOff, 250, yOff, 0, 0);

            // Force engine Judge Mode
            new Text(container, xOff + 23, yOff, _lang.string("options_force_judge_mode"));
            forceJudgeCheck = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            yOff += 30;

            new Text(container, xOff + 23, yOff, _lang.string("air_options_save_local_replays"));
            autoSaveLocalCheckbox = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            yOff += 30;

            new Text(container, xOff + 23, yOff, _lang.string("air_options_use_cache"));
            useCacheCheckbox = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            yOff += 30;

            new Text(container, xOff + 23, yOff, _lang.string("air_options_use_websockets"));
            useWebsocketCheckbox = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            useWebsocketCheckbox.addEventListener(MouseEvent.MOUSE_OVER, e_websocketMouseOver, false, 0, true);
            yOff += 30;

            // https://github.com/flashflashrevolution/web-stream-overlay
            openWebsocketOverlay = new BoxButton(container, xOff, yOff, 200, 27, _lang.string("options_overlay_instructions"), 12, clickHandler);
            yOff += 30;

            /// Col 2
            xOff = 330;
            yOff = 15;

            // Game Engine
            new Text(container, xOff, yOff, _lang.string("options_game_engine"));
            yOff += 20;

            engineCombo = new ComboBox();
            engineCombo.x = xOff;
            engineCombo.y = yOff;
            engineCombo.width = 200;
            engineCombo.openPosition = ComboBox.BOTTOM;
            engineCombo.fontSize = 11;
            engineCombo.addEventListener(Event.SELECT, engineSelect);
            container.addChild(engineCombo);
            yOff += 30;

            // Default Game Engine
            new Text(container, xOff, yOff, _lang.string("options_default_game_engine"));
            yOff += 20;

            engineDefaultCombo = new ComboBox();
            engineDefaultCombo.x = xOff;
            engineDefaultCombo.y = yOff;
            engineDefaultCombo.width = 200;
            engineDefaultCombo.openPosition = ComboBox.BOTTOM;
            engineDefaultCombo.fontSize = 11;
            engineDefaultCombo.addEventListener(Event.SELECT, engineDefaultSelect);
            container.addChild(engineDefaultCombo);
            engineRefresh();
            yOff += 30;

            // Legacy Song Display
            new Text(container, xOff + 23, yOff, _lang.string("options_include_legacy_songs"));
            legacySongsCheck = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            legacySongsCheck.addEventListener(MouseEvent.MOUSE_OVER, e_legacyEngineMouseOver, false, 0, true);
            yOff += 30;

            yOff += drawSeperator(container, xOff, 250, yOff, 0, 0);

            // Multiplayer - Text Size
            new Text(container, xOff, yOff, _lang.string("options_mp_textsize"));
            yOff += 20;

            optionMPSize = new ValidatedText(container, xOff, yOff, 120, 20, ValidatedText.R_INT_P, changeHandler);
            optionMPSize.text = "10";
            yOff += 30;

            // Multiplayer - Timestamps
            new Text(container, xOff + 23, yOff, _lang.string("options_mp_timestamp"));
            timestampCheck = new BoxCheck(container, xOff + 3, yOff + 3, clickHandler);
            yOff += 30;

            setTextMaxWidth(245);
        }

        override public function setValues():void
        {
            // Set Framerate
            optionFPS.text = _gvars.activeUser.frameRate.toString();

            forceJudgeCheck.checked = _gvars.activeUser.forceNewJudge;

            timestampCheck.checked = _gvars.activeUser.DISPLAY_MP_TIMESTAMP;
            legacySongsCheck.checked = _gvars.activeUser.DISPLAY_LEGACY_SONGS;
            optionMPSize.text = _avars.configMPSize.toString();
            startUpScreenCombo.selectedIndex = _gvars.activeUser.startUpScreen;

            setLanguage();

            autoSaveLocalCheckbox.checked = _gvars.air_autoSaveLocalReplays;
            useCacheCheckbox.checked = _gvars.air_useLocalFileCache;
            useWebsocketCheckbox.checked = _gvars.air_useWebsockets;

            CONFIG::vsync
            {
                useVSyncCheckbox.checked = _gvars.air_useVSync;
            }
        }

        override public function clickHandler(e:MouseEvent):void
        {
            // Force Judge Mode
            if (e.target == forceJudgeCheck)
            {
                e.target.checked = !e.target.checked;
                _gvars.activeUser.forceNewJudge = !_gvars.activeUser.forceNewJudge;
            }

            // MP Timestamp
            else if (e.target == timestampCheck)
            {
                e.target.checked = !e.target.checked;
                _gvars.activeUser.DISPLAY_MP_TIMESTAMP = !_gvars.activeUser.DISPLAY_MP_TIMESTAMP;
            }

            // Legacy Songs
            else if (e.target == legacySongsCheck)
            {
                e.target.checked = !e.target.checked;
                _gvars.activeUser.DISPLAY_LEGACY_SONGS = !_gvars.activeUser.DISPLAY_LEGACY_SONGS;
            }

            //- Auto Save Local Replays
            else if (e.target == autoSaveLocalCheckbox)
            {
                e.target.checked = !e.target.checked;
                _gvars.air_autoSaveLocalReplays = !_gvars.air_autoSaveLocalReplays;
                LocalStore.setVariable("air_autoSaveLocalReplays", _gvars.air_autoSaveLocalReplays);
            }

            //- Auto Save Local Replays
            else if (e.target == useCacheCheckbox)
            {
                e.target.checked = !e.target.checked;
                _gvars.air_useLocalFileCache = !_gvars.air_useLocalFileCache;
                LocalStore.setVariable("air_useLocalFileCache", _gvars.air_useLocalFileCache);
            }

            //- Vsync Toggle
            else if (e.target == useVSyncCheckbox)
            {
                e.target.checked = !e.target.checked;
                CONFIG::vsync
                {
                    _gvars.gameMain.stage.vsyncEnabled = _gvars.air_useVSync = !_gvars.air_useVSync;
                    LocalStore.setVariable("air_useVSync", _gvars.air_useVSync);
                }
            }

            // Use HTTP Websockets
            else if (e.target == useWebsocketCheckbox)
            {
                if (_gvars.air_useWebsockets)
                {
                    _gvars.destroyWebsocketServer();
                    _gvars.air_useWebsockets = false;
                    useWebsocketCheckbox.checked = false;
                    LocalStore.setVariable("air_useWebsockets", _gvars.air_useWebsockets);
                }
                else
                {
                    if (_gvars.initWebsocketServer())
                    {
                        _gvars.air_useWebsockets = true;
                        useWebsocketCheckbox.checked = true;
                        LocalStore.setVariable("air_useWebsockets", _gvars.air_useWebsockets);
                        e_websocketMouseOver();
                    }
                    else
                    {
                        useWebsocketCheckbox.checked = false;
                        Alert.add(_lang.string("air_options_unable_to_start_websockets"), 120, Alert.RED);
                    }
                }
            }

            // HTTP Websockets Instructions
            else if (e.target == openWebsocketOverlay)
            {
                navigateToURL(new URLRequest(Constant.WEBSOCKET_OVERLAY_URL), "_blank");
                return;
            }
        }

        override public function changeHandler(e:Event):void
        {
            if (e.target == optionFPS)
            {
                _gvars.activeUser.frameRate = optionFPS.validate(60);
                _gvars.activeUser.frameRate = Math.max(Math.min(_gvars.activeUser.frameRate, 1000), 10);
                _gvars.removeSongFiles();
            }

            else if (e.target == optionMPSize)
            {
                Style.fontSize = _avars.configMPSize = optionMPSize.validate(10);
                _avars.mpSave();
            }
        }

        private function e_legacyEngineMouseOver(e:Event):void
        {
            legacySongsCheck.addEventListener(MouseEvent.MOUSE_OUT, e_legacyEngineMouseOut);
            displayToolTip(legacySongsCheck.x, legacySongsCheck.y + 22, _lang.string("popup_legacy_songs"), "left");
        }

        private function e_legacyEngineMouseOut(e:Event):void
        {
            legacySongsCheck.removeEventListener(MouseEvent.MOUSE_OUT, e_legacyEngineMouseOut);
            hideTooltip();
        }

        private function e_websocketMouseOver(e:Event = null):void
        {
            if (_gvars.air_useWebsockets)
            {
                var activePort:uint = _gvars.websocketPortNumber("websocket");
                if (activePort > 0)
                {
                    useWebsocketCheckbox.addEventListener(MouseEvent.MOUSE_OUT, e_websocketMouseOut);
                    displayToolTip(useWebsocketCheckbox.x, useWebsocketCheckbox.y + 22, sprintf(_lang.string("air_options_active_port"), {"port": _gvars.websocketPortNumber("websocket").toString()}));
                }
            }
        }

        private function e_websocketMouseOut(e:Event):void
        {
            useWebsocketCheckbox.removeEventListener(MouseEvent.MOUSE_OUT, e_websocketMouseOut);
            hideTooltip();
        }

        private function startUpScreenSelect(e:Event):void
        {
            _gvars.activeUser.startUpScreen = e.target.selectedItem.data as int;
        }

        private function setLanguage():void
        {
            languageComboIgnore = true;
            languageCombo.selectedItemByData = _gvars.activeUser.language;
            languageComboIgnore = false;
        }

        private function languageSelect(e:Event):void
        {
            if (!languageComboIgnore)
            {
                _gvars.activeUser.language = e.target.selectedItem.data as String;

                _gvars.gameMain.activePanel.draw();
                _gvars.gameMain.buildContextMenu();

                if (_gvars.gameMain.activePanel is MainMenu)
                {
                    var mmpanel:MainMenu = (_gvars.gameMain.activePanel as MainMenu);
                    mmpanel.updateMenuMusicControls();
                }

                // refresh popup
                _gvars.gameMain.addPopup(Main.POPUP_OPTIONS);
            }
        }

        private function engineDefaultSelect(e:Event):void
        {
            if (!engineComboIgnore)
            {
                _avars.legacyDefaultEngine = (e.target as ComboBox).selectedItem.data;
                _avars.legacyDefaultSave();
            }
        }

        private function e_addEngine(url:String):void
        {
            ChartFFRLegacy.parseEngine(url, engineAdd);
        }

        private function engineSelect(e:Event):void
        {
            var data:Object = engineCombo.selectedItem.data;
            // Add Engine
            if (data == this)
            {
                new Prompt(parent, 320, "Engine URL", 120, "Add Engine", e_addEngine);
            }
            // Clears Engines
            else if (data == engineCombo)
            {
                _avars.legacyEngines = [];
                _avars.legacySave();
                engineRefresh();
            }
            // Change Engine
            else if (!engineComboIgnore && data != _avars.configLegacy)
            {
                _avars.configLegacy = data;
                _playlist.addEventListener(GlobalVariables.LOAD_COMPLETE, _playlist.engineChangeHandler);
                _playlist.addEventListener(GlobalVariables.LOAD_ERROR, _playlist.engineChangeHandler);
                _playlist.load();
            }
        }

        private function engineAdd(engine:Object):void
        {
            Alert.add("Engine Loaded: " + engine.name, 80);
            for (var i:int = 0; i < _avars.legacyEngines.length; i++)
            {
                if (_avars.legacyEngines[i].id == engine.id)
                {
                    engine.level_ranks = _avars.legacyEngines[i].level_ranks;
                    _avars.legacyEngines[i] = engine;
                    break;
                }
            }
            if (i == _avars.legacyEngines.length)
                _avars.legacyEngines.push(engine);
            _avars.legacySave();
            engineRefresh();
        }

        private function engineRefresh():void
        {
            engineComboIgnore = true;

            // engine Playlist Select
            engineCombo.removeAll();
            engineDefaultCombo.removeAll();
            engineCombo.addItem({label: Constant.BRAND_NAME_LONG, data: null});
            engineDefaultCombo.addItem({label: Constant.BRAND_NAME_LONG, data: null});
            engineCombo.selectedIndex = 0;
            engineDefaultCombo.selectedIndex = 0;
            for each (var engine:Object in _avars.legacyEngines)
            {
                var item:Object = {label: engine.name, data: engine};
                if (!ChartFFRLegacy.validURL(engine["playlistURL"]))
                    continue;
                if (engine["config_url"] == null)
                {
                    Alert.add("Please re-add " + engine["name"] + ", missing required information.", 240, Alert.RED);
                    continue;
                }
                engineCombo.addItem(item);
                engineDefaultCombo.addItem(item);
                if (engine == _avars.configLegacy || (_avars.configLegacy && engine["id"] == _avars.configLegacy["id"]))
                    engineCombo.selectedItem = item;
                if (engine == _avars.legacyDefaultEngine || (_avars.legacyDefaultEngine && engine["id"] == _avars.legacyDefaultEngine["id"]))
                    engineDefaultCombo.selectedItem = item;
            }
            engineCombo.addItem({label: "Add Engine...", data: this});
            if (_avars.legacyEngines.length > 0 && engineCombo.items.length > 2)
                engineCombo.addItem({label: "Clear Engines", data: engineCombo});
            engineComboIgnore = false;
        }


    }
}
