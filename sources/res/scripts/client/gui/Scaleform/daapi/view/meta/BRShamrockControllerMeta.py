from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BRShamrockControllerMeta(BaseDAAPIComponent):

    def as_addPointsS(self, amount, newTotal, fromTeammate):
        if self._isDAAPIInited():
            return self.flashObject.as_addPoints(amount, newTotal, fromTeammate)

    def as_setCounterS(self, amount):
        if self._isDAAPIInited():
            return self.flashObject.as_setCounter(amount)