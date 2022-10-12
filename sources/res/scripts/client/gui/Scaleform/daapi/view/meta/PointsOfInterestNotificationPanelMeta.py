from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PointsOfInterestNotificationPanelMeta(BaseDAAPIComponent):

    def as_addPoiStatusS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_addPoiStatus(data)

    def as_updatePoiStatusS(self, id, status, isAlly):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePoiStatus(id, status, isAlly)

    def as_updatePoiProgressS(self, id, progress):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePoiProgress(id, progress)

    def as_addNotificationS(self, id, isAlly, message):
        if self._isDAAPIInited():
            return self.flashObject.as_addNotification(id, isAlly, message)

    def as_setReplaySpeedS(self, value=1):
        if self._isDAAPIInited():
            return self.flashObject.as_setReplaySpeed(value)