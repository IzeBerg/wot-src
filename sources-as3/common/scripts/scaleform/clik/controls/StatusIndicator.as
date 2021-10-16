package scaleform.clik.controls
{
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class StatusIndicator extends UIComponent
   {
       
      
      protected var _maximum:Number = 10;
      
      protected var _minimum:Number = 0;
      
      protected var _value:Number = 0;
      
      public function StatusIndicator()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      [Inspectable(defaultValue="10")]
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function set maximum(param1:Number) : void
      {
         this._maximum = param1;
      }
      
      [Inspectable(defaultValue="0")]
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function set minimum(param1:Number) : void
      {
         if(this._minimum == param1)
         {
            return;
         }
         this._minimum = param1;
         invalidateData();
      }
      
      [Inspectable(defaultValue="0")]
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         var _loc2_:Number = Math.max(this._minimum,Math.min(this._maximum,param1));
         if(this._value == _loc2_)
         {
            return;
         }
         this._value = _loc2_;
         invalidateData();
      }
      
      public function get position() : Number
      {
         return this._value;
      }
      
      public function set position(param1:Number) : void
      {
         this.value = param1;
      }
      
      override public function toString() : String
      {
         return "[CLIK StatusIndicator " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tabEnabled = focusable = false;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updatePosition();
         }
      }
      
      protected function updatePosition() : void
      {
         if(!enabled)
         {
            return;
         }
         var _loc1_:Number = (this._value - this._minimum) / (this._maximum - this._minimum);
         gotoAndStop(Math.max(1,Math.round(_loc1_ * totalFrames)));
      }
   }
}
