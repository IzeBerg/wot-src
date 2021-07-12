package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICrewOperationsPopOverMeta extends IEventDispatcher
   {
       
      
      function invokeOperationS(param1:String) : void;
      
      function as_update(param1:Object) : void;
   }
}
