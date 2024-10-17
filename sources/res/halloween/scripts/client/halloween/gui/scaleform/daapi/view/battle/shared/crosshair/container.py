from gui.Scaleform.daapi.view.battle.shared.crosshair.container import CrosshairPanelContainer
from halloween.gui.scaleform.daapi.view.battle.shared.crosshair import plugins

class HalloweenCrosshairPanelContainer(CrosshairPanelContainer):

    def _getPlugins(self):
        res = super(HalloweenCrosshairPanelContainer, self)._getPlugins()
        res['vehicleState'] = plugins.HWVehicleStatePlugin
        return res