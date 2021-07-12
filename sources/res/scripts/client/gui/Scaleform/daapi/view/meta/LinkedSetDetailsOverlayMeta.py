from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class LinkedSetDetailsOverlayMeta(BaseDAAPIComponent):

    def startClick(self, eventID):
        self._printOverrideError('startClick')

    def setPage(self, pageID):
        self._printOverrideError('setPage')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setDataVideoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDataVideo(data)

    def as_setColorPagesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorPages(data)

    def as_setPageS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_setPage(index)