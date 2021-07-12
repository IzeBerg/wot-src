from frameworks.wulf import ViewModel

class CartTutorialModel(ViewModel):
    __slots__ = ('onTutorialClose', )

    def __init__(self, properties=1, commands=1):
        super(CartTutorialModel, self).__init__(properties=properties, commands=commands)

    def getShowProlongHint(self):
        return self._getBool(0)

    def setShowProlongHint(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(CartTutorialModel, self)._initialize()
        self._addBoolProperty('showProlongHint', False)
        self.onTutorialClose = self._addCommand('onTutorialClose')