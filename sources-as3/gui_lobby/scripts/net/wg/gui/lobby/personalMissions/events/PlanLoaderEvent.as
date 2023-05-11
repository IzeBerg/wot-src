package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class PlanLoaderEvent extends Event
   {
      
      public static const PLAN_READY:String = "onPlanReadyToUse";
       
      
      public var swfUrl:String = "";
      
      public function PlanLoaderEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.swfUrl = param2;
      }
      
      override public function clone() : Event
      {
         return new PlanLoaderEvent(type,this.swfUrl,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "[PlanLoaderEvent slotID:" + this.swfUrl + "]";
      }
   }
}
