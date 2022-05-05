from frameworks.wulf import ViewModel

class TextWithWarningViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(TextWithWarningViewModel, self).__init__(properties=properties, commands=commands)

    def getMainText(self):
        return self._getString(0)

    def setMainText(self, value):
        self._setString(0, value)

    def getWarningText(self):
        return self._getString(1)

    def setWarningText(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(TextWithWarningViewModel, self)._initialize()
        self._addStringProperty('mainText', '')
        self._addStringProperty('warningText', '')