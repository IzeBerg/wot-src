from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RankedBattlesSeasonGapViewMeta(BaseDAAPIComponent):

    def onBtnClick(self):
        self._printOverrideError('onBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setEfficiencyDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setEfficiencyData(data)

    def as_setRatingDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRatingData(data)