package net.wg.gui.components.crosshairPanel
{
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorStateParamsVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ICrosshair extends IDisposable, IDisplayObject
   {
       
      
      function setHealth(param1:Number) : void;
      
      function setDistance(param1:String) : void;
      
      function clearDistance(param1:Boolean) : void;
      
      function setDistanceVisibility(param1:Boolean) : void;
      
      function updateAmmoState(param1:String) : void;
      
      function setZoom(param1:String) : void;
      
      function updatePlayerInfo(param1:String) : void;
      
      function setAmmoStock(param1:Number, param2:String, param3:Boolean = false) : void;
      
      function setClipsParam(param1:Number, param2:Number, param3:Boolean = false) : void;
      
      function setNetType(param1:Number) : void;
      
      function setCenterType(param1:Number) : void;
      
      function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void;
      
      function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:String, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false) : void;
      
      function setReloadingState(param1:String) : void;
      
      function setReloadingAsPercent(param1:Number) : void;
      
      function setAutoloaderReloadingAsPercent(param1:Number, param2:Boolean) : void;
      
      function setReloadingTime(param1:Number) : void;
      
      function setQuickReloadingTime(param1:Boolean, param2:Number) : void;
      
      function showReloadingTimeField(param1:Boolean) : void;
      
      function setVisibleNet(param1:int) : void;
      
      function setNetSeparatorVisible(param1:Boolean) : void;
      
      function autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void;
      
      function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void;
      
      function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void;
      
      function autoloaderShowShot() : void;
      
      function updateCritical(param1:Boolean) : void;
      
      function updateScaleWidget(param1:Number) : void;
      
      function updateScaleSteps(param1:int) : void;
      
      function setGunMarkersData(param1:Vector.<GunMarkerIndicatorVO>, param2:Boolean) : void;
      
      function blinkReloadTime(param1:int) : void;
      
      function addOverheat(param1:Vector.<Number>) : void;
      
      function removeOverheat() : void;
      
      function setOverheatProgress(param1:Number, param2:Boolean, param3:Boolean = false) : void;
      
      function get autoloaderBoostParams() : BoostIndicatorStateParamsVO;
      
      function set isUseFrameAnimation(param1:Boolean) : void;
      
      function set scaleWidgetEnabled(param1:Boolean) : void;
   }
}
