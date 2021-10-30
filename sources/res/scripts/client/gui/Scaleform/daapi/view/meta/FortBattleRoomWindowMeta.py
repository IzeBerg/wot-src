from gui.Scaleform.daapi.view.lobby.rally.RallyMainWindowWithSearch import RallyMainWindowWithSearch

class FortBattleRoomWindowMeta(RallyMainWindowWithSearch):

    def onBrowseClanBattles(self):
        self._printOverrideError('onBrowseClanBattles')

    def onJoinClanBattle(self, rallyId, slotIndex, peripheryId):
        self._printOverrideError('onJoinClanBattle')

    def onCreatedBattleRoom(self, battleID, peripheryId):
        self._printOverrideError('onCreatedBattleRoom')

    def refresh(self):
        self._printOverrideError('refresh')

    def as_setWindowTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setWindowTitle(value)

    def as_setWaitingS(self, visible, message):
        if self._isDAAPIInited():
            return self.flashObject.as_setWaiting(visible, message)

    def as_setInfoS(self, visible, message, buttonLabel):
        if self._isDAAPIInited():
            return self.flashObject.as_setInfo(visible, message, buttonLabel)