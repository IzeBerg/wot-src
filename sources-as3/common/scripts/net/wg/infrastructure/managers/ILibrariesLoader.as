package net.wg.infrastructure.managers
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ILibrariesLoader extends IEventDispatcher, IDisposable
   {
       
      
      function load(param1:Vector.<String>) : void;
   }
}
