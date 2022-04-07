package net.wg.gui.lobby.rankedBattles19.data
{
   public class RankedBattlesStatsInfoVO extends RankedBattlesStatsVO
   {
       
      
      public function RankedBattlesStatsInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[RankedBattlesStatsInfoVO > icon: " + icon + ", value: " + value + ", label:" + label + ", tooltip: " + tooltip + "]";
      }
   }
}
