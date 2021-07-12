package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleCompareConfiguratorBaseViewMeta extends IEventDispatcher
   {
       
      
      function applyConfigS() : void;
      
      function resetConfigS() : void;
      
      function onCloseViewS() : void;
      
      function as_setResetEnabled(param1:Boolean) : void;
      
      function as_setApplyEnabled(param1:Boolean) : void;
      
      function as_setInitData(param1:Object) : void;
   }
}
