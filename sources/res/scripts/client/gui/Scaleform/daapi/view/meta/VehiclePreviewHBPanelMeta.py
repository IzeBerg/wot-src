from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewHBPanelMeta(BaseDAAPIComponent):

    def onAcceptClicked(self):
        self._printOverrideError('onAcceptClicked')

    def onSecondaryClicked(self):
        self._printOverrideError('onSecondaryClicked')

    def showTooltip(self, intCD, itemType):
        self._printOverrideError('showTooltip')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)