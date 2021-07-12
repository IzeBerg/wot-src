package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.events.Event;
   
   public class TriggerEvent extends Event
   {
      
      public static const TRIGGER_ACTIVATED:String = "triggerActivated";
       
      
      public var componentState:Boolean = false;
      
      public function TriggerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3);
         this.componentState = param4;
      }
   }
}
