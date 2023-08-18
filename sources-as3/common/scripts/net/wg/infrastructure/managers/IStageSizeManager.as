package net.wg.infrastructure.managers
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageBreakPoint;
   
   public interface IStageSizeManager extends IDisposable, IEventDispatcher
   {
       
      
      function register(param1:IStageSizeDependComponent) : void;
      
      function unregister(param1:IStageSizeDependComponent) : void;
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function calcAllowSize(param1:int, param2:Array) : int;
      
      function get currentBreakPoint() : StageBreakPoint;
   }
}
