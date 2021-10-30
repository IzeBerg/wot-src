from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PaginationMeta(BaseDAAPIComponent):

    def showPage(self, dir):
        self._printOverrideError('showPage')

    def as_setPageS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPage(value)

    def as_setEnabledS(self, leftEnabled, rightEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(leftEnabled, rightEnabled)