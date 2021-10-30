from gui.Scaleform.framework.entities.View import View

class EventStylesShopTabMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def onTankClick(self, index):
        self._printOverrideError('onTankClick')

    def onBannerClick(self, index):
        self._printOverrideError('onBannerClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)