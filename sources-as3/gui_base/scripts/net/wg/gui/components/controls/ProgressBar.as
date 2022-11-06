package net.wg.gui.components.controls
{
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ProgressBar extends UIComponent implements IProgressBar
   {
       
      
      private var _minimum:Number = 0;
      
      private var _maximum:Number = 1;
      
      private var _value:Number = 0;
      
      public function ProgressBar()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.applyDataChanges();
         }
      }
      
      protected function applyDataChanges() : void
      {
      }
      
      public function set minimum(param1:Number) : void
      {
         if(this._minimum != param1)
         {
            this._minimum = param1;
            invalidateData();
         }
      }
      
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function set maximum(param1:Number) : void
      {
         if(this._maximum != param1)
         {
            this._maximum = param1;
            invalidateData();
         }
      }
      
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function set value(param1:Number) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            invalidateData();
         }
      }
      
      public function get value() : Number
      {
         return this._value;
      }
   }
}
