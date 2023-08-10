from frameworks.wulf import ViewModel

class WotAnniversaryIntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onAccept')

    def __init__(self, properties=8, commands=2):
        super(WotAnniversaryIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getStartTime(self):
        return self._getNumber(0)

    def setStartTime(self, value):
        self._setNumber(0, value)

    def getEndTime(self):
        return self._getNumber(1)

    def setEndTime(self, value):
        self._setNumber(1, value)

    def getMissionsAmount(self):
        return self._getNumber(2)

    def setMissionsAmount(self, value):
        self._setNumber(2, value)

    def getRewardTankName(self):
        return self._getString(3)

    def setRewardTankName(self, value):
        self._setString(3, value)

    def getRewardTankLevel(self):
        return self._getString(4)

    def setRewardTankLevel(self, value):
        self._setString(4, value)

    def getRewardTankType(self):
        return self._getString(5)

    def setRewardTankType(self, value):
        self._setString(5, value)

    def getRewardTankImage(self):
        return self._getString(6)

    def setRewardTankImage(self, value):
        self._setString(6, value)

    def getRewardTankNameLong(self):
        return self._getString(7)

    def setRewardTankNameLong(self, value):
        self._setString(7, value)

    def _initialize(self):
        super(WotAnniversaryIntroViewModel, self)._initialize()
        self._addNumberProperty('startTime', 0)
        self._addNumberProperty('endTime', 0)
        self._addNumberProperty('missionsAmount', 0)
        self._addStringProperty('rewardTankName', '')
        self._addStringProperty('rewardTankLevel', '')
        self._addStringProperty('rewardTankType', '')
        self._addStringProperty('rewardTankImage', '')
        self._addStringProperty('rewardTankNameLong', '')
        self.onClose = self._addCommand('onClose')
        self.onAccept = self._addCommand('onAccept')