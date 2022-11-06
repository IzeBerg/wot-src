package net.wg.gui.components.questProgress.components.metrics.simpleValue
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.components.metrics.QPMetricsCmptBase;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleValueVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class MetricsSimpleValueComponentBase extends QPMetricsCmptBase
   {
       
      
      public var valueTf:TextField = null;
      
      public function MetricsSimpleValueComponentBase()
      {
         super();
      }
      
      override protected final function onInit(param1:IQPMetrics) : void
      {
         this.doInit(QPMetricsSimpleValueVO(param1));
         super.onInit(param1);
      }
      
      override protected final function onUpdate(param1:IQPMetrics) : void
      {
         this.doUpdate(QPMetricsSimpleValueVO(param1));
         super.onUpdate(param1);
      }
      
      override protected function onDispose() : void
      {
         this.valueTf = null;
         super.onDispose();
      }
      
      protected function doInit(param1:QPMetricsSimpleValueVO) : void
      {
         this.updateValue(param1.value);
      }
      
      protected function doUpdate(param1:QPMetricsSimpleValueVO) : void
      {
         this.updateValue(param1.value);
      }
      
      protected function updateValue(param1:String) : void
      {
         this.valueTf.text = param1;
      }
   }
}
