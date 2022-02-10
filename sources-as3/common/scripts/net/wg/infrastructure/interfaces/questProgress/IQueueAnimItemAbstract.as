package net.wg.infrastructure.interfaces.questProgress
{
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.IDisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQueueAnimItemAbstract extends IDisplayObjectContainer, IDisposable
   {
       
      
      function setStartPosition(param1:Point) : void;
      
      function run(param1:Function, param2:Function, param3:Function, param4:Function) : void;
   }
}
