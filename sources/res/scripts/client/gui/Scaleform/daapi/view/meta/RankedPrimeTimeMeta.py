from gui.Scaleform.daapi.view.lobby.prime_time_view_base import PrimeTimeViewBase

class RankedPrimeTimeMeta(PrimeTimeViewBase):

    def as_setHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderData(data)

    def as_setBackgroundSourceS(self, source):
        if self._isDAAPIInited():
            return self.flashObject.as_setBackgroundSource(source)