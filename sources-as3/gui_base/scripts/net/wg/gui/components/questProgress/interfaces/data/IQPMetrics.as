package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQPMetrics extends IDisposable
   {
       
      
      function get metricType() : String;
      
      function get metricValue() : String;
   }
}
