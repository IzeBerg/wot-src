from frameworks.wulf import ViewModel

class HbVehicleRewardTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(HbVehicleRewardTooltipModel, self).__init__(properties=properties, commands=commands)

    def getDiscount(self):
        return self._getNumber(0)

    def setDiscount(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(HbVehicleRewardTooltipModel, self)._initialize()
        self._addNumberProperty('discount', 0)