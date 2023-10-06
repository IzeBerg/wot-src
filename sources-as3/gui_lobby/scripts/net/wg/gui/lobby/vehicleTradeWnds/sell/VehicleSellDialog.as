package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.utils.VehicleSellDialogMoney;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellDialogVO;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellVehicleVo;
   import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleSellDialogMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class VehicleSellDialog extends VehicleSellDialogMeta implements IVehicleSellDialogMeta
   {
      
      public static const ICONS_TEXT_OFFSET:Number = -2;
      
      private static const SLIDING_SPEED:Number = 350;
      
      private static const TWEEN_QUICKSET:Object = {"ease":Strong.easeOut};
      
      private static const DISMISS_TANKMEN:int = 1;
      
      private static const CONTENT_RIGHT_ADDITIONAL_PADDING:int = -4;
      
      private static const INV_CONTROL_QUESTION:String = "invControlQuestion";
      
      private static const INV_BARRACKS_DROP:String = "invBarracksDrop";
      
      private static const INV_RESULT:String = "invalidateResult";
       
      
      public var headerComponent:SellHeaderComponent = null;
      
      public var slidingComponent:SellSlidingComponent = null;
      
      public var devicesComponent:SellDevicesComponent = null;
      
      public var controlQuestion:ControlQuestionComponent = null;
      
      public var windBgForm:Sprite = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var submitBtn:SoundButtonEx = null;
      
      public var result_mc:TotalResult = null;
      
      private var _settingsBtn:SettingsButton = null;
      
      private var _creditsIT:IconText = null;
      
      private var _settingsDropBtn:CheckBox = null;
      
      private var _listVisibleHeight:Number = 0;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _countTweenObjects:int = 0;
      
      private var _countCallBack:int = 0;
      
      private var _data:SellDialogVO = null;
      
      private var _controlQuestionVisible:Boolean = false;
      
      private var _totalCost:VehicleSellDialogMoney;
      
      private var _creditsCommon:int;
      
      public function VehicleSellDialog()
      {
         this._totalCost = new VehicleSellDialogMoney();
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(param1)
         {
            _loc2_ = Padding(window.contentPadding);
            _loc2_.right += CONTENT_RIGHT_ADDITIONAL_PADDING;
            window.contentPadding = _loc2_;
            window.titleUseHtml = true;
         }
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.updateWindowPosition();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         showWindowBgForm = false;
         scaleX = scaleY = 1;
         this.controlQuestion.visible = this._controlQuestionVisible;
         this._settingsBtn = this.slidingComponent.settingsBtn;
         this._settingsDropBtn = this._settingsBtn.setingsDropBtn;
         this._creditsIT = this._settingsBtn.creditsIT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.controlQuestion.visible = false;
         this.controlQuestion.addEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.onControlUserInputHandlerHandler);
         this.slidingComponent.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.onSlidingComponentListWasDrawnHandler);
         this.devicesComponent.addEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawnHandler);
         this.cancelBtn.label = DIALOGS.VEHICLESELLDIALOG_CANCEL;
         this.addEventListener(VehicleSellDialogEvent.SELECTION_CHANGED,this.onSelectionChangedHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.headerComponent.inBarracksDrop.addEventListener(ListEvent.INDEX_CHANGE,this.onHeaderComponentIndexChangeHandler);
         setFocus(this.submitBtn);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(setFocus);
         this.slidingComponent.slidingScrList.removeEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.onSlidingComponentListWasDrawnHandler);
         this.devicesComponent.removeEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawnHandler);
         this.removeEventListener(VehicleSellDialogEvent.SELECTION_CHANGED,this.onSelectionChangedHandler);
         this._settingsDropBtn.removeEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
         this.controlQuestion.removeEventListener(ControlQuestionComponent.USER_INPUT_HANDLER,this.onControlUserInputHandlerHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.headerComponent.inBarracksDrop.removeEventListener(ListEvent.INDEX_CHANGE,this.onHeaderComponentIndexChangeHandler);
         this.clearTweens();
         this._tweens = null;
         this._settingsBtn = null;
         this._settingsDropBtn = null;
         this._creditsIT = null;
         this.headerComponent.dispose();
         this.headerComponent = null;
         this.result_mc.dispose();
         this.result_mc = null;
         this.slidingComponent.dispose();
         this.devicesComponent.dispose();
         this.controlQuestion.dispose();
         this.slidingComponent = null;
         this.devicesComponent = null;
         this.controlQuestion = null;
         this.windBgForm = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this._data = null;
         this._totalCost.dispose();
         this._totalCost = null;
         App.toolTipMgr.hide();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(INV_BARRACKS_DROP))
            {
               if(this._controlQuestionVisible)
               {
                  this.cleanAndFocusControlQuestion();
               }
               setCrewDismissal(this.headerComponent.inBarracksDrop.selectedIndex == DISMISS_TANKMEN);
            }
            if(isInvalid(INV_RESULT))
            {
               this.result_mc.setMoney(this._totalCost.geResultMoney());
               this._settingsBtn.setData(this._creditsCommon);
            }
            if(isInvalid(INV_CONTROL_QUESTION))
            {
               this.controlQuestion.visible = this._controlQuestionVisible;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updateComponentsPosition();
            }
         }
      }
      
      override protected function setData(param1:SellDialogVO) : void
      {
         var _loc2_:SellVehicleVo = null;
         if(this._data == param1 || param1 == null)
         {
            return;
         }
         this._data = param1;
         this._totalCost.updateAccountMoneyDict(param1.accountMoney);
         _loc2_ = param1.sellVehicleVO;
         var _loc3_:String = !!_loc2_.isRented ? DIALOGS.VEHICLEREMOVEDIALOG_TITLE : DIALOGS.VEHICLESELLDIALOG_TITLE;
         this.window.title = App.utils.locale.makeString(_loc3_,{"name":_loc2_.userName});
         this.submitBtn.label = !!_loc2_.isRented ? DIALOGS.VEHICLESELLDIALOG_REMOVE : DIALOGS.VEHICLESELLDIALOG_SUBMIT;
         this.headerComponent.setData(_loc2_);
         this.devicesComponent.setData(this._data.optionalDevicesOnVehicle);
         this.slidingComponent.sellData = this.devicesComponent.sellData;
         this.slidingComponent.isOpened = this._data.isSlidingComponentOpened;
         this.devicesComponent.isExtended = !this._data.isSlidingComponentOpened;
         this.slidingComponent.setShells(this._data.shellsOnVehicle);
         this.slidingComponent.setEquipment(this._data.equipmentsOnVehicle);
         this.slidingComponent.battleBoosters(this._data.battleBoostersOnVehicle);
         this.slidingComponent.setInventory(this._data.modulesInInventory,this._data.shellsInInventory);
         this.slidingComponent.setCustomization(this._data.customizationOnVehicle);
         invalidate(InvalidationType.SIZE);
      }
      
      public function as_enableButton(param1:Boolean, param2:String) : void
      {
         var _loc3_:Boolean = this.submitBtn.enabled;
         this.submitBtn.enabled = param1;
         this.submitBtn.mouseEnabledOnDisabled = true;
         this.submitBtn.tooltip = param2;
         if(this.submitBtn.enabled && !_loc3_)
         {
            App.utils.scheduler.scheduleOnNextFrame(setFocus,this.submitBtn);
         }
      }
      
      public function as_setControlQuestionData(param1:Boolean, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         if(param1)
         {
            _loc4_ = App.utils.locale.gold(param2);
            _loc4_ = StringUtils.trim(_loc4_);
         }
         else
         {
            _loc4_ = App.utils.locale.integer(param2);
         }
         this.controlQuestion.controlText = param2;
         this.controlQuestion.formattedControlText = _loc4_;
         this.controlQuestion.headerText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_HEADER;
         this.controlQuestion.errorText = DIALOGS.VEHICLESELLDIALOG_CTRLQUESTION_ERRORMESSAGE;
         this.controlQuestion.questionText = param3;
         this.controlQuestion.invalidateData();
      }
      
      public function as_setSellEnabled(param1:Boolean, param2:String) : void
      {
         this.controlQuestion.setSellDisabledText(param2);
         this.controlQuestion.setSellEnabled(param1);
      }
      
      public function as_setTotal(param1:int, param2:Object) : void
      {
         this._creditsCommon = param1;
         this._totalCost.update(param2);
         invalidate(INV_RESULT);
      }
      
      public function as_updateAccountMoney(param1:String, param2:int) : void
      {
         this._totalCost.updateAccountMoney(param1,param2);
         invalidate(INV_RESULT);
      }
      
      public function as_visibleControlBlock(param1:Boolean) : void
      {
         if(this.controlQuestion.visible == param1)
         {
            return;
         }
         if(this._controlQuestionVisible)
         {
            setFocus(this.controlQuestion.userInput);
         }
         else
         {
            setFocus(this.submitBtn);
         }
         this._controlQuestionVisible = param1;
         invalidate(INV_CONTROL_QUESTION,InvalidationType.SIZE);
      }
      
      private function compCompletedTween() : Boolean
      {
         return this._countTweenObjects == this._countCallBack;
      }
      
      private function updateWindowPosition() : void
      {
         window.x = App.appWidth - window.width >> 1;
         window.y = App.appHeight - window.getBackground().height >> 1;
      }
      
      private function updateComponentsPosition() : void
      {
         this.slidingComponent.visible = this._listVisibleHeight != 0;
         if(this._listVisibleHeight != 0)
         {
            this._settingsBtn.visible = true;
            this.slidingComponent.expandBg.visible = true;
         }
         var _loc1_:int = this.headerComponent.y + this.headerComponent.getNextPosition();
         if(this.devicesComponent.isActive)
         {
            this.devicesComponent.y = _loc1_;
            _loc1_ = this.devicesComponent.y + this.devicesComponent.getNextPosition(!this.slidingComponent.visible);
         }
         if(this.slidingComponent.visible)
         {
            this._settingsDropBtn.addEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
            this.slidingComponent.y = _loc1_;
            _loc1_ = this.slidingComponent.y + this.slidingComponent.getNextPosition();
         }
         this.result_mc.y = _loc1_;
         if(this._controlQuestionVisible)
         {
            this.controlQuestion.y = this.result_mc.y + this.result_mc.getSize();
            _loc1_ = this.controlQuestion.y + this.controlQuestion.getNextPosition();
         }
         else
         {
            this.controlQuestion.y = 0;
            _loc1_ = this.result_mc.y + this.result_mc.getSize();
         }
         this.windBgForm.height = _loc1_;
         this.submitBtn.y = this.cancelBtn.y = this.windBgForm.y + this.windBgForm.height + window.contentPadding.bottom - window.formBgPadding.bottom;
         window.getBackground().height = this.submitBtn.y + this.submitBtn.height + window.contentPadding.top + window.contentPadding.bottom;
         this.updateWindowPosition();
      }
      
      private function updateElements() : void
      {
         this.slidingComponent.slidingScrList.y = this._settingsBtn.y + this._settingsBtn.height;
         this.slidingComponent.slidingScrList.visible = this.slidingComponent.isOpened;
      }
      
      private function cleanAndFocusControlQuestion() : void
      {
         this.controlQuestion.cleanField();
         if(!this.controlQuestion.userInput.focused)
         {
            App.utils.scheduler.scheduleOnNextFrame(setFocus,this.controlQuestion.userInput);
         }
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens == null)
         {
            return;
         }
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function motionCallBack(param1:Tween) : void
      {
         ++this._countCallBack;
         if(this.compCompletedTween())
         {
            this.updateComponentsPosition();
            if(this.controlQuestion.userInput == lastFocusedElement)
            {
               App.utils.scheduler.scheduleOnNextFrame(setFocus,this.controlQuestion.userInput);
            }
         }
      }
      
      private function onSlidingComponentSelectHandler(param1:Event) : void
      {
         var _loc6_:MovieClip = null;
         if(!this.compCompletedTween())
         {
            this._settingsDropBtn.removeEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
            this._settingsDropBtn.selected = !this._settingsDropBtn.selected;
            this._settingsDropBtn.addEventListener(Event.SELECT,this.onSlidingComponentSelectHandler);
            return;
         }
         this._countCallBack = 0;
         var _loc2_:Boolean = this.slidingComponent.isOpened;
         this.slidingComponent.isOpened = !_loc2_;
         this.devicesComponent.isExtended = _loc2_;
         var _loc3_:int = this.slidingComponent.resultExpand;
         var _loc4_:int = this.devicesComponent.extraHeight;
         var _loc5_:int = _loc3_ - _loc4_;
         _loc5_ = !!_loc2_ ? int(-_loc5_) : int(_loc5_);
         _loc6_ = window.getBackground();
         var _loc7_:int = App.appHeight - _loc6_.height - _loc5_ >> 1;
         var _loc8_:int = _loc6_.height + _loc5_;
         var _loc9_:int = !!_loc2_ ? int(-_loc3_) : int(_loc3_);
         var _loc10_:int = this.slidingComponent.height + _loc9_;
         var _loc11_:int = !!_loc2_ ? int(0) : int(this.slidingComponent.mask_mc.height + _loc9_);
         var _loc12_:int = this.slidingComponent.expandBg.height + _loc9_;
         var _loc13_:int = this.slidingComponent.y + (!!_loc2_ ? _loc4_ : -_loc4_);
         var _loc14_:int = this.windBgForm.height + _loc5_;
         var _loc15_:int = this.result_mc.y + _loc5_;
         var _loc16_:int = !!this._controlQuestionVisible ? int(this.controlQuestion.y + _loc5_) : int(0);
         var _loc17_:int = this.submitBtn.y + _loc5_;
         var _loc18_:int = this.cancelBtn.y + _loc5_;
         var _loc19_:Number = !!_loc2_ ? Number(1) : Number(0);
         var _loc20_:Number = !!_loc2_ ? Number(0) : Number(1);
         this.clearTweens();
         this._tweens = Vector.<Tween>([new Tween(SLIDING_SPEED,this.slidingComponent,{"height":_loc10_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.slidingComponent,{"y":_loc13_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.slidingComponent.mask_mc,{"height":_loc11_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.slidingComponent.expandBg,{"height":_loc12_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.windBgForm,{"height":_loc14_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.result_mc,{"y":_loc15_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.controlQuestion,{"y":_loc16_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.submitBtn,{"y":_loc17_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this.cancelBtn,{"y":_loc18_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this._creditsIT,{"alpha":_loc19_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,this._settingsBtn.ddLine,{"alpha":_loc20_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,window,{"y":_loc7_},TWEEN_QUICKSET),new Tween(SLIDING_SPEED,_loc6_,{"height":_loc8_},TWEEN_QUICKSET)]);
         this._countTweenObjects = this._tweens.length;
         var _loc21_:int = 0;
         while(_loc21_ < this._countTweenObjects)
         {
            this._tweens[_loc21_].onComplete = this.motionCallBack;
            this._tweens[_loc21_].fastTransform = false;
            _loc21_++;
         }
         this.updateElements();
      }
      
      private function onSubmitBtnClickHandler(param1:Event) : void
      {
         setDialogSettingsS(this._settingsDropBtn.selected);
         sellS();
      }
      
      private function onSlidingComponentListWasDrawnHandler(param1:VehicleSellDialogEvent) : void
      {
         this._listVisibleHeight = param1.listVisibleHight;
         this.updateComponentsPosition();
      }
      
      private function onSellDialogListItemRendererWasDrawnHandler(param1:Event) : void
      {
         this.updateComponentsPosition();
      }
      
      private function onSelectionChangedHandler(param1:VehicleSellDialogEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._controlQuestionVisible)
         {
            this.cleanAndFocusControlQuestion();
         }
         if(param1.itemIDList != null)
         {
            _loc2_ = param1.itemIDList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               onSelectionChangedS(param1.itemIDList[_loc3_],param1.toInventory,param1.currency);
               _loc3_++;
            }
         }
      }
      
      private function onCancelBtnClickHandler(param1:Event) : void
      {
         onWindowCloseS();
      }
      
      private function onControlUserInputHandlerHandler(param1:Event) : void
      {
         setUserInputS(this.controlQuestion.getUserText());
      }
      
      private function onHeaderComponentIndexChangeHandler(param1:Event) : void
      {
         invalidate(INV_BARRACKS_DROP);
      }
   }
}
