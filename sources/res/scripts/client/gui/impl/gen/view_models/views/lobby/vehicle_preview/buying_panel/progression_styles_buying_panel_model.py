from frameworks.wulf import ViewModel

class ProgressionStylesBuyingPanelModel(ViewModel):
    __slots__ = ('onChange', )

    def __init__(self, properties=3, commands=1):
        super(ProgressionStylesBuyingPanelModel, self).__init__(properties=properties, commands=commands)

    def getCurrentLevel(self):
        return self._getNumber(0)

    def setCurrentLevel(self, value):
        self._setNumber(0, value)

    def getSelectedLevel(self):
        return self._getNumber(1)

    def setSelectedLevel(self, value):
        self._setNumber(1, value)

    def getIsReady(self):
        return self._getBool(2)

    def setIsReady(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(ProgressionStylesBuyingPanelModel, self)._initialize()
        self._addNumberProperty('currentLevel', 0)
        self._addNumberProperty('selectedLevel', 0)
        self._addBoolProperty('isReady', False)
        self.onChange = self._addCommand('onChange')