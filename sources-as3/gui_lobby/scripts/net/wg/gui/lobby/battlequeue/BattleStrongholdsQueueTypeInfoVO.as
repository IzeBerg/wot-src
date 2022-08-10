package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleStrongholdsQueueTypeInfoVO extends DAAPIDataClass
   {
       
      
      public var iconLabel:String = "";
      
      public var title:String = "";
      
      public var leagueIcon:String = "";
      
      public var myClanIcon:String = "";
      
      public var myClanName:String = "";
      
      public var myClanElo:String = "";
      
      public var myClanRating:String = "";
      
      public function BattleStrongholdsQueueTypeInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
