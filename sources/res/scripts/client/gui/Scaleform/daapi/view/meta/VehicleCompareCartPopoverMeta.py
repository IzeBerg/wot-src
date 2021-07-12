from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class VehicleCompareCartPopoverMeta(SmartPopOverView):

    def remove(self, id):
        self._printOverrideError('remove')

    def removeAll(self):
        self._printOverrideError('removeAll')

    def gotoCompareView(self):
        self._printOverrideError('gotoCompareView')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_getDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDP()

    def as_updateToCmpBtnPropsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateToCmpBtnProps(data)

    def as_updateClearBtnPropsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateClearBtnProps(data)