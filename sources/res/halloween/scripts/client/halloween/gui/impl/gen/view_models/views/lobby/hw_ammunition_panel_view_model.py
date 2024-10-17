from gui.impl.gen.view_models.views.lobby.tank_setup.ammunition_panel_view_model import AmmunitionPanelViewModel

class HwAmmunitionPanelViewModel(AmmunitionPanelViewModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=1):
        super(HwAmmunitionPanelViewModel, self).__init__(properties=properties, commands=commands)

    def getIsDefenseMode(self):
        return self._getBool(7)

    def setIsDefenseMode(self, value):
        self._setBool(7, value)

    def _initialize(self):
        super(HwAmmunitionPanelViewModel, self)._initialize()
        self._addBoolProperty('isDefenseMode', False)