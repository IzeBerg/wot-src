package net.wg.gui.battle.windows
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.INTERFACE_STATES;
   import net.wg.gui.components.common.bugreport.ReportBugPanel;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.IIngameMenuMeta;
   import net.wg.infrastructure.base.meta.impl.IngameMenuMeta;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class IngameMenu extends IngameMenuMeta implements IIngameMenuMeta
   {
      
      public static var NEW_COUNTERS_CONTAINER_ID:String = "inGameMenuCountersContainer";
      
      private static const TYPE_UNAVAILABLE:String = "unavailable";
      
      private static const TYPE_CLUSTER:String = "clusterCCU";
      
      private static const TYPE_FULL:String = "regionCCU/clusterCCU";
      
      private static const INVALIDATE_SERVER_INFO:String = "serverInfo";
      
      private static const INVALIDATE_SERVER_STATS:String = "serverStats";
      
      private static const INVALIDATE_BUTTONS_LABELS:String = "buttonsLabels";
      
      private static const INVALIDATE_MENU_BUTTONS_POSITIONS:String = "buttonsPositions";
      
      private static const PADDING:int = 5;
      
      private static const Y_OFFSET_HIDE_SERVER_STATS:int = -26;
      
      private static const Y_OFFSET_HIDE_ALL:int = -60;
      
      private static const Y_OFFSET_MENU_BUTTON:int = -67;
      
      private static const REPORT_BUG_PANEL_PADDING:int = 31;
      
      private static const SERVER_SEPARATOR:String = " ";
       
      
      public var headerTF:TextField = null;
      
      public var serverNameTF:TextField = null;
      
      public var serverStatsTF:TextField = null;
      
      public var background:MovieClip = null;
      
      public var reportBugPanel:ReportBugPanel = null;
      
      public var quitBattleBtn:IconTextBigButton = null;
      
      public var settingsBtn:IconTextBigButton = null;
      
      public var helpBtn:IconTextBigButton = null;
      
      public var cancelBtn:IconTextBigButton = null;
      
      public var requestBootcampQuitBtn:IconTextBigButton = null;
      
      private var _quitLabel:String = "";
      
      private var _settingsLabel:String = "";
      
      private var _helpLabel:String = "";
      
      private var _cancelLabel:String = "";
      
      private var _bootcampLabel:String = "";
      
      private var _bootcampIcon:String = "";
      
      private var _tooltipType:String = "unavailable";
      
      private var _tooltipFullData:String = "";
      
      private var _serverState:int = 0;
      
      private var _serverName:String = "";
      
      private var _serverStats:String = "";
      
      private var _isUpdtaePosition:Boolean = false;
      
      private var _showQuitButton:Boolean = true;
      
      private var _showBootcampButton:Boolean = true;
      
      private var _showHelpButton:Boolean = true;
      
      private var _btns:Dictionary;
      
      private var _counterManager:ICounterManager;
      
      public function IngameMenu()
      {
         this._btns = new Dictionary();
         this._counterManager = App.utils.counterManager;
         super();
         showWindowBgForm = false;
         showWindowBg = false;
         this._isUpdtaePosition = false;
         TextFieldEx.setNoTranslate(this.serverNameTF,true);
         TextFieldEx.setNoTranslate(this.serverStatsTF,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         var _loc1_:DisplayObject = null;
         window.getBackground().tabEnabled = false;
         window.getBackground().tabChildren = false;
         this.quitBattleBtn.addEventListener(ButtonEvent.PRESS,this.onQuitBattleBtnPressHandler);
         this.settingsBtn.addEventListener(ButtonEvent.PRESS,this.onSettingsBtnPressHandler);
         this.helpBtn.addEventListener(ButtonEvent.PRESS,this.onHelpBtnPressHandler);
         this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.requestBootcampQuitBtn.addEventListener(ButtonEvent.PRESS,this.onRequestBootcampQuitBtnPressHandler);
         for each(_loc1_ in [this.quitBattleBtn,this.settingsBtn,this.helpBtn,this.cancelBtn,this.requestBootcampQuitBtn])
         {
            this._btns[_loc1_.name] = _loc1_;
         }
         this.serverStatsTF.addEventListener(MouseEvent.ROLL_OVER,this.onServerStatsTFRollOverHandler);
         this.serverStatsTF.addEventListener(MouseEvent.ROLL_OUT,this.onServerStatsTFRollOutHandler);
         this.headerTF.text = MENU.INGAME_MENU_TITLE;
         this.serverNameTF.autoSize = TextFieldAutoSize.CENTER;
         registerFlashComponentS(this.reportBugPanel,BATTLE_VIEW_ALIASES.REPORT_BUG);
         this.reportBugPanel.y = this.cancelBtn.y + this.cancelBtn.height + REPORT_BUG_PANEL_PADDING;
         super.onPopulate();
         updateStage(App.appWidth,App.appHeight);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._btns);
         this._btns = null;
         this._counterManager.disposeCountersForContainer(NEW_COUNTERS_CONTAINER_ID);
         this._counterManager = null;
         this.quitBattleBtn.removeEventListener(ButtonEvent.PRESS,this.onQuitBattleBtnPressHandler);
         this.settingsBtn.removeEventListener(ButtonEvent.PRESS,this.onSettingsBtnPressHandler);
         this.helpBtn.removeEventListener(ButtonEvent.PRESS,this.onHelpBtnPressHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.requestBootcampQuitBtn.removeEventListener(ButtonEvent.PRESS,this.onRequestBootcampQuitBtnPressHandler);
         this.serverStatsTF.removeEventListener(MouseEvent.ROLL_OVER,this.onServerStatsTFRollOverHandler);
         this.serverStatsTF.removeEventListener(MouseEvent.ROLL_OUT,this.onServerStatsTFRollOutHandler);
         this.quitBattleBtn.dispose();
         this.settingsBtn.dispose();
         this.helpBtn.dispose();
         this.cancelBtn.dispose();
         this.requestBootcampQuitBtn.dispose();
         this.quitBattleBtn = null;
         this.settingsBtn = null;
         this.helpBtn = null;
         this.cancelBtn = null;
         this.requestBootcampQuitBtn = null;
         this.background = null;
         this.reportBugPanel = null;
         this.headerTF = null;
         this.serverNameTF = null;
         this.serverStatsTF = null;
         super.onDispose();
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         setFocus(this.cancelBtn);
         onCounterNeedUpdateS();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(INVALIDATE_BUTTONS_LABELS))
         {
            this.quitBattleBtn.label = this._quitLabel;
            this.settingsBtn.label = this._settingsLabel;
            this.helpBtn.label = this._helpLabel;
            this.cancelBtn.label = this._cancelLabel;
            this.requestBootcampQuitBtn.label = this._bootcampLabel;
            this.requestBootcampQuitBtn.htmlIconStr = this._bootcampIcon;
         }
         if(isInvalid(INVALIDATE_SERVER_INFO))
         {
            this.serverNameTF.htmlText = App.utils.locale.makeString(MENU.INGAME_MENU_SERVERSTATS_SERVER) + SERVER_SEPARATOR + this._serverName;
            if(this._serverState != INTERFACE_STATES.SHOW_ALL)
            {
               this.serverNameTF.visible = this._serverState != INTERFACE_STATES.HIDE_ALL_SERVER_INFO;
               this.hideStats();
            }
         }
         if(isInvalid(INVALIDATE_SERVER_INFO,INVALIDATE_MENU_BUTTONS_POSITIONS))
         {
            this.requestBootcampQuitBtn.visible = this._showBootcampButton;
            this.helpBtn.visible = this._showHelpButton;
            this.quitBattleBtn.visible = this._showQuitButton;
            _loc1_ = !this._showQuitButton ? int(Y_OFFSET_MENU_BUTTON) : int(0);
            if(this._serverState == INTERFACE_STATES.HIDE_SERVER_STATS)
            {
               _loc1_ += Y_OFFSET_HIDE_SERVER_STATS;
            }
            else if(this._serverState == INTERFACE_STATES.HIDE_ALL_SERVER_INFO)
            {
               _loc1_ += Y_OFFSET_HIDE_ALL;
            }
            this.rePositionElements(_loc1_);
         }
         if(isInvalid(INVALIDATE_SERVER_STATS))
         {
            if(this._serverStats && this._serverStats != Values.EMPTY_STR)
            {
               this.serverStatsTF.htmlText = this._serverStats;
            }
            this.serverStatsTF.width = this.serverStatsTF.textWidth + PADDING;
            this.serverStatsTF.x = this.width - this.serverStatsTF.width >> 1;
         }
      }
      
      override protected function setCounter(param1:Vector.<CountersVo>) : void
      {
         var _loc4_:CountersVo = null;
         var _loc2_:ISoundButtonEx = null;
         var _loc3_:CounterProps = new CounterProps(CounterProps.DEFAULT_OFFSET_X,0);
         for each(_loc4_ in param1)
         {
            _loc2_ = this.getBtnByName(_loc4_.componentId);
            if(_loc2_)
            {
               this._counterManager.setCounter(DisplayObject(_loc2_),_loc4_.count,NEW_COUNTERS_CONTAINER_ID,_loc3_);
            }
         }
      }
      
      override protected function removeCounter(param1:Vector.<String>) : void
      {
         var _loc4_:String = null;
         var _loc2_:ISoundButtonEx = null;
         var _loc3_:Number = 0;
         for each(_loc4_ in param1)
         {
            _loc2_ = this.getBtnByName(_loc4_);
            if(_loc2_)
            {
               this._counterManager.removeCounter(DisplayObject(_loc2_),NEW_COUNTERS_CONTAINER_ID);
            }
         }
      }
      
      public function as_setMenuButtonsLabels(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this._quitLabel = param4;
         this._settingsLabel = param2;
         this._helpLabel = param1;
         this._cancelLabel = param3;
         this._bootcampLabel = param5;
         this._bootcampIcon = param6;
         invalidate(INVALIDATE_BUTTONS_LABELS);
      }
      
      public function as_setServerSetting(param1:String, param2:String, param3:int) : void
      {
         this._serverState = param3;
         this._serverName = param1;
         this._tooltipFullData = param2;
         invalidate(INVALIDATE_SERVER_INFO);
      }
      
      public function as_setServerStats(param1:String, param2:String) : void
      {
         this._tooltipType = param2 != Values.EMPTY_STR ? param2 : TYPE_UNAVAILABLE;
         this._serverStats = param1;
         invalidate(INVALIDATE_SERVER_STATS);
      }
      
      public function as_showBootcampButton(param1:Boolean) : void
      {
         this._showBootcampButton = param1;
         invalidate(INVALIDATE_MENU_BUTTONS_POSITIONS);
      }
      
      public function as_showHelpButton(param1:Boolean) : void
      {
         this._showHelpButton = param1;
         invalidate(INVALIDATE_MENU_BUTTONS_POSITIONS);
      }
      
      public function as_showQuitButton(param1:Boolean) : void
      {
         this._showQuitButton = param1;
         invalidate(INVALIDATE_MENU_BUTTONS_POSITIONS);
      }
      
      private function rePositionElements(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         if(!this._isUpdtaePosition)
         {
            this.quitBattleBtn.y += param1;
            this.settingsBtn.y += param1;
            if(this._showHelpButton)
            {
               this.helpBtn.y += param1;
            }
            else
            {
               param1 += Y_OFFSET_MENU_BUTTON;
            }
            _loc2_ = !!this._showBootcampButton ? int(0) : int(Y_OFFSET_MENU_BUTTON);
            this.cancelBtn.y += param1 + _loc2_;
            this.background.height += param1 + _loc2_;
            this.requestBootcampQuitBtn.y += param1;
            this.reportBugPanel.y = this.cancelBtn.y + this.cancelBtn.height + REPORT_BUG_PANEL_PADDING;
            this._isUpdtaePosition = true;
         }
      }
      
      private function hideStats() : void
      {
         this.serverStatsTF.visible = false;
      }
      
      private function getBtnByName(param1:String) : ISoundButtonEx
      {
         return param1 in this._btns ? ISoundButtonEx(this._btns[param1]) : null;
      }
      
      private function onServerStatsTFRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onServerStatsTFRollOverHandler(param1:MouseEvent) : void
      {
         switch(this._tooltipType)
         {
            case TYPE_UNAVAILABLE:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_UNAVAILABLE);
               break;
            case TYPE_CLUSTER:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
               break;
            case TYPE_FULL:
               App.toolTipMgr.showComplex(this._tooltipFullData);
               break;
            default:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
         }
      }
      
      private function onQuitBattleBtnPressHandler(param1:ButtonEvent) : void
      {
         quitBattleClickS();
      }
      
      private function onSettingsBtnPressHandler(param1:ButtonEvent) : void
      {
         settingsClickS();
      }
      
      private function onHelpBtnPressHandler(param1:ButtonEvent) : void
      {
         helpClickS();
      }
      
      private function onCancelBtnPressHandler(param1:ButtonEvent) : void
      {
         cancelClickS();
      }
      
      private function onRequestBootcampQuitBtnPressHandler(param1:ButtonEvent) : void
      {
         bootcampClickS();
      }
      
      public function as_setVisibility(param1:Boolean) : void
      {
         visible = param1;
      }
   }
}
