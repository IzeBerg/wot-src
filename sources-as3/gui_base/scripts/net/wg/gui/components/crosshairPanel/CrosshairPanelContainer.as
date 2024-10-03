package net.wg.gui.components.crosshairPanel
{
   import fl.motion.easing.Quartic;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSTATES;
   import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorStateParamsVO;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
   import net.wg.gui.components.crosshairPanel.components.speedometer.Speedometer;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.infrastructure.base.meta.impl.CrosshairPanelContainerMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class CrosshairPanelContainer extends CrosshairPanelContainerMeta implements ICrosshairPanelContainer
   {
      
      private static const SPEEDOMETER_X_OFFSET:int = 144;
      
      private static const SPEEDOMETER_Y_OFFSET:int = 104;
      
      private static const MSEC_TO_SEC_FACTOR:uint = 1000;
      
      private static const DIVIDE_10:Number = 0.1;
      
      private static const DIVIDE_100:Number = 0.01;
      
      private static const VALUE_100:int = 100;
      
      private static const CROSSHAIRS_LINAKGES:Vector.<String> = new <String>[Linkages.CROSSHAIR_ARCADE_UI,Linkages.CROSSHAIR_SNIPER_UI,Linkages.CROSSHAIR_STRATEGIC_UI,Linkages.CROSSHAIR_POSTMORTEM_UI,Linkages.CROSSHAIR_ASSAULT_UI];
      
      private static const FADE_TWEEN_DURATION:uint = 500;
      
      private static const FADE_IN_ALPHA:Number = 1;
      
      private static const FADE_OUT_ALPHA:Number = 0.4;
       
      
      private var _gunMarkersContainer:GunMarkersManager;
      
      private var _currentCrosshair:ICrosshair = null;
      
      private var _viewId:int = -1;
      
      private var _visibleNet:int = 3;
      
      private var _visibleNetSeparator:Boolean = true;
      
      private var _settingId:int = -1;
      
      private var _settings:Array = null;
      
      private var _healthInPercents:Number = 0;
      
      private var _indicatorsData:Vector.<GunMarkerIndicatorVO>;
      
      private var _zoomStr:String = "";
      
      private var _distanceStr:String = "";
      
      private var _playerInfoStr:String = "";
      
      private var _isDistanceShown:Boolean = true;
      
      private var _scale:Number = 1;
      
      private var _reloadingInterval:Number = -1;
      
      private var _currReloadingPercent:Number = 0;
      
      private var _previousReloadingPercent:Number = 0;
      
      private var _isQuickReloadingActive:Boolean = false;
      
      private var _quickReloadingTime:Number = -1;
      
      private var _autoloaderBaseTime:Number = 0;
      
      private var _autoloaderState:String = "reloadingEnd";
      
      private var _autoloaderTimer:Number = -1;
      
      private var _reloadingAutoloaderFinishTime:Number = 0;
      
      private var _isAutoloaderTimerOn:Boolean = false;
      
      private var _isAutoloaderTimerRed:Boolean = false;
      
      private var _autoloaderAnimationBaseTime:Number = 0;
      
      private var _autoloaderAnimationProgress:Number = 0;
      
      private var _autoloaderAnimationFinishTime:Number = 0;
      
      private var _autoloaderAnimationTimer:Number = -1;
      
      private var _autoloaderAnimationState:String = "reloadingEnd";
      
      private var _remainingTimeInSec:Number = 0;
      
      private var _baseReloadingTimeInSec:Number = 0;
      
      private var _initReloadingTime:Number = 0;
      
      private var _baseReloadingTimeInMsec:Number = 0;
      
      private var _currReloadingState:String = "reloadingInit";
      
      private var _ammoQuantity:Number = 0;
      
      private var _ammoQuantityInClip:Number = 0;
      
      private var _isAutoloader:Boolean = false;
      
      private var _isAutoloaderCritical:Boolean = false;
      
      private var _ammoClipState:String = "";
      
      private var _ammoClipReloaded:Boolean = false;
      
      private var _ammoState:String = "";
      
      private var _clipCapacity:Number = -1;
      
      private var _burst:Number = -1;
      
      private var _isReloadingTimeFieldShown:Boolean = true;
      
      private var _crosshairs:Vector.<ICrosshair> = null;
      
      private var _netType:int = -1;
      
      private var _speedometer:Speedometer = null;
      
      private var _speedometerBg:Sprite = null;
      
      private var _speed:int = 0;
      
      private var _burnout:Number = 0;
      
      private var _speedMode:Boolean = false;
      
      private var _isWarning:Boolean = false;
      
      private var _isEngineCrush:Boolean = false;
      
      private var _burnoutWarning:String = "";
      
      private var _engineCrush:String = "";
      
      private var _overheatProgress:Number = 0.0;
      
      private var _isOverheated:Boolean = false;
      
      private var _sniperCameraTransitionFx:CrosshairPanelSniperCameraTransitionFx = null;
      
      private var _fadeTween:Tween = null;
      
      public function CrosshairPanelContainer()
      {
         this._indicatorsData = new Vector.<GunMarkerIndicatorVO>();
         super();
         this._settings = [];
         this._sniperCameraTransitionFx = new CrosshairPanelSniperCameraTransitionFx();
      }
      
      private static function createComponent(param1:String) : DisplayObject
      {
         var _loc2_:Class = Class(getDefinitionByName(param1));
         return new _loc2_();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(CrosshairPanelEvent.SOUND,this.onCrosshairPanelSoundHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         removeEventListener(CrosshairPanelEvent.SOUND,this.onCrosshairPanelSoundHandler);
         this.clearReloadingTimer();
         this.clearAutoloaderReloadTimer();
         this.clearAutoloaderAtimationTimer();
         this.clearTweens();
         this._gunMarkersContainer.dispose();
         this._gunMarkersContainer = null;
         if(this._speedometer)
         {
            this._speedometer.dispose();
            this._speedometer = null;
         }
         this._speedometerBg = null;
         this._currentCrosshair = null;
         this._settings = null;
         for each(_loc1_ in this._crosshairs)
         {
            _loc1_.dispose();
         }
         this._crosshairs.length = 0;
         this._crosshairs = null;
         if(this._sniperCameraTransitionFx)
         {
            this._sniperCameraTransitionFx.dispose();
            this._sniperCameraTransitionFx = null;
         }
         this._indicatorsData = null;
         super.onDispose();
      }
      
      override protected function setGunMarkersIndicators(param1:Vector.<GunMarkerIndicatorVO>) : void
      {
         this._indicatorsData = param1;
         var _loc2_:CrosshairSettingsVO = this._settings[this._settingId];
         if(_loc2_ && this._currentCrosshair != null)
         {
            this._currentCrosshair.setGunMarkersData(param1,_loc2_.isColorBlind);
         }
      }
      
      override protected function setShotFlyTimes(param1:Vector.<ShotFlyTimeVO>) : void
      {
         if(this._currentCrosshair is CrosshairStrategic)
         {
            (this._currentCrosshair as CrosshairStrategic).setShotFlyTimesData(param1);
         }
      }
      
      override protected function addOverheat(param1:Vector.<Number>) : void
      {
         var _loc2_:ICrosshair = null;
         for each(_loc2_ in this._crosshairs)
         {
            _loc2_.addOverheat(param1);
         }
      }
      
      public function as_addSpeedometer(param1:int, param2:int) : void
      {
         if(this._speedometer == null)
         {
            this._speedometer = Speedometer(createComponent(Linkages.SPEEDOMETER_UI));
            this._speedometer.x = SPEEDOMETER_X_OFFSET;
            this._speedometer.y = SPEEDOMETER_Y_OFFSET;
            this._speedometer.setMaxSpeedNormalMode(param1);
            this._speedometer.setMaxSpeedSpeedMode(param2);
            this._speedometer.blendMode = BlendMode.ADD;
         }
         if(this._speedometerBg == null)
         {
            this._speedometerBg = Sprite(createComponent(Linkages.SPEEDOMETER_BG_UI));
            this._speedometerBg.x = SPEEDOMETER_X_OFFSET;
            this._speedometerBg.y = SPEEDOMETER_Y_OFFSET;
         }
         this._speedometerBg.visible = true;
         this._speedometer.visible = true;
         this.attachSpeedometer();
      }
      
      public function as_autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void
      {
         this.clearAutoloaderReloadTimer();
         this._isAutoloaderTimerRed = param6;
         this._isAutoloaderTimerOn = param5;
         this._autoloaderBaseTime = param2;
         this._reloadingAutoloaderFinishTime = getTimer() + param1 * CrosshairConsts.MS_IN_SECOND;
         if(param1 > 0)
         {
            this._autoloaderState = CrosshairConsts.RELOADING_PROGRESS;
            this._autoloaderTimer = setInterval(this.updateAutoloaderReloadingTimer,CrosshairConsts.ANIMATION_UPDATE_TICK);
         }
         else if(param1 == 0)
         {
            this._autoloaderState = CrosshairConsts.RELOADING_END;
         }
         this._isAutoloaderCritical = param4;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.updateCritical(this._isAutoloaderCritical);
         }
         this.applyAutoloaderState();
      }
      
      public function as_blinkReloadTime(param1:int) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.blinkReloadTime(param1);
         }
      }
      
      public function as_cancelDualGunCharge() : void
      {
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.cancelDualGunCharge();
         }
      }
      
      public function as_clearDistance(param1:Boolean) : void
      {
         this._distanceStr = Values.EMPTY_STR;
         this._isDistanceShown = false;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.clearDistance(param1);
         }
      }
      
      public function as_createGunMarker(param1:Number, param2:String, param3:String) : Boolean
      {
         var gunMarker:IGunMarker = null;
         var viewID:Number = param1;
         var linkageName:String = param2;
         var sceneName:String = param3;
         try
         {
            gunMarker = createComponent(linkageName) as IGunMarker;
            if(gunMarker != null && this._gunMarkersContainer != null)
            {
               this._gunMarkersContainer.addGunMarker(gunMarker,sceneName);
               return true;
            }
         }
         catch(e:ReferenceError)
         {
         }
         return false;
      }
      
      public function as_destroyGunMarker(param1:String) : Boolean
      {
         if(this._gunMarkersContainer != null)
         {
            return this._gunMarkersContainer.destroyGunMarker(param1);
         }
         return false;
      }
      
      public function as_hideBoost(param1:Boolean) : void
      {
         var _loc2_:BoostIndicatorStateParamsVO = null;
         if(this._currentCrosshair != null)
         {
            _loc2_ = this._currentCrosshair.autoloaderBoostParams;
            if(_loc2_)
            {
               _loc2_.currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
               _loc2_.isSideFadeOut = param1;
               this._currentCrosshair.autoloaderBoostUpdate(_loc2_,0);
            }
         }
      }
      
      public function as_isFaded(param1:Boolean) : void
      {
         this.clearTweens();
         this._fadeTween = new Tween(FADE_TWEEN_DURATION,this,{"alpha":(!!param1 ? FADE_OUT_ALPHA : FADE_IN_ALPHA)},{
            "paused":false,
            "ease":Quartic.easeOut,
            "delay":0,
            "fastTransform":false,
            "onComplete":null
         });
      }
      
      public function as_recreateDevice(param1:Number, param2:Number) : void
      {
         var _loc3_:ICrosshair = null;
         for each(_loc3_ in this._crosshairs)
         {
            _loc3_.x = param1;
            _loc3_.y = param2;
         }
      }
      
      public function as_removeOverheat() : void
      {
         var _loc1_:ICrosshair = null;
         for each(_loc1_ in this._crosshairs)
         {
            _loc1_.removeOverheat();
         }
      }
      
      public function as_removeSpeedometer() : void
      {
         if(this._speedometer)
         {
            this._speedometer.visible = false;
         }
         if(this._speedometerBg)
         {
            this._speedometerBg.visible = false;
         }
      }
      
      public function as_runCameraTransitionFx(param1:int, param2:Number) : void
      {
         if(this._currentCrosshair != null)
         {
            this._sniperCameraTransitionFx.setCameraTransitionDuration(param2);
            this._sniperCameraTransitionFx.setActiveGunId(param1);
            this._sniperCameraTransitionFx.start();
         }
      }
      
      public function as_setAmmoStock(param1:Number, param2:Number, param3:String, param4:Boolean) : void
      {
         this._ammoQuantity = param1;
         this._ammoQuantityInClip = param2;
         this._ammoClipState = param3;
         this._ammoClipReloaded = param4;
         if(this._ammoQuantity == 0)
         {
            this._remainingTimeInSec = 0;
            this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
         }
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setAmmoStock(this._ammoQuantityInClip,this._ammoClipState,this._ammoClipReloaded);
         }
         this._ammoClipReloaded = false;
      }
      
      public function as_setAutoloaderPercent(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.autoloaderUpdate(param1,param2,param3,param4);
         }
      }
      
      public function as_setAutoloaderReloadasPercent(param1:Number) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setAutoloaderReloadingAsPercent(param1,false);
         }
      }
      
      public function as_setAutoloaderReloading(param1:Number, param2:Number) : void
      {
         this.clearAutoloaderAtimationTimer();
         this._autoloaderAnimationBaseTime = param2;
         this._autoloaderAnimationFinishTime = getTimer() + param1 * CrosshairConsts.MS_IN_SECOND;
         if(param1 > 0)
         {
            this._autoloaderAnimationState = CrosshairConsts.RELOADING_PROGRESS;
            this._autoloaderAnimationTimer = setInterval(this.updateAutoloaderAnimationTimer,CrosshairConsts.ANIMATION_UPDATE_TICK);
         }
         else if(param1 == 0)
         {
            this._autoloaderAnimationState = CrosshairConsts.RELOADING_END;
            this._autoloaderAnimationProgress = 0;
         }
         this.applyAutoloaderAnimationState();
      }
      
      public function as_setBoostAsPercent(param1:Number, param2:Number) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.autoloaderBoostUpdateAsPercent(param2,param1);
         }
      }
      
      public function as_setBurnoutWarning(param1:String) : void
      {
         this._burnoutWarning = param1;
         this._isWarning = true;
         if(this._speedometer)
         {
            this._speedometer.setWarning(param1);
         }
      }
      
      public function as_setClipParams(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._isAutoloader = param3;
         this._clipCapacity = param1;
         this._burst = param2;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setClipsParam(this._clipCapacity,this._burst,param3);
         }
      }
      
      public function as_setDistance(param1:String) : void
      {
         this._distanceStr = param1;
         this._isDistanceShown = true;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setDistance(this._distanceStr);
         }
      }
      
      public function as_setDualAccActive(param1:Boolean) : void
      {
         this._gunMarkersContainer.setDualAccActive(param1);
      }
      
      public function as_setEngineCrushError(param1:String) : void
      {
         this._engineCrush = param1;
         this._isEngineCrush = true;
         if(this._speedometer)
         {
            this._speedometer.setEngineCrushError(param1);
         }
      }
      
      public function as_setGunMarkerColor(param1:String, param2:String) : void
      {
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.setGunMarkerColor(param1,param2);
         }
      }
      
      public function as_setHealth(param1:Number) : void
      {
         this._healthInPercents = param1;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setHealth(this._healthInPercents);
         }
      }
      
      public function as_setNetSeparatorVisible(param1:Boolean) : void
      {
         if(this._visibleNetSeparator == param1)
         {
            return;
         }
         this._visibleNetSeparator = param1;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setNetSeparatorVisible(this._visibleNetSeparator);
         }
      }
      
      public function as_setNetType(param1:int) : void
      {
         if(this._netType != param1)
         {
            this._netType = param1;
            this.applySettings();
         }
      }
      
      public function as_setNetVisible(param1:int) : void
      {
         if(this._visibleNet == param1)
         {
            return;
         }
         this._visibleNet = param1;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setVisibleNet(this._visibleNet);
         }
      }
      
      public function as_setOverheatProgress(param1:Number, param2:Boolean) : void
      {
         this._overheatProgress = param1;
         this._isOverheated = param2;
         this._currentCrosshair.setOverheatProgress(param1,param2);
      }
      
      public function as_setReloading(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
      {
         this.clearReloadingTimer();
         this._baseReloadingTimeInSec = param2;
         if(param1 == 0)
         {
            this._currReloadingPercent = VALUE_100;
            this._remainingTimeInSec = this._baseReloadingTimeInSec;
            if(param4)
            {
               this._currReloadingState = CrosshairConsts.RELOADING_END;
            }
            else if(param2 == 0)
            {
               this._currReloadingState = CrosshairConsts.RELOADING_INIT;
            }
            else
            {
               this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
            }
         }
         else if(param1 == Values.DEFAULT_INT)
         {
            this._currReloadingPercent = 0;
            if(this._ammoQuantity == 0)
            {
               this._remainingTimeInSec = 0;
               this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
            }
            else
            {
               this._remainingTimeInSec = this._baseReloadingTimeInSec;
               this._currReloadingState = CrosshairConsts.RELOADING_INIT;
            }
         }
         else
         {
            if(this._currReloadingState == CrosshairConsts.RELOADING_PROGRESS)
            {
               this._remainingTimeInSec = param1;
               this._previousReloadingPercent = this._currReloadingPercent;
            }
            else
            {
               this._remainingTimeInSec = param1;
               this._previousReloadingPercent = this._currReloadingPercent = param3 / param2;
            }
            this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
            this._initReloadingTime = getTimer();
            this._baseReloadingTimeInMsec = this._baseReloadingTimeInSec * MSEC_TO_SEC_FACTOR;
            this._reloadingInterval = setInterval(this.updateReloadingTimer,CrosshairConsts.COUNTER_UPDATE_TICK,false);
         }
         this.updateCurrentCrosshairReloadingParams();
      }
      
      public function as_setReloadingAsPercent(param1:Number, param2:Boolean) : void
      {
         if(param1 >= VALUE_100)
         {
            this._currReloadingPercent = 1;
            this._remainingTimeInSec = this._baseReloadingTimeInSec;
            if(param2)
            {
               this._currReloadingState = CrosshairConsts.RELOADING_END;
            }
            else
            {
               this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
            }
         }
         else
         {
            this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
            this._currReloadingPercent = param1 * DIVIDE_100;
         }
         this.applyData(true);
      }
      
      public function as_setReloadingCounterShown(param1:Boolean) : void
      {
         this._isReloadingTimeFieldShown = param1;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.showReloadingTimeField(param1);
         }
      }
      
      public function as_setScale(param1:Number) : void
      {
         var _loc2_:ICrosshair = null;
         if(this._scale == param1)
         {
            return;
         }
         this._scale = param1;
         for each(_loc2_ in this._crosshairs)
         {
            _loc2_.scaleX = _loc2_.scaleY = this._scale;
         }
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.setScale(this._scale);
         }
      }
      
      public function as_setSettings(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_)
            {
               this._settings[int(_loc2_)] = new CrosshairSettingsVO(_loc3_);
            }
         }
         this.applySettings();
      }
      
      public function as_setShellChangeTime(param1:Boolean, param2:Number) : void
      {
         this._isQuickReloadingActive = param1;
         this._quickReloadingTime = param2;
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setQuickReloadingTime(this._isQuickReloadingActive,this._quickReloadingTime);
         }
      }
      
      public function as_setSpeedMode(param1:Boolean) : void
      {
         this._speedMode = param1;
         if(this._speedometer)
         {
            this._speedometer.changeState(param1);
         }
      }
      
      public function as_setView(param1:int, param2:int) : void
      {
         var _loc3_:BoostIndicatorStateParamsVO = null;
         if(this._viewId == param1 && this._settingId == param2)
         {
            return;
         }
         this._viewId = param1;
         this._settingId = param2;
         if(this._viewId <= 0)
         {
            this.hideAll();
         }
         else if(this._currentCrosshair != null)
         {
            if(this._currentCrosshair.visible)
            {
               this._currentCrosshair.visible = false;
            }
            _loc3_ = this._currentCrosshair.autoloaderBoostParams;
            this._currentCrosshair = this._crosshairs[this._viewId - 1];
            this._currentCrosshair.visible = true;
            this._currentCrosshair.setVisibleNet(this._visibleNet);
            this._currentCrosshair.setNetSeparatorVisible(this._visibleNetSeparator);
            this._currentCrosshair.setOverheatProgress(this._overheatProgress,this._isOverheated,true);
            if(_loc3_)
            {
               this._currentCrosshair.autoloaderBoostUpdate(_loc3_,0,true);
            }
         }
         this._sniperCameraTransitionFx.setView(param1,this._currentCrosshair);
         this.applySettings();
         this.applyData();
      }
      
      public function as_setZoom(param1:String) : void
      {
         if(this._currentCrosshair != null)
         {
            this._zoomStr = param1;
            this._currentCrosshair.setZoom(this._zoomStr);
         }
      }
      
      public function as_showBoost(param1:Number, param2:Number) : void
      {
         var _loc3_:BoostIndicatorStateParamsVO = null;
         var _loc4_:Boolean = false;
         if(this._currentCrosshair != null)
         {
            _loc3_ = this._currentCrosshair.autoloaderBoostParams;
            _loc4_ = false;
            if(_loc3_)
            {
               if(_loc3_.currentState != AUTOLOADERBOOSTVIEWSTATES.RECHARGE)
               {
                  _loc3_.resetToDefault();
               }
               else
               {
                  _loc4_ = true;
               }
               _loc3_.currentState = param1;
               _loc3_.remainingDurationMSec = param1 * MSEC_TO_SEC_FACTOR;
               this._currentCrosshair.autoloaderBoostUpdate(_loc3_,param2,_loc4_);
            }
         }
      }
      
      public function as_showShot() : void
      {
         if(this._isAutoloader && this._currentCrosshair != null)
         {
            this._currentCrosshair.autoloaderShowShot();
         }
      }
      
      public function as_showPlasmaIndicator(param1:Number, param2:Boolean, param3:String) : void
      {
         if(this._currentCrosshair is WTCrosshairBase)
         {
            (this._currentCrosshair as WTCrosshairBase).showPlasmaIndicator(param1,param2,param3);
         }
      }
      
      public function as_showExplosiveShotIndicator(param1:Boolean) : void
      {
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.setExplosiveShotMarker(param1);
         }
         if(this._currentCrosshair is WTCrosshairBase)
         {
            (this._currentCrosshair as WTCrosshairBase).setExplosiveShotVisible(param1);
         }
      }
      
      public function as_startDualGunCharging(param1:Number, param2:Number) : void
      {
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.startDualGunCharging(param1,param2);
         }
      }
      
      public function as_stopBurnoutWarning() : void
      {
         this._isWarning = false;
         if(this._speedometer)
         {
            this._speedometer.stopWarning();
         }
      }
      
      public function as_stopEngineCrushError() : void
      {
         this._isEngineCrush = false;
         if(this._speedometer)
         {
            this._speedometer.stopEngineCrushError();
         }
      }
      
      public function as_updateAmmoState(param1:String) : void
      {
         if(this._currentCrosshair != null)
         {
            this._ammoState = param1;
            this._currentCrosshair.updateAmmoState(this._ammoState);
         }
      }
      
      public function as_updateBurnout(param1:Number) : void
      {
         this._burnout = param1;
         if(this._speedometer)
         {
            this._speedometer.setBurnout(param1);
         }
      }
      
      public function as_updateDualGunMarkerState(param1:int) : void
      {
         if(this._gunMarkersContainer != null)
         {
            this._gunMarkersContainer.updateDualGunMarkerState(param1);
         }
      }
      
      public function as_updatePlayerInfo(param1:String) : void
      {
         if(this._currentCrosshair != null)
         {
            this._playerInfoStr = param1;
            this._currentCrosshair.updatePlayerInfo(this._playerInfoStr);
         }
      }
      
      public function as_updateScaleSteps(param1:int) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.updateScaleSteps(param1);
         }
      }
      
      public function as_updateScaleWidget(param1:Number) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.updateScaleWidget(param1);
         }
      }
      
      public function as_updateSpeed(param1:int) : void
      {
         this._speed = param1;
         if(this._speedometer)
         {
            this._speedometer.setSpeed(param1);
         }
      }
      
      public function init() : void
      {
         var _loc1_:ICrosshair = null;
         var _loc2_:String = null;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         this._crosshairs = new Vector.<ICrosshair>(0);
         for each(_loc2_ in CROSSHAIRS_LINAKGES)
         {
            _loc1_ = ICrosshair(createComponent(_loc2_));
            this._crosshairs.push(_loc1_);
            addChild(DisplayObject(_loc1_));
         }
         this._gunMarkersContainer = new GunMarkersManager(this);
         this._currentCrosshair = this._crosshairs[0];
         this.hideAll();
      }
      
      private function clearTweens() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
      }
      
      private function attachSpeedometer() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         if(this._currentCrosshair != null && this._speedometer != null)
         {
            if(this._speedometer.parent != null)
            {
               this._speedometer.parent.removeChild(this._speedometer);
            }
            if(this._speedometerBg.parent != null)
            {
               this._speedometerBg.parent.removeChild(this._speedometer);
            }
            _loc1_ = this._currentCrosshair as DisplayObjectContainer;
            if(this._currentCrosshair)
            {
               _loc1_.addChild(this._speedometer);
               _loc1_.addChild(this._speedometerBg);
               _loc1_.blendMode = BlendMode.LAYER;
            }
         }
      }
      
      private function updateAutoloaderAnimationTimer() : void
      {
         if(getTimer() >= this._autoloaderAnimationFinishTime)
         {
            this.clearAutoloaderAtimationTimer();
         }
         this.applyAutoloaderAnimationState();
      }
      
      private function applyAutoloaderAnimationState(param1:Boolean = false) : void
      {
         var _loc2_:Number = NaN;
         if(this._autoloaderAnimationState != CrosshairConsts.RELOADING_END)
         {
            _loc2_ = (this._autoloaderAnimationFinishTime - getTimer()) / CrosshairConsts.MS_IN_SECOND;
            this._autoloaderAnimationProgress = _loc2_ / this._autoloaderAnimationBaseTime;
         }
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setAutoloaderReloadingAsPercent(1 - this._autoloaderAnimationProgress,param1);
         }
      }
      
      private function clearTimer(param1:Number) : int
      {
         if(param1 != Values.DEFAULT_INT)
         {
            clearInterval(param1);
         }
         return Values.DEFAULT_INT;
      }
      
      private function clearAutoloaderReloadTimer() : void
      {
         this._autoloaderTimer = this.clearTimer(this._autoloaderTimer);
      }
      
      private function clearAutoloaderAtimationTimer() : void
      {
         this._autoloaderAnimationTimer = this.clearTimer(this._autoloaderAnimationTimer);
      }
      
      private function updateAutoloaderReloadingTimer() : void
      {
         if(getTimer() >= this._reloadingAutoloaderFinishTime)
         {
            this.clearAutoloaderReloadTimer();
         }
         this.applyAutoloaderState();
      }
      
      private function applyAutoloaderState() : void
      {
         if(this._currentCrosshair == null)
         {
            return;
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = this._autoloaderBaseTime;
         if(this._autoloaderState != CrosshairConsts.RELOADING_END)
         {
            _loc2_ = (this._reloadingAutoloaderFinishTime - getTimer()) / CrosshairConsts.MS_IN_SECOND;
            _loc1_ = _loc2_ / this._autoloaderBaseTime;
         }
         this._currentCrosshair.autoloaderUpdate(_loc1_,_loc2_,this._isAutoloaderTimerOn,this._isAutoloaderTimerRed);
      }
      
      private function applyData(param1:Boolean = false) : void
      {
         if(this._currentCrosshair != null)
         {
            this._currentCrosshair.setInfo(this._healthInPercents,this._zoomStr,this._currReloadingState,this._isReloadingTimeFieldShown,this._isDistanceShown,this._distanceStr,this._playerInfoStr,this._clipCapacity,this._burst,this._ammoState,this._ammoQuantityInClip,this._ammoClipState,this._ammoClipReloaded,this._isAutoloader,this._isAutoloaderCritical);
            this._currentCrosshair.setQuickReloadingTime(this._isQuickReloadingActive,this._quickReloadingTime);
            if(this._speedometer != null)
            {
               this._speedometer.changeState(this._speedMode);
               this._speedometer.setBurnout(this._burnout);
               this._speedometer.setSpeed(this._speed);
               if(this._speedometer.warning.visible != this._isWarning)
               {
                  if(this._isWarning)
                  {
                     this._speedometer.setWarning(this._burnoutWarning);
                  }
                  else
                  {
                     this._speedometer.stopWarning();
                  }
               }
               if(this._speedometer.engineError.visible != this._isEngineCrush)
               {
                  if(this._isEngineCrush)
                  {
                     this._speedometer.setEngineCrushError(this._engineCrush);
                  }
                  else
                  {
                     this._speedometer.stopEngineCrushError();
                  }
               }
            }
         }
         if(this._isAutoloader && !param1)
         {
            this.applyAutoloaderState();
            this.applyAutoloaderAnimationState(true);
         }
         this.updateCurrentCrosshairReloadingParams();
      }
      
      private function applySettings() : void
      {
         var _loc1_:CrosshairSettingsVO = this._settings[this._settingId];
         if(_loc1_ && this._currentCrosshair != null)
         {
            this._currentCrosshair.setNetType(this._netType != Values.DEFAULT_INT ? Number(this._netType) : Number(_loc1_.netType));
            this._currentCrosshair.setComponentsAlpha(_loc1_.netAlphaValue,_loc1_.centerAlphaValue,_loc1_.reloaderAlphaValue,_loc1_.conditionAlphaValue,_loc1_.cassetteAlphaValue,_loc1_.reloaderTimerAlphaValue,_loc1_.zoomIndicatorAlphaValue);
            this._currentCrosshair.setCenterType(_loc1_.centerType);
            this._currentCrosshair.scaleWidgetEnabled = _loc1_.spgScaleWidgetEnabled;
            this._currentCrosshair.setGunMarkersData(this._indicatorsData,_loc1_.isColorBlind);
            this._gunMarkersContainer.updateSettings(_loc1_);
         }
      }
      
      private function updateReloadingTimer() : void
      {
         var _loc1_:Number = getTimer() - this._initReloadingTime;
         this._currReloadingPercent = _loc1_ / this._baseReloadingTimeInMsec + this._previousReloadingPercent;
         if(this._currReloadingPercent >= 1)
         {
            this.clearReloadingTimer();
            this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
            this._remainingTimeInSec = this._baseReloadingTimeInSec;
         }
         else if(this._isReloadingTimeFieldShown)
         {
            this._remainingTimeInSec = int(this._baseReloadingTimeInMsec * (1 - this._currReloadingPercent) * DIVIDE_10) * DIVIDE_100;
         }
         this.updateCurrentCrosshairReloadingParams();
      }
      
      private function updateCurrentCrosshairReloadingParams() : void
      {
         if(this._currentCrosshair != null)
         {
            if(this._isReloadingTimeFieldShown)
            {
               this._currentCrosshair.setReloadingTime(this._remainingTimeInSec);
            }
            this._currentCrosshair.setReloadingAsPercent(this._currReloadingPercent);
            this._currentCrosshair.setReloadingState(this._currReloadingState);
         }
         this._gunMarkersContainer.updateReloadingParams(this._currReloadingPercent,this._currReloadingState);
      }
      
      private function clearReloadingTimer() : void
      {
         this._reloadingInterval = this.clearTimer(this._reloadingInterval);
      }
      
      private function hideAll() : void
      {
         var _loc1_:ICrosshair = null;
         for each(_loc1_ in this._crosshairs)
         {
            _loc1_.visible = false;
         }
      }
      
      private function onCrosshairPanelSoundHandler(param1:CrosshairPanelEvent) : void
      {
         as_playSound(param1.key);
      }
   }
}
