from gui.impl.gen.view_models.common.browser_model import BrowserModel

class BrowserViewModel(BrowserModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=8, commands=5):
        super(BrowserViewModel, self).__init__(properties=properties, commands=commands)

    def getIsClosable(self):
        return self._getBool(7)

    def setIsClosable(self, value):
        self._setBool(7, value)

    def _initialize(self):
        super(BrowserViewModel, self)._initialize()
        self._addBoolProperty('isClosable', False)
        self.onClose = self._addCommand('onClose')