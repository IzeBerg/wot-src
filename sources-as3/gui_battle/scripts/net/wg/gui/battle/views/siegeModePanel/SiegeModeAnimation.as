package net.wg.gui.battle.views.siegeModePanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class SiegeModeAnimation extends BattleUIComponent
   {
      
      protected static const CHASSIS_STATE_BASE:String = "base";
      
      protected static const CHASSIS_STATE_SIEGE:String = "siege";
      
      protected static const DELIMITER:String = "_";
      
      protected static const SIEGE_SWITCHING_ON:int = 1;
      
      protected static const SIEGE_STATE_ENABLED:int = 2;
      
      private static const SIEGE_SWITCHING_OFF:int = 3;
      
      private static const STATE_VISIBLE_TIMER:String = "visibleTimer";
      
      private static const STATE_INVISIBLE_TIMER:String = "invisibleTimer";
      
      private static const STATE_SHOW_TIMER:String = "showTimer";
      
      private static const STATE_HIDE_TIMER:String = "hideTimer";
      
      private static const VISIBLE_FRAME:String = "visible";
      
      private static const ROTATION_NORMAL:Number = -45;
      
      private static const PRECISION:int = 1;
      
      private static const CRITICAL_TIME:int = 3000;
      
      private static const DESTROYED_TIME:int = 5000;
      
      private static const NO_TIME:String = "- -";
      
      private static const CRITICAL_COMPLETE_FRAME:int = 39;
      
      private static const DMG_CONTAINER_FIRST_FRAME:int = 1;
      
      private static const MIN_TIME_VALUE:Number = 0.0001;
       
      
      public var changeTimeContainer:MovieClip = null;
      
      public var statusSiegeIcon:MovieClip = null;
      
      public var switchIndicatorContainer:MovieClip = null;
      
      public var deviceIconContainer:MovieClip = null;
      
      public var damagedContainer:MovieClip = null;
      
      protected var states:Vector.<String>;
      
      protected var atlasManager:IAtlasManager;
      
      protected var switchIndicator:MovieClip = null;
      
      protected var siegeState:int = -1;
      
      protected var engineState:String = "";
      
      private var _colorByEngineState:Object;
      
      private var _changeTimeTF:TextField = null;
      
      private var _startTime:Number = 0;
      
      private var _totalTime:Number = 0;
      
      private var _switchIntervalId:int = 0;
      
      private var _deviceIntervalId:int = 0;
      
      private var _isSwitchPlay:Boolean = false;
      
      private var _isDevicePlay:Boolean = false;
      
      private var _deviceStatus:String = null;
      
      private var _deviceState:String = null;
      
      private var _deviceStatusIcon:MovieClip = null;
      
      public function SiegeModeAnimation()
      {
         this.states = new <String>[CHASSIS_STATE_BASE,CHASSIS_STATE_BASE,CHASSIS_STATE_SIEGE,CHASSIS_STATE_SIEGE];
         this.atlasManager = App.atlasMgr;
         this._colorByEngineState = {};
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._colorByEngineState[BATTLE_ITEM_STATES.NORMAL] = 13434777;
         this._colorByEngineState[BATTLE_ITEM_STATES.CRITICAL] = 16744192;
         this._colorByEngineState[BATTLE_ITEM_STATES.DESTROYED] = 16711680;
         this._changeTimeTF = this.changeTimeContainer.changeTimeTF;
         this.switchIndicator = this.switchIndicatorContainer.switchIndicator;
         this._deviceStatusIcon = this.deviceIconContainer.deviceStatusIcon;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.deviceIconContainer.stop();
         this.damagedContainer.stop();
         gotoAndStop(STATE_INVISIBLE_TIMER);
         this.deviceIconContainer.visible = false;
         this.atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.SWITCH_SIEGE_DAMAGED,this.damagedContainer.damagedIcon.graphics,Values.EMPTY_STR,false,false,true);
         this.damagedContainer.visible = false;
         this.deviceIconContainer.addFrameScript(CRITICAL_COMPLETE_FRAME,this.onLoopAnimation);
         this.deviceIconContainer.addFrameScript(this.deviceIconContainer.totalFrames - 1,this.onLoopAnimation);
         this.damagedContainer.addFrameScript(this.damagedContainer.totalFrames - 1,this.onDamagedAnimationComplete);
      }
      
      override protected function onDispose() : void
      {
         this.stopSwitchAnimation();
         this.stop();
         this.deviceIconContainer.addFrameScript(CRITICAL_COMPLETE_FRAME,null);
         this.deviceIconContainer.addFrameScript(this.deviceIconContainer.totalFrames - 1,null);
         this.damagedContainer.addFrameScript(this.damagedContainer.totalFrames - 1,null);
         this.changeTimeContainer = null;
         this.statusSiegeIcon.stop();
         this.statusSiegeIcon = null;
         this.switchIndicatorContainer.stop();
         this.switchIndicatorContainer = null;
         this.deviceIconContainer.stop();
         this.deviceIconContainer = null;
         this.damagedContainer.stop();
         this.damagedContainer = null;
         this._changeTimeTF.filters = null;
         this._changeTimeTF = null;
         this.switchIndicator.stop();
         this.switchIndicator = null;
         this._deviceStatusIcon = null;
         this.atlasManager = null;
         this.states.splice(0,this.states.length);
         this.states = null;
         App.utils.data.cleanupDynamicObject(this._colorByEngineState);
         this._colorByEngineState = null;
         super.onDispose();
      }
      
      public function setAutoSiegeModeState(param1:int, param2:String) : void
      {
         this.siegeState = param1;
         this.engineState = param2;
         if(this.siegeState == SIEGE_STATE_ENABLED)
         {
            this.drawSiegeStatusIcon();
            gotoAndStop(STATE_INVISIBLE_TIMER);
         }
         else
         {
            gotoAndStop(STATE_VISIBLE_TIMER);
         }
         this.switchIndicatorContainer.gotoAndStop(STATE_INVISIBLE_TIMER);
         this._changeTimeTF.visible = false;
         this.stopSwitchAnimation();
      }
      
      public function switchSiegeState(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void
      {
         var _loc6_:Number = NaN;
         this.siegeState = param3;
         this.engineState = param4;
         this.stopSwitchAnimation();
         this.setEngineAndTime(param2);
         if(this.siegeState == SIEGE_SWITCHING_ON || this.siegeState == SIEGE_SWITCHING_OFF)
         {
            if(param5)
            {
               this.switchIndicatorContainer.gotoAndPlay(STATE_SHOW_TIMER);
               gotoAndPlay(STATE_SHOW_TIMER);
            }
            else
            {
               this.switchIndicatorContainer.gotoAndStop(STATE_VISIBLE_TIMER);
               gotoAndStop(STATE_VISIBLE_TIMER);
            }
            this._totalTime = param1 * Time.MILLISECOND_IN_SECOND;
            _loc6_ = param2 * Time.MILLISECOND_IN_SECOND;
            this._startTime = getTimer() - (this._totalTime - _loc6_);
            if(this._totalTime < MIN_TIME_VALUE)
            {
               this._totalTime = this.checkTotalTime(this._totalTime,_loc6_);
            }
            if(this.siegeState == SIEGE_SWITCHING_ON)
            {
               this.onSwitchIndicatorAnimation(ROTATION_NORMAL * (_loc6_ / this._totalTime));
               this.tryToStartSiegeTicking();
            }
            else
            {
               this.onSwitchIndicatorAnimation(ROTATION_NORMAL * (1 - _loc6_ / this._totalTime));
               this.tryToStartSiegeTicking(false);
            }
         }
         else
         {
            this.updateFinalSiegeStatus(param5);
         }
      }
      
      public function switchSiegeStateSnapshot(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void
      {
         this.siegeState = param3;
         this.engineState = param4;
         this.setEngineAndTime(param2);
         if(this.siegeState == SIEGE_SWITCHING_ON || this.siegeState == SIEGE_SWITCHING_OFF)
         {
            if(param5)
            {
               this.switchIndicatorContainer.gotoAndPlay(STATE_SHOW_TIMER);
               gotoAndPlay(STATE_SHOW_TIMER);
            }
            else if(this.switchIndicatorContainer.currentLabel != STATE_SHOW_TIMER)
            {
               this.switchIndicatorContainer.gotoAndStop(STATE_VISIBLE_TIMER);
               gotoAndStop(STATE_VISIBLE_TIMER);
            }
            if(param1 < MIN_TIME_VALUE)
            {
               param1 = this.checkTotalTime(param1,param2);
            }
            if(this.siegeState == SIEGE_SWITCHING_ON)
            {
               this.onSwitchIndicatorAnimation(ROTATION_NORMAL * (param2 / param1));
            }
            else
            {
               this.onSwitchIndicatorAnimation(ROTATION_NORMAL * (1 - param2 / param1));
            }
            this._isSwitchPlay = true;
         }
         else
         {
            this.updateFinalSiegeStatus(param5);
            this._isSwitchPlay = false;
            this.onDamagedAnimationComplete();
         }
      }
      
      public function updateDeviceState(param1:String, param2:String) : void
      {
         var _loc3_:String = this.createDeviceStatusImgSrc(param1,param2);
         if(this._deviceStatus != _loc3_)
         {
            this._deviceStatus = _loc3_;
            this._deviceState = param2;
            if(this._isDevicePlay)
            {
               clearInterval(this._deviceIntervalId);
               this._isDevicePlay = false;
            }
            this.deviceIconContainer.visible = this._deviceState != BATTLE_ITEM_STATES.NORMAL;
            if(this.deviceIconContainer.visible)
            {
               this.atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc3_,this._deviceStatusIcon.graphics);
               this.deviceIconContainer.gotoAndPlay(this._deviceState);
               this._deviceIntervalId = setInterval(this.onAnimationComplete,this._deviceState == BATTLE_ITEM_STATES.CRITICAL ? Number(CRITICAL_TIME) : Number(DESTROYED_TIME));
               this._isDevicePlay = true;
               this.damagedContainer.visible = this._isSwitchPlay && param1 == VehicleModules.ENGINE;
               if(this.damagedContainer.visible)
               {
                  this.damagedContainer.gotoAndPlay(DMG_CONTAINER_FIRST_FRAME);
               }
            }
         }
      }
      
      protected function createDeviceStatusImgSrc(param1:String, param2:String) : String
      {
         return param1 + DELIMITER + param2;
      }
      
      protected function drawSiegeStatusIcon() : void
      {
         this.atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this.engineState + DELIMITER + this.states[this.siegeState],this.statusSiegeIcon.graphics);
      }
      
      protected function drawSwitchIndicator() : void
      {
         this.atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this.engineState,this.switchIndicator.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      protected function onSwitchIndicatorAnimation(param1:Number) : void
      {
         this.switchIndicatorContainer.rotation = param1;
      }
      
      protected function getChangeTimeTextColor() : uint
      {
         return this._colorByEngineState[this.engineState];
      }
      
      protected function getChangeTimeTextFilters() : Array
      {
         return null;
      }
      
      protected function stopSwitchAnimation() : void
      {
         if(this._isSwitchPlay)
         {
            clearInterval(this._switchIntervalId);
            this._isSwitchPlay = false;
         }
      }
      
      private function tryToStartSiegeTicking(param1:Boolean = true) : void
      {
         if(this.engineState != BATTLE_ITEM_STATES.DESTROYED)
         {
            this._switchIntervalId = setInterval(this.siegeTicking,CrosshairConsts.COUNTER_UPDATE_TICK,param1);
            this._isSwitchPlay = true;
         }
      }
      
      private function updateFinalSiegeStatus(param1:Boolean) : void
      {
         this.drawSiegeStatusIcon();
         this.switchIndicatorContainer.gotoAndStop(STATE_INVISIBLE_TIMER);
         if(param1)
         {
            this.switchIndicatorContainer.gotoAndPlay(STATE_HIDE_TIMER);
            gotoAndPlay(STATE_HIDE_TIMER);
         }
         else
         {
            gotoAndStop(STATE_INVISIBLE_TIMER);
         }
      }
      
      private function setEngineAndTime(param1:Number) : void
      {
         if(!this._changeTimeTF.visible)
         {
            this._changeTimeTF.visible = true;
         }
         if(this.engineState != BATTLE_ITEM_STATES.DESTROYED && param1 > 0)
         {
            this._changeTimeTF.text = param1.toFixed(PRECISION);
         }
         else
         {
            this._changeTimeTF.text = NO_TIME;
         }
         this._changeTimeTF.textColor = this.getChangeTimeTextColor();
         this._changeTimeTF.filters = this.getChangeTimeTextFilters();
         this.drawSwitchIndicator();
      }
      
      private function onAnimationComplete() : void
      {
         this.deviceIconContainer.gotoAndStop(this._deviceState + DELIMITER + VISIBLE_FRAME);
         clearInterval(this._deviceIntervalId);
         this._isDevicePlay = false;
      }
      
      private function siegeTicking(param1:Boolean) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = getTimer() - this._startTime;
         var _loc3_:Number = (this._totalTime - _loc2_) / Time.MILLISECOND_IN_SECOND;
         if(_loc3_ < 0)
         {
            this.stopSwitchAnimation();
         }
         else
         {
            this._changeTimeTF.text = _loc3_.toFixed(PRECISION);
            _loc4_ = ROTATION_NORMAL * (!!param1 ? 1 - _loc2_ / this._totalTime : _loc2_ / this._totalTime);
            this.onSwitchIndicatorAnimation(_loc4_);
         }
      }
      
      private function onLoopAnimation() : void
      {
         this.deviceIconContainer.gotoAndPlay(this._deviceState);
      }
      
      private function onDamagedAnimationComplete() : void
      {
         this.damagedContainer.visible = false;
      }
      
      private function checkTotalTime(param1:Number, param2:Number) : Number
      {
         return Math.max(MIN_TIME_VALUE,Math.max(param1,param2));
      }
   }
}
