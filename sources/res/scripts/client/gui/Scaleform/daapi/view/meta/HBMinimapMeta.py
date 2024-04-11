from gui.Scaleform.daapi.view.battle.classic.minimap import ClassicMinimapComponent

class HBMinimapMeta(ClassicMinimapComponent):

    def onZoomModeChanged(self, change):
        self._printOverrideError('onZoomModeChanged')

    def as_setZoomModeS(self, mode, modeText):
        if self._isDAAPIInited():
            return self.flashObject.as_setZoomMode(mode, modeText)

    def as_setMapDimensionsS(self, widthPx, heightPx):
        if self._isDAAPIInited():
            return self.flashObject.as_setMapDimensions(widthPx, heightPx)

    def as_updateSectorStateStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSectorStateStats(data)