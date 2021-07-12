package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicRespawnViewMeta extends IEventDispatcher
   {
       
      
      function onLocationSelectedS(param1:int) : void;
      
      function onRespawnBtnClickS() : void;
      
      function onDeploymentReadyS() : void;
      
      function as_updateTimer(param1:Boolean, param2:String) : void;
      
      function as_updateAutoTimer(param1:Boolean, param2:String) : void;
      
      function as_resetRespawnState() : void;
      
      function as_setSelectedLocation(param1:int) : void;
      
      function as_setLaneState(param1:int, param2:Boolean, param3:String) : void;
      
      function as_setMapDimensions(param1:int, param2:int) : void;
      
      function as_setRespawnLocations(param1:Array) : void;
   }
}
