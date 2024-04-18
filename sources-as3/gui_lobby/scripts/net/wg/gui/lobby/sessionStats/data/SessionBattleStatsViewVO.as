package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SessionBattleStatsViewVO extends DAAPIDataClass
   {
      
      private static const LAST_BATTLE:String = "lastBattle";
      
      private static const TOTAL:String = "total";
      
      private static const BATTLE_EFFICIENCY:String = "battleEfficiency";
       
      
      public var lastBattle:DataProvider = null;
      
      public var total:DataProvider = null;
      
      public var battleEfficiency:DataProvider = null;
      
      public var collapseLabel:String = "";
      
      public function SessionBattleStatsViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == LAST_BATTLE)
         {
            this.lastBattle = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.lastBattle.push(new SessionBattleStatsRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == TOTAL)
         {
            this.total = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.total.push(new SessionBattleStatsRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == BATTLE_EFFICIENCY)
         {
            this.battleEfficiency = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.battleEfficiency.push(new SessionBattleStatsRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.lastBattle)
         {
            for each(_loc1_ in this.lastBattle)
            {
               _loc1_.dispose();
            }
            this.lastBattle.cleanUp();
         }
         this.lastBattle = null;
         if(this.total)
         {
            for each(_loc1_ in this.total)
            {
               _loc1_.dispose();
            }
            this.total.cleanUp();
         }
         this.total = null;
         if(this.battleEfficiency)
         {
            for each(_loc1_ in this.battleEfficiency)
            {
               _loc1_.dispose();
            }
            this.battleEfficiency.cleanUp();
         }
         this.battleEfficiency = null;
         super.onDispose();
      }
   }
}
