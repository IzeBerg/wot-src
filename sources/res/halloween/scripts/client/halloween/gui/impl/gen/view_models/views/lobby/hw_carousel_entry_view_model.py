from frameworks.wulf import ViewModel

class HwCarouselEntryViewModel(ViewModel):
    __slots__ = ('onAction', )

    def __init__(self, properties=0, commands=1):
        super(HwCarouselEntryViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(HwCarouselEntryViewModel, self)._initialize()
        self.onAction = self._addCommand('onAction')