from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class ConfirmExchangeDialogMeta(AbstractWindowView):

    def exchange(self, goldValue):
        self._printOverrideError('exchange')

    def onSelectedAmountChanged(self, goldValue, needItemsValue):
        self._printOverrideError('onSelectedAmountChanged')

    def openDiscountInfoPage(self):
        self._printOverrideError('openDiscountInfoPage')

    def as_updateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_update(data)

    def as_setExchangeValuesS(self, goldValue, needItemsValue, discountsAmountApplied):
        if self._isDAAPIInited():
            return self.flashObject.as_setExchangeValues(goldValue, needItemsValue, discountsAmountApplied)