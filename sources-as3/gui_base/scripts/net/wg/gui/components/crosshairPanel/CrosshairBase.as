package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CROSSHAIR_CONSTANTS;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBarContainer;
   import net.wg.gui.components.crosshairPanel.components.OverheatBar;
   import net.wg.gui.components.crosshairPanel.components.autoloader.AutoloaderIndicator;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorStateParamsVO;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   
   public class CrosshairBase extends MovieClip implements ICrosshair
   {
      
      private static const TYPE_PREFIX:String = "type";
      
      private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";
      
      private static const TF_LEFT_MARGIN:int = 2;
       
      
      public var timerProgressTextField:TextField = null;
      
      public var timerCompleteTextField:TextField = null;
      
      public var reloadTimeBlink:MovieClip = null;
      
      public var quickReloadingTimerTextField:TextField = null;
      
      public var reloadingBar:MovieClip = null;
      
      public var reloadingAnimationMC:MovieClip = null;
      
      public var healthBarMC:MovieClip = null;
      
      public var cassetteMC:CrosshairClipQuantityBarContainer = null;
      
      public var centerMC:MovieClip = null;
      
      public var netMC:Sprite = null;
      
      public var netSeparator:Sprite = null;
      
      public var distance:CrosshairDistanceContainer = null;
      
      public var autoloaderComponent:AutoloaderIndicator = null;
      
      protected var health:Number = 0;
      
      protected var reloadingTime:Number = 0;
      
      protected var netType:Number = 0;
      
      protected var centerType:Number = 0;
      
      protected var reloadingState:String = "";
      
      protected var centerAlpha:Number = 1.0;
      
      protected var netAlpha:Number = 1.0;
      
      protected var reloadingBarAlpha:Number = 1.0;
      
      protected var healthBarAlpha:Number = 1.0;
      
      protected var cassetteAlpha:Number = 1.0;
      
      protected var reloadingTimeFieldAlpha:Number = 1.0;
      
      private var _overheatBar:OverheatBar = null;
      
      private var _isAutoloader:Boolean = false;
      
      private var _currentTimerTextField:TextField = null;
      
      private var _currentReloadingTime:Number = -1;
      
      private var _isReloadInProgress:Boolean = false;
      
      private var _isUseFrameAnimation:Boolean = true;
      
      private var _netSeparatorVisible:Boolean = true;
      
      private var _visibleNetMask:int = 3;
      
      private var _quickReloadingTime:Number = -1;
      
      private var _quickReloadingTimerActive:Boolean = false;
      
      private var _quickReloadingTimerVisible:Boolean = true;
      
      private var _reloadTimeBlinkYPos:Array = null;
      
      private var _disposed:Boolean = false;
      
      public function CrosshairBase()
      {
         super();
         this.cassetteMC.isUseFrameAnimation = this._isUseFrameAnimation;
         this.timerProgressTextField.visible = false;
         this.reloadTimeBlink.visible = false;
         this.updateQuickReloadingTimer();
         addEventListener(CrosshairPanelEvent.SOUND,this.onCrosshairPanelSoundHandler);
         this._reloadTimeBlinkYPos = this.getReloadTimeBlinkYPos();
      }
      
      public function addOverheat(param1:Vector.<Number>) : void
      {
         var _loc2_:Class = null;
         if(!this._overheatBar)
         {
            _loc2_ = Class(getDefinitionByName(Linkages.OVERHEAT_WIDGET));
            this._overheatBar = OverheatBar(new _loc2_());
            addChild(this._overheatBar);
            this._overheatBar.x = OverheatBar.X_OFFSET;
            this._overheatBar.y = OverheatBar.Y_OFFSET;
         }
         this._overheatBar.setOverheatMarkers(param1);
         this._overheatBar.visible = true;
      }
      
      public function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void
      {
         this.autoloaderComponent.autoloaderBoostUpdate(param1,param2,param3);
      }
      
      public function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void
      {
         this.autoloaderComponent.autoloaderBoostUpdateAsPercent(param1,param2);
      }
      
      public function autoloaderShowShot() : void
      {
         if(this._isAutoloader)
         {
            this.autoloaderComponent.autoloaderShowShot();
         }
      }
      
      public function autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         this.autoloaderComponent.autoloaderUpdate(param1,param2,param3,param4);
      }
      
      public function blinkReloadTime(param1:int) : void
      {
         var _loc2_:Boolean = param1 > 0;
         this.reloadTimeBlink.visible = _loc2_;
         if(_loc2_)
         {
            this.arrangeReloadTimeBlink();
            this.reloadTimeBlink.blink.gotoAndStop(param1);
            this.reloadTimeBlink.gotoAndPlay(1);
         }
      }
      
      public function clearDistance(param1:Boolean) : void
      {
         this.distance.clearDistance(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function removeOverheat() : void
      {
         if(this._overheatBar)
         {
            this._overheatBar.visible = false;
         }
      }
      
      public function setAmmoStock(param1:Number, param2:String, param3:Boolean = false) : void
      {
         if(this._isAutoloader)
         {
            this.autoloaderComponent.updateCurrentAmmo(param1);
         }
         else
         {
            this.cassetteMC.updateInfo(param1,param2,param3);
         }
      }
      
      public function setAutoloaderReloadingAsPercent(param1:Number, param2:Boolean) : void
      {
         this.autoloaderComponent.setGunReloadingPercent(param1);
      }
      
      public function setCenterType(param1:Number) : void
      {
         if(this.centerType != param1)
         {
            this.centerType = param1;
            this.updateCenterMC();
         }
      }
      
      public function setClipsParam(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         this._isAutoloader = param3;
         this.updateNetSeparatorVisibility();
         if(this._isAutoloader)
         {
            this.autoloaderComponent.updateTotalAmmo(param1);
         }
         else
         {
            this.cassetteMC.setClipsParam(param1,param2);
         }
         this.autoloaderComponent.visible = this._isAutoloader;
         this.cassetteMC.visible = !this._isAutoloader;
      }
      
      public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         this.netAlpha = param1;
         this.centerAlpha = param2;
         this.reloadingBarAlpha = param3;
         this.healthBarAlpha = param4;
         this.cassetteAlpha = param5;
         this.setReloadingAlpha(param6);
         this.updateComponentsAlpha();
      }
      
      public function setDistance(param1:String) : void
      {
         this.distance.setDistance(param1);
      }
      
      public function setDistanceVisibility(param1:Boolean) : void
      {
      }
      
      public function setGunMarkersData(param1:Vector.<GunMarkerIndicatorVO>, param2:Boolean) : void
      {
      }
      
      public function setHealth(param1:Number) : void
      {
         if(this.health == param1)
         {
            return;
         }
         this.health = param1;
         this.updateHealthBarMC();
      }
      
      public function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:String, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false) : void
      {
         this.setClipsParam(param8,param9,param14);
         this.setHealth(param1);
         this.setZoom(param2);
         this.setReloadingState(param3);
         this.showReloadingTimeField(param4);
         this.setDistanceVisibility(param5);
         this.setDistance(param6);
         this.updatePlayerInfo(param7);
         this.setAmmoStock(param11,param12,param13);
         this.updateAmmoState(param10);
         this.updateAutoloaderState(param8,param11,param15);
      }
      
      public function setNetSeparatorVisible(param1:Boolean) : void
      {
         this._netSeparatorVisible = param1;
         this.updateNetSeparatorVisibility();
      }
      
      public function setNetType(param1:Number) : void
      {
         if(this.netType != param1)
         {
            this.netType = param1;
            this.updateNetType();
            this.updateCenterMC();
            this.updateComponentsAlpha();
            this.updateHealthBarMC();
            this.setReloadingBarFrame();
            this.updateNetSeparatorVisibility();
            this.updateQuickReloadingTimer();
         }
      }
      
      public function setOverheatProgress(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(this._overheatBar)
         {
            if(param3)
            {
               this._overheatBar.onChangeCrosshair(param1,param2);
            }
            else
            {
               this._overheatBar.updateInfo(param1,param2);
            }
         }
      }
      
      public function setQuickReloadingTime(param1:Boolean, param2:Number) : void
      {
         if(this._quickReloadingTimerActive != param1 || this._quickReloadingTime != param2)
         {
            this._quickReloadingTimerActive = param1;
            this._quickReloadingTime = param2;
            this.updateQuickReloadingTimer();
         }
      }
      
      public function setReloadingAsPercent(param1:Number) : void
      {
         if(this.reloadingTime == param1)
         {
            return;
         }
         this.reloadingTime = param1;
         this.setReloadingBarFrame();
      }
      
      public function setReloadingState(param1:String) : void
      {
         if(this.reloadingState != param1)
         {
            this.reloadingState = param1;
            this.updateReloadingState();
         }
      }
      
      public function setReloadingTime(param1:Number) : void
      {
         if(this._currentReloadingTime != param1)
         {
            this._currentReloadingTime = param1 < 0 ? Number(0) : Number(param1);
            this.applyReloadingData();
         }
      }
      
      public function setTimerReloadingState() : void
      {
         var _loc1_:Boolean = !(this.reloadingState == CrosshairConsts.RELOADING_ENDED || this.reloadingState == CrosshairConsts.RELOADING_END);
         var _loc2_:Boolean = this._currentTimerTextField == this.timerProgressTextField;
         var _loc3_:Boolean = this._currentTimerTextField == this.timerCompleteTextField;
         if(this._isReloadInProgress == _loc1_ && this._currentTimerTextField && (_loc2_ || _loc3_))
         {
            return;
         }
         this._isReloadInProgress = _loc1_;
         if(this._currentTimerTextField)
         {
            this.timerProgressTextField.visible = false;
            this.timerCompleteTextField.visible = false;
         }
         this._currentTimerTextField = !!this._isReloadInProgress ? this.timerProgressTextField : this.timerCompleteTextField;
         this._currentTimerTextField.visible = true;
         this.applyReloadingData();
         this.applyReloadingAlpha();
      }
      
      public function setVisibleNet(param1:int) : void
      {
         this._visibleNetMask = param1;
         this.updateNetVisibility();
         this.updateNetSeparatorVisibility();
      }
      
      public function setZoom(param1:String) : void
      {
      }
      
      public function showReloadingTimeField(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._currentTimerTextField)
            {
               this.timerCompleteTextField.visible = this.timerCompleteTextField == this._currentTimerTextField;
               this.timerProgressTextField.visible = this.timerProgressTextField == this._currentTimerTextField;
            }
            else
            {
               this.timerCompleteTextField.visible = true;
               this.timerProgressTextField.visible = false;
            }
            this._quickReloadingTimerVisible = true;
         }
         else
         {
            this.timerCompleteTextField.visible = false;
            this.timerProgressTextField.visible = false;
            this._quickReloadingTimerVisible = false;
         }
         this.updateQuickReloadingTimer();
      }
      
      public function updateAmmoState(param1:String) : void
      {
      }
      
      public function updateAutoloaderState(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(this._isAutoloader)
         {
            this.autoloaderComponent.updateQuantityInClip(param2,param1);
            this.autoloaderComponent.updateCritical(param3);
         }
      }
      
      public function updateCritical(param1:Boolean) : void
      {
         if(this._isAutoloader)
         {
            this.autoloaderComponent.updateCritical(param1);
         }
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
      
      protected function onDispose() : void
      {
         removeEventListener(CrosshairPanelEvent.SOUND,this.onCrosshairPanelSoundHandler);
         this.reloadTimeBlink = null;
         this.timerProgressTextField = null;
         this.timerCompleteTextField = null;
         this._currentTimerTextField = null;
         this.quickReloadingTimerTextField = null;
         this.reloadingBar = null;
         this.reloadingAnimationMC = null;
         this.healthBarMC = null;
         this.centerMC = null;
         this.netMC = null;
         this.netSeparator = null;
         this.autoloaderComponent.dispose();
         this.autoloaderComponent = null;
         this.distance.dispose();
         this.distance = null;
         this.cassetteMC.dispose();
         this.cassetteMC = null;
         if(this._overheatBar)
         {
            this._overheatBar.dispose();
            this._overheatBar = null;
         }
         if(this._reloadTimeBlinkYPos)
         {
            this._reloadTimeBlinkYPos.length = 0;
            this._reloadTimeBlinkYPos = null;
         }
      }
      
      protected function arrangeReloadTimeBlink() : void
      {
         this.reloadTimeBlink.x = this._currentTimerTextField.x + (this._currentTimerTextField.textWidth >> 1) + TF_LEFT_MARGIN;
         this.reloadTimeBlink.y = this._reloadTimeBlinkYPos[this.netType];
      }
      
      protected function updateNetType() : void
      {
         gotoAndStop(TYPE_PREFIX + this.netType);
      }
      
      protected function updateReloadingState() : void
      {
         this.setTimerReloadingState();
         if(this.reloadingState == CrosshairConsts.RELOADING_END)
         {
            this.reloadingAnimationMC.visible = true;
            this.reloadingAnimationMC.play();
         }
         else if(this.reloadingState == CrosshairConsts.RELOADING_ENDED)
         {
            this.reloadingAnimationMC.visible = true;
            this.reloadingAnimationMC.gotoAndStop(1);
         }
         else
         {
            this.reloadingAnimationMC.visible = false;
         }
      }
      
      protected function getReloadTimeBlinkYPos() : Array
      {
         return null;
      }
      
      private function updateQuickReloadingTimer() : void
      {
         var _loc1_:String = null;
         if(this.quickReloadingTimerTextField)
         {
            if(this._quickReloadingTimerVisible && this._quickReloadingTimerActive && this._quickReloadingTime > 0)
            {
               _loc1_ = ExternalInterface.call.apply(this,[FRACTIONAL_FORMAT_CMD,this._quickReloadingTime]);
               this.quickReloadingTimerTextField.text = _loc1_;
               this.quickReloadingTimerTextField.visible = true;
            }
            else
            {
               this.quickReloadingTimerTextField.visible = false;
            }
         }
      }
      
      private function updateNetSeparatorVisibility() : void
      {
         if(this.netSeparator)
         {
            this.netSeparator.visible = !this._isAutoloader && this._netSeparatorVisible;
         }
      }
      
      private function updateNetVisibility() : void
      {
         this.netMC.visible = (this._visibleNetMask & CROSSHAIR_CONSTANTS.VISIBLE_NET) != 0;
      }
      
      private function setReloadingAlpha(param1:Number) : void
      {
         if(this.reloadingTimeFieldAlpha != param1)
         {
            this.reloadingTimeFieldAlpha = param1;
            this.applyReloadingAlpha();
         }
      }
      
      private function applyReloadingAlpha() : void
      {
         if(this._currentTimerTextField)
         {
            this._currentTimerTextField.alpha = this.reloadingTimeFieldAlpha;
         }
         if(this.quickReloadingTimerTextField)
         {
            this.quickReloadingTimerTextField.alpha = this.reloadingTimeFieldAlpha;
         }
      }
      
      private function applyReloadingData() : void
      {
         if(this._currentTimerTextField && this._currentReloadingTime != Values.DEFAULT_INT)
         {
            this._currentTimerTextField.text = ExternalInterface.call.apply(this,[FRACTIONAL_FORMAT_CMD,Number(this._currentReloadingTime)]);
         }
      }
      
      private function updateCenterMC() : void
      {
         this.centerMC.gotoAndStop(TYPE_PREFIX + this.centerType);
      }
      
      private function updateHealthBarMC() : void
      {
         if(this.healthBarMC)
         {
            this.healthBarMC.gotoAndStop(CrosshairConsts.PROGRESS_TOTAL_FRAMES_COUNT * this.health);
         }
      }
      
      private function setReloadingBarFrame() : void
      {
         if(this.reloadingBar)
         {
            this.updateReloadingState();
            this.reloadingBar.gotoAndStop(CrosshairConsts.PROGRESS_TOTAL_FRAMES_COUNT * this.reloadingTime);
         }
      }
      
      private function updateComponentsAlpha() : void
      {
         this.centerMC.alpha = this.centerAlpha;
         if(this.netSeparator)
         {
            this.netSeparator.alpha = this.netAlpha;
         }
         this.netMC.alpha = this.netAlpha;
         this.healthBarMC.alpha = this.healthBarAlpha;
         this.reloadingBar.alpha = this.reloadingBarAlpha;
         this.reloadingAnimationMC.alpha = this.reloadingBarAlpha;
         this.cassetteMC.alpha = this.cassetteAlpha;
         this.autoloaderComponent.alpha = this.cassetteAlpha;
      }
      
      public function get autoloaderBoostParams() : BoostIndicatorStateParamsVO
      {
         return this.autoloaderComponent.autoloaderBoostParams;
      }
      
      public function set isUseFrameAnimation(param1:Boolean) : void
      {
         this._isUseFrameAnimation = param1;
      }
      
      public function set scaleWidgetEnabled(param1:Boolean) : void
      {
      }
      
      public function get isAutoloader() : Boolean
      {
         return this._isAutoloader;
      }
      
      private function onCrosshairPanelSoundHandler(param1:CrosshairPanelEvent) : void
      {
         if(!visible)
         {
            param1.stopImmediatePropagation();
         }
      }
   }
}
