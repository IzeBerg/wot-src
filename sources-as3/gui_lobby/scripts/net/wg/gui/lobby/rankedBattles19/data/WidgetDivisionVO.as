package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WidgetDivisionVO extends DAAPIDataClass
   {
       
      
      public var division:int = -1;
      
      public var newDivision:int = -1;
      
      public var title:String = "";
      
      public var infoText:String = "";
      
      public function WidgetDivisionVO(param1:Object)
      {
         super(param1);
      }
   }
}
