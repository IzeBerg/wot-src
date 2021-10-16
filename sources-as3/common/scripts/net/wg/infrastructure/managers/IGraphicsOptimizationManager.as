package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.interfaces.IGraphicsOptimizationComponent;
   
   public interface IGraphicsOptimizationManager
   {
       
      
      function register(param1:IGraphicsOptimizationComponent) : void;
      
      function unregister(param1:IGraphicsOptimizationComponent) : void;
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function switchEnabled(param1:Boolean) : void;
   }
}
