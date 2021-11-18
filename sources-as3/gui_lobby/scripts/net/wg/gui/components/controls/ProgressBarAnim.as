package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   
   public class ProgressBarAnim extends StatusIndicatorAnim implements IProgressBarAnim
   {
      
      private static const PADDING:int = 1;
      
      private static const HUNDRED_PERCENT:int = 100;
      
      private static const ANIM_STEP_TIME:int = 10;
      
      private static const NUM_CYCLES:int = 30;
      
      private static const PROGRESS_INV:String = "invalidate_progress";
      
      private static const INIT_MAX_PROGRESS_INV:String = "invalidate_max_progress";
       
      
      public var progressBarInProgress:DisplayObject = null;
      
      public var progressBarDone:DisplayObject = null;
      
      public var glowInProgress:DisplayObject = null;
      
      public var glowDone:DisplayObject = null;
      
      public var progressMask:DisplayObject = null;
      
      public var bg:DisplayObject = null;
      
      private var _glow:DisplayObject = null;
      
      private var _onePercent:Number = 0;
      
      private var _onePercentWidth:Number = 0;
      
      private var _maxProgressPixels:Number = 0;
      
      public function ProgressBarAnim()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INIT_MAX_PROGRESS_INV))
         {
            this.initMaxProgress();
         }
         if(isInvalid(PROGRESS_INV))
         {
            this.updatePosition();
         }
      }
      
      override protected function updatePosition() : void
      {
         var _loc1_:int = _value / this._onePercent * this._onePercentWidth ^ 0;
         var _loc2_:Boolean = _value >= _maximum;
         if(this.progressBarDone != null && this.progressBarInProgress != null)
         {
            this.progressBarInProgress.visible = !_loc2_ && _value > 0;
            this.progressBarDone.visible = _loc2_;
            this.layoutMaskProgress(this._maxProgressPixels - _loc1_ ^ 0);
         }
         if(this.glowInProgress != null && this.glowDone != null)
         {
            if(_loc2_)
            {
               this._glow = this.glowDone;
               this.glowInProgress.visible = false;
            }
            else
            {
               this._glow = this.glowInProgress;
               this.glowDone.visible = false;
            }
            this.layoutGlow(_loc1_);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         this._maxProgressPixels = width - (PADDING << 1);
         this.progressBarInProgress.width = this._maxProgressPixels;
         this.progressBarDone.width = this._maxProgressPixels;
         if(this.bg)
         {
            this.bg.width = width;
         }
         this.progressBarInProgress.visible = this.progressBarDone.visible = false;
         this.glowInProgress.visible = this.glowDone.visible = false;
         this.progressMask.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.progressMask = null;
         this.progressBarInProgress = null;
         this.progressBarDone = null;
         this.glowInProgress = null;
         this.glowDone = null;
         this.bg = null;
         this._glow = null;
         super.onDispose();
      }
      
      override protected function getAnimStepTime() : int
      {
         return ANIM_STEP_TIME;
      }
      
      override protected function getNumCycles() : int
      {
         return NUM_CYCLES;
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:ProgressBarAnimVO = null;
         if(param1 != null)
         {
            _loc2_ = ProgressBarAnimVO(param1);
            minimum = _loc2_.minValue;
            maximum = _loc2_.maxValue;
            useAnim = _loc2_.useAnim;
            value = _loc2_.value;
            this._onePercent = (_maximum - _minimum) / HUNDRED_PERCENT;
            if(!initialized)
            {
               invalidate(INIT_MAX_PROGRESS_INV);
            }
            else
            {
               this.initMaxProgress();
            }
            invalidate(PROGRESS_INV);
         }
      }
      
      private function initMaxProgress() : void
      {
         this._onePercentWidth = this._maxProgressPixels / HUNDRED_PERCENT;
      }
      
      private function layoutGlow(param1:int) : void
      {
         if(param1 > 0)
         {
            this._glow.width = param1;
            this._glow.visible = true;
         }
         else
         {
            this._glow.visible = false;
         }
      }
      
      private function layoutMaskProgress(param1:int) : void
      {
         if(param1 > 0)
         {
            this.progressMask.width = param1;
            this.progressMask.x = this._maxProgressPixels - this.progressMask.width + PADDING ^ 0;
            this.progressMask.visible = true;
         }
         else
         {
            this.progressMask.visible = false;
         }
      }
   }
}
