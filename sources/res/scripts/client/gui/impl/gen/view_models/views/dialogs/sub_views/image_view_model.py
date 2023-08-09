from frameworks.wulf import ViewModel

class ImageViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ImageViewModel, self).__init__(properties=properties, commands=commands)

    def getPath(self):
        return self._getString(0)

    def setPath(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(ImageViewModel, self)._initialize()
        self._addStringProperty('path', '')