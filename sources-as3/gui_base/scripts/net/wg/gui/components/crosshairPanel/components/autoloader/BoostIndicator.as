package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSTATES;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class BoostIndicator extends SimpleContainer
   {
      
      private static const WAITING_TO_START_OFFSET_FACTOR:Number = 0.07;
      
      private static const CHARGED_OFFSET_MSECS:uint = 300;
       
      
      public var left:BoostIndicatorElement = null;
      
      public var right:BoostIndicatorElement = null;
      
      private var _currentState:int = -2;
      
      private var _stateParams:BoostIndicatorStateParamsVO = null;
      
      private var _isRecharging:Boolean = false;
      
      private var _isFadingOut:Boolean = false;
      
      private var _isCharging:Boolean = false;
      
      private var _rechargeEnabled:Boolean = true;
      
      private var _timeOutId:int = -1;
      
      public function BoostIndicator()
      {
         super();
         this.left.onRechargeComplete = this.onFinishRechargeAnimation;
         this.left.onChargeComplete = this.onFinishChargeAnimation;
         this.left.onFadeOutComplete = this.onFinishFadeOutAnimation;
         this.left.soundsEnabled = false;
         this.left.hide();
         this.right.hide();
         this._stateParams = new BoostIndicatorStateParamsVO();
      }
      
      override protected function onDispose() : void
      {
         this._stateParams = null;
         this.left.dispose();
         this.left = null;
         this.right.dispose();
         this.right = null;
         super.onDispose();
      }
      
      public function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!param3 && param1.currentState != AUTOLOADERBOOSTVIEWSTATES.RECHARGE && this._currentState == param1.currentState)
         {
            return;
         }
         if(param3)
         {
            this._isRecharging = false;
         }
         this.cancelTasks();
         this._stateParams = param1;
         if(param1.currentState == AUTOLOADERBOOSTVIEWSTATES.WAITING_TO_START)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.WAITING_TO_START;
            _loc4_ = param2 * (1 - WAITING_TO_START_OFFSET_FACTOR) * 1000;
            this.left.hide();
            this.left.showFadeIn(_loc4_);
            this.right.hide();
            this.right.showFadeIn(_loc4_);
         }
         else if(param1.currentState == AUTOLOADERBOOSTVIEWSTATES.INVISIBLE && !this._isFadingOut)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
            this._isRecharging = false;
            this._isCharging = false;
            if(param1.isSideFadeOut)
            {
               this.left.showFadeOut();
               this.right.showFadeOut();
               this._isFadingOut = true;
            }
            else
            {
               this.left.hide();
               this.right.hide();
            }
            if(!this._rechargeEnabled)
            {
               this.autoloaderBoostUpdateAsPercent(param1.currentState,param1.percent);
            }
         }
         else if(this._rechargeEnabled && param1.currentState == AUTOLOADERBOOSTVIEWSTATES.CHARGED)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.CHARGED;
            this._isRecharging = false;
            this._isFadingOut = false;
            if(param1.isCharging)
            {
               this.left.showCharged(param1.currentFrame);
               this.right.showCharged(param1.currentFrame);
            }
            else if(param1.currentFrame > this.left.currentFrame && param1.currentFrame >= BoostIndicatorElement.CHARGE_MAX_FRAME)
            {
               this.left.showCharged(param1.currentFrame);
               this.right.showCharged(param1.currentFrame);
            }
            else
            {
               this.left.showCharged();
               this.right.showCharged();
            }
            this._isCharging = true;
         }
         else if(this._rechargeEnabled && param1.currentState > 0 && !this._isRecharging)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.RECHARGE;
            this._isRecharging = true;
            this._isFadingOut = false;
            this._isCharging = false;
            if(param1.isRecharging)
            {
               this.left.currentFrame = this.right.currentFrame = param1.currentFrame;
            }
            else
            {
               this.left.currentFrame = this.right.currentFrame = BoostIndicatorElement.RECHARGE_BEGIN_FRAME;
            }
            this.left.showRecharge(param1.remainingDurationMSec);
            this.right.showRecharge(param1.remainingDurationMSec);
            _loc5_ = param1.remainingDurationMSec - CHARGED_OFFSET_MSECS;
            if(_loc5_ > 0)
            {
               this._stateParams.remainingDurationMSec = this._stateParams.currentState = AUTOLOADERBOOSTVIEWSTATES.CHARGED;
               this._stateParams.currentFrame = BoostIndicatorElement.RECHARGE_END_FRAME;
               this._stateParams.isRecharging = true;
               this._stateParams.isFadingOut = false;
               this._stateParams.isCharging = false;
               this._timeOutId = setTimeout(this.autoloaderBoostUpdate,_loc5_,param1,0);
            }
         }
      }
      
      public function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void
      {
         if(this._isFadingOut)
         {
            return;
         }
         if(param1 == AUTOLOADERBOOSTVIEWSTATES.INVISIBLE && !this._isFadingOut)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
            this._isRecharging = false;
            this._isCharging = false;
         }
         else if(param1 == AUTOLOADERBOOSTVIEWSTATES.CHARGED)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.CHARGED;
            this._isRecharging = false;
            this._isFadingOut = false;
         }
         else if(param1 > 0 && !this._isRecharging)
         {
            this._currentState = AUTOLOADERBOOSTVIEWSTATES.RECHARGE;
            this._isRecharging = true;
            this._isFadingOut = false;
            this._isCharging = false;
         }
         this._rechargeEnabled = false;
         this.left.percent = this.right.percent = param2;
         this.stateParams.percent = param2;
      }
      
      private function onFinishRechargeAnimation() : void
      {
         this.stateParams.resetToDefault();
         this._isRecharging = false;
      }
      
      private function onFinishChargeAnimation() : void
      {
         this._isCharging = false;
      }
      
      private function onFinishFadeOutAnimation() : void
      {
         this.stateParams.resetToDefault();
         this._isFadingOut = false;
      }
      
      private function cancelTasks() : void
      {
         this.left.cancelTasks();
         this.right.cancelTasks();
         if(this._timeOutId != -1)
         {
            clearTimeout(this._timeOutId);
            this._timeOutId = -1;
         }
      }
      
      public function get stateParams() : BoostIndicatorStateParamsVO
      {
         this._stateParams.remainingDurationMSec = this.left.remainingDurationMSc;
         this._stateParams.currentFrame = this.left.currentFrame;
         this._stateParams.currentState = this._currentState;
         this._stateParams.isRecharging = this._isRecharging;
         this._stateParams.isFadingOut = this._isFadingOut;
         this._stateParams.isCharging = this._isCharging;
         return this._stateParams;
      }
   }
}
