package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import flash.events.Event;
   
   public class TutorialHintEvent extends Event
   {
      
      public static const LOOP_ENDED:String = "loopEnded";
      
      public static const ANIMATION_ENDED:String = "animationEnded";
       
      
      public function TutorialHintEvent(param1:String)
      {
         super(param1,true,true);
      }
   }
}
