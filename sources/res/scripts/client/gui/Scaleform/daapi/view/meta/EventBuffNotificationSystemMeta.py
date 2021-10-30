from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBuffNotificationSystemMeta(BaseDAAPIComponent):

    def as_showBuffNotificationS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showBuffNotification(data)

    def as_hideBuffNotificationS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideBuffNotification()