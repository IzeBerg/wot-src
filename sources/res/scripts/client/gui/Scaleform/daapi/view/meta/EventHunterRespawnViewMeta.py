from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventHunterRespawnViewMeta(BaseDAAPIComponent):

    def onRespawnPointClick(self, id):
        self._printOverrideError('onRespawnPointClick')

    def as_updateTimerS(self, timeLeft, timeTotal, replaySpeed=1):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTimer(timeLeft, timeTotal, replaySpeed)

    def as_setIconS(self, icon):
        if self._isDAAPIInited():
            return self.flashObject.as_setIcon(icon)