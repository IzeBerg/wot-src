from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class CustomizationKitPopoverMeta(SmartPopOverView):

    def removeCustomizationKit(self):
        self._printOverrideError('removeCustomizationKit')

    def updateAutoProlongation(self):
        self._printOverrideError('updateAutoProlongation')

    def as_setHeaderS(self, title):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeader(title)

    def as_getDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDP()

    def as_showClearMessageS(self, isClear, message):
        if self._isDAAPIInited():
            return self.flashObject.as_showClearMessage(isClear, message)

    def as_setAutoProlongationCheckboxSelectedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoProlongationCheckboxSelected(value)

    def as_setAutoProlongationCheckboxEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoProlongationCheckboxEnabled(value)