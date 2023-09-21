from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MinimapMeta(BaseDAAPIComponent):

    def onMinimapClicked(self, x, y, buttonIdx, mapScaleIndex):
        self._printOverrideError('onMinimapClicked')

    def applyNewSize(self, sizeIndex):
        self._printOverrideError('applyNewSize')

    def as_setSizeS(self, size):
        if self._isDAAPIInited():
            return self.flashObject.as_setSize(size)

    def as_setVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(isVisible)

    def as_setAlphaS(self, alpha):
        if self._isDAAPIInited():
            return self.flashObject.as_setAlpha(alpha)

    def as_showVehiclesNameS(self, visibility):
        if self._isDAAPIInited():
            return self.flashObject.as_showVehiclesName(visibility)

    def as_setBackgroundS(self, path):
        if self._isDAAPIInited():
            return self.flashObject.as_setBackground(path)

    def as_enableHintPanelWithDataS(self, isStrategicArtyView, isSPG):
        if self._isDAAPIInited():
            return self.flashObject.as_enableHintPanelWithData(isStrategicArtyView, isSPG)

    def as_disableHintPanelS(self, instantHide):
        if self._isDAAPIInited():
            return self.flashObject.as_disableHintPanel(instantHide)

    def as_updateHintPanelDataS(self, isStrategicArtyView, isSPG):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHintPanelData(isStrategicArtyView, isSPG)

    def as_initPrebattleSizeS(self, preferableSize):
        if self._isDAAPIInited():
            return self.flashObject.as_initPrebattleSize(preferableSize)

    def as_setScenarioEventS(self, id, path, type):
        if self._isDAAPIInited():
            return self.flashObject.as_setScenarioEvent(id, path, type)

    def as_setScenarioEventVisibleS(self, id, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setScenarioEventVisible(id, visible)

    def as_clearScenarioEventS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_clearScenarioEvent(id)