from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MissionsViewBaseMeta(BaseDAAPIComponent):

    def dummyClicked(self, clickType):
        self._printOverrideError('dummyClicked')

    def as_showDummyS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showDummy(data)

    def as_hideDummyS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideDummy()

    def as_setWaitingVisibleS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setWaitingVisible(visible)

    def as_setBackgroundS(self, source):
        if self._isDAAPIInited():
            return self.flashObject.as_setBackground(source)