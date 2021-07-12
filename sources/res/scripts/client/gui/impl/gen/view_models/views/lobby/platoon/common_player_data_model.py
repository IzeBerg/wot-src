from frameworks.wulf import ViewModel

class CommonPlayerDataModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(CommonPlayerDataModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getClanTag(self):
        return self._getString(1)

    def setClanTag(self, value):
        self._setString(1, value)

    def getBadgeID(self):
        return self._getString(2)

    def setBadgeID(self, value):
        self._setString(2, value)

    def getRating(self):
        return self._getString(3)

    def setRating(self, value):
        self._setString(3, value)

    def getColor(self):
        return self._getString(4)

    def setColor(self, value):
        self._setString(4, value)

    def _initialize(self):
        super(CommonPlayerDataModel, self)._initialize()
        self._addStringProperty('name', 'rookie')
        self._addStringProperty('clanTag', '')
        self._addStringProperty('badgeID', '')
        self._addStringProperty('rating', '')
        self._addStringProperty('color', '')