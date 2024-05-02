package net.wg.gui.lobby.profile.pages.statistics
{
   import flash.geom.Point;
   import net.wg.gui.lobby.profile.components.chart.layout.LayoutBase;
   
   public class StatisticBarChartLayout extends LayoutBase
   {
       
      
      public function StatisticBarChartLayout()
      {
         super();
      }
      
      override public function layout(param1:uint, param2:Object) : void
      {
         var _loc3_:StatisticBarChartItem = StatisticBarChartItem(param2);
         var _loc4_:Point = _loc3_.getThumbDimensions();
         _loc3_.x = Math.round(paddingLeft + param1 * (gap + _loc4_.x));
         _loc3_.y -= _loc4_.y;
      }
   }
}
