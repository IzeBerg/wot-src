package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   
   public class AnimationItemFailed extends AnimationItem
   {
       
      
      public function AnimationItemFailed()
      {
         super();
      }
      
      override protected function getValueColor() : uint
      {
         return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_FAILD_VALUE;
      }
      
      override protected function getAnimStatusType() : String
      {
         return QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_FAILD;
      }
   }
}
