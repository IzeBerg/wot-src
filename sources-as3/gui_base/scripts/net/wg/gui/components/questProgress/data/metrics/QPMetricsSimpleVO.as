package net.wg.gui.components.questProgress.data.metrics
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public class QPMetricsSimpleVO extends DAAPIDataClass implements IQPMetrics
   {
       
      
      public var mType:String = "";
      
      public function QPMetricsSimpleVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get metricType() : String
      {
         return this.mType;
      }
      
      public function get metricValue() : String
      {
         return Values.EMPTY_STR;
      }
   }
}
