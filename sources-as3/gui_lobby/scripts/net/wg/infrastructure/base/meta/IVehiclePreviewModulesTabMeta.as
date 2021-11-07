package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewModulesTabMeta extends IEventDispatcher
   {
       
      
      function setActiveStateS(param1:Boolean) : void;
      
      function as_setStatusInfo(param1:String, param2:String, param3:int, param4:Boolean) : void;
   }
}
