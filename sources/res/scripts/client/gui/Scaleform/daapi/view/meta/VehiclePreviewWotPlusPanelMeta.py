from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewWotPlusPanelMeta(BaseDAAPIComponent):

    def onRentClick(self):
        self._printOverrideError('onRentClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)