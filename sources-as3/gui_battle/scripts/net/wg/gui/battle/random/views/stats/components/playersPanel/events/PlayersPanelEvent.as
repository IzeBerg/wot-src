package net.wg.gui.battle.random.views.stats.components.playersPanel.events
{
   import flash.events.Event;
   
   public class PlayersPanelEvent extends Event
   {
      
      public static const ON_ITEMS_COUNT_CHANGE:String = "onItemsCountChange";
       
      
      public function PlayersPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
