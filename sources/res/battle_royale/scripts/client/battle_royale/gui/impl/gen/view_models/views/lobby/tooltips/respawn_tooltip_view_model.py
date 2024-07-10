from frameworks.wulf import ViewModel

class RespawnTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(RespawnTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getPlatoonTimeToRessurect(self):
        return self._getNumber(0)

    def setPlatoonTimeToRessurect(self, value):
        self._setNumber(0, value)

    def getPlatoonRespawnPeriod(self):
        return self._getNumber(1)

    def setPlatoonRespawnPeriod(self, value):
        self._setNumber(1, value)

    def getSoloRespawnPeriod(self):
        return self._getNumber(2)

    def setSoloRespawnPeriod(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(RespawnTooltipViewModel, self)._initialize()
        self._addNumberProperty('platoonTimeToRessurect', 0)
        self._addNumberProperty('platoonRespawnPeriod', 0)
        self._addNumberProperty('soloRespawnPeriod', 0)