package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionOperationsMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function onOperationClickS(param1:int, param2:int) : void;
      
      function showInfoS() : void;
      
      function as_setOperations(param1:Array) : void;
      
      function as_setTitle(param1:Object) : void;
   }
}
