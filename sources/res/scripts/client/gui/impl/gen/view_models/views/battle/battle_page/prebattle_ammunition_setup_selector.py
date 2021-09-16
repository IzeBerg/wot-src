from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.tank_setup.common.ammunition_setup_selector import AmmunitionSetupSelector

class PrebattleAmmunitionSetupSelector(AmmunitionSetupSelector):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(PrebattleAmmunitionSetupSelector, self).__init__(properties=properties, commands=commands)

    def getHotKeys(self):
        return self._getArray(3)

    def setHotKeys(self, value):
        self._setArray(3, value)

    def _initialize(self):
        super(PrebattleAmmunitionSetupSelector, self)._initialize()
        self._addArrayProperty('hotKeys', Array())