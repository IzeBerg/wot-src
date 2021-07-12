from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class EpicBattlesPrestigeViewMeta(WrapperViewMeta):

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def onResetBtnClick(self):
        self._printOverrideError('onResetBtnClick')

    def onBackBtnClick(self):
        self._printOverrideError('onBackBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_showSuccessfullPrestigeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showSuccessfullPrestige()