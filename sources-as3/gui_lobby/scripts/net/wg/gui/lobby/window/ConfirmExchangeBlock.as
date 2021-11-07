package net.wg.gui.lobby.window
{
   import flash.text.TextField;
   import net.wg.data.VO.ConfirmExchangeBlockVO;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.ConfirmExchangeBlockEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.IndexEvent;
   
   public class ConfirmExchangeBlock extends UIComponentEx
   {
       
      
      public var rateCmp:ExchangeHeader;
      
      public var needItemsStepperTitleTf:TextField;
      
      public var goldStepperTitleTf:TextField;
      
      public var needItemsIcon:UILoaderAlt;
      
      public var goldIcon:UILoaderAlt;
      
      public var needItemsStepper:NumericStepper;
      
      public var goldStepper:NumericStepper;
      
      private var _realExchangeRate:Number;
      
      private var _needGoldValue:Number;
      
      public function ConfirmExchangeBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rateCmp.useBackDecor = false;
         this.rateCmp.useActionOffset = false;
         this.needItemsStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onNeedItemsStepperIndexChangeHandler);
         this.goldStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onGoldStepperIndexChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.needItemsStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNeedItemsStepperIndexChangeHandler);
         this.goldStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onGoldStepperIndexChangeHandler);
         this.needItemsIcon.dispose();
         this.goldIcon.dispose();
         this.needItemsStepper.dispose();
         this.goldStepper.dispose();
         this.rateCmp.dispose();
         this.rateCmp = null;
         this.needItemsStepperTitleTf = null;
         this.goldStepperTitleTf = null;
         this.needItemsIcon = null;
         this.goldIcon = null;
         this.needItemsStepper = null;
         this.goldStepper = null;
         super.onDispose();
      }
      
      public function setData(param1:ConfirmExchangeBlockVO) : void
      {
         this._realExchangeRate = param1.exchangeRate;
         this._needGoldValue = param1.defaultGoldValue;
         this.goldStepper.maximum = param1.maxGoldValue;
         this.needItemsStepper.maximum = this.convertGold(this.goldStepper.maximum);
         this.goldStepper.stepSize = param1.goldStepSize;
         this.needItemsStepper.stepSize = this.convertGold(param1.goldStepSize);
         this.goldStepper.textColorId = param1.goldTextColorId;
         this.needItemsStepper.textColorId = param1.itemsTextColorId;
         this.needItemsStepperTitleTf.htmlText = param1.needItemsStepperTitle;
         this.goldStepperTitleTf.htmlText = param1.goldStepperTitle;
         this.needItemsIcon.source = param1.needItemsIcon;
         this.goldIcon.source = param1.goldIcon;
         this.needItemsStepper.value = this.convertGold(this._needGoldValue);
         this.goldStepper.value = this._needGoldValue;
         this.rateCmp.setData(param1.exchangeHeaderData);
         this.rateCmp.setRates(param1.defaultExchangeRate,param1.exchangeRate);
         this.rateCmp.isActionMode = param1.defaultExchangeRate != param1.exchangeRate && param1.exchangeRate != 0;
      }
      
      private function convertGold(param1:Number) : Number
      {
         return Math.floor(param1 * this._realExchangeRate);
      }
      
      private function convertNeedItems(param1:Number) : int
      {
         return Math.ceil(param1 / this._realExchangeRate);
      }
      
      private function onGoldStepperIndexChangeHandler(param1:IndexEvent) : void
      {
         this.needItemsStepper.value = this.convertGold(this.goldStepper.value);
         var _loc2_:Boolean = this.goldStepper.value >= this._needGoldValue;
         var _loc3_:Boolean = this.goldStepper.value == 0;
         dispatchEvent(new ConfirmExchangeBlockEvent(ConfirmExchangeBlockEvent.VALUE_CHANGED,_loc2_,_loc3_));
      }
      
      private function onNeedItemsStepperIndexChangeHandler(param1:IndexEvent) : void
      {
         this.goldStepper.value = this.convertNeedItems(this.needItemsStepper.value);
      }
   }
}
