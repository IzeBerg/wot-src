from gui.impl.gen.view_models.views.lobby.tank_setup.common.base_ammunition_slot import BaseAmmunitionSlot

class ShellAmmunitionSlot(BaseAmmunitionSlot):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(ShellAmmunitionSlot, self).__init__(properties=properties, commands=commands)

    def getCount(self):
        return self._getNumber(8)

    def setCount(self, value):
        self._setNumber(8, value)

    def _initialize(self):
        super(ShellAmmunitionSlot, self)._initialize()
        self._addNumberProperty('count', 0)