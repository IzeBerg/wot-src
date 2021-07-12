from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SessionStatsSettingsMeta(BaseDAAPIComponent):

    def onClickApplyBtn(self):
        self._printOverrideError('onClickApplyBtn')

    def onClickBackBtn(self):
        self._printOverrideError('onClickBackBtn')

    def onClickResetBtn(self):
        self._printOverrideError('onClickResetBtn')

    def onSettingsInputChanged(self, identifier, value):
        self._printOverrideError('onSettingsInputChanged')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setControlsStateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setControlsState(data)

    def as_setBattleSettingsStatusS(self, value, showWarning):
        if self._isDAAPIInited():
            return self.flashObject.as_setBattleSettingsStatus(value, showWarning)