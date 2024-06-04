from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage

class EpicBattlePageMeta(ClassicPage):

    def onDeactivateRadialMenu(self):
        self._printOverrideError('onDeactivateRadialMenu')

    def as_setSelectReservesAvailableS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectReservesAvailable(value)

    def as_setVehPostProgressionEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehPostProgressionEnabled(value)