package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WidgetLeagueVO extends DAAPIDataClass
   {
      
      private static const EFFICIENCY_DATA_FIELD:String = "efficiency";
      
      private static const POSITION_DATA_FIELD:String = "position";
       
      
      public var league:int = -1;
      
      public var title:String = "";
      
      public var infoText:String = "";
      
      private var _efficiencyData:RankedBattlesStatsDeltaVO = null;
      
      private var _positionData:RankedBattlesStatsVO = null;
      
      public function WidgetLeagueVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == EFFICIENCY_DATA_FIELD)
         {
            this._efficiencyData = new RankedBattlesStatsDeltaVO(param2);
            return false;
         }
         if(param1 == POSITION_DATA_FIELD)
         {
            this._positionData = new RankedBattlesStatsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._efficiencyData.dispose();
         this._efficiencyData = null;
         this._positionData.dispose();
         this._positionData = null;
         super.onDispose();
      }
      
      public function get efficiencyData() : RankedBattlesStatsDeltaVO
      {
         return this._efficiencyData;
      }
      
      public function get positionData() : RankedBattlesStatsVO
      {
         return this._positionData;
      }
   }
}
