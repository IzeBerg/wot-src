package net.wg.gui.lobby.profile.components
{
   import flash.text.TextFormat;
   import net.wg.gui.components.advanced.DashLineTextItem;
   
   public class ColoredDeshLineTextItem extends DashLineTextItem
   {
       
      
      private var _valueTextColor:uint = 0;
      
      public function ColoredDeshLineTextItem()
      {
         super();
         this._valueTextColor = valueTextField.textColor;
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(VALUE_INV))
         {
            _loc1_ = valueTextField.getTextFormat();
            _loc1_.color = this._valueTextColor;
            valueTextField.setTextFormat(_loc1_);
         }
      }
      
      public function get valueTextColor() : uint
      {
         return this._valueTextColor;
      }
      
      public function set valueTextColor(param1:uint) : void
      {
         if(this._valueTextColor != param1)
         {
            this._valueTextColor = param1;
            invalidate(VALUE_INV);
         }
      }
   }
}
