package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.components.chart.AxisChart;
   
   public class StatisticsBarChart extends AxisChart
   {
       
      
      public var mainHorizontalAxis:StatisticsBarChartAxis;
      
      private var initializer:StatisticBarChartInitializer;
      
      public function StatisticsBarChart()
      {
         super();
         var _loc1_:int = 26;
         var _loc2_:int = 27;
         var _loc3_:int = 18;
         var _loc4_:StatisticBarChartLayout = new StatisticBarChartLayout();
         _loc4_.paddingRight = _loc1_;
         _loc4_.paddingLeft = _loc2_;
         _loc4_.gap = _loc3_;
         currentLayout = _loc4_;
         horizontalAxis = this.mainHorizontalAxis;
         this.initializer = new StatisticBarChartInitializer(this);
      }
      
      override protected function onDispose() : void
      {
         this.mainHorizontalAxis = null;
         this.initializer.dispose();
         this.initializer = null;
         super.onDispose();
      }
      
      public function setAxisText(param1:String) : void
      {
         this.mainHorizontalAxis.setLineText(param1);
      }
      
      override public function get width() : Number
      {
         return this.actualWidth;
      }
   }
}
