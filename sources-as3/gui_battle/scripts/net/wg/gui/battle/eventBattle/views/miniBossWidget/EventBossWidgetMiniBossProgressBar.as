package net.wg.gui.battle.eventBattle.views.miniBossWidget
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.eventBattle.views.bossWidget.EventProgressBar;
   
   public class EventBossWidgetMiniBossProgressBar extends EventProgressBar
   {
      
      public static const FRAME_LABEL_ALLY:String = "ally";
      
      public static const FRAME_LABEL_ENEMY:String = "enemy";
      
      public static const FRAME_LABEL_DESTROYED:String = "destroyed";
       
      
      public var tankIconMc:MovieClip = null;
      
      public var bgGlowMc:MovieClip = null;
      
      public var healthProgress:MovieClip = null;
      
      public var flare:MovieClip = null;
      
      public var hpMax:Number = 0;
      
      public var hpCurrent:Number = 0;
      
      public var isEnemy:Boolean = false;
      
      public function EventBossWidgetMiniBossProgressBar()
      {
         super();
         this.healthProgress.visible = true;
      }
      
      override protected function onDispose() : void
      {
         this.healthProgress = null;
         this.tankIconMc = null;
         this.bgGlowMc = null;
         this.flare = null;
         super.onDispose();
      }
      
      public function updateData(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.visible = true;
         this.hpMax = param2;
         this.hpCurrent = param1;
         this.isEnemy = param3;
         this.value = EventProgressBar.getProgress(param2,param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateProgressBars();
         }
      }
      
      public function updateProgressBars() : void
      {
         this.healthProgress.gotoAndStop(progressValue);
         var _loc1_:Boolean = this.hpCurrent > 0;
         var _loc2_:String = FRAME_LABEL_DESTROYED;
         this.flare.visible = _loc1_;
         this.healthProgress.visible = _loc1_;
         this.bgGlowMc.visible = _loc1_;
         if(_loc1_)
         {
            _loc2_ = !!this.isEnemy ? FRAME_LABEL_ENEMY : FRAME_LABEL_ALLY;
            this.flare.gotoAndStop(_loc2_);
            this.healthProgress.progressBarMc.gotoAndStop(_loc2_);
            this.bgGlowMc.gotoAndStop(_loc2_);
         }
         this.tankIconMc.gotoAndStop(_loc2_);
      }
   }
}
