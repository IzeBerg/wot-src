package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const SUBMIT:String = "submit";
       
      
      public function GameEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}
