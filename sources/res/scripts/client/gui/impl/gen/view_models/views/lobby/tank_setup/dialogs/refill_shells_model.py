from gui.impl.gen.view_models.views.lobby.common.dialog_with_exchange import DialogWithExchange
from gui.impl.gen.view_models.views.lobby.common.multiple_items_content_model import MultipleItemsContentModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.deal_panel_model import DealPanelModel

class RefillShellsModel(DialogWithExchange):
    __slots__ = ()

    def __init__(self, properties=18, commands=3):
        super(RefillShellsModel, self).__init__(properties=properties, commands=commands)

    @property
    def dealPanel(self):
        return self._getViewModel(15)

    @staticmethod
    def getDealPanelType():
        return DealPanelModel

    @property
    def mainContent(self):
        return self._getViewModel(16)

    @staticmethod
    def getMainContentType():
        return MultipleItemsContentModel

    def getWithRollback(self):
        return self._getBool(17)

    def setWithRollback(self, value):
        self._setBool(17, value)

    def _initialize(self):
        super(RefillShellsModel, self)._initialize()
        self._addViewModelProperty('dealPanel', DealPanelModel())
        self._addViewModelProperty('mainContent', MultipleItemsContentModel())
        self._addBoolProperty('withRollback', False)