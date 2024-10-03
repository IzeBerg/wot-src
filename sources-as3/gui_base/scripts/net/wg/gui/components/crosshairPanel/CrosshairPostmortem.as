package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorStateParamsVO;
   
   public class CrosshairPostmortem extends MovieClip implements ICrosshair
   {
       
      
      public var ammoInfo:TextField = null;
      
      private var _strAmmoState:String = "";
      
      private var _disposed:Boolean = false;
      
      public function CrosshairPostmortem()
      {
         super();
      }
      
      public function addOverheat(param1:Vector.<Number>) : void
      {
      }
      
      public function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void
      {
      }
      
      public function autoloaderShowShot() : void
      {
      }
      
      public function autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void
      {
      }
      
      public function blinkReloadTime(param1:int) : void
      {
      }
      
      public function clearDistance(param1:Boolean) : void
      {
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.ammoInfo = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function removeOverheat() : void
      {
      }
      
      public function setAmmoStock(param1:Number, param2:String, param3:Boolean = false) : void
      {
      }
      
      public function setAutoloaderReloadingAsPercent(param1:Number, param2:Boolean) : void
      {
      }
      
      public function setCenterType(param1:Number) : void
      {
      }
      
      public function setClipsParam(param1:Number, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
      }
      
      public function setDistance(param1:String) : void
      {
      }
      
      public function setDistanceVisibility(param1:Boolean) : void
      {
      }
      
      public function setGunMarkersData(param1:Vector.<GunMarkerIndicatorVO>, param2:Boolean) : void
      {
      }
      
      public function setHealth(param1:Number) : void
      {
      }
      
      public function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:String, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false) : void
      {
         this.updatePlayerInfo(param7);
         this.updateAmmoState(param10);
      }
      
      public function setNetSeparatorVisible(param1:Boolean) : void
      {
      }
      
      public function setNetType(param1:Number) : void
      {
      }
      
      public function setOverheatProgress(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
      }
      
      public function setQuickReloadingTime(param1:Boolean, param2:Number) : void
      {
      }
      
      public function setReloadingAsPercent(param1:Number) : void
      {
      }
      
      public function setReloadingState(param1:String) : void
      {
      }
      
      public function setReloadingTime(param1:Number) : void
      {
      }
      
      public function setVisibleNet(param1:int) : void
      {
      }
      
      public function setZoom(param1:String) : void
      {
      }
      
      public function showReloadingTimeField(param1:Boolean) : void
      {
      }
      
      public function updateAmmoState(param1:String) : void
      {
         if(this._strAmmoState != param1)
         {
            this._strAmmoState = param1;
            this.ammoInfo.text = this._strAmmoState;
         }
      }
      
      public function updateCritical(param1:Boolean) : void
      {
      }
      
      public function updatePlayerInfo(param1:String) : void
      {
      }
      
      public function updateScaleSteps(param1:int) : void
      {
      }
      
      public function updateScaleWidget(param1:Number) : void
      {
      }
      
      public function set isUseFrameAnimation(param1:Boolean) : void
      {
      }
      
      public function get autoloaderBoostParams() : BoostIndicatorStateParamsVO
      {
         return null;
      }
      
      public function set scaleWidgetEnabled(param1:Boolean) : void
      {
      }
   }
}
