from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBanInfoMeta(BaseDAAPIComponent):

    def as_setEventBanInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setEventBanInfo(data)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)