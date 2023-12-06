from frameworks.wulf import ViewModel

class NyMenuCollectionsTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NyMenuCollectionsTooltipModel, self).__init__(properties=properties, commands=commands)

    def getCurrentToysCount(self):
        return self._getString(0)

    def setCurrentToysCount(self, value):
        self._setString(0, value)

    def getAllToysCount(self):
        return self._getString(1)

    def setAllToysCount(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(NyMenuCollectionsTooltipModel, self)._initialize()
        self._addStringProperty('currentToysCount', '')
        self._addStringProperty('allToysCount', '')