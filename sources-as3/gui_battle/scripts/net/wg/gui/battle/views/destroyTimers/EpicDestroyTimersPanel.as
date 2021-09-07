package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IEpicDestroyTimersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicDestroyTimersPanelMeta;
   import net.wg.utils.StageSizeBoundaries;
   
   public class EpicDestroyTimersPanel extends EpicDestroyTimersPanelMeta implements IEpicDestroyTimersPanelMeta
   {
      
      private static const INVALID_RESUPPLY_STATE:uint = InvalidationType.STATE << 1;
      
      private static const RESUPPLY_CIRCLE:int = 1;
      
      private static const RESUPPLY_TIMER_SHIFT_SMALL:int = 110;
      
      private static const RESUPPLY_TIMER_SHIFT_HUGE:int = 130;
      
      private static const SECONDARY_TIMER_SHIFT_SMALL:int = 90;
      
      private static const SECONDARY_TIMER_SHIFT_HUGE:int = 120;
       
      
      public var additionalTimerContainer:MovieClip = null;
      
      private var _isSmall:Boolean = false;
      
      private var _isTimerShow:Boolean = false;
      
      private var _showWithWarning:Boolean = false;
      
      private var _progress:Number = 0;
      
      private var _state:int = 0;
      
      private var _cooldownTime:String = "";
      
      private var _resupplyTimer:ResupplyTimer = null;
      
      public function EpicDestroyTimersPanel()
      {
         super();
      }
      
      override protected function hideTimer(param1:DestroyTimer) : void
      {
         super.hideTimer(param1);
         if(this._resupplyTimer.isActive)
         {
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      override protected function hideSecondaryTimer(param1:String) : void
      {
         super.hideSecondaryTimer(param1);
         if(this._resupplyTimer.isActive)
         {
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      override protected function showTimer(param1:String, param2:String, param3:Boolean) : void
      {
         super.showTimer(param1,param2,param3);
         if(this._resupplyTimer.isActive)
         {
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      override protected function showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean = false) : void
      {
         super.showSecondaryTimer(param1,param2,param3,param4);
         if(this._resupplyTimer.isActive)
         {
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(this._resupplyTimer && isInvalid(InvalidationType.SIZE))
         {
            if(this._isSmall != stageWidth < StageSizeBoundaries.WIDTH_1280)
            {
               this._isSmall = stageWidth < StageSizeBoundaries.WIDTH_1280;
               this.recreateTimerBySize(this._isSmall || isAnyTimerActive());
               invalidate(INVALID_STATE);
               invalidate(INVALID_RESUPPLY_STATE);
            }
         }
         if(isInvalid(INVALID_RESUPPLY_STATE))
         {
            if(this._resupplyTimer.isActive)
            {
               _loc1_ = isAnyTimerActive();
               _loc2_ = isAnySecondaryTimerActive();
               this._showWithWarning = _loc1_ || _loc2_;
               this.recreateTimerBySize(this._isSmall || isAnyTimerActive());
               if(this._showWithWarning)
               {
                  this._resupplyTimer.cropSize();
               }
               else
               {
                  this._resupplyTimer.fullSize();
               }
               this._resupplyTimer.x = !!_loc1_ ? (!!this._resupplyTimer.isSmallSize ? Number(RESUPPLY_TIMER_SHIFT_SMALL) : Number(RESUPPLY_TIMER_SHIFT_HUGE)) : Number(Values.ZERO);
               evaluateState();
            }
         }
      }
      
      override protected function isAnyTimerInCenter() : Boolean
      {
         return this._isTimerShow || super.isAnyTimerInCenter();
      }
      
      override protected function calculateSecondaryContainerShift() : int
      {
         var _loc1_:int = super.calculateSecondaryContainerShift();
         if(this._isTimerShow)
         {
            if(isAnyTimerActive())
            {
               _loc1_ += !!this._resupplyTimer.isSmallSize ? SECONDARY_TIMER_SHIFT_SMALL : SECONDARY_TIMER_SHIFT_HUGE;
            }
            else
            {
               _loc1_ = SECONDARY_TIMER_OFFSET_X;
            }
         }
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         this.additionalTimerContainer.removeChild(this._resupplyTimer);
         this.additionalTimerContainer = null;
         this._resupplyTimer.dispose();
         this._resupplyTimer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._isSmall = stageWidth < StageSizeBoundaries.WIDTH_1280;
         var _loc1_:String = !!this._isSmall ? Linkages.RESUPPLY_TIMER_SMALL_UI : Linkages.RESUPPLY_TIMER_UI;
         this._resupplyTimer = App.utils.classFactory.getComponent(_loc1_,ResupplyTimer);
         this._resupplyTimer.stop();
         this._resupplyTimer.visible = false;
         this._resupplyTimer.mouseEnabled = false;
         this._resupplyTimer.mouseChildren = false;
         this._resupplyTimer.setState(0);
         this.additionalTimerContainer.addChild(this._resupplyTimer);
      }
      
      public function as_hideAdditionalTimer(param1:int) : void
      {
         if(param1 == RESUPPLY_CIRCLE)
         {
            this._resupplyTimer.resetTimer();
            this._resupplyTimer.isActive = false;
            this._isTimerShow = false;
            this._resupplyTimer.hideTimer();
            invalidate(INVALID_STATE);
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      public function as_setAdditionalTimerProgressValue(param1:int, param2:Number) : void
      {
         if(param1 == RESUPPLY_CIRCLE)
         {
            this._progress = param2;
            this._resupplyTimer.setProgressValue(param2);
         }
      }
      
      public function as_setAdditionalTimerState(param1:int, param2:int) : void
      {
         if(param1 == RESUPPLY_CIRCLE)
         {
            this._state = param2;
            this._resupplyTimer.setState(param2);
         }
      }
      
      public function as_setAdditionalTimerTimeString(param1:int, param2:String) : void
      {
         if(param1 == RESUPPLY_CIRCLE)
         {
            this._cooldownTime = param2;
            this._resupplyTimer.setCooldownTime(param2);
         }
      }
      
      public function as_showAdditionalTimer(param1:int, param2:int) : void
      {
         if(param1 == RESUPPLY_CIRCLE)
         {
            this._resupplyTimer.visible = true;
            this._resupplyTimer.isActive = true;
            this._state = param2;
            this._resupplyTimer.setState(param2);
            this._isTimerShow = true;
            this._resupplyTimer.showTimer(true);
            invalidate(INVALID_STATE);
            invalidate(INVALID_RESUPPLY_STATE);
         }
      }
      
      private function recreateTimerBySize(param1:Boolean) : void
      {
         if(this._resupplyTimer)
         {
            if(this._resupplyTimer.isSmallSize == param1)
            {
               return;
            }
            this.additionalTimerContainer.removeChild(this._resupplyTimer);
         }
         var _loc2_:String = !!param1 ? Linkages.RESUPPLY_TIMER_SMALL_UI : Linkages.RESUPPLY_TIMER_UI;
         this._resupplyTimer = App.utils.classFactory.getComponent(_loc2_,ResupplyTimer);
         this._resupplyTimer.stop();
         this._resupplyTimer.visible = false;
         this._resupplyTimer.mouseEnabled = false;
         this._resupplyTimer.mouseChildren = false;
         this._resupplyTimer.isSmallSize = param1;
         this._resupplyTimer.setProgressValue(this._progress);
         this._resupplyTimer.setState(this._state);
         this._resupplyTimer.setCooldownTime(this._cooldownTime);
         this._resupplyTimer.isActive = this._isTimerShow;
         if(this._isTimerShow)
         {
            this._resupplyTimer.visible = true;
            this._resupplyTimer.showTimer(true);
         }
         else
         {
            this._resupplyTimer.resetTimer();
            this._resupplyTimer.hideTimer();
         }
         this.additionalTimerContainer.addChild(this._resupplyTimer);
      }
   }
}
