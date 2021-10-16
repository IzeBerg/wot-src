package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleMarkersManagerMeta extends IEventDispatcher
   {
       
      
      function as_setMarkerDuration(param1:int) : void;
      
      function as_setMarkerSettings(param1:Object) : void;
      
      function as_setShowExInfoFlag(param1:Boolean) : void;
      
      function as_updateMarkersSettings() : void;
      
      function as_setColorBlind(param1:Boolean) : void;
      
      function as_setColorSchemes(param1:Object, param2:Object) : void;
   }
}
