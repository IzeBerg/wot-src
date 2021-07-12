from gui.impl.lobby.tank_setup.ammunition_panel.base import BaseAmmunitionPanel
from gui.impl.lobby.tank_setup.ammunition_blocks_controller import AmmunitionBlocksController

class HangarAmmunitionPanel(BaseAmmunitionPanel):

    def _createAmmunitionBlockController(self, vehicle):
        return AmmunitionBlocksController(vehicle)