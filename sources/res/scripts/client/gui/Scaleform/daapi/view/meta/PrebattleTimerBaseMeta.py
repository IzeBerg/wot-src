from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PrebattleTimerBaseMeta(BaseDAAPIComponent):

    def as_setTimerS(self, totalTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(totalTime)

    def as_setMessageS(self, msg):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessage(msg)

    def as_hideAllS(self, useAnim):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAll(useAnim)

    def as_setWinConditionTextS(self, winCondition):
        if self._isDAAPIInited():
            return self.flashObject.as_setWinConditionText(winCondition)