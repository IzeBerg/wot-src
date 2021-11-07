package net.wg.gui.lobby.eventBattleResult.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TeamStatsVO extends DAAPIDataClass
   {
       
      
      public var damage:int = -1;
      
      public var matter:int = -1;
      
      public var kills:int = -1;
      
      public var blocked:int = -1;
      
      public var keys:int = -1;
      
      public function TeamStatsVO(param1:Object)
      {
         super(param1);
      }
   }
}
