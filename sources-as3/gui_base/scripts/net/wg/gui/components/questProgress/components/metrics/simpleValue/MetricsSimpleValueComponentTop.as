package net.wg.gui.components.questProgress.components.metrics.simpleValue
{
   public class MetricsSimpleValueComponentTop extends MetricsSimpleValueComponentBase
   {
       
      
      public function MetricsSimpleValueComponentTop()
      {
         super();
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         valueTf.visible = !isCompleted;
         super.doUpdateState(param1);
      }
   }
}
