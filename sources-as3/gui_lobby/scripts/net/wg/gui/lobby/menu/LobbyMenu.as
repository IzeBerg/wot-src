package net.wg.gui.lobby.menu
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.bugreport.ReportBugPanel;
   import net.wg.gui.components.common.serverStats.ServerStats;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
   import net.wg.infrastructure.base.meta.impl.LobbyMenuMeta;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.TextFieldEx;
   
   public class LobbyMenu extends LobbyMenuMeta implements ILobbyMenuMeta
   {
      
      public static var NEW_COUNTER_CONTAINER_ID:String = "LobbyMenuCountersContainer";
      
      private static const Y_OFFSET_MENU_BUTTON:int = -63;
      
      private static const INVALIDATE_BUTTONS_VISIBLE:String = "buttonsVisible";
      
      private static const BACKGROUND_SIZE_FIX:int = 20;
      
      private static const COUNTER_OFFSET_X:int = 7;
       
      
      public var header:TextField;
      
      public var serverStats:ServerStats;
      
      public var reportBugPanel:ReportBugPanel;
      
      public var background:MovieClip;
      
      public var bounds:DisplayObject;
      
      public var logoffBtn:ISoundButtonEx;
      
      public var settingsBtn:IconTextBigButton;
      
      public var quitBtn:IconTextBigButton;
      
      public var cancelBtn:IconTextBigButton;
      
      public var bootcampBtn:IconTextBigButton;
      
      public var manualBtn:IconTextBigButton;
      
      public var postBtn:IconTextBigButton;
      
      public var versionTF:TextField;
      
      private var _btns:Dictionary;
      
      private var _boundsHeight:int;
      
      private var _showBootcampButton:Boolean = true;
      
      private var _showPostButton:Boolean = true;
      
      private var _showManualButton:Boolean = true;
      
      private var _menuState:String = "";
      
      private var _postIconOpen:String = "";
      
      private var _postIconClose:String = "";
      
      private var _counterManager:ICounterManager;
      
      private var _bootomPositions:Dictionary;
      
      public function LobbyMenu()
      {
         this._btns = new Dictionary();
         this._counterManager = App.utils.counterManager;
         this._bootomPositions = new Dictionary();
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         x = param1 - this.bounds.width >> 1;
         y = param2 - this.bounds.height >> 1;
         this.background.width = param1 + BACKGROUND_SIZE_FIX;
         this.background.height = param2 + BACKGROUND_SIZE_FIX;
         this.background.x = -x - BACKGROUND_SIZE_FIX * 0.5;
         this.background.y = -y - BACKGROUND_SIZE_FIX * 0.5;
      }
      
      override protected function onPopulate() : void
      {
         this.updateButtons();
         super.onPopulate();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.versionTF,TextFieldEx.VALIGN_CENTER);
         this.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_LOGOFF;
         this.settingsBtn.label = MENU.LOBBY_MENU_BUTTONS_SETTINGS;
         this.quitBtn.label = MENU.LOBBY_MENU_BUTTONS_EXIT;
         this.cancelBtn.label = MENU.LOBBY_MENU_BUTTONS_BACK;
         this.manualBtn.label = MENU.HEADERBUTTONS_WIKI;
         this.postBtn.label = MENU.LOBBY_MENU_BUTTONS_POST;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(INVALIDATE_BUTTONS_VISIBLE))
         {
            _loc1_ = !!this._showBootcampButton ? int(0) : int(Y_OFFSET_MENU_BUTTON);
            _loc1_ += !!this._showManualButton ? 0 : Y_OFFSET_MENU_BUTTON;
            _loc2_ = !!this._showPostButton ? int(0) : int(Y_OFFSET_MENU_BUTTON);
            _loc1_ += _loc2_;
            this.rePositionBottomElements(_loc1_,_loc2_);
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeButtonsListeners();
         this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
         this._counterManager = null;
         App.utils.data.cleanupDynamicObject(this._btns);
         this._btns = null;
         this.logoffBtn.dispose();
         this.settingsBtn.dispose();
         this.quitBtn.dispose();
         this.cancelBtn.dispose();
         this.bootcampBtn.dispose();
         this.manualBtn.dispose();
         this.postBtn.dispose();
         this.logoffBtn = null;
         this.settingsBtn = null;
         this.quitBtn = null;
         this.cancelBtn = null;
         this.bootcampBtn = null;
         this.manualBtn = null;
         this.postBtn = null;
         this.versionTF = null;
         this.header = null;
         this.background = null;
         this.bounds = null;
         this.serverStats = null;
         this.reportBugPanel = null;
         App.instance.utils.data.cleanupDynamicObject(this._bootomPositions);
         this._bootomPositions = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.cancelBtn);
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         super.onSetModalFocus(param1);
         onCounterNeedUpdateS();
      }
      
      override protected function setCounter(param1:Vector.<CountersVo>) : void
      {
         var _loc4_:CountersVo = null;
         var _loc2_:ISoundButtonEx = null;
         var _loc3_:CounterProps = new CounterProps(COUNTER_OFFSET_X,0,TextFormatAlign.CENTER);
         for each(_loc4_ in param1)
         {
            _loc2_ = this.getBtnByName(_loc4_.componentId);
            if(_loc2_ && _loc2_.visible)
            {
               this._counterManager.setCounter(DisplayObject(_loc2_),_loc4_.count,NEW_COUNTER_CONTAINER_ID,_loc3_);
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
               this._counterManager.removeCounter(DisplayObject(_loc2_),NEW_COUNTER_CONTAINER_ID);
            }
         }
      }
      
      public function as_setBootcampButtonLabel(param1:String, param2:String) : void
      {
         this.bootcampBtn.label = param1;
         this.bootcampBtn.htmlIconStr = param2;
      }
      
      public function as_setManualButtonIcon(param1:String) : void
      {
         this.manualBtn.htmlIconStr = param1;
      }
      
      public function as_setMenuState(param1:String) : void
      {
         if(this._menuState != Values.EMPTY_STR)
         {
            this.removeButtonsListeners();
            unregisterComponent(Aliases.SERVER_STATS);
            unregisterComponent(Aliases.REPORT_BUG);
         }
         var _loc2_:Boolean = this._menuState != param1;
         this._menuState = param1;
         this.gotoAndPlay(this._menuState);
         this.updateButtons();
         if(_loc2_)
         {
            this._bootomPositions[this.quitBtn] = this.quitBtn.y;
            this._bootomPositions[this.cancelBtn] = this.cancelBtn.y;
            this._bootomPositions[this.versionTF] = this.versionTF.y;
            this._bootomPositions[this.reportBugPanel] = this.reportBugPanel.y;
            this._bootomPositions[this.manualBtn] = this.manualBtn.y;
            this._bootomPositions[this.bootcampBtn] = this.bootcampBtn.y;
         }
         this.background.tabEnabled = false;
         this.background.tabChildren = false;
         this.logoffBtn.addEventListener(ButtonEvent.CLICK,this.onLogoffBtnClickHandler);
         this.settingsBtn.addEventListener(ButtonEvent.CLICK,this.onSettingsBtnClickHandler);
         this.quitBtn.addEventListener(ButtonEvent.CLICK,this.onQuitBtnClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.bootcampBtn.addEventListener(ButtonEvent.CLICK,this.onBootcampButtonClickHandler);
         this.manualBtn.addEventListener(ButtonEvent.CLICK,this.onManualBtnClickHandler);
         this.postBtn.addEventListener(ButtonEvent.CLICK,this.onPostBtnClickHandler);
         this.postBtn.addEventListener(MouseEvent.ROLL_OVER,this.onPostBtnRollOverHandler);
         this.postBtn.addEventListener(MouseEvent.ROLL_OUT,this.onPostBtnRollOutHandler);
         this.header.text = MENU.LOBBY_MENU_TITLE;
         registerFlashComponentS(this.serverStats,Aliases.SERVER_STATS);
         registerFlashComponentS(this.reportBugPanel,Aliases.REPORT_BUG);
         this.updateHeight(this.bounds.height);
         if(hasFocus)
         {
            onCounterNeedUpdateS();
         }
      }
      
      public function as_setPostButtonIcons(param1:String, param2:String) : void
      {
         this._postIconClose = param1;
         this._postIconOpen = param2;
         this.postBtn.htmlIconStr = this._postIconClose;
      }
      
      public function as_setPostButtonVisible(param1:Boolean) : void
      {
         this._showPostButton = this.postBtn.visible = param1;
         if(!param1)
         {
            this._counterManager.removeCounter(DisplayObject(this.postBtn),NEW_COUNTER_CONTAINER_ID);
         }
         invalidate(INVALIDATE_BUTTONS_VISIBLE);
      }
      
      public function as_setVersionMessage(param1:String) : void
      {
         this.versionTF.htmlText = param1;
      }
      
      public function as_showBootcampButton(param1:Boolean) : void
      {
         this.bootcampBtn.visible = this._showBootcampButton = param1;
         invalidate(INVALIDATE_BUTTONS_VISIBLE);
      }
      
      public function as_showManualButton(param1:Boolean) : void
      {
         this.manualBtn.visible = this._showManualButton = param1;
         invalidate(INVALIDATE_BUTTONS_VISIBLE);
      }
      
      private function updateButtons() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in [this.logoffBtn,this.settingsBtn,this.quitBtn,this.cancelBtn,this.bootcampBtn,this.manualBtn,this.postBtn])
         {
            this._btns[_loc1_.name] = _loc1_;
         }
      }
      
      private function updateHeight(param1:int) : void
      {
         this._boundsHeight = this.height = param1;
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      private function removeButtonsListeners() : void
      {
         this.logoffBtn.removeEventListener(ButtonEvent.CLICK,this.onLogoffBtnClickHandler);
         this.settingsBtn.removeEventListener(ButtonEvent.CLICK,this.onSettingsBtnClickHandler);
         this.quitBtn.removeEventListener(ButtonEvent.CLICK,this.onQuitBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.bootcampBtn.removeEventListener(ButtonEvent.CLICK,this.onBootcampButtonClickHandler);
         this.manualBtn.removeEventListener(ButtonEvent.CLICK,this.onManualBtnClickHandler);
         this.postBtn.removeEventListener(ButtonEvent.CLICK,this.onPostBtnClickHandler);
         this.postBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onPostBtnRollOverHandler);
         this.postBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onPostBtnRollOutHandler);
      }
      
      private function rePositionBottomElements(param1:int = 0, param2:int = 0) : void
      {
         this.manualBtn.y = this._bootomPositions[this.manualBtn] + param1;
         this.bootcampBtn.y = this._bootomPositions[this.bootcampBtn] + param2;
         this.quitBtn.y = this._bootomPositions[this.quitBtn] + param1;
         this.cancelBtn.y = this._bootomPositions[this.cancelBtn] + param1;
         this.postBtn.y = this._bootomPositions[this.postBtn] + param1;
         this.versionTF.y = this._bootomPositions[this.versionTF] + param1;
         this.reportBugPanel.y = this._bootomPositions[this.reportBugPanel] + param1;
         this.updateHeight(this._boundsHeight + param1);
      }
      
      private function getBtnByName(param1:String) : ISoundButtonEx
      {
         return param1 in this._btns ? ISoundButtonEx(this._btns[param1]) : null;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            onEscapePressS();
         }
      }
      
      private function onPostBtnRollOverHandler(param1:MouseEvent) : void
      {
         this.postBtn.htmlIconStr = this._postIconOpen;
      }
      
      private function onPostBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.postBtn.htmlIconStr = this._postIconClose;
      }
      
      private function onPostBtnClickHandler(param1:ButtonEvent) : void
      {
         postClickS();
      }
      
      private function onLogoffBtnClickHandler(param1:ButtonEvent) : void
      {
         logoffClickS();
      }
      
      private function onSettingsBtnClickHandler(param1:ButtonEvent) : void
      {
         settingsClickS();
      }
      
      private function onQuitBtnClickHandler(param1:ButtonEvent) : void
      {
         quitClickS();
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent = null) : void
      {
         cancelClickS();
      }
      
      private function onBootcampButtonClickHandler(param1:ButtonEvent) : void
      {
         bootcampClickS();
      }
      
      private function onManualBtnClickHandler(param1:ButtonEvent) : void
      {
         manualClickS();
      }
   }
}
