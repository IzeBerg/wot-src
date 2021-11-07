package net.wg.infrastructure.base.meta
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   
   public interface ILobbyVehicleMarkerViewMeta extends IEventDispatcher
   {
       
      
      function onMarkerClickS(param1:int) : void;
      
      function as_createMarker(param1:int, param2:String, param3:String, param4:int) : DisplayObject;
      
      function as_createPlatoonMarker(param1:int, param2:String, param3:String) : DisplayObject;
      
      function as_createCustomMarker(param1:int, param2:String, param3:String) : DisplayObject;
      
      function as_removeMarker(param1:int) : void;
   }
}
