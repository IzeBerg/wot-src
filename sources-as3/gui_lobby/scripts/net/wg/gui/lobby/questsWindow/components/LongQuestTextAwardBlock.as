package net.wg.gui.lobby.questsWindow.components
{
   public class LongQuestTextAwardBlock extends QuestTextAwardBlock
   {
       
      
      public function LongQuestTextAwardBlock()
      {
         super();
      }
      
      override protected function get fixedMode() : Boolean
      {
         return true;
      }
   }
}
