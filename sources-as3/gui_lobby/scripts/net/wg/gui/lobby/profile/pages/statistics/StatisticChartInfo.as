package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatisticChartInfo extends DAAPIDataClass
   {
       
      
      public var xField:String = "";
      
      public var icon:String = "";
      
      public var yField:Number;
      
      public var tooltip:String = "";
      
      public var percentValue:int = -1;
      
      public function StatisticChartInfo(param1:Object)
      {
         super(param1);
      }
   }
}
