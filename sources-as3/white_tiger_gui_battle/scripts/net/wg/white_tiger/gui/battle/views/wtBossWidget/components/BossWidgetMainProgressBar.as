package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   
   public class BossWidgetMainProgressBar extends ProgressBar
   {
      
      private static const INVALIDATE_DEBUFF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const FRAME_NORMAL:String = "normal";
      
      private static const FRAME_DEBUFF:String = "debuff";
      
      private static const FRAME_DOWN_END:int = 100;
       
      
      public var hpProgress:MovieClip = null;
      
      public var hpProgressDown:MovieClip = null;
      
      public var debuffProgress:MovieClip = null;
      
      public var flare:MovieClip = null;
      
      private var _curAnimationFrame:int = 0;
      
      private var _debuffAnimationActive:Boolean = false;
      
      private var _updateProgressAfterAnimation:Boolean = false;
      
      private var _isDebuff:Boolean = false;
      
      private var _isInited:Boolean = false;
      
      public function BossWidgetMainProgressBar()
      {
         super();
         this.hpProgressDown.visible = false;
         this.debuffProgress.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.hpProgressDown.addFrameScript(FRAME_DOWN_END - 1,null);
         this.hpProgress.addFrameScript(this._curAnimationFrame,null);
         this.hpProgress = null;
         this.hpProgressDown = null;
         this.debuffProgress = null;
         this.flare = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hpProgress.gotoAndStop(this.hpProgress.totalFrames);
         this.debuffProgress.gotoAndStop(this.debuffProgress.totalFrames);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(!this._debuffAnimationActive)
            {
               this.updateProgressBars();
            }
            else
            {
               this._updateProgressAfterAnimation = true;
            }
         }
         if(isInvalid(INVALIDATE_DEBUFF) && this._isInited)
         {
            this.flare.gotoAndStop(!!this._isDebuff ? FRAME_DEBUFF : FRAME_NORMAL);
            if(this._isDebuff)
            {
               this._debuffAnimationActive = true;
               this.updateProgressBars();
               this.hpProgressDown.gotoAndStop(100 - progressValue);
               this.debuffProgress.visible = true;
               this.hpProgressDown.visible = true;
               this.hpProgress.visible = false;
               this.hpProgressDown.addFrameScript(FRAME_DOWN_END - 1,this.onChangeHpProgressBar);
               this.hpProgressDown.play();
               BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_PROGRESS_DEBUFF);
            }
            else
            {
               this._debuffAnimationActive = true;
               this.hpProgress.gotoAndStop(1);
               this.hpProgress.visible = true;
               this._curAnimationFrame = progressValue;
               _loc1_ = Math.max(0,this._curAnimationFrame - 1);
               this.hpProgress.addFrameScript(_loc1_,this.onHideDebuffProgressBar);
               this.hpProgress.play();
               this.flare.visible = false;
               BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_TIME_TICK_SHOW);
            }
         }
      }
      
      private function updateProgressBars() : void
      {
         this.hpProgress.gotoAndStop(progressValue);
         this.debuffProgress.gotoAndStop(progressValue);
      }
      
      private function onHideDebuffProgressBar() : void
      {
         this._debuffAnimationActive = false;
         this.hpProgress.addFrameScript(this._curAnimationFrame - 1,null);
         this.hpProgress.stop();
         this.debuffProgress.visible = false;
         this.flare.visible = true;
         if(this._updateProgressAfterAnimation)
         {
            this.updateProgressBars();
            this._updateProgressAfterAnimation = false;
         }
      }
      
      private function onChangeHpProgressBar() : void
      {
         this._debuffAnimationActive = false;
         this.hpProgressDown.addFrameScript(FRAME_DOWN_END - 1,null);
         this.hpProgressDown.visible = false;
         this.hpProgress.gotoAndStop(1);
         if(this._updateProgressAfterAnimation)
         {
            this.updateProgressBars();
            this._updateProgressAfterAnimation = false;
         }
      }
      
      public function set isDebuff(param1:Boolean) : void
      {
         if(this._isDebuff == param1)
         {
            return;
         }
         if(!this._isInited)
         {
            this._isInited = true;
         }
         this._isDebuff = param1;
         invalidate(INVALIDATE_DEBUFF);
      }
   }
}
