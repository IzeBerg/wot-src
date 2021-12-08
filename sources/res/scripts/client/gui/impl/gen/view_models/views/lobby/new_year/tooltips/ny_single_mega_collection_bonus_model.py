from frameworks.wulf import ViewModel

class NySingleMegaCollectionBonusModel(ViewModel):
    __slots__ = ()
    ABSENCE = 'absence'
    NOT_INSTALLED = 'notInstalled'
    INSTALLED = 'installed'

    def __init__(self, properties=3, commands=0):
        super(NySingleMegaCollectionBonusModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getStatus(self):
        return self._getString(1)

    def setStatus(self, value):
        self._setString(1, value)

    def getValue(self):
        return self._getReal(2)

    def setValue(self, value):
        self._setReal(2, value)

    def _initialize(self):
        super(NySingleMegaCollectionBonusModel, self)._initialize()
        self._addStringProperty('type', '')
        self._addStringProperty('status', '')
        self._addRealProperty('value', 0.0)