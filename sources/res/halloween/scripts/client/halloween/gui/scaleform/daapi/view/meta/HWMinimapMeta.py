from gui.Scaleform.daapi.view.battle.classic.minimap import ClassicMinimapComponent

class HWMinimapMeta(ClassicMinimapComponent):

    def as_setZoomModeS(self, mode):
        if self._isDAAPIInited():
            return self.flashObject.as_setZoomMode(mode)

    def as_setMapDimensionsS(self, widthPx, heightPx):
        if self._isDAAPIInited():
            return self.flashObject.as_setMapDimensions(widthPx, heightPx)