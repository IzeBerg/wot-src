from frameworks.wulf import ViewModel

class FriendGiftLootBoxInfo(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(FriendGiftLootBoxInfo, self).__init__(properties=properties, commands=commands)

    def getUserName(self):
        return self._getString(0)

    def setUserName(self, value):
        self._setString(0, value)

    def getUserClanAbbrev(self):
        return self._getString(1)

    def setUserClanAbbrev(self, value):
        self._setString(1, value)

    def getUserCongratulation(self):
        return self._getString(2)

    def setUserCongratulation(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(FriendGiftLootBoxInfo, self)._initialize()
        self._addStringProperty('userName', '')
        self._addStringProperty('userClanAbbrev', '')
        self._addStringProperty('userCongratulation', '')