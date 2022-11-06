package net.wg.gui.lobby.profile.pages.statistics.body
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
   
   public class StatisticsChartsTabDataVO extends StatisticsLabelLinkageDataVO
   {
       
      
      public var chartsData:Array = null;
      
      public function StatisticsChartsTabDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function parseData(param1:Object) : void
      {
         this.chartsData = param1.data as Array;
         App.utils.asserter.assertNotNull(this.chartsData,"chartsData" + Errors.CANT_NULL);
      }
   }
}
