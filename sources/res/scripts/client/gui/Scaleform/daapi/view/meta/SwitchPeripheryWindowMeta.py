from gui.Scaleform.daapi.view.meta.SimpleWindowMeta import SimpleWindowMeta

class SwitchPeripheryWindowMeta(SimpleWindowMeta):

    def requestForChange(self, id):
        self._printOverrideError('requestForChange')

    def onDropDownOpened(self, opened):
        self._printOverrideError('onDropDownOpened')

    def as_setServerParamsS(self, label, showDropDown):
        if self._isDAAPIInited():
            return self.flashObject.as_setServerParams(label, showDropDown)

    def as_setSelectedIndexS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedIndex(index)

    def as_getServersDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getServersDP()