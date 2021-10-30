from frameworks.wulf import ViewModel

class DialogTemplatePlaceHolderViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(DialogTemplatePlaceHolderViewModel, self).__init__(properties=properties, commands=commands)

    def getResourceID(self):
        return self._getNumber(0)

    def setResourceID(self, value):
        self._setNumber(0, value)

    def getPlaceHolder(self):
        return self._getString(1)

    def setPlaceHolder(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(DialogTemplatePlaceHolderViewModel, self)._initialize()
        self._addNumberProperty('resourceID', 0)
        self._addStringProperty('placeHolder', '')