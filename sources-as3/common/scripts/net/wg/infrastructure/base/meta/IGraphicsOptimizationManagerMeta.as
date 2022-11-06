package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGraphicsOptimizationManagerMeta extends IEventDispatcher
   {
       
      
      function registerOptimizationAreaS(param1:Number, param2:Number, param3:Number, param4:Number) : Number;
      
      function unregisterOptimizationAreaS(param1:int) : void;
      
      function updateOptimizationAreaS(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void;
      
      function isOptimizationAvailableS(param1:String) : Boolean;
      
      function isOptimizationEnabledS(param1:String) : Boolean;
      
      function switchOptimizationEnabledS(param1:Boolean) : void;
      
      function as_invalidateRectangles() : void;
      
      function as_switchOptimizationEnabled(param1:Boolean) : void;
   }
}
