from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class GraphicsOptimizationManagerMeta(BaseDAAPIComponent):

    def registerOptimizationArea(self, x, y, width, height):
        self._printOverrideError('registerOptimizationArea')

    def unregisterOptimizationArea(self, optimizationID):
        self._printOverrideError('unregisterOptimizationArea')

    def updateOptimizationArea(self, optimizationID, x, y, width, height):
        self._printOverrideError('updateOptimizationArea')

    def isOptimizationAvailable(self, alias):
        self._printOverrideError('isOptimizationAvailable')

    def isOptimizationEnabled(self, alias):
        self._printOverrideError('isOptimizationEnabled')

    def switchOptimizationEnabled(self, value):
        self._printOverrideError('switchOptimizationEnabled')

    def as_invalidateRectanglesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_invalidateRectangles()

    def as_switchOptimizationEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_switchOptimizationEnabled(value)