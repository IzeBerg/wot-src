package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LeaguesStatsBlockVO extends DAAPIDataClass
   {
      
      private static const FIELD_STRIPES_IN_LEAGUE:String = "stripesInLeague";
      
      private static const FIELD_BATTLES_IN_LEAGUE:String = "battlesInLeague";
      
      private static const FIELD_STRIPES_TOTAL:String = "stripesTotal";
      
      private static const FIELD_BATTLES_TOTAL:String = "battlesTotal";
       
      
      public var stripesInLeague:RankedBattlesStatsVO = null;
      
      public var battlesInLeague:RankedBattlesStatsVO = null;
      
      public var stripesTotal:RankedBattlesStatsVO = null;
      
      public var battlesTotal:RankedBattlesStatsVO = null;
      
      public function LeaguesStatsBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_STRIPES_IN_LEAGUE)
         {
            this.stripesInLeague = new RankedBattlesStatsVO(param2);
            return false;
         }
         if(param1 == FIELD_BATTLES_IN_LEAGUE)
         {
            this.battlesInLeague = new RankedBattlesStatsVO(param2);
            return false;
         }
         if(param1 == FIELD_STRIPES_TOTAL)
         {
            this.stripesTotal = new RankedBattlesStatsVO(param2);
            return false;
         }
         if(param1 == FIELD_BATTLES_TOTAL)
         {
            this.battlesTotal = new RankedBattlesStatsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.stripesInLeague != null)
         {
            this.stripesInLeague.dispose();
            this.stripesInLeague = null;
         }
         if(this.battlesInLeague != null)
         {
            this.battlesInLeague.dispose();
            this.battlesInLeague = null;
         }
         if(this.stripesTotal != null)
         {
            this.stripesTotal.dispose();
            this.stripesTotal = null;
         }
         if(this.battlesTotal != null)
         {
            this.battlesTotal.dispose();
            this.battlesTotal = null;
         }
         super.onDispose();
      }
   }
}
