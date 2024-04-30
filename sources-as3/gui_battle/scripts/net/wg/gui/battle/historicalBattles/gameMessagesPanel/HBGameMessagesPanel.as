package net.wg.gui.battle.historicalBattles.gameMessagesPanel
{
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.data.constants.generated.HB_GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.historicalBattles.gameMessagesPanel.components.ObjectiveGameMessage;
   import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
   
   public class HBGameMessagesPanel extends GameMessagesPanel
   {
       
      
      public function HBGameMessagesPanel()
      {
         super();
      }
      
      override protected function initMappingDict() : void
      {
         super.initMappingDict();
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED] = HB_GAME_MESSAGES_CONSTS.BASE_CAPTURED_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE] = HB_GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE_LINKAGE;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED] = ObjectiveGameMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE] = ObjectiveGameMessage;
      }
   }
}
