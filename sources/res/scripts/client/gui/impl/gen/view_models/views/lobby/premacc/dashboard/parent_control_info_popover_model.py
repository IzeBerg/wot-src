from frameworks.wulf import ViewModel

class ParentControlInfoPopoverModel(ViewModel):
    __slots__ = ('onLinkClicked', )

    def __init__(self, properties=0, commands=1):
        super(ParentControlInfoPopoverModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ParentControlInfoPopoverModel, self)._initialize()
        self.onLinkClicked = self._addCommand('onLinkClicked')