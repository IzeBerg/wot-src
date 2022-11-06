package net.wg.gui.components.questProgress.components.metrics.simple
{
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class MetricsSimpleComponentBase extends QPMetricsCmptBase
   {
       
      
      public function MetricsSimpleComponentBase()
      {
         super();
      }
      
      override protected final function onInit(param1:IQPMetrics) : void
      {
         this.doInit(QPMetricsSimpleVO(param1));
         super.onInit(param1);
      }
      
      override protected final function onUpdate(param1:IQPMetrics) : void
      {
         this.doUpdate(QPMetricsSimpleVO(param1));
         super.onUpdate(param1);
      }
      
      protected function doInit(param1:QPMetricsSimpleVO) : void
      {
      }
      
      protected function doUpdate(param1:QPMetricsSimpleVO) : void
      {
      }
   }
}
