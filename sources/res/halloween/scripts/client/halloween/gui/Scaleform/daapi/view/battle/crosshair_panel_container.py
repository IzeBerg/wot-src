from gui.Scaleform.daapi.view.battle.shared.crosshair import CrosshairPanelContainer
from halloween.gui.Scaleform.daapi.view.battle.plugins.crosshair.ammo_plugin import HalloweenAmmoPlugin

class HalloweenCrosshairPanelContainer(CrosshairPanelContainer):

    def _getPlugins(self):
        plugins = super(HalloweenCrosshairPanelContainer, self)._getPlugins()
        plugins.update({'ammo': HalloweenAmmoPlugin})
        return plugins