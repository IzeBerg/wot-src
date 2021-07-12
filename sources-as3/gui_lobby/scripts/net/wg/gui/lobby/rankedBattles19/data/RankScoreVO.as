package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankScoreVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var newLabel:String = "";
      
      public var img:String = "";
      
      public var tooltip:String = "";
      
      public function RankScoreVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
