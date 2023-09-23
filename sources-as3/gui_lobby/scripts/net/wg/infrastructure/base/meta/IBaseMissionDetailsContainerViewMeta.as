package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseMissionDetailsContainerViewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function requestMissionDataS(param1:int) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setMissionData(param1:Object) : void;
   }
}
