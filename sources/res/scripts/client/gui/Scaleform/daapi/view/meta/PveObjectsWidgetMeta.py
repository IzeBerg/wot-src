from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PveObjectsWidgetMeta(BaseDAAPIComponent):

    def as_addObjectS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_addObject(data)

    def as_removeObjectS(self, id, state):
        if self._isDAAPIInited():
            return self.flashObject.as_removeObject(id, state)

    def as_setProgressBarValueS(self, id, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setProgressBarValue(id, value)

    def as_updateTimeS(self, id, value, isWarning):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTime(id, value, isWarning)

    def as_setAlarmS(self, id, isAlarm):
        if self._isDAAPIInited():
            return self.flashObject.as_setAlarm(id, isAlarm)

    def as_setTitleS(self, id, title):
        if self._isDAAPIInited():
            return self.flashObject.as_setTitle(id, title)