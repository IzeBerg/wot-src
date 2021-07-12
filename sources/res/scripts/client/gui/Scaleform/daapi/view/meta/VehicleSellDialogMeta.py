from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class VehicleSellDialogMeta(AbstractWindowView):

    def setDialogSettings(self, isOpen):
        self._printOverrideError('setDialogSettings')

    def sell(self):
        self._printOverrideError('sell')

    def setUserInput(self, value):
        self._printOverrideError('setUserInput')

    def setCrewDismissal(self, value):
        self._printOverrideError('setCrewDismissal')

    def onSelectionChanged(self, itemID, toInventory, currency):
        self._printOverrideError('onSelectionChanged')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_visibleControlBlockS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_visibleControlBlock(value)

    def as_enableButtonS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_enableButton(value)

    def as_setControlQuestionDataS(self, isGold, value, question):
        if self._isDAAPIInited():
            return self.flashObject.as_setControlQuestionData(isGold, value, question)

    def as_setTotalS(self, common, total):
        if self._isDAAPIInited():
            return self.flashObject.as_setTotal(common, total)

    def as_updateAccountMoneyS(self, currency, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAccountMoney(currency, value)