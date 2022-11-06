from gui.Scaleform.daapi.view.meta.EpicQuestProgressInfoMeta import EpicQuestProgressInfoMeta
from gui.shared import g_eventBus, events
from helpers import dependency
from skeletons.gui.battle_results import IBattleResultsService

class EpicQuestProgressView(EpicQuestProgressInfoMeta):
    __slots__ = ()
    _battleResults = dependency.descriptor(IBattleResultsService)

    def showQuestById(self, questId, eventType):
        g_eventBus.handleEvent(events.LobbySimpleEvent(events.LobbySimpleEvent.BATTLE_RESULTS_SHOW_QUEST, ctx={'questId': questId, 
           'eventType': eventType}))

    def updateQuestsInfo(self, arenaUniqueID):
        battleResultsVO = self._getQuestVO(arenaUniqueID)
        if not battleResultsVO:
            return
        quests = []
        quests.extend(battleResultsVO.get('battlePass', []))
        quests.extend(battleResultsVO.get('quests', []))
        questsArray = []
        for quest in quests:
            questInfo = quest['questInfo']
            questModel = {'id': questInfo['questID'], 
               'eventType': questInfo['eventType'], 
               'name': quest.get('title', '') or questInfo.get('description', ''), 
               'progressList': quest['progressList'], 
               'status': questInfo['status'], 
               'statusTooltip': questInfo.get('statusTooltip', '')}
            rewards = self.__getRewards(quest)
            if rewards:
                questModel['rewards'] = [
                 {'linkage': 'EpicQuestTextAwardBlockUI', 
                    'items': [
                            (', ').join(rewards)]}]
            questsArray.append(questModel)

        self.as_updateDataS(questsArray)

    def _getQuestVO(self, arenaUniqueID):
        return self._battleResults.getResultsVO(arenaUniqueID)

    @staticmethod
    def __getRewards(quest):
        awards = quest.get('awards', [])
        if not awards:
            return []
        return [ item for award in awards for item in award.get('items', []) ]