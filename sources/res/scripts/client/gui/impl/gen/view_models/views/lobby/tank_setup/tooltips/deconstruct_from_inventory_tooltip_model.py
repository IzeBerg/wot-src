from frameworks.wulf import ViewModel

class DeconstructFromInventoryTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(DeconstructFromInventoryTooltipModel, self).__init__(properties=properties, commands=commands)

    def getEquipmentName(self):
        return self._getString(0)

    def setEquipmentName(self, value):
        self._setString(0, value)

    def getEquipmentAmount(self):
        return self._getNumber(1)

    def setEquipmentAmount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(DeconstructFromInventoryTooltipModel, self)._initialize()
        self._addStringProperty('equipmentName', '')
        self._addNumberProperty('equipmentAmount', 0)