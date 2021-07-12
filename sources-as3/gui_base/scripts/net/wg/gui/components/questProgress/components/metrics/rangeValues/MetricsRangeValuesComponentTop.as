package net.wg.gui.components.questProgress.components.metrics.rangeValues
{
   public class MetricsRangeValuesComponentTop extends MetricsRangeValuesComponentBase
   {
      
      protected static const VALUE_GAP:int = 0;
      
      private static const GOAL_GAP:int = 0;
       
      
      public function MetricsRangeValuesComponentTop()
      {
         super();
      }
      
      override protected function doLayout() : void
      {
         if(!isCompleted)
         {
            separatorTf.x = -(separatorTf.width >> 1);
            valueTf.x = separatorTf.x - valueTf.width - VALUE_GAP;
            goalTf.x = separatorTf.x + separatorTf.width + GOAL_GAP;
         }
         super.doLayout();
      }
   }
}
