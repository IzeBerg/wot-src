from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class EpicBattlesOfflineViewMeta(WrapperViewMeta):

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onAboutButtonClick(self):
        self._printOverrideError('onAboutButtonClick')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)