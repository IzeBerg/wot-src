from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class BattleResultsMeta(AbstractWindowView):

    def saveSorting(self, iconType, sortDirection, bonusType):
        self._printOverrideError('saveSorting')

    def showEventsWindow(self, questID, eventType):
        self._printOverrideError('showEventsWindow')

    def getClanEmblem(self, uid, clanID):
        self._printOverrideError('getClanEmblem')

    def onResultsSharingBtnPress(self):
        self._printOverrideError('onResultsSharingBtnPress')

    def showUnlockWindow(self, itemId, unlockType):
        self._printOverrideError('showUnlockWindow')

    def showProgressiveRewardView(self):
        self._printOverrideError('showProgressiveRewardView')

    def onAppliedPremiumBonus(self):
        self._printOverrideError('onAppliedPremiumBonus')

    def onShowDetailsPremium(self):
        self._printOverrideError('onShowDetailsPremium')

    def onShowDetailsWotPlus(self):
        self._printOverrideError('onShowDetailsWotPlus')

    def onShowManageableXPScreen(self):
        self._printOverrideError('onShowManageableXPScreen')

    def showDogTagWindow(self, componentId):
        self._printOverrideError('showDogTagWindow')

    def showVehicleStats(self, vehCD):
        self._printOverrideError('showVehicleStats')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setClanEmblemS(self, uid, iconTag):
        if self._isDAAPIInited():
            return self.flashObject.as_setClanEmblem(uid, iconTag)

    def as_setTeamInfoS(self, uid, iconTag, teamName):
        if self._isDAAPIInited():
            return self.flashObject.as_setTeamInfo(uid, iconTag, teamName)

    def as_setIsInBattleQueueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsInBattleQueue(value)