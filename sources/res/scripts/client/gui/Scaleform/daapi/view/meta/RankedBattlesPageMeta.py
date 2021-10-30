from gui.Scaleform.framework.entities.View import View

class RankedBattlesPageMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onPageChanged(self, viewId):
        self._printOverrideError('onPageChanged')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderData(data)

    def as_setCountersS(self, countersData):
        if self._isDAAPIInited():
            return self.flashObject.as_setCounters(countersData)