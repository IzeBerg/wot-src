from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class EpicBattlesInfoViewMeta(WrapperViewMeta):

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onManageAbilitiesBtnClick(self):
        self._printOverrideError('onManageAbilitiesBtnClick')

    def onPrestigeBtnClick(self):
        self._printOverrideError('onPrestigeBtnClick')

    def onGameRewardsBtnClick(self):
        self._printOverrideError('onGameRewardsBtnClick')

    def onInfoBtnClick(self):
        self._printOverrideError('onInfoBtnClick')

    def onShowRewardVehicleInGarageBtnClick(self):
        self._printOverrideError('onShowRewardVehicleInGarageBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_showInfoLinesS(self, show):
        if self._isDAAPIInited():
            return self.flashObject.as_showInfoLines(show)

    def as_showFinalRewardClaimedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showFinalRewardClaimed()