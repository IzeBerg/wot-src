from frameworks.wulf import ViewModel

class WotAnniversaryWelcomeViewModel(ViewModel):
    __slots__ = ('onClose', 'onAccept', 'onPlay')

    def __init__(self, properties=3, commands=3):
        super(WotAnniversaryWelcomeViewModel, self).__init__(properties=properties, commands=commands)

    def getStartTime(self):
        return self._getNumber(0)

    def setStartTime(self, value):
        self._setNumber(0, value)

    def getEndTime(self):
        return self._getNumber(1)

    def setEndTime(self, value):
        self._setNumber(1, value)

    def getIsChina(self):
        return self._getBool(2)

    def setIsChina(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(WotAnniversaryWelcomeViewModel, self)._initialize()
        self._addNumberProperty('startTime', 0)
        self._addNumberProperty('endTime', 0)
        self._addBoolProperty('isChina', False)
        self.onClose = self._addCommand('onClose')
        self.onAccept = self._addCommand('onAccept')
        self.onPlay = self._addCommand('onPlay')