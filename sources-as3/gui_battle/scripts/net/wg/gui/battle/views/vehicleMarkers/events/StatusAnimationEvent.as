package net.wg.gui.battle.views.vehicleMarkers.events
{
   import flash.events.Event;
   
   public class StatusAnimationEvent extends Event
   {
      
      public static const EVENT_HIDDEN:String = "eventHidden";
       
      
      public var isOneShotAnimation:Boolean = false;
      
      public var statusID:int = -1;
      
      public function StatusAnimationEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.isOneShotAnimation = param3;
         this.statusID = param2;
      }
      
      override public function clone() : Event
      {
         return new TimelineEvent(type,this.isOneShotAnimation,bubbles,cancelable);
      }
   }
}
