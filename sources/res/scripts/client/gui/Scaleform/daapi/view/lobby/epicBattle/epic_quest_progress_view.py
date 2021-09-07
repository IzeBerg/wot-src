from gui.Scaleform.daapi.view.meta.EpicQuestProgressInfoMeta import EpicQuestProgressInfoMeta
from gui.shared import g_eventBus, events
from helpers import dependency
from skeletons.gui.battle_results import IBattleResultsService

class EpicQuestProgressView(EpicQuestProgressInfoMeta):
    __slots__ = ()
    __battleResults = dependency.descriptor(IBattleResultsService)

    def showQuestById(self, questId, eventType):
        g_eventBus.handleEvent(events.LobbySimpleEvent(events.LobbySimpleEvent.BATTLE_RESULTS_SHOW_QUEST, ctx={'questId': questId, 
           'eventType': eventType}))

    def updateQuestsInfo(self, arenaUniqueID):
        battleResultsVO = self.__battleResults.getResultsVO(arenaUniqueID).get('battlePass')
        if not battleResultsVO:
            return
        questsArray = []
        for quest in battleResultsVO:
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

    @staticmethod
    def __getRewards(quest):
        awards = quest.get('awards', [])
        if not awards:
            return []
        return [ item for award in awards for item in award.get('items', []) ]