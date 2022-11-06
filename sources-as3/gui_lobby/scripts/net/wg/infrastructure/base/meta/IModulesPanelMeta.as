package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IModulesPanelMeta extends IEventDispatcher
   {
       
      
      function showModuleInfoS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setVehicleHasTurret(param1:Boolean) : void;
   }
}
