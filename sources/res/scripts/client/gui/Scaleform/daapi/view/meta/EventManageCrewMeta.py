from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventManageCrewMeta(BaseDAAPIComponent):

    def onApply(self):
        self._printOverrideError('onApply')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)