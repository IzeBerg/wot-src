package net.wg.gui.events
{
   import flash.events.Event;
   
   public class CooldownEvent extends Event
   {
      
      public static const FINISHED:String = "finished";
       
      
      public function CooldownEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new CooldownEvent(type);
      }
   }
}
