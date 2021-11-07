package net.wg.gui.components.questProgress.interfaces.components
{
   import flash.geom.Rectangle;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   
   public interface IChartProgress extends IQPComponent
   {
       
      
      function init(param1:IQPInitData) : void;
      
      function update(param1:IQPProgressData) : void;
      
      function getMetrics() : Rectangle;
      
      function unlock() : void;
   }
}
