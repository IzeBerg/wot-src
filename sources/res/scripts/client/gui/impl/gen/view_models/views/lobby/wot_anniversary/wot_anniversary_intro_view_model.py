from frameworks.wulf import ViewModel

class WotAnniversaryIntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onAccept')

    def __init__(self, properties=2, commands=2):
        super(WotAnniversaryIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getStartTime(self):
        return self._getNumber(0)

    def setStartTime(self, value):
        self._setNumber(0, value)

    def getEndTime(self):
        return self._getNumber(1)

    def setEndTime(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(WotAnniversaryIntroViewModel, self)._initialize()
        self._addNumberProperty('startTime', 0)
        self._addNumberProperty('endTime', 0)
        self.onClose = self._addCommand('onClose')
        self.onAccept = self._addCommand('onAccept')