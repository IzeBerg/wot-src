from gui.impl.gen.view_models.common.price_model import PriceModel
from gui.impl.gen.view_models.views.lobby.common.dialog_with_exchange import DialogWithExchange
from gui.impl.gen.view_models.views.lobby.common.select_slot_spec_dialog_content_model import SelectSlotSpecDialogContentModel

class SelectSlotSpecDialogModel(DialogWithExchange):
    __slots__ = ()
    BUY_NOT_REQUIRED_PANEL = 'buyNotRequiredPanel'

    def __init__(self, properties=17, commands=3):
        super(SelectSlotSpecDialogModel, self).__init__(properties=properties, commands=commands)

    @property
    def changePrice(self):
        return self._getViewModel(15)

    @staticmethod
    def getChangePriceType():
        return PriceModel

    @property
    def mainContent(self):
        return self._getViewModel(16)

    @staticmethod
    def getMainContentType():
        return SelectSlotSpecDialogContentModel

    def _initialize(self):
        super(SelectSlotSpecDialogModel, self)._initialize()
        self._addViewModelProperty('changePrice', PriceModel())
        self._addViewModelProperty('mainContent', SelectSlotSpecDialogContentModel())