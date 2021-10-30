from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class FreeSheetPopoverMeta(SmartPopOverView):

    def onTaskClick(self, idx):
        self._printOverrideError('onTaskClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setListDataProviderS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setListDataProvider(data)