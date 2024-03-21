package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleStrongholdsLeaguesLeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var leagueIcon:String = "";
      
      public var clanIcon:String = "";
      
      public var clanName:String = "";
      
      public var clanElo:String = "";
      
      public var tooltip:String = "";
      
      public function BattleStrongholdsLeaguesLeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
