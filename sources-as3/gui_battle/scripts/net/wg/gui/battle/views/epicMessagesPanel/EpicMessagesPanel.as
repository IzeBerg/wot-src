package net.wg.gui.battle.views.epicMessagesPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.epicMessagesPanel.components.BaseCaptureMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.BaseContestedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.FirstGeneralRankReachedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.HeadquarterAttackedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.HeadquarterDestroyedMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.OverTimeMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.RankUpMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.RetreatMessage;
   import net.wg.gui.battle.views.epicMessagesPanel.components.TimeRemainingMessage;
   import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
   import net.wg.infrastructure.base.meta.IGameMessagesPanelMeta;
   
   public class EpicMessagesPanel extends GameMessagesPanel implements IGameMessagesPanelMeta
   {
       
      
      public function EpicMessagesPanel()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override protected function initMappingDict() : void
      {
         super.initMappingDict();
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.TIME_REMAINING] = Linkages.TIME_REMAINING_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.TIME_REMAINING_POSITIVE] = Linkages.TIME_REMAINING_POSITIVE_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.OVERTIME] = Linkages.OVER_TIME_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE] = Linkages.BASE_CAPTURED_POSITIVE_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED] = Linkages.BASE_CAPTURED_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CONTESTED_POSITIVE] = Linkages.BASE_CONTESTED_POSITIVE_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.BASE_CONTESTED] = Linkages.BASE_CONTESTED_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.RANK_UP] = Linkages.RANK_UP_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED_POSITIVE] = Linkages.OBJECTIVE_DESTROYED_POSITIVE_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED] = Linkages.OBJECTIVE_DESTROYED_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.RETREAT] = Linkages.RETREAT_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK_POSITIVE] = Linkages.OBJECTIVE_UNDER_ATTACK_POSITIVE_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK] = Linkages.OBJECTIVE_UNDER_ATTACK_UI_LINKAGE;
         msgLinkageTypeDict[GAME_MESSAGES_CONSTS.GENERAL_RANK_REACHED] = Linkages.FIRST_GENERAL_RANK_REACHED_UI_LINKAGE;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.TIME_REMAINING] = TimeRemainingMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.TIME_REMAINING_POSITIVE] = TimeRemainingMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.OVERTIME] = OverTimeMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED_POSITIVE] = BaseCaptureMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CAPTURED] = BaseCaptureMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CONTESTED_POSITIVE] = BaseContestedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.BASE_CONTESTED] = BaseContestedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.RANK_UP] = RankUpMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED_POSITIVE] = HeadquarterDestroyedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_DESTROYED] = HeadquarterDestroyedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.RETREAT] = RetreatMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK_POSITIVE] = HeadquarterAttackedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.OBJECTIVE_UNDER_ATTACK] = HeadquarterAttackedMessage;
         msgClassTypeDict[GAME_MESSAGES_CONSTS.GENERAL_RANK_REACHED] = FirstGeneralRankReachedMessage;
      }
   }
}
