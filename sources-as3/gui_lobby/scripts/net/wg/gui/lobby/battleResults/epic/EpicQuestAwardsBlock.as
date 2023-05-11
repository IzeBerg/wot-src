package net.wg.gui.lobby.battleResults.epic
{
   import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
   
   public class EpicQuestAwardsBlock extends QuestAwardsBlock
   {
      
      private static const AWARDS_BLOCK_HEIGHT:int = 75;
       
      
      public function EpicQuestAwardsBlock()
      {
         super();
      }
      
      override protected function get defaultHeight() : Number
      {
         return AWARDS_BLOCK_HEIGHT;
      }
   }
}
