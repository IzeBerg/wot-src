package net.wg.gui.lobby.shop.popovers
{
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.shop.data.VehicleSellConfirmationPopoverVO;
   import net.wg.infrastructure.base.meta.IVehicleSellConfirmationPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleSellConfirmationPopoverMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   
   public class VehicleSellConfirmationPopover extends VehicleSellConfirmationPopoverMeta implements IVehicleSellConfirmationPopoverMeta
   {
      
      private static const RESTRICT:String = "0-9";
      
      private static const AUTO_UPDATE_TIMER:int = 2000;
       
      
      public var lblTitle:TextField;
      
      public var lblPrice:TextField;
      
      public var lblError:TextField;
      
      public var input:TextInput;
      
      private var _targetPrice:int = -1;
      
      public function VehicleSellConfirmationPopover()
      {
         super();
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.runtimeValidate);
         this.lblTitle = null;
         this.lblPrice = null;
         this.lblError = null;
         this.input.removeEventListener(InputEvent.INPUT,this.onInputInputHandler);
         this.input.dispose();
         this.input = null;
         super.onDispose();
      }
      
      override protected function setInitData(param1:VehicleSellConfirmationPopoverVO) : void
      {
         this.lblTitle.htmlText = param1.titleLabel;
         this.lblPrice.htmlText = param1.priceLabel;
         this._targetPrice = param1.priceValue;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.showErrorState(false);
         this.input.addEventListener(InputEvent.INPUT,this.onInputInputHandler);
         this.input.textField.restrict = RESTRICT;
         this.lblError.text = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_CONFIRMATION_ERRORMESSAGE;
      }
      
      private function showErrorState(param1:Boolean) : void
      {
         this.lblError.visible = param1;
         this.input.highlight = param1;
      }
      
      private function runtimeValidate() : void
      {
         this.showErrorState(!this.isValidControlInput);
      }
      
      private function get isValidControlInput() : Boolean
      {
         return int(this.input.text) == this._targetPrice;
      }
      
      private function onInputInputHandler(param1:InputEvent) : void
      {
         if(param1.details.value == InputValue.KEY_UP)
         {
            this.showErrorState(false);
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            if(param1.details.code == Keyboard.ENTER)
            {
               this.runtimeValidate();
            }
            if(this.isValidControlInput)
            {
               confirmTradeInS();
            }
            else
            {
               App.utils.scheduler.scheduleTask(this.runtimeValidate,AUTO_UPDATE_TIMER);
            }
         }
      }
   }
}
