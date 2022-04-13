from frameworks.wulf import ViewModel

class IntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onVideo')

    def __init__(self, properties=1, commands=2):
        super(IntroViewModel, self).__init__(properties=properties, commands=commands)

    def getIsVideoOpened(self):
        return self._getBool(0)

    def setIsVideoOpened(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(IntroViewModel, self)._initialize()
        self._addBoolProperty('isVideoOpened', False)
        self.onClose = self._addCommand('onClose')
        self.onVideo = self._addCommand('onVideo')