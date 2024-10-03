package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICrosshairPanelContainerMeta extends IEventDispatcher
   {
       
      
      function as_playSoundS(param1:String) : void;
      
      function as_setSettings(param1:Object) : void;
      
      function as_setScale(param1:Number) : void;
      
      function as_setView(param1:int, param2:int) : void;
      
      function as_recreateDevice(param1:Number, param2:Number) : void;
      
      function as_setReloadingCounterShown(param1:Boolean) : void;
      
      function as_setReloading(param1:Number, param2:Number, param3:Number, param4:Boolean) : void;
      
      function as_setReloadingAsPercent(param1:Number, param2:Boolean) : void;
      
      function as_setBoostAsPercent(param1:Number, param2:Number) : void;
      
      function as_setHealth(param1:Number) : void;
      
      function as_setAmmoStock(param1:Number, param2:Number, param3:String, param4:Boolean) : void;
      
      function as_setClipParams(param1:Number, param2:Number, param3:Boolean) : void;
      
      function as_setDistance(param1:String) : void;
      
      function as_clearDistance(param1:Boolean) : void;
      
      function as_updatePlayerInfo(param1:String) : void;
      
      function as_updateAmmoState(param1:String) : void;
      
      function as_setZoom(param1:String) : void;
      
      function as_createGunMarker(param1:Number, param2:String, param3:String) : Boolean;
      
      function as_destroyGunMarker(param1:String) : Boolean;
      
      function as_setGunMarkerColor(param1:String, param2:String) : void;
      
      function as_setNetVisible(param1:int) : void;
      
      function as_setNetSeparatorVisible(param1:Boolean) : void;
      
      function as_setNetType(param1:int) : void;
      
      function as_autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void;
      
      function as_setAutoloaderReloading(param1:Number, param2:Number) : void;
      
      function as_showBoost(param1:Number, param2:Number) : void;
      
      function as_hideBoost(param1:Boolean) : void;
      
      function as_showShot() : void;
      
      function as_setAutoloaderReloadasPercent(param1:Number) : void;
      
      function as_setAutoloaderPercent(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void;
      
      function as_setSpeedMode(param1:Boolean) : void;
      
      function as_updateSpeed(param1:int) : void;
      
      function as_updateBurnout(param1:Number) : void;
      
      function as_addSpeedometer(param1:int, param2:int) : void;
      
      function as_removeSpeedometer() : void;
      
      function as_setBurnoutWarning(param1:String) : void;
      
      function as_stopBurnoutWarning() : void;
      
      function as_setEngineCrushError(param1:String) : void;
      
      function as_stopEngineCrushError() : void;
      
      function as_startDualGunCharging(param1:Number, param2:Number) : void;
      
      function as_cancelDualGunCharge() : void;
      
      function as_updateDualGunMarkerState(param1:int) : void;
      
      function as_runCameraTransitionFx(param1:int, param2:Number) : void;
      
      function as_updateScaleWidget(param1:Number) : void;
      
      function as_updateScaleSteps(param1:int) : void;
      
      function as_setGunMarkersIndicators(param1:Array) : void;
      
      function as_setShotFlyTimes(param1:Array) : void;
      
      function as_setShellChangeTime(param1:Boolean, param2:Number) : void;
      
      function as_isFaded(param1:Boolean) : void;
      
      function as_blinkReloadTime(param1:int) : void;
      
      function as_setDualAccActive(param1:Boolean) : void;
      
      function as_setOverheatProgress(param1:Number, param2:Boolean) : void;
      
      function as_addOverheat(param1:Array) : void;
      
      function as_removeOverheat() : void;
      
      function as_showPlasmaIndicator(param1:Number, param2:Boolean, param3:String) : void;
      
      function as_showExplosiveShotIndicator(param1:Boolean) : void;
   }
}
