from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HangarHeaderMeta(BaseDAAPIComponent):

    def onQuestBtnClick(self, questType, questID):
        self._printOverrideError('onQuestBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_createBattlePassS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createBattlePass()

    def as_removeBattlePassS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBattlePass()

    def as_createRankedBattlesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createRankedBattles()

    def as_removeRankedBattlesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeRankedBattles()

    def as_createBattleRoyaleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createBattleRoyale()

    def as_removeBattleRoyaleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBattleRoyale()

    def as_createBattleRoyaleTournamentS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createBattleRoyaleTournament()

    def as_removeBattleRoyaleTournamentS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBattleRoyaleTournament()

    def as_createEpicWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createEpicWidget()

    def as_removeEpicWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeEpicWidget()

    def as_setSecondaryEntryPointVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSecondaryEntryPointVisible(value)

    def as_setResourceWellEntryPointS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setResourceWellEntryPoint(value)

    def as_setBattleMattersEntryPointS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBattleMattersEntryPoint(value)

    def as_createEventWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createEventWidget()

    def as_removeEventWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeEventWidget()