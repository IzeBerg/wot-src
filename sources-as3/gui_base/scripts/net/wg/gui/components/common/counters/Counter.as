package net.wg.gui.components.common.counters
{
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class Counter extends CounterBase
   {
      
      public static const NORMAL_STATE:String = "normal";
      
      public static const EMPTY_STATE:String = "empty";
       
      
      public var counterView:CounterView = null;
      
      private var _transitions:Vector.<String>;
      
      public function Counter()
      {
         var _loc1_:FrameLabel = null;
         this._transitions = new Vector.<String>(0);
         super();
         for each(_loc1_ in currentLabels)
         {
            this._transitions.push(_loc1_.name);
         }
      }
      
      override public function setTarget(param1:DisplayObject, param2:String, param3:Point = null, param4:String = null, param5:Boolean = true, param6:int = 0, param7:String = null) : void
      {
         super.setTarget(param1,param2,param3,param4,param5,param6,param7);
         this.counterView.tfPadding = param6;
      }
      
      override protected function onDispose() : void
      {
         this._transitions.splice(0,this._transitions.length);
         this._transitions = null;
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
      
      override protected function getDefaultState() : String
      {
         return NORMAL_STATE;
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
         if(this._transitions.indexOf(this.viewState) == -1)
         {
            return;
         }
         if(this.viewState)
         {
            this.gotoAndStop(this.viewState);
         }
      }
   }
}
