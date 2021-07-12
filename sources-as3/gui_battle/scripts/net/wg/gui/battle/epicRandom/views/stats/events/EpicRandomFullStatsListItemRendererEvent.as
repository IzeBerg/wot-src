package net.wg.gui.battle.epicRandom.views.stats.events
{
   import flash.events.Event;
   
   public class EpicRandomFullStatsListItemRendererEvent extends Event
   {
      
      public static const ON_DATA_SYNC:String = "onDataSync";
       
      
      public function EpicRandomFullStatsListItemRendererEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicRandomFullStatsListItemRendererEvent(type,bubbles,cancelable);
      }
   }
}
