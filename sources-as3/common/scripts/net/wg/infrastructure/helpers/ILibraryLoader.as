package net.wg.infrastructure.helpers
{
   import flash.display.DisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ILibraryLoader extends IDisposable
   {
       
      
      function init(param1:DisplayObjectContainer) : void;
      
      function load(param1:Vector.<String>) : void;
   }
}
