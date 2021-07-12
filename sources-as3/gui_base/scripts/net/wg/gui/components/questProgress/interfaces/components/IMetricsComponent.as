package net.wg.gui.components.questProgress.interfaces.components
{
   import net.wg.gui.components.questProgress.interfaces.data.IQPMetrics;
   
   public interface IMetricsComponent extends IQPComponent
   {
       
      
      function init(param1:IQPMetrics, param2:int) : void;
      
      function update(param1:IQPMetrics, param2:int) : void;
      
      function get componentWidth() : int;
      
      function get componentHeight() : int;
      
      function get mType() : String;
   }
}
