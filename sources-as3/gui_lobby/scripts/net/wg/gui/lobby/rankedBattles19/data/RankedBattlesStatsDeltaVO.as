package net.wg.gui.lobby.rankedBattles19.data
{
   public class RankedBattlesStatsDeltaVO extends RankedBattlesStatsVO
   {
       
      
      public var delta:String = "";
      
      public function RankedBattlesStatsDeltaVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[RankedBattlesStatsDeltaVO > icon: " + icon + ", value: " + value + ", label:" + label + ", delta: " + this.delta + "]";
      }
   }
}
