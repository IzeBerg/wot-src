package net.wg.gui.lobby.storage.categories.storage
{
   import flash.text.TextField;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.gui.components.controls.IconText;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BalanceBlock extends UIComponentEx
   {
      
      private static const BALANCE_VALUE_TEXT_SIZE:uint = 22;
      
      private static const BALANCE_LABEL_VALUE_GAP:int = 4;
       
      
      public var balanceLabel:TextField;
      
      public var balanceValue:IconText;
      
      private var _balanceAmount:String;
      
      private var _currencyIcon:String;
      
      public function BalanceBlock()
      {
         this._balanceAmount = String.prototype;
         this._currencyIcon = String.prototype;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         this.balanceLabel.text = STORAGE.STORAGE_BALANCELABEL;
         App.utils.commons.updateTextFieldSize(this.balanceLabel,true,false);
         this.balanceValue.textFont = Fonts.TITLE_FONT;
         this.balanceValue.textSize = BALANCE_VALUE_TEXT_SIZE;
         this.balanceValue.iconPosition = IconTextPosition.RIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.balanceValue.text = this._balanceAmount;
            this.balanceValue.icon = this._currencyIcon;
            this.balanceValue.validateNow();
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.balanceValue.x = -this.balanceValue.actualWidth;
            this.balanceLabel.x = this.balanceValue.x - BALANCE_LABEL_VALUE_GAP - this.balanceLabel.width;
         }
      }
      
      override protected function onDispose() : void
      {
         this.balanceValue.dispose();
         this.balanceValue = null;
         this.balanceLabel = null;
         super.onDispose();
      }
      
      public function set icon(param1:String) : void
      {
         if(param1 == this._currencyIcon)
         {
            return;
         }
         this._currencyIcon = param1;
         invalidateData();
      }
      
      public function set amount(param1:String) : void
      {
         if(param1 == this._balanceAmount)
         {
            return;
         }
         this._balanceAmount = param1;
         invalidateData();
      }
   }
}
