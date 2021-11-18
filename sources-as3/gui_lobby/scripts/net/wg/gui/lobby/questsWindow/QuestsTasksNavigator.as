package net.wg.gui.lobby.questsWindow
{
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   
   public class QuestsTasksNavigator extends AbstractListSelectionNavigator
   {
       
      
      public function QuestsTasksNavigator()
      {
         super();
      }
      
      override protected function isSelectable(param1:int) : Boolean
      {
         var _loc2_:QuestRendererVO = QuestRendererVO(getItemByIndex(param1));
         return !_loc2_ || _loc2_.rendererType != QUESTS_ALIASES.RENDERER_TYPE_BLOCK_TITLE;
      }
   }
}
