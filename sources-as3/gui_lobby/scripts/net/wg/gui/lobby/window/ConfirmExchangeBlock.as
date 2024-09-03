package net.wg.gui.lobby.window
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.VO.ConfirmExchangeBlockVO;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.ConfirmExchangeBlockEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.events.IndexEvent;
   
   public class ConfirmExchangeBlock extends UIComponentEx
   {
      
      private static const DEBOUNCE_TIMEOUT:uint = 1000;
      
      private static const DISCOUNTS_AMOUNT_APPLIED_MAX:uint = 2;
      
      private static const FADE_IN_DELAY:uint = 100;
       
      
      public var rateCmp:ExchangeHeader;
      
      public var needItemsStepperTitleTf:TextField;
      
      public var goldStepperTitleTf:TextField;
      
      public var needItemsIcon:UILoaderAlt;
      
      public var goldIcon:UILoaderAlt;
      
      public var needItemsStepper:NumericStepper;
      
      public var goldStepper:NumericStepper;
      
      public var notificationAction:ConfirmExchangeBlockNotification = null;
      
      public var notificationDiscount:ConfirmExchangeBlockNotification = null;
      
      private var _data:ConfirmExchangeBlockVO = null;
      
      private var _needItemsManualValue:int = 0;
      
      private var _useTween:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      public function ConfirmExchangeBlock()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.notificationAction.actionIsActive = true;
         this.notificationAction.discountsAmountLimitExceed = false;
         this.notificationAction.visible = false;
         this.notificationDiscount.actionIsActive = false;
         this.notificationDiscount.discountsAmountLimitExceed = true;
         this.notificationDiscount.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rateCmp.useBackDecor = false;
         this.rateCmp.useActionOffset = false;
         this.needItemsStepper.addEventListener(Event.CHANGE,this.onNeedItemsStepperChangeHandler);
         this.needItemsStepper.stepSizeUnbindedToValue = true;
         this.needItemsStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onNeedItemsStepperIndexChangeHandler);
         this.goldStepper.stepSizeUnbindedToValue = true;
         this.goldStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onGoldStepperIndexChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.needItemsStepper.removeEventListener(Event.CHANGE,this.onNeedItemsStepperChangeHandler);
         this.needItemsStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNeedItemsStepperIndexChangeHandler);
         this.goldStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onGoldStepperIndexChangeHandler);
         this.needItemsIcon.dispose();
         this.goldIcon.dispose();
         this.needItemsStepper.dispose();
         this.goldStepper.dispose();
         this.rateCmp.dispose();
         this.notificationAction.dispose();
         this.notificationDiscount.dispose();
         this.rateCmp = null;
         this.needItemsStepperTitleTf = null;
         this.goldStepperTitleTf = null;
         this.needItemsIcon = null;
         this.goldIcon = null;
         this.needItemsStepper = null;
         this.goldStepper = null;
         this.notificationAction = null;
         this.notificationDiscount = null;
         this._data = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      public function setData(param1:ConfirmExchangeBlockVO, param2:String) : void
      {
         this._data = param1;
         this.goldStepper.setMaximumWithoutValidation(param1.maxGoldValue);
         this.goldStepper.stepSize = param1.goldStepSize;
         this.needItemsStepper.stepSize = param1.exchangeRate;
         this.needItemsStepper.setMaximumWithoutValidation(param1.maxNeedItemsValue);
         this.goldStepper.textColorId = param1.goldTextColorId;
         this.needItemsStepper.textColorId = param1.itemsTextColorId;
         this.needItemsStepperTitleTf.htmlText = param1.needItemsStepperTitle;
         this.goldStepperTitleTf.htmlText = param1.goldStepperTitle;
         this.needItemsIcon.source = param1.needItemsIcon;
         this.goldIcon.source = param1.goldIcon;
         this.rateCmp.setData(this._data.exchangeHeaderData,param2,this._data.discountsAmountLimitExceed);
         this.notificationAction.setData(this._data,param2);
         this.notificationDiscount.setData(this._data,param2);
      }
      
      public function setExchangeValue(param1:Number, param2:Number, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         this.goldStepper.setValueWithoutValidation(param1);
         if(param1 >= this.goldStepper.maximum)
         {
            this.needItemsStepper.setMaximumWithoutValidation(param2);
         }
         this.needItemsStepper.setValueWithoutValidation(param2);
         if(this._data)
         {
            _loc4_ = this._data.exchangeRate;
            _loc5_ = this._data.isDiscountLimited && param1 - this._data.goldStepSize >= this._data.discountLimit;
            if(_loc5_)
            {
               _loc4_ = this._data.defaultExchangeRate;
            }
            if(this._data.isDiscountAvailable)
            {
               if(param3 < DISCOUNTS_AMOUNT_APPLIED_MAX)
               {
                  if(_loc4_ == this._data.defaultExchangeRate)
                  {
                     this.rateCmp.fadeOut(this._useTween);
                     this.notificationDiscount.fadeOut(this._useTween);
                     this.notificationDiscount.goldValue = param1;
                     this.notificationAction.fadeIn(this._useTween,FADE_IN_DELAY);
                     this.notificationAction.goldValue = param1;
                     this._useTween = true;
                     return;
                  }
                  this.rateCmp.isActionMode = true;
                  this.rateCmp.fadeIn(this._useTween,FADE_IN_DELAY);
                  this.notificationAction.fadeOut(this._useTween);
                  this.notificationDiscount.fadeOut(this._useTween);
               }
               else if(param3 >= DISCOUNTS_AMOUNT_APPLIED_MAX)
               {
                  this.rateCmp.fadeOut(this._useTween);
                  if(param3 <= this._data.maxDiscountsAppliedForMoreInfo)
                  {
                     this.notificationAction.fadeIn(this._useTween,FADE_IN_DELAY);
                     this.notificationDiscount.fadeOut(this._useTween);
                  }
                  else if(param3 > this._data.maxDiscountsAppliedForMoreInfo)
                  {
                     this.notificationAction.fadeOut(this._useTween);
                     this.notificationDiscount.fadeIn(this._useTween,FADE_IN_DELAY);
                  }
                  this.notificationAction.goldValue = param1;
                  this.notificationDiscount.goldValue = param1;
                  this._useTween = true;
                  return;
               }
            }
            else
            {
               this.rateCmp.isActionMode = false;
               this.rateCmp.fadeIn(this._useTween,FADE_IN_DELAY);
               this.notificationAction.fadeOut(this._useTween);
               this.notificationDiscount.fadeOut(this._useTween);
            }
            this.updateRateCmp(_loc4_);
            this._useTween = true;
         }
      }
      
      private function updateRateCmp(param1:Number) : void
      {
         this.rateCmp.setRates(this._data.defaultExchangeRate,param1,this._data.isDiscountLimited,this.goldStepper.value);
      }
      
      private function dispatchConfirmExchangeBlockEvent(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = this.goldStepper.value == 0;
         dispatchEvent(new ConfirmExchangeBlockEvent(ConfirmExchangeBlockEvent.VALUE_CHANGED,_loc3_,param1,param2));
      }
      
      private function onNeedItemsStepperChange() : void
      {
         this.dispatchConfirmExchangeBlockEvent(this.goldStepper.value,this._needItemsManualValue);
      }
      
      private function onGoldStepperIndexChangeHandler(param1:IndexEvent) : void
      {
         this.dispatchConfirmExchangeBlockEvent(this.goldStepper.value,this.needItemsStepper.value);
      }
      
      private function onNeedItemsStepperIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:int = this.goldStepper.value;
         if(param1.index < param1.lastIndex)
         {
            _loc2_--;
         }
         else
         {
            _loc2_++;
         }
         this.dispatchConfirmExchangeBlockEvent(_loc2_,this.needItemsStepper.value);
      }
      
      private function onNeedItemsStepperChangeHandler(param1:Event) : void
      {
         if(this.needItemsStepper.manualValue < this.needItemsStepper.maximum)
         {
            this._needItemsManualValue = this.needItemsStepper.manualValue;
         }
         else
         {
            this._needItemsManualValue = this.needItemsStepper.maximum;
         }
         this._scheduler.cancelTask(this.onNeedItemsStepperChange);
         this._scheduler.scheduleTask(this.onNeedItemsStepperChange,DEBOUNCE_TIMEOUT);
      }
   }
}
