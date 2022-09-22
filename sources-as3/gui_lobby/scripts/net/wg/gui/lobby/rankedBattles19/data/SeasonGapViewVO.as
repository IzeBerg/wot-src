package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SeasonGapViewVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var descr:String = "";
      
      public var btnLabel:String = "";
      
      public var btnVisible:Boolean = false;
      
      public var state:String = "";
      
      public var disabled:Boolean = false;
      
      public var leagueID:int = -1;
      
      public var divisionImgSmall:String = "";
      
      public var divisionImgBig:String = "";
      
      public var sprinterImg:String = "";
      
      public function SeasonGapViewVO(param1:Object)
      {
         super(param1);
      }
   }
}
