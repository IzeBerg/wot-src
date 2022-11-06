from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class VehicleSellConfirmationPopoverMeta(SmartPopOverView):

    def confirmTradeIn(self):
        self._printOverrideError('confirmTradeIn')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)