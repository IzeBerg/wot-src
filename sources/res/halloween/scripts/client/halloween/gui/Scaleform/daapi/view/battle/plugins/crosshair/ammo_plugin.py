from gui.Scaleform.daapi.view.battle.shared.crosshair.plugins import AmmoPlugin
SHELL_INF = -999

class HalloweenAmmoPlugin(AmmoPlugin):

    def _setAmmoStock(self, quantity, quantityInClip, isLow, clipState, clipReloaded=False):
        self._parentObj.as_setAmmoStockS(SHELL_INF, quantityInClip, isLow, clipState, clipReloaded)