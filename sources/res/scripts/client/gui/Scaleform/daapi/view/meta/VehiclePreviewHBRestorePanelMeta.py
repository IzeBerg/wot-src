from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewHBRestorePanelMeta(BaseDAAPIComponent):

    def onBuyClick(self):
        self._printOverrideError('onBuyClick')

    def as_setBuyDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBuyData(data)