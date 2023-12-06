from frameworks.wulf import ViewModel

class NewYearTabModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(NewYearTabModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getUnseenCount(self):
        return self._getNumber(1)

    def setUnseenCount(self, value):
        self._setNumber(1, value)

    def getInfoCount(self):
        return self._getNumber(2)

    def setInfoCount(self, value):
        self._setNumber(2, value)

    def getIconName(self):
        return self._getString(3)

    def setIconName(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(NewYearTabModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addNumberProperty('unseenCount', 0)
        self._addNumberProperty('infoCount', 0)
        self._addStringProperty('iconName', '')