package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   
   public class AnimationItemProgress extends AnimationItem
   {
       
      
      public var progress:AnimStepProgress = null;
      
      public function AnimationItemProgress()
      {
         super();
      }
      
      override public function setProgressPrc(param1:int) : void
      {
         super.setProgressPrc(param1);
         this.progress.setProgress(param1);
      }
      
      override protected function onDispose() : void
      {
         this.progress.dispose();
         this.progress = null;
         super.onDispose();
      }
      
      override protected function getValueColor() : uint
      {
         return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS_VALUE;
      }
      
      override protected function getAnimStatusType() : String
      {
         return QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS;
      }
   }
}
