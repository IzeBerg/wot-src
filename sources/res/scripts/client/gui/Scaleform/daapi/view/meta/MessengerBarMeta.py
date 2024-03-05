from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MessengerBarMeta(BaseDAAPIComponent):

    def channelButtonClick(self):
        self._printOverrideError('channelButtonClick')

    def referralButtonClick(self):
        self._printOverrideError('referralButtonClick')

    def sessionStatsButtonClick(self):
        self._printOverrideError('sessionStatsButtonClick')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setVehicleCompareCartButtonVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleCompareCartButtonVisible(value)

    def as_setReferralProgramButtonVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setReferralProgramButtonVisible(value)

    def as_setReferralProgramButtonTooltipS(self, tooltip, isSpecial):
        if self._isDAAPIInited():
            return self.flashObject.as_setReferralProgramButtonTooltip(tooltip, isSpecial)

    def as_setReferralButtonEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setReferralButtonEnabled(value)

    def as_enableReferralRecruterEffectS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_enableReferralRecruterEffect(value)

    def as_setReferralBtnCounterS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setReferralBtnCounter(value)

    def as_openVehicleCompareCartPopoverS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_openVehicleCompareCartPopover(value)

    def as_showAddVehicleCompareAnimS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showAddVehicleCompareAnim(data)

    def as_setSessionStatsButtonVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSessionStatsButtonVisible(value)

    def as_setSessionStatsButtonEnableS(self, value, tooltip):
        if self._isDAAPIInited():
            return self.flashObject.as_setSessionStatsButtonEnable(value, tooltip)

    def as_setSessionStatsButtonSettingsUpdateS(self, show, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSessionStatsButtonSettingsUpdate(show, value)