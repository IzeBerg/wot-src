package net.wg.gui.bootcamp.events
{
   import flash.events.Event;
   
   public class AppearEvent extends Event
   {
      
      public static const PREPARE:String = "appearStart";
      
      public static const ALL_COMPLETE:String = "appearAllComplete";
      
      public static const TWEEN_COMPLETE:String = "appearTweenComplete";
      
      public static const IN_TWEEN:String = "InTween";
       
      
      public var key:String;
      
      public var owner:String;
      
      public function AppearEvent(param1:String, param2:String = "", param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.key = param2;
         this.owner = param3;
      }
      
      override public function clone() : Event
      {
         return new AppearEvent(type,this.key,this.owner,bubbles,cancelable);
      }
   }
}
