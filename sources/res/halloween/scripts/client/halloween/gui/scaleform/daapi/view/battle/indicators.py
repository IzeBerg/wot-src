from gui.Scaleform.daapi.view.battle.shared.indicators import SixthSenseIndicator
from gui.Scaleform.daapi.view.battle.shared.indicators import _DamageIndicator
from gui.battle_control.battle_constants import HIT_INDICATOR_MAX_ON_SCREEN

class HWDamageIndicator(_DamageIndicator):
    _DAMAGE_INDICATOR_SWF = 'halloween|halloweenBattleDamageIndicatorApp.swf'


def hwCreateDamageIndicator():
    return HWDamageIndicator(HIT_INDICATOR_MAX_ON_SCREEN)


class HalloweenSixthSenseIndicator(SixthSenseIndicator):

    def _populate(self):
        super(HalloweenSixthSenseIndicator, self)._populate()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self._onPostMortemSwitched
        return

    def _dispose(self):
        super(HalloweenSixthSenseIndicator, self)._dispose()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self._onPostMortemSwitched
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        self._cancelCallback()
        self._hide()