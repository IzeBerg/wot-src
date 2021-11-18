package net.wg.gui.lobby.profile.pages.statistics
{
   public class TypeBarChartItem extends StatisticBarChartItem
   {
       
      
      public function TypeBarChartItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_TYPE_TOOLTIP;
      }
   }
}
