from frameworks.wulf import ViewModel

class TutorialBannerViewModel(ViewModel):
    __slots__ = ('onBannerClick', )

    def __init__(self, properties=1, commands=1):
        super(TutorialBannerViewModel, self).__init__(properties=properties, commands=commands)

    def getIsDisabled(self):
        return self._getBool(0)

    def setIsDisabled(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(TutorialBannerViewModel, self)._initialize()
        self._addBoolProperty('isDisabled', False)
        self.onBannerClick = self._addCommand('onBannerClick')