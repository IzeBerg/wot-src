from frameworks.wulf import ViewModel

class NyRewardKitRestrictionTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(NyRewardKitRestrictionTooltipModel, self).__init__(properties=properties, commands=commands)

    def getMaxCount(self):
        return self._getNumber(0)

    def setMaxCount(self, value):
        self._setNumber(0, value)

    def getCount(self):
        return self._getNumber(1)

    def setCount(self, value):
        self._setNumber(1, value)

    def getIsLastDay(self):
        return self._getBool(2)

    def setIsLastDay(self, value):
        self._setBool(2, value)

    def getCountdownTimestamp(self):
        return self._getNumber(3)

    def setCountdownTimestamp(self, value):
        self._setNumber(3, value)

    def _initialize(self):
        super(NyRewardKitRestrictionTooltipModel, self)._initialize()
        self._addNumberProperty('maxCount', 0)
        self._addNumberProperty('count', 0)
        self._addBoolProperty('isLastDay', False)
        self._addNumberProperty('countdownTimestamp', 0)