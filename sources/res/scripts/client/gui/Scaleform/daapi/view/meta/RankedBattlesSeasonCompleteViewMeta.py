from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class RankedBattlesSeasonCompleteViewMeta(WrapperViewMeta):

    def showRating(self):
        self._printOverrideError('showRating')

    def closeView(self):
        self._printOverrideError('closeView')

    def onSoundTrigger(self, soundName):
        self._printOverrideError('onSoundTrigger')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setPlaceS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlace(value)

    def as_setAwardsDataS(self, awardsData):
        if self._isDAAPIInited():
            return self.flashObject.as_setAwardsData(awardsData)