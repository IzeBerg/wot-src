package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDualGunPanelMeta extends IEventDispatcher
   {
       
      
      function as_reset() : void;
      
      function as_setView(param1:int) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_setPlaybackSpeed(param1:Number) : void;
      
      function as_updateActiveGun(param1:int, param2:Number, param3:Number) : void;
      
      function as_readyForCharge() : void;
      
      function as_setGunState(param1:int, param2:int, param3:Number, param4:Number) : void;
      
      function as_startCharging(param1:Number, param2:Number) : void;
      
      function as_cancelCharge() : void;
      
      function as_disableCharge() : void;
      
      function as_setCooldown(param1:Number) : void;
      
      function as_setDualShotMode() : void;
      
      function as_collapsePanel() : void;
      
      function as_expandPanel() : void;
      
      function as_setReloadingTimeIncreased(param1:Boolean) : void;
      
      function as_updateTotalTime(param1:Number) : void;
      
      function as_setTimerVisible(param1:Boolean) : void;
      
      function as_setChangeGunTweenProps(param1:int, param2:int) : void;
   }
}
