from gui.impl.gen import R
from frameworks.wulf import ViewModel

class HalloweenTooltipAbilityItem(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(HalloweenTooltipAbilityItem, self).__init__(properties=properties, commands=commands)

    def getAbilityIcon(self):
        return self._getResource(0)

    def setAbilityIcon(self, value):
        self._setResource(0, value)

    def getAbilityName(self):
        return self._getResource(1)

    def setAbilityName(self, value):
        self._setResource(1, value)

    def _initialize(self):
        super(HalloweenTooltipAbilityItem, self)._initialize()
        self._addResourceProperty('abilityIcon', R.invalid())
        self._addResourceProperty('abilityName', R.invalid())