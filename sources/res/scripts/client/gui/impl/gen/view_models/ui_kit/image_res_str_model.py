from gui.impl.gen import R
from frameworks.wulf import ViewModel

class ImageResStrModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ImageResStrModel, self).__init__(properties=properties, commands=commands)

    def getImgSource(self):
        return self._getResource(0)

    def setImgSource(self, value):
        self._setResource(0, value)

    def _initialize(self):
        super(ImageResStrModel, self)._initialize()
        self._addResourceProperty('imgSource', R.invalid())