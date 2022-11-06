package net.wg.gui.events
{
   import flash.events.Event;
   
   public class FinalStatisticEvent extends Event
   {
      
      public static const EFFICIENCY_ICON_ROLL_OVER:String = "EfficiencyRollOver";
      
      public static const EFFICIENCY_ICON_ROLL_OUT:String = "EfficiencyRollOut";
      
      public static const HIDE_STATS_VIEW:String = "hideStatsView";
       
      
      public var data:Object;
      
      public function FinalStatisticEvent(param1:String, param2:Object = null)
      {
         super(param1,true,true);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new FinalStatisticEvent(type,this.data);
      }
   }
}
