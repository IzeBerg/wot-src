from frameworks.wulf import ViewModel

class WotPlusTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(WotPlusTooltipModel, self).__init__(properties=properties, commands=commands)

    def getNextCharge(self):
        return self._getString(0)

    def setNextCharge(self, value):
        self._setString(0, value)

    def getIsActivated(self):
        return self._getBool(1)

    def setIsActivated(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(WotPlusTooltipModel, self)._initialize()
        self._addStringProperty('nextCharge', '')
        self._addBoolProperty('isActivated', False)