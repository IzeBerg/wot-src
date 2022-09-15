from frameworks.wulf import ViewModel

class SeasonModel(ViewModel):
    __slots__ = ('pollServerTime', )

    def __init__(self, properties=3, commands=1):
        super(SeasonModel, self).__init__(properties=properties, commands=commands)

    def getStartTimestamp(self):
        return self._getNumber(0)

    def setStartTimestamp(self, value):
        self._setNumber(0, value)

    def getEndTimestamp(self):
        return self._getNumber(1)

    def setEndTimestamp(self, value):
        self._setNumber(1, value)

    def getServerTimestamp(self):
        return self._getNumber(2)

    def setServerTimestamp(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(SeasonModel, self)._initialize()
        self._addNumberProperty('startTimestamp', 0)
        self._addNumberProperty('endTimestamp', 0)
        self._addNumberProperty('serverTimestamp', 0)
        self.pollServerTime = self._addCommand('pollServerTime')