package net.wg.gui.lobby.settings.config
{
   import flash.display.DisplayObject;
   import flash.net.registerClassAlias;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.settings.SettingsChangesMap;
   import net.wg.gui.lobby.settings.vo.ColorFilerSettingsVo;
   import net.wg.gui.lobby.settings.vo.CursorTabsDataVo;
   import net.wg.gui.lobby.settings.vo.MarkerTabsDataVo;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.ControlsSettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.SettingConfigDataVo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SettingsConfigHelper implements IDisposable
   {
      
      private static var _instance:SettingsConfigHelper = null;
      
      public static const GAME_SETTINGS:String = "GameSettings";
      
      public static const GRAPHIC_SETTINGS:String = "GraphicSettings";
      
      public static const SOUND_SETTINGS:String = "SoundSettings";
      
      public static const CONTROLS_SETTINGS:String = "ControlsSettings";
      
      public static const CURSOR_SETTINGS:String = "AimSettings";
      
      public static const MARKER_SETTINGS:String = "MarkerSettings";
      
      public static const FEEDBACK_SETTINGS:String = "FeedbackSettings";
      
      public static const TYPE_CHECKBOX:String = "Checkbox";
      
      public static const TYPE_SLIDER:String = "Slider";
      
      public static const TYPE_STEP_SLIDER:String = "StepSlider";
      
      public static const TYPE_RANGE_SLIDER:String = "RangeSlider";
      
      public static const TYPE_DROPDOWN:String = "DropDown";
      
      public static const TYPE_BUTTON_BAR:String = "ButtonBar";
      
      public static const TYPE_LABEL:String = "Label";
      
      public static const TYPE_VALUE:String = "Value";
      
      public static const TYPE_KEYINPUT:String = "KeyInput";
      
      public static const TYPE_KEYINPUT_ITEM:String = "KeyInputItem";
      
      public static const TYPE_BUTTON:String = "Button";
      
      public static const LOCALIZATION:String = "#settings:";
      
      public static const ADVANCED_GRAPHICS_DATA:int = 0;
      
      public static const KEYS_LAYOUT:String = "keysLayout";
      
      public static const KEYS_TOOLTIPS:String = "keysTooltips";
      
      public static const KEYBOARD_IMPORTANT_BINDS:String = "keyboardImportantBinds";
      
      public static const KEYBOARD:String = "keyboard";
      
      public static const PUSH_TO_TALK:String = "pushToTalk";
      
      public static const KEYS_LAYOUT_ORDER:String = "keysLayoutOrder";
      
      public static const PTT:String = "PTT";
      
      public static const ENABLE_VO_IP:String = "enableVoIP";
      
      public static const VOICE_CHAT_SUPPORTED:String = "voiceChatSupported";
      
      public static const MIC_VIVOX_VOLUME:String = "micVivoxVolume";
      
      public static const ALTERNATIVE_VOICES:String = "alternativeVoices";
      
      public static const BULB_VOICES:String = "bulbVoices";
      
      public static const ARTY_BULB_VOICES:String = "artyBulbVoices";
      
      public static const SOUND_SPEAKERS:String = "soundSpeakers";
      
      public static const SOUND_SPEAKERS_ID_FIELD:String = "id";
      
      public static const SOUND_SPEAKERS_TOOLTIP_FIELD:String = "tooltip";
      
      public static const SOUND_SPEAKERS_IS_AUTODETECT_FIELD:String = "isAutodetect";
      
      public static const SOUND_DEVICE_ID_FIELD:String = "id";
      
      public static const SOUND_DEVICE_SPEAKER_ID:String = "speakerId";
      
      public static const SOUND_DEVICE:String = "soundDevice";
      
      public static const SOUND_DEVICE_ALERT_FIELD:String = "showDeviceAlert";
      
      public static const DEF_ALTERNATIVE_VOICE:String = "default";
      
      public static const AUTODETECT_BUTTON:String = "autodetectButton";
      
      public static const QUALITY_ORDER:String = "qualityOrder";
      
      public static const PRESETS:String = "presets";
      
      public static const MASTER_VOLUME_TOGGLE:String = "masterVolumeToggle";
      
      public static const NIGHT_MODE:String = "nightMode";
      
      public static const BASS_BOOST:String = "bassBoost";
      
      public static const SOUND_QUALITY:String = "soundQuality";
      
      public static const SUBTITLES:String = "subtitles";
      
      public static const SOUND_QUALITY_VISIBLE:String = "soundQualityVisible";
      
      public static const SIZES:String = "sizes";
      
      public static const REFRESH_RATE:String = "refreshRate";
      
      public static const DYNAMIC_RENDERER:String = "dynamicRenderer";
      
      public static const INTERFACE_SCALE:String = "interfaceScale";
      
      public static const VERTICAL_SYNC:String = "vertSync";
      
      public static const TRIPLE_BUFFERED:String = "tripleBuffered";
      
      public static const IGB_HARDWARE_ACCELERATION:String = "igbHardwareAcceleration";
      
      public static const FOV:String = "fov";
      
      public static const DYNAMIC_FOV:String = "dynamicFov";
      
      public static const HAVOK_ENABLED:String = "HAVOK_ENABLED";
      
      public static const SCREEN_MODE:String = "screenMode";
      
      public static const RESOLUTION:String = "resolution";
      
      public static const WINDOW_SIZE:String = "windowSize";
      
      public static const BORDERLESS_SIZE:String = "borderlessSize";
      
      public static const SIZES_ORDER_ID:Vector.<String> = Vector.<String>([WINDOW_SIZE,RESOLUTION,BORDERLESS_SIZE]);
      
      public static const MONITOR:String = "monitor";
      
      public static const CUSTOM_AA_MODE:String = "CUSTOM_AA_MODE";
      
      public static const MSAA_QUALITY:String = "MSAA_QUALITY";
      
      public static const reservedImaginaryControls:Array = [QUALITY_ORDER,WINDOW_SIZE,RESOLUTION,BORDERLESS_SIZE,MSAA_QUALITY,CUSTOM_AA_MODE];
      
      public static const COLOR_GRADING_TECHNIQUE:String = "COLOR_GRADING_TECHNIQUE";
      
      public static const COLOR_FILTER_IMAGES:String = "colorFilterImages";
      
      public static const IS_COLOR_BLIND:String = "isColorBlind";
      
      public static const TEXTURE_QUALITY:String = "TEXTURE_QUALITY";
      
      public static const SHADOWS_QUALITY:String = "SHADOWS_QUALITY";
      
      public static const TERRAIN_QUALITY:String = "TERRAIN_QUALITY";
      
      public static const WATER_QUALITY:String = "WATER_QUALITY";
      
      public static const LIGHTING_QUALITY:String = "LIGHTING_QUALITY";
      
      public static const SPEEDTREE_QUALITY:String = "SPEEDTREE_QUALITY";
      
      public static const FLORA_QUALITY:String = "FLORA_QUALITY";
      
      public static const EFFECTS_QUALITY:String = "EFFECTS_QUALITY";
      
      public static const POST_PROCESSING_QUALITY:String = "POST_PROCESSING_QUALITY";
      
      public static const MOTION_BLUR_QUALITY:String = "MOTION_BLUR_QUALITY";
      
      public static const FAR_PLANE:String = "FAR_PLANE";
      
      public static const OBJECT_LOD:String = "OBJECT_LOD";
      
      public static const SNIPER_MODE_EFFECTS_QUALITY:String = "SNIPER_MODE_EFFECTS_QUALITY";
      
      public static const SNIPER_MODE_GRASS_ENABLED:String = "SNIPER_MODE_GRASS_ENABLED";
      
      public static const VEHICLE_TRACES_ENABLED:String = "VEHICLE_TRACES_ENABLED";
      
      public static const SEMITRANSPARENT_LEAVES_ENABLED:String = "SEMITRANSPARENT_LEAVES_ENABLED";
      
      public static const TERRAIN_TESSELLATION_ENABLED:String = "TERRAIN_TESSELLATION_ENABLED";
      
      public static const SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED:String = "SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED";
      
      public static const VEHICLE_DUST_ENABLED:String = "VEHICLE_DUST_ENABLED";
      
      public static const DRR_AUTOSCALER_ENABLED:String = "DRR_AUTOSCALER_ENABLED";
      
      public static const TESSELLATION_SUPPORTED:String = "tessellationSupported";
      
      public static const NATIVE_RESOLUTION:String = "nativeResolution";
      
      public static const IS_SD_QUALITY:String = "isSDQuality";
      
      public static const RENDER_PIPELINE:String = "RENDER_PIPELINE";
      
      public static const CUSTOM:String = "CUSTOM";
      
      public static const GRAPHIC_QUALITY:String = "graphicsQuality";
      
      public static const GRAPHIC_QUALITY_HDSD:String = "graphicsQualityHDSD";
      
      public static const GRAPHIC_QUALITY_HDSD_HIGH:String = "graphicsQualityHDSDHigh";
      
      public static const ENABLE_OL_FILTER:String = "enableOlFilter";
      
      public static const MINIMAP_ALPHA_ENABLED:String = "minimapAlphaEnabled";
      
      public static const MINIMAP_ALPHA:String = "minimapAlpha";
      
      public static const RECEIVE_CLAN_INVITES_NOTIFICATIONS:String = "receiveClanInvitesNotifications";
      
      public static const GAMEPLAY_ONLY_10_MODE:String = "gameplay_only10Mode";
      
      public static const INTERFACE_SCALE_DISABLED:String = "interfaceScaleDisabled";
      
      public static const CAROUSEL_TYPE:String = "carouselType";
      
      public static const CAROUSEL_SINGLE:String = "single";
      
      public static const CAROUSEL_DOUBLE:String = "double";
      
      public static const CAROUSEL_TYPE_ID:Vector.<String> = Vector.<String>([CAROUSEL_SINGLE,CAROUSEL_DOUBLE]);
      
      private static const DEFAULT_KEY_RANGE:String = "defaultRange";
      
      private static const PTT_KEY_RANGE:String = "pushToTalk";
      
      public static const CO_DEPENDENTS:Object = {
         "fire":"chargeFire",
         "chargeFire":"fire"
      };
      
      public static const KEY_RANGE:Object = {
         "defaultRange":["APOSTROPHE","SEMICOLON","LBRACKET","STOP","COMMA","SLASH","BACKSLASH","RBRACKET","SPACE","LSHIFT","LALT","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","V","X","Y","Z","UPARROW","DOWNARROW","LEFTARROW","RIGHTARROW","MOUSE0","MOUSE1","MOUSE2","MOUSE3","MOUSE4","MOUSE5","MOUSE6","MOUSE7","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","INSERT","DELETE","HOME","END","NUMPAD0","NUMPAD1","NUMPAD2","NUMPAD3","NUMPAD4","NUMPAD5","NUMPAD6","NUMPAD7","NUMPAD8","NUMPAD9","NAMPADSLASH","NAMPADSTAR","NUMPADMINUS","ADD","NUMPADPERIOD"],
         "pushToTalk":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe"],
         "sizeUp":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
         "sizeDown":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
         "visible":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
         "chargeFire":["APOSTROPHE","SEMICOLON","LBRACKET","STOP","COMMA","SLASH","BACKSLASH","RBRACKET","SPACE","LSHIFT","LALT","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","V","X","Y","Z","UPARROW","DOWNARROW","LEFTARROW","RIGHTARROW","MOUSE0","MOUSE2","MOUSE3","MOUSE4","MOUSE5","MOUSE6","MOUSE7","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","INSERT","DELETE","HOME","END","NUMPAD0","NUMPAD1","NUMPAD2","NUMPAD3","NUMPAD4","NUMPAD5","NUMPAD6","NUMPAD7","NUMPAD8","NUMPAD9","NAMPADSLASH","NAMPADSTAR","NUMPADMINUS","ADD","NUMPADPERIOD"]
      };
      
      private static const ENEMY_STR:String = "enemy";
      
      private static const ENEMY_FORM_STR:String = ENEMY_STR + "Form";
      
      private static const MARKER_ENEMY_STR:String = "markerEnemy";
      
      private static const ALLY_STR:String = "ally";
      
      private static const ALLY_FORM_STR:String = ALLY_STR + "Form";
      
      private static const MARKER_ALLY_STR:String = "markerAlly";
      
      private static const DEAD_STR:String = "dead";
      
      private static const DEAD_FORM_STR:String = DEAD_STR + "Form";
      
      private static const MARKER_DEAD_STR:String = "markerDead";
      
      private static const ARCADE_STR:String = "arcade";
      
      private static const ARCADE_FORM_STR:String = ARCADE_STR + "Form";
      
      private static const ARCADE_CROSSHAIR_STR:String = ARCADE_STR + "Crosshair";
      
      private static const SNIPER_STR:String = "sniper";
      
      private static const SNIPER_FORM_STR:String = SNIPER_STR + "Form";
      
      private static const SNIPER_CROSSHAIR_STR:String = SNIPER_STR + "Crosshair";
      
      private static const ARTY_STR:String = "spg";
      
      private static const ARTY_FORM_STR:String = ARTY_STR + "Form";
      
      private static const ARTY_CROSSHAIR_STR:String = ARTY_STR + "Crosshair";
       
      
      private var _settingsData:SettingsDataVo;
      
      private var _changesData:SettingsChangesMap;
      
      private var _settingsDataWithChanges:Dictionary;
      
      private var _markerTabsDataProvider:DataProvider;
      
      private var _cursorTabsDataProvider:DataProvider;
      
      private var _graphicSettingsTabsDataProvider:DataProvider;
      
      private var _liveUpdateVideoSettingsOrderData:Vector.<String>;
      
      private var _liveUpdateVideoSettingsData:Object;
      
      private var _liveUpdateColorFilterData:ColorFilerSettingsVo;
      
      private var _tabsDataProvider:Array;
      
      public function SettingsConfigHelper()
      {
         this._settingsData = new SettingConfigDataVo();
         this._changesData = new SettingsChangesMap();
         this._settingsDataWithChanges = new Dictionary();
         this._markerTabsDataProvider = new DataProvider([new MarkerTabsDataVo({
            "label":SETTINGS.MARKER_ENEMYTITLE,
            "linkage":null,
            "id":ENEMY_STR,
            "formID":ENEMY_FORM_STR,
            "markerID":MARKER_ENEMY_STR,
            "markerFlag":1
         }),new MarkerTabsDataVo({
            "label":SETTINGS.MARKER_ALLYTITLE,
            "linkage":null,
            "id":ALLY_STR,
            "formID":ALLY_FORM_STR,
            "markerID":MARKER_ALLY_STR,
            "markerFlag":2
         }),new MarkerTabsDataVo({
            "label":SETTINGS.MARKER_DEADTITLE,
            "linkage":null,
            "id":DEAD_STR,
            "formID":DEAD_FORM_STR,
            "markerID":MARKER_DEAD_STR,
            "markerFlag":2
         })]);
         this._cursorTabsDataProvider = new DataProvider([new CursorTabsDataVo({
            "label":SETTINGS.CURSOR_ARCADETITLE,
            "linkage":ARCADE_STR,
            "id":ARCADE_STR,
            "formID":ARCADE_FORM_STR,
            "crosshairID":ARCADE_CROSSHAIR_STR
         }),new CursorTabsDataVo({
            "label":SETTINGS.CURSOR_SNIPPERTITLE,
            "linkage":SNIPER_STR,
            "id":SNIPER_STR,
            "formID":SNIPER_FORM_STR,
            "crosshairID":SNIPER_CROSSHAIR_STR
         }),new CursorTabsDataVo({
            "label":SETTINGS.CURSOR_ARTYTITLE,
            "linkage":ARTY_STR,
            "id":ARTY_STR,
            "formID":ARTY_FORM_STR,
            "crosshairID":ARTY_CROSSHAIR_STR
         })]);
         this._graphicSettingsTabsDataProvider = new DataProvider([new TabsDataVo({
            "label":SETTINGS.GRAPHICS_TABSCREEN,
            "linkage":Linkages.SCREEN_SETTING
         }),new TabsDataVo({
            "label":SETTINGS.GRAPHICS_TABADVANCED,
            "linkage":Linkages.ADVANCED_GRAPHIC_SETTINGS
         })]);
         this._liveUpdateVideoSettingsOrderData = Vector.<String>([MONITOR,SCREEN_MODE,WINDOW_SIZE,RESOLUTION,BORDERLESS_SIZE,SIZES,REFRESH_RATE,DYNAMIC_RENDERER,INTERFACE_SCALE]);
         this._liveUpdateVideoSettingsData = {
            "monitor":null,
            "screenMode":null,
            "windowSize":null,
            "resolution":null,
            "borderlessSize":null,
            "refreshRate":null,
            "dynamicRenderer":null,
            "interfaceScale":null
         };
         this._liveUpdateColorFilterData = new ColorFilerSettingsVo();
         this._tabsDataProvider = [new TabsDataVo({
            "label":SETTINGS.GAMETITLE,
            "linkage":GAME_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.GRAFICTITLE,
            "linkage":GRAPHIC_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.SOUNDTITLE,
            "linkage":SOUND_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.KEYBOARDTITLE,
            "linkage":CONTROLS_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.CURSORTITLE,
            "linkage":CURSOR_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.MARKERTITLE,
            "linkage":MARKER_SETTINGS
         }),new TabsDataVo({
            "label":SETTINGS.FEEDBACK,
            "linkage":FEEDBACK_SETTINGS
         })];
         super();
         App.utils.asserter.assert(!_instance,"Instantiation failed: Use TweenFlowFactory.getInstance() instead of new.");
         registerClassAlias(getQualifiedClassName(SettingsDataVo),SettingsDataVo);
         registerClassAlias(getQualifiedClassName(ControlsSettingsDataVo),ControlsSettingsDataVo);
         registerClassAlias(getQualifiedClassName(SettingsControlProp),SettingsControlProp);
         registerClassAlias(getQualifiedClassName(SettingsKeyProp),SettingsKeyProp);
      }
      
      private static function applyChangesData(param1:SettingsDataVo, param2:Object) : void
      {
         var _loc5_:SettingsDataVo = null;
         var _loc6_:* = null;
         var _loc3_:Object = {};
         var _loc4_:Object = null;
         for(_loc6_ in param2)
         {
            _loc4_ = param2[_loc6_];
            _loc3_ = getControlInLayer(param1,_loc6_);
            if(_loc4_ is Boolean || _loc4_ is Number || _loc4_ is String)
            {
               if(_loc3_ != null && _loc4_ != null)
               {
                  if(_loc3_ is SettingsControlProp)
                  {
                     SettingsControlProp(_loc3_).current = _loc4_;
                  }
                  else if(_loc3_ is SettingsKeyProp)
                  {
                     SettingsKeyProp(_loc3_).key = Number(_loc4_);
                  }
               }
            }
            else if(_loc3_ is SettingsControlProp)
            {
               SettingsControlProp(_loc3_).current = _loc4_;
            }
            else
            {
               _loc5_ = SettingsDataVo(_loc3_);
               if(_loc5_ != null)
               {
                  applyChangesData(_loc5_,_loc4_);
               }
            }
         }
      }
      
      private static function getControlInLayer(param1:SettingsDataVo, param2:String) : Object
      {
         var _loc7_:int = 0;
         var _loc3_:Vector.<Object> = param1.values;
         var _loc4_:int = param1.keys.length;
         var _loc5_:Object = param1.getByKey(param2);
         var _loc6_:SettingsDataVo = null;
         if(_loc5_ == null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc6_ = _loc3_[_loc7_] as SettingsDataVo;
               if(_loc6_)
               {
                  _loc5_ = _loc6_.getByKey(param2);
               }
               if(_loc5_ != null)
               {
                  return _loc5_;
               }
               _loc7_++;
            }
         }
         return _loc5_;
      }
      
      public static function get instance() : SettingsConfigHelper
      {
         if(!_instance)
         {
            _instance = new SettingsConfigHelper();
         }
         return _instance;
      }
      
      public static function get defaultKeyRange() : Array
      {
         return KEY_RANGE[DEFAULT_KEY_RANGE];
      }
      
      public static function get pttKeyRange() : Array
      {
         return KEY_RANGE[PTT_KEY_RANGE];
      }
      
      public function applyChangesToCurrentData() : void
      {
         if(this._changesData.length > 0)
         {
            applyChangesData(this._settingsData,this._changesData.getChanges());
            this._changesData.clear();
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:SettingsDataVo = null;
         var _loc2_:SettingsControlProp = null;
         this._settingsData.dispose();
         this._settingsData = null;
         this._changesData.dispose();
         this._changesData = null;
         for each(_loc1_ in this._settingsDataWithChanges)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._settingsDataWithChanges);
         this._settingsDataWithChanges = null;
         this._markerTabsDataProvider.cleanUp();
         this._markerTabsDataProvider = null;
         this._cursorTabsDataProvider.cleanUp();
         this._cursorTabsDataProvider = null;
         this._graphicSettingsTabsDataProvider.cleanUp();
         this._graphicSettingsTabsDataProvider = null;
         this._liveUpdateVideoSettingsOrderData.splice(0,this._liveUpdateVideoSettingsOrderData.length);
         this._liveUpdateVideoSettingsOrderData = null;
         for each(_loc2_ in this._liveUpdateVideoSettingsData)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         this._liveUpdateVideoSettingsData = null;
         this._liveUpdateColorFilterData.dispose();
         this._liveUpdateColorFilterData = null;
         this._tabsDataProvider.splice(0);
         this._tabsDataProvider = null;
         _instance = null;
      }
      
      public function getControlIdByControl(param1:DisplayObject) : String
      {
         var _loc2_:String = this.getControlType(param1);
         if(_loc2_)
         {
            return this.getControlIdByControlNameAndType(param1.name,_loc2_);
         }
         return null;
      }
      
      public function getControlIdByControlNameAndType(param1:String, param2:String) : String
      {
         return param1.replace(param2,Values.EMPTY_STR);
      }
      
      public function getControlType(param1:DisplayObject) : String
      {
         var _loc2_:String = param1.name;
         if(_loc2_.indexOf(TYPE_CHECKBOX) >= 0)
         {
            return TYPE_CHECKBOX;
         }
         if(_loc2_.indexOf(TYPE_DROPDOWN) >= 0)
         {
            return TYPE_DROPDOWN;
         }
         if(_loc2_.indexOf(TYPE_SLIDER) >= 0)
         {
            return TYPE_SLIDER;
         }
         if(_loc2_.indexOf(TYPE_STEP_SLIDER) >= 0)
         {
            return TYPE_STEP_SLIDER;
         }
         if(_loc2_.indexOf(TYPE_RANGE_SLIDER) >= 0)
         {
            return TYPE_RANGE_SLIDER;
         }
         if(_loc2_.indexOf(TYPE_BUTTON_BAR) >= 0)
         {
            return TYPE_BUTTON_BAR;
         }
         if(_loc2_.indexOf(TYPE_BUTTON) >= 0)
         {
            return TYPE_BUTTON;
         }
         return null;
      }
      
      public function getDataItem(param1:String, param2:Boolean = false) : SettingsDataVo
      {
         var _loc3_:SettingsDataVo = SettingsDataVo(this._settingsData[param1]);
         if(param2 && this._changesData.length > 0)
         {
            if(param1 in this._settingsDataWithChanges)
            {
               SettingsDataVo(this._settingsDataWithChanges[param1]).dispose();
            }
            _loc3_ = SettingsDataVo(App.utils.data.cloneObject(_loc3_));
            applyChangesData(_loc3_,this._changesData.getChanges());
            this._settingsDataWithChanges[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      public function getScreenSizeDataIndexById(param1:String) : Number
      {
         var _loc2_:Number = SIZES_ORDER_ID.length;
         var _loc3_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(SIZES_ORDER_ID[_loc3_] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function get settingsData() : SettingsDataVo
      {
         return this._settingsData;
      }
      
      public function get markerTabsDataProvider() : IDataProvider
      {
         return this._markerTabsDataProvider;
      }
      
      public function get cursorTabsDataProvider() : IDataProvider
      {
         return this._cursorTabsDataProvider;
      }
      
      public function get liveUpdateVideoSettingsOrderData() : Vector.<String>
      {
         return this._liveUpdateVideoSettingsOrderData;
      }
      
      public function get liveUpdateVideoSettingsData() : Object
      {
         return this._liveUpdateVideoSettingsData;
      }
      
      public function get liveUpdateColorFilterData() : ColorFilerSettingsVo
      {
         return this._liveUpdateColorFilterData;
      }
      
      public function get tabsDataProvider() : Array
      {
         return this._tabsDataProvider;
      }
      
      public function get changesData() : SettingsChangesMap
      {
         return this._changesData;
      }
      
      public function get graphicSettingsTabsDataProvider() : IDataProvider
      {
         return this._graphicSettingsTabsDataProvider;
      }
   }
}
