package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicMinimapMeta extends IEventDispatcher
   {
       
      
      function onZoomModeChangedS(param1:int) : void;
      
      function as_setZoomMode(param1:Number, param2:String) : void;
      
      function as_setMapDimensions(param1:int, param2:int) : void;
      
      function as_updateSectorStateStats(param1:Object) : void;
      
      function as_setMapShortcutLabel(param1:String) : void;
   }
}
