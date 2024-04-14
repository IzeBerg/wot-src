package net.wg.gui.lobby.profile.components.chart
{
   public class FrameChartItem extends ChartItem
   {
       
      
      public function FrameChartItem()
      {
         super();
      }
      
      override protected function applyValueChange() : void
      {
         this.gotoAndStop(value);
      }
   }
}
