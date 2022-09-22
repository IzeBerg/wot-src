package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesPageHeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var mainDescr:String = "";
      
      public var extraDescr:String = "";
      
      public var tooltip:String = "";
      
      public function RankedBattlesPageHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
