from enum import Enum
from frameworks.wulf import Array
from gui.impl.gen import R
from historical_battles.gui.impl.gen.view_models.views.common.selectable_view_model import SelectableViewModel
from historical_battles.gui.impl.gen.view_models.views.lobby.order_model import OrderModel

class FrontmanRole(Enum):
    ENGINEER = 'engineer'
    AVIATION = 'aviation'
    ARTILLERY = 'artillery'


class PreBattleQueueViewModel(SelectableViewModel):
    __slots__ = ('onExitBattle', )

    def __init__(self, properties=7, commands=3):
        super(PreBattleQueueViewModel, self).__init__(properties=properties, commands=commands)

    def getTimePassed(self):
        return self._getString(0)

    def setTimePassed(self, value):
        self._setString(0, value)

    def getWaitTip(self):
        return self._getResource(1)

    def setWaitTip(self, value):
        self._setResource(1, value)

    def getSelectedVehicleName(self):
        return self._getString(2)

    def setSelectedVehicleName(self, value):
        self._setString(2, value)

    def getSelectedFrontmanRole(self):
        return FrontmanRole(self._getString(3))

    def setSelectedFrontmanRole(self, value):
        self._setString(3, value.value)

    def getOrders(self):
        return self._getArray(4)

    def setOrders(self, value):
        self._setArray(4, value)

    @staticmethod
    def getOrdersType():
        return OrderModel

    def getSelectedOrderId(self):
        return self._getString(5)

    def setSelectedOrderId(self, value):
        self._setString(5, value)

    def getIsQuitButtonDisabled(self):
        return self._getBool(6)

    def setIsQuitButtonDisabled(self, value):
        self._setBool(6, value)

    def _initialize(self):
        super(PreBattleQueueViewModel, self)._initialize()
        self._addStringProperty('timePassed', '')
        self._addResourceProperty('waitTip', R.invalid())
        self._addStringProperty('selectedVehicleName', '')
        self._addStringProperty('selectedFrontmanRole')
        self._addArrayProperty('orders', Array())
        self._addStringProperty('selectedOrderId', '')
        self._addBoolProperty('isQuitButtonDisabled', False)
        self.onExitBattle = self._addCommand('onExitBattle')