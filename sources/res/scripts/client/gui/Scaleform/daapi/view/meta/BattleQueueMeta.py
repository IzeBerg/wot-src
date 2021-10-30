from gui.Scaleform.daapi.view.meta.BaseBattleQueueMeta import BaseBattleQueueMeta

class BattleQueueMeta(BaseBattleQueueMeta):

    def startClick(self):
        self._printOverrideError('startClick')

    def as_setTypeInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTypeInfo(data)

    def as_setPlayersS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayers(text)

    def as_setDPS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_setDP(dataProvider)

    def as_showStartS(self, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_showStart(vis)