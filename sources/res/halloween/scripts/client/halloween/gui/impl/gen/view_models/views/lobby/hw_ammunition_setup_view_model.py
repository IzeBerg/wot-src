from gui.impl.gen.view_models.views.lobby.tank_setup.ammunition_setup_view_model import AmmunitionSetupViewModel

class HwAmmunitionSetupViewModel(AmmunitionSetupViewModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=4):
        super(HwAmmunitionSetupViewModel, self).__init__(properties=properties, commands=commands)

    def getIsDefenseMode(self):
        return self._getBool(8)

    def setIsDefenseMode(self, value):
        self._setBool(8, value)

    def _initialize(self):
        super(HwAmmunitionSetupViewModel, self)._initialize()
        self._addBoolProperty('isDefenseMode', False)