from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyalePlayerStatsMeta(BaseDAAPIComponent):

    def as_setInitDataS(self, title):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(title)

    def as_setDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(value)

    def as_setStpCoinsS(self, initial, factor=1):
        if self._isDAAPIInited():
            return self.flashObject.as_setStpCoins(initial, factor)