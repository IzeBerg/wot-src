package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileMeta extends IEventDispatcher
   {
       
      
      function onCloseProfileS() : void;
      
      function as_update(param1:Object) : void;
   }
}
