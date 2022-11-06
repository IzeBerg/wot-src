package net.wg.gui.battle.epicBattle.views.stats.events
{
   import flash.events.Event;
   
   public class EpicFullStatsEvent extends Event
   {
      
      public static const FILTER_CHANGED:String = "filterChanged";
       
      
      public var lane:int = -1;
      
      public function EpicFullStatsEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.lane = param2;
      }
      
      override public function clone() : Event
      {
         return new EpicFullStatsEvent(type,this.lane,bubbles,cancelable);
      }
   }
}
