package net.wg.gui.battle.views.questProgress.helper
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   
   public class BattleQuestProgressConsts
   {
       
      
      public function BattleQuestProgressConsts()
      {
         super();
      }
      
      public static function getChartAnimItem(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_COMPLETED:
               return getAnimCompleted(param2);
            case QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_FAILD:
               return getAnimFailed(param2);
            case QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS:
               return getAnimProgress(param2);
            default:
               App.utils.asserter.assert(false,"Anim linkage for animState:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getAnimCompleted(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_RADIAL_COMPLETED;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_HEXAGON_COMPLETED;
            default:
               App.utils.asserter.assert(false,"Completed anim linkage for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getAnimFailed(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_RADIAL_FAILED;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_HEXAGON_FAILED;
            default:
               App.utils.asserter.assert(false,"Failed anim linkage for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getAnimProgress(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_RADIAL_PROGRESS;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BATTLE.QP_ANIM_HEXAGON_PROGRESS;
            default:
               App.utils.asserter.assert(false,"Progress anim linkage for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
   }
}
