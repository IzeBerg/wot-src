package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IGraphicsOptimizationComponent extends IEventDispatcher
   {
       
      
      function getRectangles() : Vector.<Rectangle>;
      
      function getAliasS() : String;
   }
}
