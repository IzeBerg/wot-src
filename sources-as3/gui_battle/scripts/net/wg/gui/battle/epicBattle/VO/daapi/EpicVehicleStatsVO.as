package net.wg.gui.battle.epicBattle.VO.daapi
{
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   
   public class EpicVehicleStatsVO extends DAAPIVehicleStatsVO
   {
       
      
      public var rank:int = -1;
      
      public var lane:int = -1;
      
      public var hasRespawns:Boolean = false;
      
      public function EpicVehicleStatsVO(param1:Object)
      {
         super(param1);
      }
   }
}
