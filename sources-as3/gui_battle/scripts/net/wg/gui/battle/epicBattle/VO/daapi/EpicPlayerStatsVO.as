package net.wg.gui.battle.epicBattle.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicPlayerStatsVO extends DAAPIDataClass
   {
       
      
      public var isAttacker:Boolean = false;
      
      public var lane:int = -1;
      
      public var respawnLane:int = -1;
      
      public var rank:int = -1;
      
      public function EpicPlayerStatsVO(param1:Object)
      {
         super(param1);
      }
   }
}
