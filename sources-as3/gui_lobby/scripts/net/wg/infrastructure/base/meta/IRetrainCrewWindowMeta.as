package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRetrainCrewWindowMeta extends IEventDispatcher
   {
       
      
      function submitS(param1:int) : void;
      
      function changeRetrainTypeS(param1:Number) : void;
      
      function as_setCrewData(param1:Object) : void;
      
      function as_setVehicleData(param1:Object) : void;
      
      function as_setCrewOperationData(param1:Object) : void;
   }
}
