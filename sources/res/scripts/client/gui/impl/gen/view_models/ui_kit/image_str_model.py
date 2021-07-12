from frameworks.wulf import ViewModel

class ImageStrModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ImageStrModel, self).__init__(properties=properties, commands=commands)

    def getImgSource(self):
        return self._getString(0)

    def setImgSource(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(ImageStrModel, self)._initialize()
        self._addStringProperty('imgSource', '')