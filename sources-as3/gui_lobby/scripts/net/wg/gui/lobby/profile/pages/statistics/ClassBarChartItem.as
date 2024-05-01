package net.wg.gui.lobby.profile.pages.statistics
{
   public class ClassBarChartItem extends StatisticBarChartItem
   {
       
      
      public function ClassBarChartItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_CLASS_TOOLTIP;
      }
   }
}
