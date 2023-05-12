package net.wg.gui.battle.views.dualGunPanel
{
   import flash.utils.Dictionary;
   import net.wg.data.VO.RunningTimerData;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.CROSSHAIR_VIEW_ID;
   import net.wg.infrastructure.base.meta.IDualGunPanelMeta;
   import net.wg.infrastructure.base.meta.impl.DualGunPanelMeta;
   import net.wg.utils.IScheduler;
   import scaleform.clik.controls.StatusIndicator;
   
   public class DualGunPanel extends DualGunPanelMeta implements IDualGunPanelMeta
   {
      
      private static const GUN_LEFT:int = 0;
      
      private static const GUN_RIGHT:int = 1;
      
      private static const TIMER_ID_ACTIVE_GUN_CHANGE:String = "activeGun";
      
      private static const TIMER_ID_LOADING_LEFT:String = "loadingLeft";
      
      private static const TIMER_ID_LOADING_RIGHT:String = "loadingRight";
      
      private static const TIMER_ID_CHARGE_PROGRESS:String = "chargeProgress";
      
      private static const TIMER_ID_COOLDOWN:String = "cooldown";
      
      private static const PADDING_TOP_ARCADE_VIEW:Number = 10;
      
      private static const PADDING_TOP_SNIPER_VIEW:Number = 100;
      
      private static const TIMERS:Array = [TIMER_ID_ACTIVE_GUN_CHANGE,TIMER_ID_LOADING_LEFT,TIMER_ID_LOADING_RIGHT,TIMER_ID_CHARGE_PROGRESS,TIMER_ID_COOLDOWN];
      
      private static const RELOADING_TIMERS:Array = [TIMER_ID_LOADING_LEFT,TIMER_ID_LOADING_RIGHT];
       
      
      public var chargeAnimation:StatusIndicator;
      
      public var leftGunContainer:DualGunPanelGunIndicator;
      
      public var rightGunContainer:DualGunPanelGunIndicator;
      
      public var panelTimer:DualGunPanelTimer;
      
      private var _scheduler:IScheduler;
      
      private var _timers:Dictionary;
      
      private var _gunIndicators:Vector.<DualGunPanelGunIndicator>;
      
      private var _activeTimers:Vector.<String>;
      
      private var _activeGunId:int = 0;
      
      private var _speedFactor:Number = 1;
      
      private var _viewId:Number = 0;
      
      private var _stageWidth:Number;
      
      private var _stageHeight:Number;
      
      private var _hasNegativeReloadingEffect:Boolean = false;
      
      private var _isCollapsed:Boolean = false;
      
      private var _isReadyForCharge:Boolean = false;
      
      private var _lastActiveState:String = "singleMode";
      
      public function DualGunPanel()
      {
         this._scheduler = App.utils.scheduler;
         this._timers = new Dictionary();
         this._gunIndicators = new Vector.<DualGunPanelGunIndicator>(0);
         this._activeTimers = new Vector.<String>();
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.createTimers();
         this.updateState(DualGunPanelState.SINGLE_SHOT_MODE);
         this._gunIndicators[GUN_LEFT] = this.leftGunContainer;
         this._gunIndicators[GUN_RIGHT] = this.rightGunContainer;
         this.chargeAnimation.maximum = 1;
         this.visible = false;
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._timers);
         this._timers = null;
         this.leftGunContainer.dispose();
         this.leftGunContainer = null;
         this.rightGunContainer.dispose();
         this.rightGunContainer = null;
         this._gunIndicators.splice(0,this._gunIndicators.length);
         this._gunIndicators = null;
         this._scheduler.cancelTask(this.onUpdate);
         this._scheduler = null;
         this._activeTimers.splice(0,this._activeTimers.length);
         this._activeTimers = null;
         this.chargeAnimation.dispose();
         this.chargeAnimation = null;
         this.panelTimer.dispose();
         this.panelTimer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.leftGunContainer.setGunActive(true);
         this.leftGunContainer.oppositeGunPositionX(this.rightGunContainer.x - this.leftGunContainer.x);
         this.rightGunContainer.oppositeGunPositionX(this.leftGunContainer.x - this.rightGunContainer.x);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            _loc1_ = this._viewId == CROSSHAIR_VIEW_ID.SNIPER ? Number(PADDING_TOP_SNIPER_VIEW) : Number(PADDING_TOP_ARCADE_VIEW);
            x = this._stageWidth >> 1;
            y = (this._stageHeight >> 1) + _loc1_;
         }
      }
      
      public function as_cancelCharge() : void
      {
         this.updateState(DualGunPanelState.CANCEL_CHARGE);
      }
      
      public function as_collapsePanel() : void
      {
         this.updateState(DualGunPanelState.COLLAPSE);
         this.leftGunContainer.playCollapseAnim();
         this.rightGunContainer.playCollapseAnim();
      }
      
      public function as_disableCharge() : void
      {
         this.updateState(DualGunPanelState.SHOT_UNAVAILABLE);
      }
      
      public function as_expandPanel() : void
      {
         this.updateState(DualGunPanelState.EXPAND);
      }
      
      public function as_readyForCharge() : void
      {
         this.getTimerById(TIMER_ID_ACTIVE_GUN_CHANGE).complete();
         this.getTimerById(RELOADING_TIMERS[this._activeGunId]).complete();
         this.updateState(DualGunPanelState.READY_FOR_CHARGE);
      }
      
      public function as_reset() : void
      {
         this.reset();
      }
      
      public function as_setChangeGunTweenProps(param1:int, param2:int) : void
      {
         this.leftGunContainer.setChangeGunTweenProps(param1,param2);
         this.rightGunContainer.setChangeGunTweenProps(param1,param2);
      }
      
      public function as_setCooldown(param1:Number) : void
      {
         this.reset();
         this.activateTimer(TIMER_ID_COOLDOWN,param1,param1);
         this.updateState(DualGunPanelState.COOLDOWN);
      }
      
      public function as_setDualShotMode() : void
      {
      }
      
      public function as_setGunState(param1:int, param2:int, param3:Number, param4:Number) : void
      {
         if(param2 == DualGunBulletState.READY)
         {
            param3 = 0;
         }
         if(param2 == DualGunBulletState.EMPTY)
         {
            param3 = param4;
         }
         var _loc5_:DualGunPanelGunIndicator = this.getGunById(param1);
         _loc5_.updateReloadingProgress(param3,param4);
         var _loc6_:String = RELOADING_TIMERS[param1];
         if(param2 != DualGunBulletState.EMPTY)
         {
            this.activateTimer(_loc6_,param3,param4);
         }
         else
         {
            this.deactivateTimer(_loc6_);
            this.getTimerById(_loc6_).update(param3,param4,false);
         }
         if(param3 > 0)
         {
            this.updateState(DualGunPanelState.SINGLE_SHOT_MODE);
         }
      }
      
      public function as_setPlaybackSpeed(param1:Number) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this._timers)
         {
            this.getTimerById(_loc2_).setSpeed(param1);
         }
         if(param1 == 0)
         {
            this._scheduler.cancelTask(this.onUpdate);
         }
         else if(this._speedFactor == 0)
         {
            if(this._activeTimers.length > 0)
            {
               this._scheduler.scheduleOnNextFrame(this.onUpdate);
            }
         }
         this._speedFactor = param1;
      }
      
      public function as_setReloadingTimeIncreased(param1:Boolean) : void
      {
         this._hasNegativeReloadingEffect = param1;
      }
      
      public function as_setTimerVisible(param1:Boolean) : void
      {
         this.panelTimer.visible = param1;
      }
      
      public function as_setView(param1:int) : void
      {
         this._viewId = param1;
         invalidatePosition();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         _isCompVisible = param1;
         this.visible = param1;
      }
      
      public function as_startCharging(param1:Number, param2:Number) : void
      {
         this.updateState(DualGunPanelState.CHARGE);
         this.activateTimer(TIMER_ID_CHARGE_PROGRESS,param1,param2);
      }
      
      public function as_updateActiveGun(param1:int, param2:Number, param3:Number) : void
      {
         var _loc5_:int = 0;
         var _loc7_:DualGunPanelGunIndicator = null;
         var _loc8_:Boolean = false;
         var _loc4_:Boolean = this._activeGunId != param1;
         this._activeGunId = param1;
         var _loc6_:int = this._gunIndicators.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = this._gunIndicators[_loc5_];
            _loc8_ = _loc5_ == this._activeGunId;
            _loc7_.setGunActive(_loc8_);
            _loc7_.updateSwitchingProgress(param2,param3);
            _loc5_++;
         }
         if(_loc4_)
         {
            this.getGunById(param1).changeActiveGun();
         }
         this.activateTimer(TIMER_ID_ACTIVE_GUN_CHANGE,param2,param3);
      }
      
      public function as_updateTotalTime(param1:Number) : void
      {
         this.panelTimer.updateTotalTime(param1);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidatePosition();
      }
      
      private function reset() : void
      {
         var _loc1_:String = null;
         var _loc2_:RunningTimerData = null;
         for each(_loc1_ in TIMERS)
         {
            _loc2_ = this._timers[_loc1_];
            _loc2_.reset();
         }
         this._activeTimers.length = 0;
         this.chargeAnimation.value = 0;
         this.resetGunIndicators();
         this.updateState(DualGunPanelState.SINGLE_SHOT_MODE);
      }
      
      private function resetGunIndicators() : void
      {
         var _loc1_:DualGunPanelGunIndicator = null;
         for each(_loc1_ in this._gunIndicators)
         {
            _loc1_.reset();
         }
      }
      
      private function createTimers() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in TIMERS)
         {
            this._timers[_loc1_] = new RunningTimerData();
         }
      }
      
      private function activateTimer(param1:String, param2:Number, param3:Number) : void
      {
         this.getTimerById(param1).update(param2,param3,true);
         if(this._activeTimers.indexOf(param1) == -1)
         {
            this._activeTimers.push(param1);
            this._scheduler.scheduleOnNextFrame(this.onUpdate);
         }
      }
      
      private function deactivateTimer(param1:String) : void
      {
         var _loc2_:int = this._activeTimers.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.getTimerById(param1).stop();
         this._activeTimers.splice(_loc2_,1);
         if(this._activeTimers.length == 0)
         {
            this._scheduler.cancelTask(this.onUpdate);
         }
      }
      
      private function getTimerById(param1:String) : RunningTimerData
      {
         return this._timers[param1];
      }
      
      private function onUpdate() : void
      {
         var _loc2_:String = null;
         var _loc3_:RunningTimerData = null;
         var _loc4_:int = 0;
         if(this._speedFactor == 0)
         {
            return;
         }
         var _loc1_:Array = [];
         for each(_loc2_ in this._activeTimers)
         {
            _loc3_ = this._timers[_loc2_];
            switch(_loc2_)
            {
               case TIMER_ID_ACTIVE_GUN_CHANGE:
                  this.getGunById(this._activeGunId).updateSwitchingProgress(_loc3_.timeLeft,_loc3_.totalTime);
                  break;
               case TIMER_ID_LOADING_LEFT:
               case TIMER_ID_LOADING_RIGHT:
                  _loc4_ = RELOADING_TIMERS.indexOf(_loc2_);
                  this.getGunById(_loc4_).updateReloadingProgress(_loc3_.timeLeft,_loc3_.totalTime);
                  break;
               case TIMER_ID_CHARGE_PROGRESS:
                  this.chargeAnimation.value = _loc3_.elapsedPercent;
            }
            if(_loc3_.elapsedPercent == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         for each(_loc2_ in _loc1_)
         {
            this.deactivateTimer(_loc2_);
         }
         if(this._activeTimers.length > 0)
         {
            this._scheduler.scheduleOnNextFrame(this.onUpdate);
         }
         this.updatePanelTimer();
      }
      
      private function updatePanelTimer() : void
      {
         var _loc7_:Number = NaN;
         var _loc1_:RunningTimerData = this._timers[TIMER_ID_ACTIVE_GUN_CHANGE];
         var _loc2_:RunningTimerData = this._timers[TIMER_ID_LOADING_LEFT];
         var _loc3_:RunningTimerData = this._timers[TIMER_ID_LOADING_RIGHT];
         var _loc4_:RunningTimerData = this._timers[TIMER_ID_CHARGE_PROGRESS];
         var _loc5_:RunningTimerData = this._timers[TIMER_ID_COOLDOWN];
         var _loc6_:String = DualGunPanelTimer.STYLE_IDLE;
         if(_loc5_.isRunning)
         {
            _loc6_ = DualGunPanelTimer.STYLE_DEBUFF;
            _loc7_ = _loc5_.timeLeft;
         }
         else if(_loc4_.isRunning)
         {
            _loc6_ = DualGunPanelTimer.STYLE_CHARGE;
            _loc7_ = _loc4_.timeLeft;
         }
         else if(_loc2_.isRunning || _loc3_.isRunning)
         {
            _loc6_ = !!_loc1_.isRunning ? DualGunPanelTimer.STYLE_PRIMARY_LOADING : DualGunPanelTimer.STYLE_SECONDARY_LOADING;
            _loc7_ = _loc2_.timeLeft + _loc3_.timeLeft;
         }
         else
         {
            _loc6_ = DualGunPanelTimer.STYLE_IDLE;
            _loc7_ = _loc2_.totalTime + _loc3_.totalTime;
         }
         if(this._hasNegativeReloadingEffect && (_loc6_ == DualGunPanelTimer.STYLE_PRIMARY_LOADING || _loc6_ == DualGunPanelTimer.STYLE_SECONDARY_LOADING))
         {
            _loc6_ = DualGunPanelTimer.STYLE_CRITICAL;
         }
         this.panelTimer.setTextStyle(_loc6_);
         if(_loc7_ > 0)
         {
            this.panelTimer.updateTimerValue(_loc7_);
         }
      }
      
      private function getGunById(param1:int) : DualGunPanelGunIndicator
      {
         return this._gunIndicators[param1];
      }
      
      private function stopCharge() : void
      {
         this.deactivateTimer(TIMER_ID_CHARGE_PROGRESS);
         this.chargeAnimation.value = 0;
      }
      
      private function updateState(param1:String) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:String = param1;
         switch(param1)
         {
            case DualGunPanelState.SINGLE_SHOT_MODE:
               this.deactivateTimer(TIMER_ID_COOLDOWN);
               this._isReadyForCharge = false;
               this.stopCharge();
               if(this._isCollapsed)
               {
                  _loc3_ = DualGunPanelState.COLLAPSE;
               }
               break;
            case DualGunPanelState.CHARGE:
               this.deactivateTimer(TIMER_ID_COOLDOWN);
               if(this._isCollapsed)
               {
                  _loc3_ = DualGunPanelState.CHARGED;
               }
               this._isCollapsed = true;
               break;
            case DualGunPanelState.SHOT_UNAVAILABLE:
               this.stopCharge();
               _loc2_ = false;
               break;
            case DualGunPanelState.CANCEL_CHARGE:
               this.stopCharge();
               if(this._isCollapsed)
               {
                  this._isCollapsed = false;
               }
               else
               {
                  _loc2_ = false;
               }
               break;
            case DualGunPanelState.READY_FOR_CHARGE:
               this.deactivateTimer(TIMER_ID_COOLDOWN);
               this.stopCharge();
               this._isReadyForCharge = true;
               if(this._isCollapsed)
               {
                  _loc3_ = DualGunPanelState.CHARGED;
               }
               break;
            case DualGunPanelState.COLLAPSE:
               this._isCollapsed = true;
               if(this._isReadyForCharge)
               {
                  _loc3_ = DualGunPanelState.CHARGE;
               }
               break;
            case DualGunPanelState.COOLDOWN:
               this._isCollapsed = false;
               break;
            case DualGunPanelState.EXPAND:
               this._isCollapsed = false;
               if(this._isReadyForCharge)
               {
                  _loc3_ = DualGunPanelState.CANCEL_CHARGE;
               }
         }
         if(_loc2_ && this._lastActiveState != _loc3_)
         {
            if(_loc3_ == DualGunPanelState.CHARGED)
            {
               this.gotoAndStop(_loc3_);
               this.leftGunContainer.gotoAndStop(_loc3_);
               this.rightGunContainer.gotoAndStop(_loc3_);
            }
            else
            {
               this.gotoAndPlay(_loc3_);
               this.leftGunContainer.gotoAndPlay(_loc3_);
               this.rightGunContainer.gotoAndPlay(_loc3_);
            }
            this._lastActiveState = _loc3_;
         }
         this.updatePanelTimer();
      }
   }
}
