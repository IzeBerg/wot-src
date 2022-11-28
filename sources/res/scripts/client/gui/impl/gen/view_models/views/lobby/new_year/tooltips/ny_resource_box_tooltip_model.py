from frameworks.wulf import ViewModel

class NyResourceBoxTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyResourceBoxTooltipModel, self).__init__(properties=properties, commands=commands)

    def getIsFriendsList(self):
        return self._getBool(0)

    def setIsFriendsList(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(NyResourceBoxTooltipModel, self)._initialize()
        self._addBoolProperty('isFriendsList', False)