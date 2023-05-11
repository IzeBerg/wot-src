package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicSpectatorViewMeta extends IEventDispatcher
   {
       
      
      function as_setFollowInfoText(param1:String) : void;
      
      function as_changeMode(param1:int) : void;
      
      function as_focusOnVehicle(param1:Boolean) : void;
      
      function as_setTimer(param1:String) : void;
   }
}
