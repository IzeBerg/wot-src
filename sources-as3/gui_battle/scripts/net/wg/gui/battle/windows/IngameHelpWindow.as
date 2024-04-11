package net.wg.gui.battle.windows
{
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.KEYBOARD_KEYS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.infrastructure.base.meta.IIngameHelpWindowMeta;
   import net.wg.infrastructure.base.meta.impl.IngameHelpWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.utils.IAssertable;
   import net.wg.utils.ICommons;
   import scaleform.clik.events.ButtonEvent;
   
   public class IngameHelpWindow extends IngameHelpWindowMeta implements IIngameHelpWindowMeta
   {
      
      private static const CROSSHAIRCONTROLS_TIMELEFT:Number = 7.42;
      
      private static const SCHEME_NAME:String = "vm_enemy";
       
      
      public var closeBtn:CloseButtonText = null;
      
      public var pageTitle:TextField = null;
      
      public var exampleTimeLeft:TextField = null;
      
      public var exampleDistance:TextField = null;
      
      public var exampleName:TextField = null;
      
      public var exampleHp:TextField = null;
      
      public var exampleHit:TextField = null;
      
      public var battleControlsTitle:TextField = null;
      
      public var radialMenuTitle:TextField = null;
      
      public var chatControlsTitle:TextField = null;
      
      public var vehicleTypesTitle:TextField = null;
      
      public var crosshairControlsTitle:TextField = null;
      
      public var markerColorsTitle:TextField = null;
      
      public var movementForward:TextField = null;
      
      public var movementBackward:TextField = null;
      
      public var movementLeft:TextField = null;
      
      public var movementRight:TextField = null;
      
      public var cruiseCtrlForward:TextField = null;
      
      public var cruiseCtrlBackward:TextField = null;
      
      public var switchAutorotation:TextField = null;
      
      public var stopFire:TextField = null;
      
      public var voiceChatMute:TextField = null;
      
      public var casseteReload:TextField = null;
      
      public var fire:TextField = null;
      
      public var toggleLockTarget:TextField = null;
      
      public var toggleLockTargetExt:TextField = null;
      
      public var disableLockTarget:TextField = null;
      
      public var toggleSniperMode:TextField = null;
      
      public var toggleSniperModeExt:TextField = null;
      
      public var togglePlayerPanelModes:TextField = null;
      
      public var showExPlayerInfo:TextField = null;
      
      public var hideInterface:TextField = null;
      
      public var showCursor:TextField = null;
      
      public var showCursorExt:TextField = null;
      
      public var makeScreenshort:TextField = null;
      
      public var highlightLocation:TextField = null;
      
      public var highlightActiveTarget:TextField = null;
      
      public var radialMenuShow:TextField = null;
      
      public var radialMenuShowExt:TextField = null;
      
      public var enterToChatMode:TextField = null;
      
      public var changetf:TextField = null;
      
      public var send:TextField = null;
      
      public var exitFromChatMode:TextField = null;
      
      public var atSpg:TextField = null;
      
      public var spg:TextField = null;
      
      public var lightTank:TextField = null;
      
      public var mediumTank:TextField = null;
      
      public var heavyTank:TextField = null;
      
      public var friend:TextField = null;
      
      public var enemy:TextField = null;
      
      public var teamKiller:TextField = null;
      
      public var squadPlay:TextField = null;
      
      public var targetIcon:TextField = null;
      
      public var targetDistance:TextField = null;
      
      public var targetLevel:TextField = null;
      
      public var targetName:TextField = null;
      
      public var hpIndicator:TextField = null;
      
      public var hpValues:TextField = null;
      
      public var targetClass:TextField = null;
      
      public var damageIndicator:TextField = null;
      
      public var reloadTimer:TextField = null;
      
      public var reloadIndicator:TextField = null;
      
      public var ammoNumber:TextField = null;
      
      public var marker:TextField = null;
      
      public var healthPlayer:TextField = null;
      
      public var dispercion:TextField = null;
      
      public var gunMarker:TextField = null;
      
      public var printscreenTF:TextField = null;
      
      public var enterTF:TextField = null;
      
      public var tabTF:TextField = null;
      
      public var enter2TF:TextField = null;
      
      public var escapeTF:TextField = null;
      
      public var showCursorTF:TextField = null;
      
      public var forwardTF:TextField = null;
      
      public var backwardTF:TextField = null;
      
      public var leftTF:TextField = null;
      
      public var rightTF:TextField = null;
      
      public var forwardCruiseTF:TextField = null;
      
      public var backwardCruiseTF:TextField = null;
      
      public var autoRotationTF:TextField = null;
      
      public var stopFireTF:TextField = null;
      
      public var pushToTalkTF:TextField = null;
      
      public var reloadPartialClipTF:TextField = null;
      
      public var fireTF:TextField = null;
      
      public var lockTargetTF:TextField = null;
      
      public var lockTargetOffTF:TextField = null;
      
      public var alternateModeTF:TextField = null;
      
      public var togglePlayerPanelModesTF:TextField = null;
      
      public var showExPlayerInfoTF:TextField = null;
      
      public var showHUDTF:TextField = null;
      
      public var showRadialMenuTF:TextField = null;
      
      public var highlightLocationTF:TextField = null;
      
      public var highlightActiveTargetTF:TextField = null;
      
      public var background:BattleAtlasSprite = null;
      
      public var bgInfo:BattleAtlasSprite = null;
      
      private var _keysDictionary:Dictionary;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      public function IngameHelpWindow()
      {
         this._keysDictionary = new Dictionary();
         super();
         showWindowBgForm = false;
         showWindowBg = false;
         this._keysDictionary[KEYBOARD_KEYS.FORWARD] = this.forwardTF;
         this._keysDictionary[KEYBOARD_KEYS.BACKWARD] = this.backwardTF;
         this._keysDictionary[KEYBOARD_KEYS.LEFT] = this.leftTF;
         this._keysDictionary[KEYBOARD_KEYS.RIGHT] = this.rightTF;
         this._keysDictionary[KEYBOARD_KEYS.FORWARD_CRUISE] = this.forwardCruiseTF;
         this._keysDictionary[KEYBOARD_KEYS.BACKWARD_CRUISE] = this.backwardCruiseTF;
         this._keysDictionary[KEYBOARD_KEYS.AUTO_ROTATION] = this.autoRotationTF;
         this._keysDictionary[KEYBOARD_KEYS.STOP_FIRE] = this.stopFireTF;
         this._keysDictionary[KEYBOARD_KEYS.PUSH_TO_TALK] = this.pushToTalkTF;
         this._keysDictionary[KEYBOARD_KEYS.RELOAD_PARTIAL_CLIP] = this.reloadPartialClipTF;
         this._keysDictionary[KEYBOARD_KEYS.FIRE] = this.fireTF;
         this._keysDictionary[KEYBOARD_KEYS.LOCK_TARGET] = this.lockTargetTF;
         this._keysDictionary[KEYBOARD_KEYS.LOCK_TARGET_OFF] = this.lockTargetOffTF;
         this._keysDictionary[KEYBOARD_KEYS.ALTERNATE_MODE] = this.alternateModeTF;
         this._keysDictionary[KEYBOARD_KEYS.TOGGLE_PLAYER_PANEL_MODES] = this.togglePlayerPanelModesTF;
         this._keysDictionary[KEYBOARD_KEYS.SHOW_EX_PLAYER_INFO] = this.showExPlayerInfoTF;
         this._keysDictionary[KEYBOARD_KEYS.SHOW_HUD] = this.showHUDTF;
         this._keysDictionary[KEYBOARD_KEYS.SHOW_RADIAL_MENU] = this.showRadialMenuTF;
         this._keysDictionary[KEYBOARD_KEYS.HIGHLIGHT_LOCATION] = this.highlightLocationTF;
         this._keysDictionary[KEYBOARD_KEYS.HIGHLIGHT_TARGET] = this.highlightActiveTargetTF;
         this._colorMgr = App.colorSchemeMgr;
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.background.imageName = BATTLEATLAS.HELP_WINDOW_BG;
         this.closeBtn.label = INGAME_HELP.BATTLECONTROLS_CLOSEBTNLABEL;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         updateStage(App.appWidth,App.appHeight);
         window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
         this.setTitleTexts();
         this.setDescriptionTexts();
         this.setCrossHairTexts();
         this.setkeysTexts();
         this.updateColorDependencies(this._colorMgr.getIsColorBlindS());
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(geometry && window && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            window.x = App.appWidth - window.getBackground().width >> 1;
            window.y = App.appHeight - window.getBackground().height >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorMgr = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.background = null;
         this.bgInfo = null;
         this._keysDictionary = null;
         this.exampleTimeLeft = null;
         this.exampleDistance = null;
         this.exampleName = null;
         this.exampleHp = null;
         this.exampleHit = null;
         this.pageTitle = null;
         this.battleControlsTitle = null;
         this.radialMenuTitle = null;
         this.chatControlsTitle = null;
         this.vehicleTypesTitle = null;
         this.crosshairControlsTitle = null;
         this.markerColorsTitle = null;
         this.movementForward = null;
         this.movementBackward = null;
         this.movementLeft = null;
         this.movementRight = null;
         this.cruiseCtrlForward = null;
         this.cruiseCtrlBackward = null;
         this.switchAutorotation = null;
         this.stopFire = null;
         this.voiceChatMute = null;
         this.casseteReload = null;
         this.fire = null;
         this.toggleLockTarget = null;
         this.toggleLockTargetExt = null;
         this.disableLockTarget = null;
         this.toggleSniperMode = null;
         this.toggleSniperModeExt = null;
         this.togglePlayerPanelModes = null;
         this.showExPlayerInfo = null;
         this.hideInterface = null;
         this.showCursor = null;
         this.showCursorExt = null;
         this.makeScreenshort = null;
         this.radialMenuShow = null;
         this.radialMenuShowExt = null;
         this.highlightLocation = null;
         this.highlightActiveTarget = null;
         this.enterToChatMode = null;
         this.changetf = null;
         this.send = null;
         this.exitFromChatMode = null;
         this.atSpg = null;
         this.spg = null;
         this.lightTank = null;
         this.mediumTank = null;
         this.heavyTank = null;
         this.friend = null;
         this.enemy = null;
         this.teamKiller = null;
         this.squadPlay = null;
         this.targetIcon = null;
         this.targetDistance = null;
         this.targetLevel = null;
         this.targetName = null;
         this.hpIndicator = null;
         this.hpValues = null;
         this.targetClass = null;
         this.damageIndicator = null;
         this.reloadTimer = null;
         this.reloadIndicator = null;
         this.ammoNumber = null;
         this.marker = null;
         this.healthPlayer = null;
         this.dispercion = null;
         this.gunMarker = null;
         this.printscreenTF = null;
         this.enterTF = null;
         this.tabTF = null;
         this.enter2TF = null;
         this.escapeTF = null;
         this.showCursorTF = null;
         this.forwardTF = null;
         this.backwardTF = null;
         this.leftTF = null;
         this.rightTF = null;
         this.forwardCruiseTF = null;
         this.backwardCruiseTF = null;
         this.autoRotationTF = null;
         this.stopFireTF = null;
         this.pushToTalkTF = null;
         this.reloadPartialClipTF = null;
         this.fireTF = null;
         this.lockTargetTF = null;
         this.lockTargetOffTF = null;
         this.alternateModeTF = null;
         this.togglePlayerPanelModesTF = null;
         this.showExPlayerInfoTF = null;
         this.showHUDTF = null;
         this.showRadialMenuTF = null;
         this.highlightLocationTF = null;
         this.highlightActiveTargetTF = null;
         super.onDispose();
      }
      
      public function as_setKeys(param1:Object) : void
      {
         this.setKeys(param1);
      }
      
      private function setKeys(param1:Object) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:* = null;
         var _loc4_:IAssertable = App.utils.asserter;
         var _loc5_:ICommons = App.utils.commons;
         for(_loc3_ in param1)
         {
            _loc2_ = this._keysDictionary[_loc3_];
            _loc4_.assert(_loc2_ != null,"No " + _loc3_ + " in clip");
            _loc2_.text = _loc5_.keyToString(param1[_loc3_]).keyName;
         }
      }
      
      private function setTitleTexts() : void
      {
         this.pageTitle.text = INGAME_HELP.BATTLECONTROLS_PAGETITLE;
         this.battleControlsTitle.text = INGAME_HELP.BATTLECONTROLS_TITLE;
         this.radialMenuTitle.text = INGAME_HELP.TEAMCOMM_TITLE;
         this.chatControlsTitle.text = INGAME_HELP.CHATCONTROLS_TITLE;
         this.vehicleTypesTitle.text = INGAME_HELP.VEHICLETYPES_TITLE;
         this.crosshairControlsTitle.text = INGAME_HELP.CROSSHAIRCONTROLS_TITLE;
         this.markerColorsTitle.text = INGAME_HELP.MARKERCOLORS_TITLE;
      }
      
      private function setDescriptionTexts() : void
      {
         this.movementForward.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTFORWARD;
         this.movementBackward.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTBACKWARD;
         this.movementLeft.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTLEFT;
         this.movementRight.text = INGAME_HELP.BATTLECONTROLS_MOVEMENTRIGHT;
         this.cruiseCtrlForward.text = INGAME_HELP.BATTLECONTROLS_CRUISECTRLFORWARD;
         this.cruiseCtrlBackward.text = INGAME_HELP.BATTLECONTROLS_CRUISECTRLBACKWARD;
         this.switchAutorotation.text = INGAME_HELP.BATTLECONTROLS_SWITCHAUTOROTATION;
         this.stopFire.text = INGAME_HELP.BATTLECONTROLS_STOPFIRE;
         this.voiceChatMute.text = INGAME_HELP.BATTLECONTROLS_VOICECHATMUTE;
         this.casseteReload.text = INGAME_HELP.BATTLECONTROLS_CASSETERELOAD;
         this.fire.text = INGAME_HELP.BATTLECONTROLS_FIRE;
         this.toggleLockTarget.text = INGAME_HELP.BATTLECONTROLS_TOGGLELOCKTARGET;
         this.toggleLockTargetExt.text = INGAME_HELP.BATTLECONTROLS_TOGGLELOCKTARGET_EXT;
         this.disableLockTarget.text = INGAME_HELP.BATTLECONTROLS_DISABLELOCKTARGET;
         this.toggleSniperMode.text = INGAME_HELP.BATTLECONTROLS_TOGGLESNIPERMODE;
         this.toggleSniperModeExt.text = INGAME_HELP.BATTLECONTROLS_TOGGLESNIPERMODE_EXT;
         this.togglePlayerPanelModes.text = INGAME_HELP.BATTLECONTROLS_TOGGLEPLAYERPANELMODES;
         this.showExPlayerInfo.text = INGAME_HELP.BATTLECONTROLS_SHOWEXPLAYERINFO;
         this.hideInterface.text = INGAME_HELP.BATTLECONTROLS_HIDEINTERFACE;
         this.showCursor.text = INGAME_HELP.BATTLECONTROLS_SHOWCURSOR;
         this.showCursorExt.text = INGAME_HELP.BATTLECONTROLS_SHOWCURSOR_EXT;
         this.makeScreenshort.text = INGAME_HELP.BATTLECONTROLS_MAKESCREENSHORT;
         this.highlightLocation.text = INGAME_HELP.TEAMCOMM_HIGHLIGHTLOCATION;
         this.highlightActiveTarget.text = INGAME_HELP.TEAMCOMM_HIGHLIGHTASACTIVETARGET;
         this.radialMenuShow.text = INGAME_HELP.TEAMCOMM_SHOW;
         this.radialMenuShowExt.text = INGAME_HELP.TEAMCOMM_SHOW_EXT;
         this.enterToChatMode.text = INGAME_HELP.CHATCONTROLS_ENTERTOCHATMODE;
         this.changetf.text = INGAME_HELP.CHATCONTROLS_CHANGE;
         this.send.text = INGAME_HELP.CHATCONTROLS_SEND;
         this.exitFromChatMode.text = INGAME_HELP.CHATCONTROLS_EXITFROMCHATMODE;
         this.atSpg.text = ITEM_TYPES.VEHICLE_TAGS_AT_SPG_NAME;
         this.spg.text = ITEM_TYPES.VEHICLE_TAGS_SPG_NAME;
         this.lightTank.text = ITEM_TYPES.VEHICLE_TAGS_LIGHT_TANK_NAME;
         this.mediumTank.text = ITEM_TYPES.VEHICLE_TAGS_MEDIUM_TANK_NAME;
         this.heavyTank.text = ITEM_TYPES.VEHICLE_TAGS_HEAVY_TANK_NAME;
         this.friend.text = INGAME_HELP.MARKERCOLORS_FRIEND;
         this.enemy.text = INGAME_HELP.MARKERCOLORS_ENEMY;
         this.teamKiller.text = INGAME_HELP.MARKERCOLORS_TEAMKILLER;
         this.squadPlay.text = INGAME_HELP.MARKERCOLORS_SQUADPLAYER;
         this.targetIcon.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETICON;
         this.targetDistance.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETDISTANCE;
         this.targetLevel.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETLEVEL;
         this.targetName.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETNAME;
         this.hpIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_HPINDICATOR;
         this.hpValues.text = INGAME_HELP.CROSSHAIRCONTROLS_HPVALUES;
         this.targetClass.text = INGAME_HELP.CROSSHAIRCONTROLS_TARGETCLASS;
         this.damageIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_DAMAGEINDICATOR;
         this.reloadTimer.text = INGAME_HELP.CROSSHAIRCONTROLS_RELOADTIMER;
         this.reloadIndicator.text = INGAME_HELP.CROSSHAIRCONTROLS_RELOADINDICATOR;
         this.ammoNumber.text = INGAME_HELP.CROSSHAIRCONTROLS_AMMONUMBER;
         this.marker.text = INGAME_HELP.CROSSHAIRCONTROLS_MARKER;
         this.healthPlayer.text = INGAME_HELP.CROSSHAIRCONTROLS_HEALTHPLAYER;
         this.dispercion.text = INGAME_HELP.CROSSHAIRCONTROLS_DISPERCION;
         this.gunMarker.text = INGAME_HELP.CROSSHAIRCONTROLS_GUNMARKER;
      }
      
      private function setCrossHairTexts() : void
      {
         this.exampleTimeLeft.text = App.utils.locale.float(CROSSHAIRCONTROLS_TIMELEFT);
         this.exampleDistance.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_DISTANCE;
         this.exampleName.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_NAME;
         this.exampleHp.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_HP;
         this.exampleHit.text = INGAME_HELP.CROSSHAIRCONTROLS_EXAMPLE_DAMAGE;
      }
      
      private function setkeysTexts() : void
      {
         this.printscreenTF.text = CONTROLS.KEYBOARD_KEY_PRINT_SCREEN;
         this.enterTF.text = CONTROLS.KEYBOARD_KEY_ENTER;
         this.tabTF.text = CONTROLS.KEYBOARD_KEY_TAB;
         this.enter2TF.text = CONTROLS.KEYBOARD_KEY_ENTER;
         this.escapeTF.text = CONTROLS.KEYBOARD_KEY_ESCAPE;
         this.showCursorTF.text = CONTROLS.KEYBOARD_KEY_CTRL_WO_REFERRAL;
      }
      
      private function updateColorDependencies(param1:Boolean) : void
      {
         this.bgInfo.imageName = !!param1 ? BATTLEATLAS.HELP_WINDOW_INFO_BLIND : BATTLEATLAS.HELP_WINDOW_INFO;
         var _loc2_:uint = this._colorMgr.getRGB(SCHEME_NAME);
         var _loc3_:ColorTransform = this._colorMgr.getTransform(SCHEME_NAME);
         this.exampleName.textColor = _loc2_;
         this.exampleHit.textColor = _loc2_;
         this.exampleHit.transform.colorTransform = _loc3_;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColorDependencies(this._colorMgr.getIsColorBlindS());
      }
      
      private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
      {
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         handleWindowClose();
      }
   }
}
