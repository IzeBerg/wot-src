from frameworks.wulf import ViewModel

class NySacksTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NySacksTooltipModel, self).__init__(properties=properties, commands=commands)

    def getBundleType(self):
        return self._getString(0)

    def setBundleType(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(NySacksTooltipModel, self)._initialize()
        self._addStringProperty('bundleType', '')