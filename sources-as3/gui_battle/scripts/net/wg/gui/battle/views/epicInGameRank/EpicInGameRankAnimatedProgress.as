package net.wg.gui.battle.views.epicInGameRank
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.epicInGameRank.events.EpicInGameRankEvent;
   
   public class EpicInGameRankAnimatedProgress extends BattleUIComponent
   {
      
      private static const PROGRESS_ANIMATION_END_FRAME:Number = 180;
      
      private static const END_FRAME_SCRIPT_OFFSET:int = 2;
       
      
      public var rankXPSlow:MovieClip = null;
      
      public var rankXPFast:MovieClip = null;
      
      public var background:MovieClip = null;
      
      public function EpicInGameRankAnimatedProgress()
      {
         super();
         this.rankXPSlow.addFrameScript(PROGRESS_ANIMATION_END_FRAME - END_FRAME_SCRIPT_OFFSET,this.onLevelUpFrameReached);
      }
      
      override protected function onDispose() : void
      {
         this.rankXPSlow.addFrameScript(PROGRESS_ANIMATION_END_FRAME - END_FRAME_SCRIPT_OFFSET,null);
         removeEventListener(Event.ENTER_FRAME,this.onProgressAnimationEnterFrameHandler);
         this.rankXPFast = null;
         this.rankXPSlow.stop();
         this.rankXPSlow = null;
         this.background = null;
         super.onDispose();
      }
      
      public function updateProgressAnimation(param1:Number, param2:Number) : void
      {
         this.rankXPFast.gotoAndStop(param2 * PROGRESS_ANIMATION_END_FRAME >> 0);
         this.rankXPSlow.gotoAndStop(param1 * PROGRESS_ANIMATION_END_FRAME >> 0);
         this.rankXPSlow.play();
         addEventListener(Event.ENTER_FRAME,this.onProgressAnimationEnterFrameHandler);
      }
      
      public function updateProgressCircleVisibility(param1:Boolean) : void
      {
         this.rankXPSlow.visible = param1;
         this.rankXPFast.visible = param1;
         this.background.visible = param1;
      }
      
      private function onLevelUpFrameReached() : void
      {
         dispatchEvent(new EpicInGameRankEvent(EpicInGameRankEvent.LEVEL_UP_ANIMATION_COMPLETE));
      }
      
      private function onProgressAnimationEnterFrameHandler(param1:Event) : void
      {
         if(this.rankXPSlow.currentFrame == this.rankXPFast.currentFrame || this.rankXPSlow.currentFrame > this.rankXPFast.currentFrame)
         {
            this.rankXPSlow.stop();
            removeEventListener(Event.ENTER_FRAME,this.onProgressAnimationEnterFrameHandler);
         }
      }
   }
}
