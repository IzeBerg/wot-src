from frameworks.wulf import ViewModel

class TankSetupFields(ViewModel):
    __slots__ = ()
    TANK_SETUP_CARD = 0
    AMMO_PANEL_SLOT = 1

    def __init__(self, properties=0, commands=0):
        super(TankSetupFields, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TankSetupFields, self)._initialize()