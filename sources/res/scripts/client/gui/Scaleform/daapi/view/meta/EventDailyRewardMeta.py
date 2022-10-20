from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventDailyRewardMeta(BaseDAAPIComponent):

    def onClick(self):
        self._printOverrideError('onClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)