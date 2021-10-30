from gui.Scaleform.framework.entities.View import View

class EventShopTabMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def onItemsBannerClick(self):
        self._printOverrideError('onItemsBannerClick')

    def onMainBannerClick(self):
        self._printOverrideError('onMainBannerClick')

    def onPackBannerClick(self, id):
        self._printOverrideError('onPackBannerClick')

    def as_setPackBannersDataS(self, dataPack1, dataPack2):
        if self._isDAAPIInited():
            return self.flashObject.as_setPackBannersData(dataPack1, dataPack2)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)

    def as_setExpireDateS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setExpireDate(value)