package net.wg.gui.components.questProgress.data.metrics
{
   public class QPMetricsSimpleValueVO extends QPMetricsSimpleVO
   {
       
      
      public var title:String = "";
      
      public var value:String = "";
      
      public function QPMetricsSimpleValueVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function get metricValue() : String
      {
         return this.value;
      }
   }
}
