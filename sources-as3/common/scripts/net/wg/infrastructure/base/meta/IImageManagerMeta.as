package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IImageManagerMeta extends IEventDispatcher
   {
       
      
      function as_setImageCacheSettings(param1:int, param2:int) : void;
      
      function as_loadImages(param1:Array) : void;
      
      function as_unloadImages(param1:Array) : void;
   }
}
