package net.wg.gui.lobby.profile.pages.statistics
{
   public class PlaceBarChartItem extends StatisticBarChartItem
   {
       
      
      public function PlaceBarChartItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_PLACE_TOOLTIP;
      }
   }
}
