package net.wg.gui.lobby.questsWindow.components
{
   public class EpicQuestTextAwardBlock extends QuestTextAwardBlock
   {
      
      private static const DOTS:String = "...";
      
      private static const MAX_LINE_NUMBER:uint = 3;
       
      
      public function EpicQuestTextAwardBlock()
      {
         super();
      }
      
      override protected function get fixedMode() : Boolean
      {
         return true;
      }
      
      override protected function get lineLimit() : int
      {
         return MAX_LINE_NUMBER;
      }
      
      override protected function get lineEnd() : String
      {
         return DOTS;
      }
   }
}
