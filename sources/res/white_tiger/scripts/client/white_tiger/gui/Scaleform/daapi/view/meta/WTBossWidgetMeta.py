from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class WTBossWidgetMeta(BaseDAAPIComponent):

    def as_setWidgetDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setWidgetData(data)

    def as_updateHpS(self, hpCurrent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHp(hpCurrent)

    def as_updateKillsS(self, kills):
        if self._isDAAPIInited():
            return self.flashObject.as_updateKills(kills)

    def as_updateGeneratorsS(self, availableCount):
        if self._isDAAPIInited():
            return self.flashObject.as_updateGenerators(availableCount)

    def as_updateDebuffS(self, totalTime, remainingTime):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDebuff(totalTime, remainingTime)

    def as_updateHyperionChargeS(self, count, maxCount):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHyperionCharge(count, maxCount)

    def as_updateGeneratorsChargingS(self, id, timeLeft, progress, numInvaders, speed):
        if self._isDAAPIInited():
            return self.flashObject.as_updateGeneratorsCharging(id, timeLeft, progress, numInvaders, speed)

    def as_resetGeneratorCaptureTimerS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_resetGeneratorCaptureTimer(id)