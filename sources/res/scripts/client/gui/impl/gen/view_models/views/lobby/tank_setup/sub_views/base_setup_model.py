from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.deal_panel_model import DealPanelModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.filters_model import FiltersModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.setup_tabs_model import SetupTabsModel
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_slot_model import BaseSlotModel

class BaseSetupModel(ViewModel):
    __slots__ = ('onSlotAction', 'onDealConfirmed', 'onDealCancelled', 'onAutoRenewalChanged',
                 'onTabChanged', 'onFilterChanged', 'onFilterReset')
    SELECT_SLOT_ACTION = 'select'
    REVERT_SLOT_ACTION = 'undo'
    RETURN_TO_STORAGE_ACTION = 'cancel'
    SWAP_SLOTS_ACTION = 'swap'
    DEMOUNT_SLOT_ACTION = 'demount'
    DEMOUNT_SLOT_FROM_SETUP_ACTION = 'demount_from_setup'
    DEMOUNT_SLOT_FROM_SETUPS_ACTION = 'demount_from_setups'
    DESTROY_SLOT_ACTION = 'destroy'
    SHOW_INFO_SLOT_ACTION = 'show_info'
    UPGRADE_SLOT_ACTION = 'upgrade'
    ADD_ONE_SLOT_ACTION = 'add_one'
    DRAG_AND_DROP_SLOT_ACTION = 'drag_drop'

    def __init__(self, properties=5, commands=7):
        super(BaseSetupModel, self).__init__(properties=properties, commands=commands)

    @property
    def filter(self):
        return self._getViewModel(0)

    @staticmethod
    def getFilterType():
        return FiltersModel

    @property
    def dealPanel(self):
        return self._getViewModel(1)

    @staticmethod
    def getDealPanelType():
        return DealPanelModel

    @property
    def tabs(self):
        return self._getViewModel(2)

    @staticmethod
    def getTabsType():
        return SetupTabsModel

    def getSlots(self):
        return self._getArray(3)

    def setSlots(self, value):
        self._setArray(3, value)

    @staticmethod
    def getSlotsType():
        return BaseSlotModel

    def getSyncInitiator(self):
        return self._getNumber(4)

    def setSyncInitiator(self, value):
        self._setNumber(4, value)

    def _initialize(self):
        super(BaseSetupModel, self)._initialize()
        self._addViewModelProperty('filter', FiltersModel())
        self._addViewModelProperty('dealPanel', DealPanelModel())
        self._addViewModelProperty('tabs', SetupTabsModel())
        self._addArrayProperty('slots', Array())
        self._addNumberProperty('syncInitiator', 0)
        self.onSlotAction = self._addCommand('onSlotAction')
        self.onDealConfirmed = self._addCommand('onDealConfirmed')
        self.onDealCancelled = self._addCommand('onDealCancelled')
        self.onAutoRenewalChanged = self._addCommand('onAutoRenewalChanged')
        self.onTabChanged = self._addCommand('onTabChanged')
        self.onFilterChanged = self._addCommand('onFilterChanged')
        self.onFilterReset = self._addCommand('onFilterReset')