package net.wg.gui.battle.views.consumablesPanel.events
{
   import flash.events.Event;
   
   public class ConsumablesButtonEvent extends Event
   {
      
      public static const GLOW_ON_IDLE_STATE:String = "glowOnIdleState";
       
      
      public function ConsumablesButtonEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ConsumablesButtonEvent(type,bubbles,cancelable);
      }
   }
}
