from gui.Scaleform.framework.entities.View import View

class EventBattleResultScreenMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def playSliderSound(self):
        self._printOverrideError('playSliderSound')

    def playPointsSound(self):
        self._printOverrideError('playPointsSound')

    def playQuestSound(self):
        self._printOverrideError('playQuestSound')

    def playRewardSound(self):
        self._printOverrideError('playRewardSound')

    def playProgressBarSound(self):
        self._printOverrideError('playProgressBarSound')

    def addToSquad(self, databaseID):
        self._printOverrideError('addToSquad')

    def addToFriend(self, databaseID, userName):
        self._printOverrideError('addToFriend')

    def as_setVictoryDataS(self, data, canInvite, friends):
        if self._isDAAPIInited():
            return self.flashObject.as_setVictoryData(data, canInvite, friends)

    def as_playAnimationS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_playAnimation()

    def as_addToSquadResultS(self, result, databaseID):
        if self._isDAAPIInited():
            return self.flashObject.as_addToSquadResult(result, databaseID)

    def as_addToFriendResultS(self, databaseID, isFriend, isPending):
        if self._isDAAPIInited():
            return self.flashObject.as_addToFriendResult(databaseID, isFriend, isPending)