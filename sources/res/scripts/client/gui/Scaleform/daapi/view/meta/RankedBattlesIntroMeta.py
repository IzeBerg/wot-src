from gui.Scaleform.framework.entities.View import View

class RankedBattlesIntroMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onAcceptClick(self):
        self._printOverrideError('onAcceptClick')

    def onDetailedClick(self):
        self._printOverrideError('onDetailedClick')

    def onPlayVideoClick(self):
        self._printOverrideError('onPlayVideoClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setAlertMessageBlockDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setAlertMessageBlockData(data)

    def as_setBeforeSeasonBlockDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBeforeSeasonBlockData(data)