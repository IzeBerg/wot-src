package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesStatsBlockVO extends DAAPIDataClass
   {
      
      private static const FIELD_DIVISION_EFFICIENCY:String = "divisionEfficiency";
      
      private static const FIELD_SEASON_EFFICIENCY:String = "seasonEfficiency";
       
      
      private var _divisionEfficiency:RankedBattlesStatsVO = null;
      
      private var _seasonEfficiency:RankedBattlesStatsVO = null;
      
      public function RankedBattlesStatsBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[RankedBattlesStatsBlockVO > divisionEfficiency: " + this._divisionEfficiency + ", seasonEfficiency: " + this._seasonEfficiency + "]";
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_DIVISION_EFFICIENCY)
         {
            this._divisionEfficiency = new RankedBattlesStatsVO(param2);
            return false;
         }
         if(param1 == FIELD_SEASON_EFFICIENCY)
         {
            this._seasonEfficiency = new RankedBattlesStatsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._divisionEfficiency != null)
         {
            this._divisionEfficiency.dispose();
            this._divisionEfficiency = null;
         }
         if(this._seasonEfficiency != null)
         {
            this._seasonEfficiency.dispose();
            this._seasonEfficiency = null;
         }
         super.onDispose();
      }
      
      public function get divisionEfficiency() : RankedBattlesStatsVO
      {
         return this._divisionEfficiency;
      }
      
      public function get seasonEfficiency() : RankedBattlesStatsVO
      {
         return this._seasonEfficiency;
      }
   }
}
