from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel

class KingRewardCongratsViewModel(ViewModel):
    __slots__ = ('onClose', 'onToGarageClick', 'onToOutroClick')

    def __init__(self, properties=5, commands=3):
        super(KingRewardCongratsViewModel, self).__init__(properties=properties, commands=commands)

    def getVehicleUserName(self):
        return self._getString(0)

    def setVehicleUserName(self, value):
        self._setString(0, value)

    def getVehicleLevel(self):
        return self._getString(1)

    def setVehicleLevel(self, value):
        self._setString(1, value)

    def getVehicleType(self):
        return self._getString(2)

    def setVehicleType(self, value):
        self._setString(2, value)

    def getVehicleIsPremium(self):
        return self._getBool(3)

    def setVehicleIsPremium(self, value):
        self._setBool(3, value)

    def getRewards(self):
        return self._getArray(4)

    def setRewards(self, value):
        self._setArray(4, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(KingRewardCongratsViewModel, self)._initialize()
        self._addStringProperty('vehicleUserName', '')
        self._addStringProperty('vehicleLevel', '')
        self._addStringProperty('vehicleType', '')
        self._addBoolProperty('vehicleIsPremium', False)
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')
        self.onToGarageClick = self._addCommand('onToGarageClick')
        self.onToOutroClick = self._addCommand('onToOutroClick')