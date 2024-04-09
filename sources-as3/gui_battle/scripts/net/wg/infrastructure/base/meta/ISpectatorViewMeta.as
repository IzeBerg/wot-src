package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISpectatorViewMeta extends IEventDispatcher
   {
       
      
      function as_setFollowInfoText(param1:String) : void;
      
      function as_changeMode(param1:int) : void;
      
      function as_focusOnVehicle(param1:Boolean) : void;
      
      function as_setTimer(param1:String) : void;
      
      function as_setSpeed(param1:int) : void;
      
      function as_setHintStrings(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) : void;
      
      function as_showMovementHint(param1:Boolean) : void;
      
      function as_showSpeedHeightHint(param1:Boolean) : void;
      
      function as_showReturnHint(param1:Boolean) : void;
      
      function as_showSpeedHint(param1:Boolean) : void;
      
      function as_toggleHint(param1:int) : void;
      
      function as_handleAsReplay() : void;
      
      function as_updateMovementHintControls(param1:String, param2:String, param3:String, param4:String) : void;
   }
}
