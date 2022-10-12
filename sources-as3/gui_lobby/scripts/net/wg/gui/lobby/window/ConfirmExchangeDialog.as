package net.wg.gui.lobby.window
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.VO.ConfirmExchangeDialogVO;
   import net.wg.data.constants.generated.CONFIRM_EXCHANGE_DIALOG_TYPES;
   import net.wg.gui.components.advanced.ExtraModuleIcon;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.icons.TankTypeIco;
   import net.wg.gui.events.ConfirmExchangeBlockEvent;
   import net.wg.infrastructure.base.meta.IConfirmExchangeDialogMeta;
   import net.wg.infrastructure.base.meta.impl.ConfirmExchangeDialogMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class ConfirmExchangeDialog extends ConfirmExchangeDialogMeta implements IConfirmExchangeDialogMeta
   {
      
      private static const VEHICLE_TEXTS_OFFSET:Number = -11;
      
      private static const PLATFORM_PACK_TEXTS_OFFSET:int = -60;
       
      
      public var vehicleIcon:TankTypeIco;
      
      public var moduleIcon:ExtraModuleIcon;
      
      public var itemNameTf:TextField;
      
      public var needItemsTf:TextField;
      
      public var needGoldTf:TextField;
      
      public var lockExchangeMessageTf:TextField;
      
      public var exchangeBlock:ConfirmExchangeBlock;
      
      public var exchangeBtn:SoundButtonEx;
      
      public var cancelBtn:SoundButtonEx;
      
      private var _isBlinking:Boolean = false;
      
      private var _originalPos:Dictionary;
      
      public function ConfirmExchangeDialog()
      {
         super();
         this._originalPos = new Dictionary();
         this._originalPos[this.itemNameTf] = this.itemNameTf.x;
         this._originalPos[this.needItemsTf] = this.needItemsTf.x;
         this._originalPos[this.needGoldTf] = this.needGoldTf.x;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.exchangeBtn.addEventListener(ButtonEvent.PRESS,this.onExchangeBtnPressHandler);
         this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.exchangeBlock.addEventListener(ConfirmExchangeBlockEvent.VALUE_CHANGED,this.onExchangeBlockValueChangedHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.exchangeBtn);
      }
      
      override protected function update(param1:ConfirmExchangeDialogVO) : void
      {
         var _loc2_:Boolean = false;
         this.vehicleIcon.visible = false;
         this.moduleIcon.visible = false;
         switch(param1.iconType)
         {
            case CONFIRM_EXCHANGE_DIALOG_TYPES.VEHICLE_ICON:
               this.vehicleIcon.type = param1.icon;
               this.vehicleIcon.visible = true;
               this.layout(VEHICLE_TEXTS_OFFSET);
               break;
            case CONFIRM_EXCHANGE_DIALOG_TYPES.MODULE_ICON:
               this.moduleIcon.setValueLabel(param1.icon,0);
               this.moduleIcon.extraIconSource = param1.iconExtraInfo;
               this.moduleIcon.visible = true;
               this.layout();
               break;
            case CONFIRM_EXCHANGE_DIALOG_TYPES.PLATFORM_PACK_ICON:
               this.layout(PLATFORM_PACK_TEXTS_OFFSET);
               break;
            default:
               App.utils.asserter.assert(false,"Unknown icon type");
         }
         _loc2_ = param1.state == CONFIRM_EXCHANGE_DIALOG_TYPES.NORMAL_STATE;
         this.needItemsTf.visible = _loc2_ || param1.state == CONFIRM_EXCHANGE_DIALOG_TYPES.NOT_ENOUGH_GOLD_STATE;
         this.needGoldTf.visible = _loc2_;
         this.exchangeBlock.visible = _loc2_;
         this.lockExchangeMessageTf.visible = !_loc2_;
         window.title = param1.title;
         this.itemNameTf.htmlText = param1.itemName;
         this.needItemsTf.htmlText = param1.needItemsText;
         this.exchangeBtn.label = param1.exchangeBtnText;
         this.cancelBtn.label = param1.cancelBtnText;
         this.exchangeBtn.enabled = _loc2_;
         if(_loc2_)
         {
            this.exchangeBlock.setData(param1.exchangeBlockData);
            this.needGoldTf.htmlText = param1.needGoldText;
         }
         else
         {
            this.lockExchangeMessageTf.htmlText = param1.lockExchangeMessage;
            this.lockExchangeMessageTf.x = Math.round((width - this.lockExchangeMessageTf.textWidth) * 0.5);
         }
      }
      
      override protected function onDispose() : void
      {
         this.setBlinking(false);
         this.exchangeBtn.removeEventListener(ButtonEvent.PRESS,this.onExchangeBtnPressHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.exchangeBlock.removeEventListener(ConfirmExchangeBlockEvent.VALUE_CHANGED,this.onExchangeBlockValueChangedHandler);
         this.vehicleIcon.dispose();
         this.moduleIcon.dispose();
         this.exchangeBlock.dispose();
         this.exchangeBtn.dispose();
         this.cancelBtn.dispose();
         App.utils.data.cleanupDynamicObject(this._originalPos);
         this.vehicleIcon = null;
         this.moduleIcon = null;
         this.itemNameTf = null;
         this.needItemsTf = null;
         this.needGoldTf = null;
         this.lockExchangeMessageTf = null;
         this.exchangeBlock = null;
         this.exchangeBtn = null;
         this.cancelBtn = null;
         this._originalPos = null;
         super.onDispose();
      }
      
      private function layout(param1:Number = 0.0) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = undefined;
         for(_loc3_ in this._originalPos)
         {
            _loc2_ = _loc3_ as DisplayObject;
            App.utils.asserter.assertNotNull(_loc2_,"Item must be DisplayObject");
            _loc2_.x = this._originalPos[_loc3_] + param1;
         }
      }
      
      private function setBlinking(param1:Boolean) : void
      {
         if(this._isBlinking == param1)
         {
            return;
         }
         this._isBlinking = param1;
         if(!this._isBlinking)
         {
            App.utils.tweenAnimator.removeAnims(this.needItemsTf);
            App.utils.tweenAnimator.removeAnims(this.needGoldTf);
            this.needGoldTf.alpha = 1;
            this.needItemsTf.alpha = 1;
         }
         else
         {
            App.utils.tweenAnimator.blinkInfinity(this.needItemsTf);
            App.utils.tweenAnimator.blinkInfinity(this.needGoldTf);
         }
      }
      
      private function onExchangeBtnPressHandler(param1:ButtonEvent) : void
      {
         exchangeS(this.exchangeBlock.goldStepper.value);
      }
      
      private function onCancelBtnPressHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onExchangeBlockValueChangedHandler(param1:ConfirmExchangeBlockEvent) : void
      {
         this.exchangeBtn.enabled = !param1.isNull;
         this.setBlinking(!param1.isEnough);
      }
   }
}
