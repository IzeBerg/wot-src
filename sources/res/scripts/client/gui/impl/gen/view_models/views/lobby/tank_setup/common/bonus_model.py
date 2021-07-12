from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.bonus_value_model import BonusValueModel

class BonusModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BonusModel, self).__init__(properties=properties, commands=commands)

    def getLocaleName(self):
        return self._getString(0)

    def setLocaleName(self, value):
        self._setString(0, value)

    def getValues(self):
        return self._getArray(1)

    def setValues(self, value):
        self._setArray(1, value)

    def _initialize(self):
        super(BonusModel, self)._initialize()
        self._addStringProperty('localeName', '')
        self._addArrayProperty('values', Array())