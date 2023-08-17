from frameworks.wulf import ViewModel

class PagesBlurredBackgroundModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(PagesBlurredBackgroundModel, self).__init__(properties=properties, commands=commands)

    def getMain(self):
        return self._getString(0)

    def setMain(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(PagesBlurredBackgroundModel, self)._initialize()
        self._addStringProperty('main', 'img://gui/maps/icons/collections/collections_content/battlePass/battlePass10/bgMain.png')