package net.wg.gui.lobby.components.events
{
   import flash.events.Event;
   
   public class ShineEvent extends Event
   {
      
      public static const ON_ANIM_COMPLETED:String = "onShineAnimCompleted";
      
      public static const ON_ANIM_LOOP_FINISHED:String = "onShineAnimLoopFinished";
       
      
      public function ShineEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
