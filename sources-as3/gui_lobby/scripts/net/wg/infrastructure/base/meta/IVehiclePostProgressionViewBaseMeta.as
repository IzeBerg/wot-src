package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePostProgressionViewBaseMeta extends IEventDispatcher
   {
       
      
      function demountAllPairsS() : void;
      
      function as_setVehicleTitle(param1:Object) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_show() : void;
      
      function as_onEscPressed() : void;
   }
}
