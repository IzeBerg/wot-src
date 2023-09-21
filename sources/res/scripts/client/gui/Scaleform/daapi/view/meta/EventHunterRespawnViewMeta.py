from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventHunterRespawnViewMeta(BaseDAAPIComponent):

    def onRespawnPointClick(self, id):
        self._printOverrideError('onRespawnPointClick')

    def as_updateTimerS(self, timeLeft, timeTotal, applyTimerImmediately, replaySpeed=1):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTimer(timeLeft, timeTotal, applyTimerImmediately, replaySpeed)