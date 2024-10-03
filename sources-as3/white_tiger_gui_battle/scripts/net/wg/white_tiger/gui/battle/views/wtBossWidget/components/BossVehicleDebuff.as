package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   
   public class BossVehicleDebuff extends BattleUIComponent
   {
      
      private static const PROGRESS_MULTIPLIER:uint = 3;
      
      private static const INVALIDATE_DEBUFF_TIME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      public var timerTF:TextField = null;
      
      public var outer:BattleAtlasSprite = null;
      
      public var debuffProgress:ProgressBar = null;
      
      public var idleAnimation:MovieClip = null;
      
      private var _debuffRemainingTime:Number = 0;
      
      private var _debuffTotalTime:Number = 0;
      
      private var _debuffTfTime:int = 0;
      
      public function BossVehicleDebuff()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.outer.imageName = BATTLEATLAS.WT_STROKE_DEBUFF;
         invalidate(INVALIDATE_DEBUFF_TIME);
      }
      
      override protected function onDispose() : void
      {
         this.debuffProgress.dispose();
         this.debuffProgress = null;
         this.timerTF = null;
         this.outer = null;
         this.idleAnimation = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(INVALIDATE_DEBUFF_TIME))
         {
            this.visible = this._debuffRemainingTime > 0;
            this.idleAnimationVisible = this.visible;
            if(this.visible)
            {
               _loc1_ = this._debuffRemainingTime | 0;
               this.debuffProgress.value = PROGRESS_MULTIPLIER * ProgressBar.getProgress(this._debuffTotalTime,this._debuffRemainingTime);
               if(this._debuffTfTime != _loc1_)
               {
                  BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_TIME_SHOW);
                  this._debuffTfTime = _loc1_;
                  this.timerTF.text = this._debuffTfTime.toString();
               }
            }
         }
      }
      
      public function updateDebuffTime(param1:Number, param2:Number) : void
      {
         this._debuffTotalTime = param1;
         this._debuffRemainingTime = param2;
         invalidate(INVALIDATE_DEBUFF_TIME);
      }
      
      private function set idleAnimationVisible(param1:Boolean) : void
      {
         this.idleAnimation.visible = param1;
         if(param1)
         {
            this.idleAnimation.play();
         }
         else
         {
            this.idleAnimation.stop();
         }
      }
   }
}
