from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.dog_tags.dt_dog_tag import DtDogTag

class CustomizationConfirmDialogModel(ViewModel):
    __slots__ = ('onClose', 'onDiscard', 'onConfirm')

    def __init__(self, properties=1, commands=3):
        super(CustomizationConfirmDialogModel, self).__init__(properties=properties, commands=commands)

    @property
    def equippedDogTag(self):
        return self._getViewModel(0)

    @staticmethod
    def getEquippedDogTagType():
        return DtDogTag

    def _initialize(self):
        super(CustomizationConfirmDialogModel, self)._initialize()
        self._addViewModelProperty('equippedDogTag', DtDogTag())
        self.onClose = self._addCommand('onClose')
        self.onDiscard = self._addCommand('onDiscard')
        self.onConfirm = self._addCommand('onConfirm')