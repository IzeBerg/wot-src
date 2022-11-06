package net.wg.gui.events
{
   import flash.events.Event;
   
   public class UILoaderEvent extends Event
   {
      
      public static const IOERROR:String = "ui io error";
      
      public static const COMPLETE:String = "ui complete";
      
      public static const PROGRESS:String = "ui progress";
       
      
      public var percent:Number = 0;
      
      public function UILoaderEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:Number = 0)
      {
         super(param1,param2,param3);
         this.percent = param4;
      }
      
      override public function clone() : Event
      {
         return new UILoaderEvent(type,bubbles,cancelable,this.percent);
      }
      
      override public function toString() : String
      {
         return formatToString("UILoaderEvent","type","bubbles","cancelable","eventPhase","percent");
      }
   }
}
