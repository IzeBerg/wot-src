package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPointsOfInterestNotificationPanelMeta extends IEventDispatcher
   {
       
      
      function as_addPoiStatus(param1:Object) : void;
      
      function as_updatePoiStatus(param1:uint, param2:uint, param3:Boolean) : void;
      
      function as_updatePoiProgress(param1:uint, param2:uint) : void;
      
      function as_addNotification(param1:uint, param2:Boolean, param3:String) : void;
      
      function as_setReplaySpeed(param1:Number) : void;
   }
}
