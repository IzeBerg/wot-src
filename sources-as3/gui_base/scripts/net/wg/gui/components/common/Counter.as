package net.wg.gui.components.common
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class Counter extends CounterBase
   {
      
      public static const NORMAL_STATE:String = "normal";
      
      public static const EMPTY_STATE:String = "empty";
       
      
      public var counterView:CounterView = null;
      
      public function Counter()
      {
         super();
      }
      
      override public function setTarget(param1:DisplayObject, param2:String, param3:Point = null, param4:String = null, param5:Boolean = true, param6:Number = 0, param7:String = null) : void
      {
         if(!param7)
         {
            param7 = NORMAL_STATE;
         }
         super.setTarget(param1,param2,param3,param4,param5,param6,param7);
         this.counterView.tfPadding = param6;
      }
      
      override protected function onDispose() : void
      {
         if(this.counterView)
         {
            this.counterView.dispose();
            this.counterView = null;
         }
         super.onDispose();
      }
      
      override protected function applyCountValue() : void
      {
         this.counterView.setCount(value);
         super.applyCountValue();
      }
      
      override protected function applyPosition() : void
      {
         var _loc1_:Rectangle = this.target.getBounds(this.target.parent);
         x = _loc1_.x + _loc1_.width | 0;
         if(this.counterView.label)
         {
            if(this.horizontalAlign == TextFormatAlign.RIGHT)
            {
               x -= this.counterView.label.width;
            }
            else if(this.horizontalAlign == TextFormatAlign.CENTER)
            {
               x -= this.counterView.label.width >> 1;
            }
         }
         y = _loc1_.y | 0;
         if(this.offset != null)
         {
            x += this.offset.x | 0;
            y += this.offset.y | 0;
         }
      }
      
      override protected function applyState() : void
      {
         super.applyState();
         if(this.viewState)
         {
            this.gotoAndStop(this.viewState);
         }
      }
   }
}
