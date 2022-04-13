from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehicleSelectionMeta(BaseDAAPIComponent):

    def setSelectionParams(self, topX, topY, bottomX, bottomY, finish):
        self._printOverrideError('setSelectionParams')

    def handleRightMouseBtn(self):
        self._printOverrideError('handleRightMouseBtn')

    def handleMouseOverUI(self, isOverUI):
        self._printOverrideError('handleMouseOverUI')

    def handleMouseWheel(self, delta):
        self._printOverrideError('handleMouseWheel')

    def as_setEnabledS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(enabled)