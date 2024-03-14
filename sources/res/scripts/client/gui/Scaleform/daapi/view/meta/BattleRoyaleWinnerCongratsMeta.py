from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyaleWinnerCongratsMeta(BaseDAAPIComponent):

    def onBecomeVisible(self):
        self._printOverrideError('onBecomeVisible')

    def as_setStpCoinsS(self, initial, factor=1, placeBonus=0):
        if self._isDAAPIInited():
            return self.flashObject.as_setStpCoins(initial, factor, placeBonus)