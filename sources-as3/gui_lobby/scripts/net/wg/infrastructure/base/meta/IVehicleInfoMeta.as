package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleInfoMeta extends IEventDispatcher
   {
       
      
      function getVehicleInfoS() : void;
      
      function onCancelClickS() : void;
      
      function addToCompareS() : void;
      
      function changeNationS() : void;
      
      function as_setVehicleInfo(param1:Object) : void;
      
      function as_setCompareButtonData(param1:Object) : void;
      
      function as_setChangeNationButtonData(param1:Object) : void;
   }
}
