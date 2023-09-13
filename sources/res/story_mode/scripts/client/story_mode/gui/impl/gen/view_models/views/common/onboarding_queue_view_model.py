from frameworks.wulf import ViewModel

class OnboardingQueueViewModel(ViewModel):
    __slots__ = ('onQuit', 'onLoaded')

    def __init__(self, properties=1, commands=2):
        super(OnboardingQueueViewModel, self).__init__(properties=properties, commands=commands)

    def getIsVisibleButton(self):
        return self._getBool(0)

    def setIsVisibleButton(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(OnboardingQueueViewModel, self)._initialize()
        self._addBoolProperty('isVisibleButton', False)
        self.onQuit = self._addCommand('onQuit')
        self.onLoaded = self._addCommand('onLoaded')