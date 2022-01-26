package net.wg.gui.lobby.profile.pages.statistics
{
   public class LevelBarChartItem extends StatisticBarChartItem
   {
       
      
      public function LevelBarChartItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVEL_TOOLTIP;
      }
      
      override protected function applyValueChange() : void
      {
         if(_data.yField == -1)
         {
            tweenManager.registerAndLaunch(tweeSpeed,this,{"alpha":0},getQuickSet());
         }
         else
         {
            tweenManager.registerAndLaunch(tweeSpeed,this,{"alpha":1},getQuickSet());
         }
         super.applyValueChange();
      }
   }
}
