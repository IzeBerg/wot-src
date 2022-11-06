package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITutorialBuilder extends IDisposable, IEventDispatcher
   {
       
      
      function externalUpdate() : void;
      
      function updateData(param1:Object) : void;
      
      function stopEffect() : void;
      
      function setView(param1:IView) : void;
      
      function set component(param1:DisplayObject) : void;
   }
}
