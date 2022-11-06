package net.wg.gui.events
{
   import flash.events.Event;
   
   public class TimelineEvent extends Event
   {
      
      public static const TWEEN_COMPLETE:String = "tweenComplete";
       
      
      public var isShow:Boolean = false;
      
      public function TimelineEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.isShow = param2;
      }
      
      override public function clone() : Event
      {
         return new TimelineEvent(type,this.isShow,bubbles,cancelable);
      }
   }
}
