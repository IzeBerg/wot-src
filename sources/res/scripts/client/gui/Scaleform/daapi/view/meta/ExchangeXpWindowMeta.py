from gui.Scaleform.daapi.view.lobby.exchange.BaseExchangeWindow import BaseExchangeWindow

class ExchangeXpWindowMeta(BaseExchangeWindow):

    def getSubmitButtonEnableState(self, selectedXPCount):
        self._printOverrideError('getSubmitButtonEnableState')

    def as_vehiclesDataChangedS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_vehiclesDataChanged(data)

    def as_totalExperienceChangedS(self, totalXP):
        if self._isDAAPIInited():
            return self.flashObject.as_totalExperienceChanged(totalXP)

    def as_setWalletStatusS(self, walletStatus, enableSubmitButton):
        if self._isDAAPIInited():
            return self.flashObject.as_setWalletStatus(walletStatus, enableSubmitButton)

    def as_setTargetXPS(self, targetXP):
        if self._isDAAPIInited():
            return self.flashObject.as_setTargetXP(targetXP)