from frameworks.wulf import ViewModel

class AbilityTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(AbilityTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getAbilityName(self):
        return self._getString(0)

    def setAbilityName(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(AbilityTooltipViewModel, self)._initialize()
        self._addStringProperty('abilityName', '')