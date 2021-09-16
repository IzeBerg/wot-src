from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel

class FullScreenDialogWindowModel(ViewModel):
    __slots__ = ('onAcceptClicked', 'onCancelClicked', 'onExit')

    def __init__(self, properties=11, commands=3):
        super(FullScreenDialogWindowModel, self).__init__(properties=properties, commands=commands)

    def getDialogType(self):
        return self._getString(0)

    def setDialogType(self, value):
        self._setString(0, value)

    def getCredits(self):
        return self._getNumber(1)

    def setCredits(self, value):
        self._setNumber(1, value)

    def getGolds(self):
        return self._getNumber(2)

    def setGolds(self, value):
        self._setNumber(2, value)

    def getCrystals(self):
        return self._getNumber(3)

    def setCrystals(self, value):
        self._setNumber(3, value)

    def getFreexp(self):
        return self._getNumber(4)

    def setFreexp(self, value):
        self._setNumber(4, value)

    def getIsWalletAvailable(self):
        return self._getBool(5)

    def setIsWalletAvailable(self, value):
        self._setBool(5, value)

    def getIsAcceptDisabled(self):
        return self._getBool(6)

    def setIsAcceptDisabled(self, value):
        self._setBool(6, value)

    def getTitleBody(self):
        return self._getResource(7)

    def setTitleBody(self, value):
        self._setResource(7, value)

    def getTitleArgs(self):
        return self._getArray(8)

    def setTitleArgs(self, value):
        self._setArray(8, value)

    def getAcceptButtonText(self):
        return self._getResource(9)

    def setAcceptButtonText(self, value):
        self._setResource(9, value)

    def getCancelButtonText(self):
        return self._getResource(10)

    def setCancelButtonText(self, value):
        self._setResource(10, value)

    def _initialize(self):
        super(FullScreenDialogWindowModel, self)._initialize()
        self._addStringProperty('dialogType', 'simple')
        self._addNumberProperty('credits', 0)
        self._addNumberProperty('golds', 0)
        self._addNumberProperty('crystals', 0)
        self._addNumberProperty('freexp', 0)
        self._addBoolProperty('isWalletAvailable', True)
        self._addBoolProperty('isAcceptDisabled', False)
        self._addResourceProperty('titleBody', R.invalid())
        self._addArrayProperty('titleArgs', Array())
        self._addResourceProperty('acceptButtonText', R.invalid())
        self._addResourceProperty('cancelButtonText', R.invalid())
        self.onAcceptClicked = self._addCommand('onAcceptClicked')
        self.onCancelClicked = self._addCommand('onCancelClicked')
        self.onExit = self._addCommand('onExit')