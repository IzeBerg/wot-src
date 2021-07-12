from gui.Scaleform.framework.entities.View import View

class BattleRoyaleVehicleInfoMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onShowIntro(self):
        self._printOverrideError('onShowIntro')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setTabsDataS(self, tabsData):
        if self._isDAAPIInited():
            return self.flashObject.as_setTabsData(tabsData)