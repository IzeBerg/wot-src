from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SeniorityAwardsEntryPointMeta(BaseDAAPIComponent):

    def onClick(self):
        self._printOverrideError('onClick')

    def playSound(self, sounr):
        self._printOverrideError('playSound')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)