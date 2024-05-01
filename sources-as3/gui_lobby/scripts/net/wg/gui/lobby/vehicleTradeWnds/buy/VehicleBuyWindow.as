package net.wg.gui.lobby.vehicleTradeWnds.buy
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.assets.ArrowSeparator;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.interfaces.IVehicleBuyView;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyVo;
   import net.wg.gui.lobby.vehicleTradeWnds.cpmts.VehicleTradeHeader;
   import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleBuyWindowMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IWindow;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleBuyWindow extends VehicleBuyWindowMeta implements IVehicleBuyWindowMeta
   {
      
      private static const CONTENT_POS_X:Number = 0;
      
      private static const CONTENT_POS_Y:Number = 125;
      
      private static const INVALID_DEPENDENT_LABEL:String = "invalidDependentLabels";
      
      private static const INVALID_SUBMIT_BTN:String = "invalidSubmitBtn";
      
      private static const INVALID_TOTAL_CREDITS:String = "invalidTotalCredits";
      
      private static const INVALID_TRADE_IN_WARNNING_MESSAGE:String = "invalidTradeInWarningMessage";
      
      private static const INVALID_TOTAL_GOLD:String = "invalidTotalGold";
      
      private static const INVALID_TRADEOFF_VEHICLE:String = "invalidVehicle";
      
      private static const INVALID_CONTENT_HEIGHT:String = "invalidContentHeight";
      
      private static const BG_BOTTOM_GAP:Number = 18;
      
      private static const BTN_TOP_GAP:Number = 2;
      
      private static const MIN_WND_CONTENT_HEIGHT:Number = 400;
      
      private static const CONTENT:String = "content";
       
      
      public var header:VehicleTradeHeader = null;
      
      public var submitBtn:SoundButtonEx = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var separator:ArrowSeparator = null;
      
      public var bounds:Sprite = null;
      
      public var bg:Sprite = null;
      
      private var _content:IVehicleBuyView = null;
      
      private var _dataVo:VehicleBuyVo = null;
      
      private var _isPopulated:Boolean = false;
      
      private var _needUpdateSubmitFocus:Boolean = false;
      
      private var _isSetSubmitFocus:Boolean = false;
      
      private var _totalGold:Number = -1;
      
      private var _totalCredits:Number = -1;
      
      private var _selectedTab:Number = -1;
      
      private var _vehicleBuyTradeOffVo:VehicleBuyTradeOffVo = null;
      
      private var _needUpdateWndPosition:Boolean = false;
      
      private var _tradeInWarningMessage:String = "";
      
      private var _academyEnabled:Boolean;
      
      private var _schoolEnabled:Boolean;
      
      private var _freeEnabled:Boolean;
      
      public function VehicleBuyWindow()
      {
         super();
         showWindowBgForm = false;
         this.separator.visible = false;
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
         window.useBottomBtns = true;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         DisplayObject(window).visible = false;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.submitBtn);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(this._dataVo != null && isInvalid(InvalidationType.DATA))
         {
            this.window.titleUseHtml = true;
            this._selectedTab = this._dataVo.contentData && this._dataVo.contentData.selectedTab != Values.DEFAULT_INT ? Number(this._dataVo.contentData.selectedTab) : Number(0);
            invalidate(INVALID_DEPENDENT_LABEL);
            if(!this._isPopulated)
            {
               this.header.setData(this._dataVo.headerDataVo);
               this._content = App.utils.classFactory.getComponent(this._dataVo.contentLinkage,IVehicleBuyView);
               this._content.name = CONTENT;
               this._content.setTrainingButtonsEnableState(this._academyEnabled,this._schoolEnabled,this._freeEnabled);
               if(this._dataVo.isContentDAAPI)
               {
                  App.utils.asserter.assert(StringUtils.isNotEmpty(this._dataVo.contentAlias),"contentAlias" + Errors.CANT_EMPTY);
                  registerFlashComponentS(IDAAPIModule(this._content),this._dataVo.contentAlias);
               }
               this._content.x = CONTENT_POS_X;
               this._content.y = CONTENT_POS_Y;
               this.addChild(DisplayObject(this._content));
               this._content.addEventListener(VehicleBuyEvent.UPDATE_INTERFACE,this.onContentUpdateInterfaceHandler);
               this._content.addEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onContentTotalPriceUpdatedHandler);
               this._content.addEventListener(VehicleBuyEvent.TAB_CHANGE,this.onContentTabChangeHandler);
               this._content.addEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onContentSizeChangeHandler);
               this._content.addEventListener(VehicleBuyEvent.TRADE_IN_CLEAR_VEHICLE,this.onContentTradeInClearVehicleHandler);
               this.separator.visible = !this._dataVo.isTradeIn;
            }
            this._content.memberTradeInIntCD(this._dataVo.headerDataVo.intCD);
            this._content.update(this._dataVo.contentData);
            this._isPopulated = true;
         }
         if(this._dataVo != null && isInvalid(INVALID_DEPENDENT_LABEL))
         {
            this.updateDependentLabels(this._dataVo.isTradeIn,this._selectedTab);
         }
         if(this._content && isInvalid(INVALID_TRADE_IN_WARNNING_MESSAGE))
         {
            this._content.setTradeInWarningMessagege(this._tradeInWarningMessage);
         }
         if(this._content && isInvalid(INVALID_TOTAL_CREDITS))
         {
            this._content.updateTotalCredits(this._totalCredits);
         }
         if(this._content && isInvalid(INVALID_TOTAL_GOLD))
         {
            this._content.updateTotalGold(this._totalGold);
         }
         if(this._content && isInvalid(INVALID_TRADEOFF_VEHICLE))
         {
            this._content.updateTradeOffVehicle(this._vehicleBuyTradeOffVo);
         }
         if(isInvalid(INVALID_SUBMIT_BTN))
         {
            if(this._needUpdateSubmitFocus && this.submitBtn.enabled && this._isSetSubmitFocus)
            {
               App.utils.scheduler.scheduleOnNextFrame(setFocus,this.submitBtn);
               this._needUpdateSubmitFocus = false;
            }
         }
         if(this._content && isInvalid(INVALID_CONTENT_HEIGHT))
         {
            this.bg.height = Math.max(this._content.y + this._content.getActualHeight() + BG_BOTTOM_GAP,MIN_WND_CONTENT_HEIGHT);
            this.submitBtn.y = this.cancelBtn.y = this.bg.y + this.bg.height + BTN_TOP_GAP;
            this.bounds.height = this.submitBtn.y + this.submitBtn.height;
            window.updateSize(this.width,this.height,true);
            if(this._needUpdateWndPosition)
            {
               _loc1_ = 0;
               if(window.contentPadding.hasOwnProperty("vertical"))
               {
                  _loc1_ = window.contentPadding["vertical"];
               }
               window.y = App.appHeight - this.bounds.height - _loc1_ >> 1;
               if(!DisplayObject(window).visible)
               {
                  App.utils.scheduler.scheduleOnNextFrame(this.showWindow);
               }
               this._needUpdateWndPosition = false;
            }
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.showWindow);
         App.utils.scheduler.cancelTask(setFocus);
         this.header.dispose();
         this.header = null;
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitButtonClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         if(this._content)
         {
            this._content.removeEventListener(VehicleBuyEvent.UPDATE_INTERFACE,this.onContentUpdateInterfaceHandler);
            this._content.removeEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onContentTotalPriceUpdatedHandler);
            this._content.removeEventListener(VehicleBuyEvent.TAB_CHANGE,this.onContentTabChangeHandler);
            this._content.removeEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onContentSizeChangeHandler);
            this._content.removeEventListener(VehicleBuyEvent.TRADE_IN_CLEAR_VEHICLE,this.onContentTradeInClearVehicleHandler);
            if(!this._dataVo.isContentDAAPI)
            {
               this._content.dispose();
            }
            this._content = null;
         }
         this._dataVo = null;
         this._vehicleBuyTradeOffVo = null;
         this.separator.dispose();
         this.separator = null;
         this.bounds = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:VehicleBuyVo) : void
      {
         this._dataVo = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override protected function updateTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         this._vehicleBuyTradeOffVo = param1;
         invalidate(INVALID_TRADEOFF_VEHICLE);
      }
      
      public function as_setCredits(param1:Number) : void
      {
         this._totalCredits = param1;
         invalidate(INVALID_TOTAL_CREDITS);
      }
      
      public function as_setGold(param1:Number) : void
      {
         this._totalGold = param1;
         invalidate(INVALID_TOTAL_GOLD);
      }
      
      public function as_setTradeInWarningMessagege(param1:String) : void
      {
         this._tradeInWarningMessage = param1;
         invalidate(INVALID_TRADE_IN_WARNNING_MESSAGE);
      }
      
      public function as_setState(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this._academyEnabled = param1;
         this._schoolEnabled = param2;
         this._freeEnabled = param3;
         this.submitBtn.enabled = param4;
         if(this._content)
         {
            this._content.setTrainingButtonsEnableState(this._academyEnabled,this._schoolEnabled,this._freeEnabled);
         }
         invalidate(INVALID_SUBMIT_BTN);
      }
      
      private function onContentTradeInClearVehicleHandler() : void
      {
         onTradeInClearVehicleS();
      }
      
      private function updateDependentLabels(param1:Boolean, param2:Number) : void
      {
         if(param1 && param2 == 1)
         {
            this.window.title = this._dataVo.tradeInTitle;
            this.submitBtn.label = this._dataVo.tradeInSubmitBtnLabel;
            this.cancelBtn.label = this._dataVo.tradeInCancelBtnLabel;
         }
         else
         {
            this.window.title = this._dataVo.title;
            this.submitBtn.label = this._dataVo.submitBtnLabel;
            this.cancelBtn.label = this._dataVo.cancelBtnLabel;
         }
      }
      
      private function showWindow() : void
      {
         DisplayObject(window).visible = true;
      }
      
      override public function get height() : Number
      {
         return this.bounds.height;
      }
      
      override public function get width() : Number
      {
         return this.bounds.width;
      }
      
      public function get content() : IVehicleBuyView
      {
         return this._content;
      }
      
      private function onContentUpdateInterfaceHandler(param1:VehicleBuyEvent) : void
      {
         if(this._content)
         {
            stateChangeS(this._content.getSubmitData());
         }
      }
      
      private function onContentTotalPriceUpdatedHandler(param1:VehicleBuyEvent) : void
      {
         this._needUpdateSubmitFocus = true;
         this._isSetSubmitFocus = param1.isSubmitSetFocus;
         invalidate(INVALID_SUBMIT_BTN);
      }
      
      private function onContentTabChangeHandler(param1:VehicleBuyEvent) : void
      {
         this._selectedTab = param1.tabIndex;
         selectTabS(this._selectedTab);
         invalidate(INVALID_DEPENDENT_LABEL,INVALID_CONTENT_HEIGHT);
      }
      
      private function onContentSizeChangeHandler(param1:VehicleBuyEvent) : void
      {
         this._needUpdateWndPosition = true;
         invalidate(INVALID_CONTENT_HEIGHT);
      }
      
      private function onSubmitButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this._content)
         {
            submitS(this._content.getSubmitData());
         }
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
   }
}
