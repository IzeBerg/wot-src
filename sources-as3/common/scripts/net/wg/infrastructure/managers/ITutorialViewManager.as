package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITutorialViewManager extends IEventDispatcher, IDisposable
   {
       
      
      function showHint(param1:DisplayObject, param2:Array) : void;
      
      function hideHint(param1:DisplayObject) : void;
   }
}
