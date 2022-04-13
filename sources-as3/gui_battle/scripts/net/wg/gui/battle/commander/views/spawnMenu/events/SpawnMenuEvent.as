package net.wg.gui.battle.commander.views.spawnMenu.events
{
   import flash.events.Event;
   
   public class SpawnMenuEvent extends Event
   {
      
      public static const AUTOSET:String = "autoset";
      
      public static const RESET:String = "reset";
      
      public static const BATTLE:String = "battle";
       
      
      public function SpawnMenuEvent(param1:String)
      {
         super(param1,true);
      }
   }
}
