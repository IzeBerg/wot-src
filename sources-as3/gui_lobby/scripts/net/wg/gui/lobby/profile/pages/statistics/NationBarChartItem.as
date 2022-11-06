package net.wg.gui.lobby.profile.pages.statistics
{
   public class NationBarChartItem extends StatisticBarChartItem
   {
       
      
      public function NationBarChartItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_NATION_TOOLTIP;
      }
   }
}
