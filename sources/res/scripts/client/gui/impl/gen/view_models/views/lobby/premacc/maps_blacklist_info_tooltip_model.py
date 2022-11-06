from frameworks.wulf import ViewModel

class MapsBlacklistInfoTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(MapsBlacklistInfoTooltipModel, self).__init__(properties=properties, commands=commands)

    def getMaxCooldownTime(self):
        return self._getNumber(0)

    def setMaxCooldownTime(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(MapsBlacklistInfoTooltipModel, self)._initialize()
        self._addNumberProperty('maxCooldownTime', 0)