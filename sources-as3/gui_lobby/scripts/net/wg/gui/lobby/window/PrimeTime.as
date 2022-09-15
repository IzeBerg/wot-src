package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.common.serverStats.ServerDropDown;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.components.data.PrimeTimeServerVO;
   import net.wg.gui.lobby.components.data.PrimeTimeVO;
   import net.wg.infrastructure.base.meta.IPrimeTimeMeta;
   import net.wg.infrastructure.base.meta.impl.PrimeTimeMeta;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.IListDAAPIDataProvider;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   
   public class PrimeTime extends PrimeTimeMeta implements IPrimeTimeMeta
   {
      
      private static const CLOSE_BTN_RIGHT_OFFSET:int = 30;
      
      private static const CLOSE_BTN_TOP_OFFSET:int = 64;
      
      private static const TOTAL_BLOCK_HEIGHT:int = 267;
      
      private static const STATUS_TF_OFFSET:int = 86;
      
      private static const SERVERS_TF_OFFSET:int = 9;
      
      private static const SERVERS_DD_OFFSET:int = -3;
      
      private static const SERVERS_DD_GAP:int = 2;
      
      private static const TIME_TF_OFFSET:int = 23;
      
      private static const SEPARATOR_OFFSET:int = 43;
      
      private static const BUTTONS_GAP:int = 10;
      
      private static const BUTTONS_OFFSET:int = 25;
      
      private static const ALERT_BG_OFFSET:int = -337;
       
      
      public var warningIcon:IImage = null;
      
      public var serversTf:TextField = null;
      
      public var serversDD:ServerDropDown = null;
      
      public var timeTf:TextField = null;
      
      public var cancelBtn:UniversalBtn = null;
      
      public var alertBG:MovieClip = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public var statusTf:TextField = null;
      
      public var separator:MovieClip = null;
      
      public var applyBtn:UniversalBtn = null;
      
      private var _dataProvider:IListDAAPIDataProvider = null;
      
      private var _data:PrimeTimeVO = null;
      
      public function PrimeTime()
      {
         super();
         fadeAnimat = true;
         this._dataProvider = new ListDAAPIDataProvider(PrimeTimeServerVO);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setViewSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serversDD.dataProvider = this._dataProvider;
         this.serversDD.addEventListener(ListEvent.INDEX_CHANGE,this.onServersDDIndexChangeHandler);
         this.serversDD.selectedIndex = this._dataProvider.getDAAPIselectedIdx();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
         this.applyBtn.label = EPIC_BATTLE.PRIMETIME_APPLYBTN;
         App.utils.universalBtnStyles.setStyle(this.applyBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.cancelBtn.label = EPIC_BATTLE.PRIMETIME_CANCELBTN;
         App.utils.universalBtnStyles.setStyle(this.cancelBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.warningIcon.addEventListener(Event.CHANGE,this.onWarningIconChangeHandler);
         this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.validateNow();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.statusTf.htmlText = this._data.status;
            this.serversTf.htmlText = this._data.serversText;
            this.timeTf.htmlText = this._data.timeText;
            this.warningIcon.source = this._data.warningIconSrc;
            this.alertBG.visible = this._data.showAlertBG;
            this.serversDD.visible = this._data.serverDDVisible;
            this.serversDD.enabled = this._data.serversDDEnabled;
            App.utils.commons.updateTextFieldSize(this.serversTf,true,false);
            App.utils.commons.updateTextFieldSize(this.statusTf,false,true);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            updateBG();
            this.setIconSmoothing();
            this.warningIcon.x = width - this.warningIcon.width >> 1;
            this.warningIcon.y = height - TOTAL_BLOCK_HEIGHT >> 1;
            this.statusTf.x = 0;
            this.statusTf.y = this.warningIcon.y + STATUS_TF_OFFSET;
            this.statusTf.width = width;
            _loc1_ = !!this.serversDD.visible ? int(this.serversDD.width + SERVERS_DD_GAP) : int(0);
            this.serversTf.x = width - this.serversTf.width - _loc1_ >> 1;
            this.serversTf.y = this.statusTf.y + this.statusTf.height + SERVERS_TF_OFFSET;
            if(this.serversDD.visible)
            {
               this.serversDD.x = this.serversTf.x + this.serversTf.width + SERVERS_DD_GAP | 0;
               this.serversDD.y = this.serversTf.y + SERVERS_DD_OFFSET;
            }
            this.timeTf.x = 0;
            this.timeTf.y = this.serversTf.y + TIME_TF_OFFSET;
            this.timeTf.width = width;
            this.separator.x = width - this.separator.width >> 1;
            this.separator.y = this.timeTf.y + SEPARATOR_OFFSET;
            this.applyBtn.x = width - this.applyBtn.width - this.cancelBtn.width - BUTTONS_GAP >> 1;
            this.applyBtn.y = this.cancelBtn.y = this.separator.y + BUTTONS_OFFSET;
            this.cancelBtn.x = this.applyBtn.x + this.applyBtn.width + BUTTONS_GAP;
            if(this.alertBG.visible)
            {
               this.alertBG.x = width - this.alertBG.width >> 1;
               this.alertBG.y = this.warningIcon.y + ALERT_BG_OFFSET;
            }
            this.closeBtn.x = width - this.closeBtn.width - CLOSE_BTN_RIGHT_OFFSET;
            this.closeBtn.y = CLOSE_BTN_TOP_OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         this.warningIcon.removeEventListener(Event.CHANGE,this.onWarningIconChangeHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.serversDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onServersDDIndexChangeHandler);
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.warningIcon.dispose();
         this.warningIcon = null;
         this.serversDD.dispose();
         this.serversDD = null;
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.applyBtn.dispose();
         this.applyBtn = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this._data = null;
         this.serversTf = null;
         this.timeTf = null;
         this.alertBG = null;
         this.statusTf = null;
         this.separator = null;
         super.onDispose();
      }
      
      override protected function setData(param1:PrimeTimeVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function as_getServersDP() : Object
      {
         return this._dataProvider;
      }
      
      private function setIconSmoothing() : void
      {
         if(App.appScale > 1)
         {
            this.warningIcon.smoothing = false;
         }
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         applyS();
      }
      
      private function onEscapeKeyDownHandler(param1:InputEvent) : void
      {
         closeViewS();
      }
      
      private function onServersDDIndexChangeHandler(param1:ListEvent) : void
      {
         selectServerS(param1.index);
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onWarningIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
