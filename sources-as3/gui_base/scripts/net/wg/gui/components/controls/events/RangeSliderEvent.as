package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   
   public class RangeSliderEvent extends SliderEvent
   {
       
      
      public var leftValue:Number = -1;
      
      public var rightValue:Number = -1;
      
      public function RangeSliderEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Number = -1, param5:Number = -1, param6:Number = -1)
      {
         super(param1,param2,param3,param4);
         this.leftValue = param5;
         this.rightValue = param6;
      }
      
      override public function clone() : Event
      {
         return new RangeSliderEvent(type,bubbles,cancelable,value,this.leftValue,this.rightValue);
      }
      
      override public function toString() : String
      {
         return formatToString("SliderEvent","type","bubbles","cancelable","value","leftValue","rightValue");
      }
   }
}
