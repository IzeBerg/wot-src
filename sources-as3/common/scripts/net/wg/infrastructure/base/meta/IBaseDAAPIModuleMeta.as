package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseDAAPIModuleMeta extends IEventDispatcher
   {
       
      
      function as_populate() : void;
      
      function as_dispose() : void;
   }
}
