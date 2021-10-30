from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SessionVehicleStatsViewMeta(BaseDAAPIComponent):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)