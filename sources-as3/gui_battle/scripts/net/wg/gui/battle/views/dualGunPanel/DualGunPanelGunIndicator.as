package net.wg.gui.battle.views.dualGunPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.clik.controls.StatusIndicator;
   
   public class DualGunPanelGunIndicator extends BattleUIComponent
   {
      
      private static const INV_SWITCH_INDICATOR:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INV_CHANGE_ACTIVE_GUN:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var gunChangingProgress:DualGunChangingProgressIndicator;
      
      public var bulletProgress:StatusIndicator;
      
      private var _reloadingTimeLeft:Number = 0;
      
      private var _reloadingTotalTime:Number = 0;
      
      private var _switchingTimeLeft:Number = 0;
      
      private var _switchingTotalTime:Number = 0;
      
      private var _isActive:Boolean;
      
      private var _needChangeActiveGun:Boolean = false;
      
      public function DualGunPanelGunIndicator()
      {
         super();
         this.bulletProgress.maximum = 1;
         this.bulletProgress.value = 0;
         this.gunChangingProgress.stop();
      }
      
      override protected function onDispose() : void
      {
         this.gunChangingProgress.dispose();
         this.gunChangingProgress = null;
         this.bulletProgress.dispose();
         this.bulletProgress = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(INV_SWITCH_INDICATOR))
         {
            this.gunChangingProgress.setActive(this._isActive);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = Math.max(this._switchingTimeLeft,this._reloadingTimeLeft);
            _loc2_ = 1 - this._reloadingTimeLeft / this._reloadingTotalTime;
            this.bulletProgress.value = _loc2_;
            this.gunChangingProgress.updateProgress(_loc1_,this._switchingTotalTime);
         }
         if(this._needChangeActiveGun && isInvalid(INV_CHANGE_ACTIVE_GUN))
         {
            this._needChangeActiveGun = false;
            this.gunChangingProgress.playChangeActiveGunAnim();
         }
      }
      
      public function changeActiveGun() : void
      {
         this._needChangeActiveGun = true;
         invalidate(INV_CHANGE_ACTIVE_GUN);
      }
      
      public function oppositeGunPositionX(param1:int) : void
      {
         this.gunChangingProgress.oppositeGunPositionX = param1;
      }
      
      public function playCollapseAnim() : void
      {
         this.gunChangingProgress.playCollapseAnim();
      }
      
      public function reset() : void
      {
         this.updateReloadingProgress(1,1);
         this.updateSwitchingProgress(1,1);
         this.setGunActive(false);
      }
      
      public function setChangeGunTweenProps(param1:int, param2:int) : void
      {
         this.gunChangingProgress.setChangeGunTweenProps(param1,param2);
      }
      
      public function setGunActive(param1:Boolean) : void
      {
         this._isActive = param1;
         invalidate(INV_SWITCH_INDICATOR);
      }
      
      public function updateReloadingProgress(param1:Number, param2:Number) : void
      {
         if(this._reloadingTimeLeft != param1 || this._reloadingTotalTime != param2)
         {
            this._reloadingTimeLeft = param1;
            this._reloadingTotalTime = param2;
            invalidate(InvalidationType.DATA);
         }
      }
      
      public function updateSwitchingProgress(param1:Number, param2:Number) : void
      {
         if(this._switchingTimeLeft != param1 || this._switchingTotalTime != param2)
         {
            this._switchingTimeLeft = param1;
            this._switchingTotalTime = param2;
            invalidate(InvalidationType.DATA);
         }
      }
   }
}
