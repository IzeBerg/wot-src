package net.wg.gui.battle.views.destroyTimers.events
{
   import flash.events.Event;
   import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
   
   public class DestroyTimerEvent extends Event
   {
      
      public static const TIMER_HIDDEN_EVENT:String = "timerHiddenEvent";
       
      
      public var destroyTimer:DestroyTimer = null;
      
      public function DestroyTimerEvent(param1:String, param2:DestroyTimer, param3:Boolean = false, param4:Boolean = false)
      {
         this.destroyTimer = param2;
         super(param1,param3,param4);
      }
      
      override public function clone() : Event
      {
         return new DestroyTimerEvent(type,this.destroyTimer);
      }
   }
}
