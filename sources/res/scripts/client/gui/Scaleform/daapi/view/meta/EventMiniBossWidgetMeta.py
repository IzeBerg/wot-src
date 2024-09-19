from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventMiniBossWidgetMeta(BaseDAAPIComponent):

    def as_setMiniBossWidgetDataS(self, miniBossName, hpCurrent, hpMax, isEnemy):
        if self._isDAAPIInited():
            return self.flashObject.as_setMiniBossWidgetData(miniBossName, hpCurrent, hpMax, isEnemy)

    def as_updateMiniBossHpS(self, newHealth):
        if self._isDAAPIInited():
            return self.flashObject.as_updateMiniBossHp(newHealth)

    def as_resetMiniBossWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetMiniBossWidget()