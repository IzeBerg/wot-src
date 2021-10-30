import typing
from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.tooltips.veh_post_progression_entry_point_tooltip_model import VehPostProgressionEntryPointTooltipModel
from gui.impl.pub import ViewImpl
from helpers import dependency
from items import filterIntCDsByItemType, ITEM_TYPES
from skeletons.gui.shared import IItemsCache
from uilogging.veh_post_progression.loggers import VehPostProgressionEntryPointLogger
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.Vehicle import Vehicle, EliteStatusProgress
    from gui.impl.gen_utils import DynAccessor

class VehPostProgressionEntryPointTooltip(ViewImpl):
    __slots__ = ('__parentScreen', '__vehicle')
    __itemsCache = dependency.descriptor(IItemsCache)
    __uiLogger = VehPostProgressionEntryPointLogger()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.tooltips.VehPostProgressionEntryPointTooltip())
        settings.model = VehPostProgressionEntryPointTooltipModel()
        settings.args = args
        settings.kwargs = kwargs
        self.__vehicle = None
        self.__parentScreen = None
        super(VehPostProgressionEntryPointTooltip, self).__init__(settings)
        return

    @property
    def viewModel(self):
        return super(VehPostProgressionEntryPointTooltip, self).getViewModel()

    def _onLoading(self, intCD, parentScreen):
        items = self.__itemsCache.items
        self.__vehicle = items.getItemByCD(intCD)
        eliteProgress = self.__vehicle.getEliteStatusProgress()
        hasVehiclesToUnlock = any(filterIntCDsByItemType(eliteProgress.total, ITEM_TYPES.vehicle))
        self.__parentScreen = parentScreen
        with self.viewModel.transaction() as (model):
            model.setHeader(R.strings.veh_post_progression.tooltips.entry_point.header())
            model.setDescription(R.strings.veh_post_progression.tooltips.entry_point.description())
            model.setStatus(self.__getStatus(eliteProgress))
            model.setModulesExplored(len(eliteProgress.unlocked))
            model.setModulesTotal(len(eliteProgress.total))
            model.setHasVehiclesToUnlock(hasVehiclesToUnlock)

    def _onLoaded(self, *args, **kwargs):
        super(VehPostProgressionEntryPointTooltip, self)._onLoaded(*args, **kwargs)
        self.__uiLogger.onTooltipOpened(self.__parentScreen, self.__vehicle.postProgressionAvailability(unlockOnly=True).result)

    def _finalize(self):
        self.__uiLogger.onTooltipClosed()
        super(VehPostProgressionEntryPointTooltip, self)._finalize()

    def __getStatus(self, eliteProgress):
        status = R.strings.veh_post_progression.tooltips.entry_point.status
        isPurchased = self.__vehicle.isPurchased
        fullyUnlocked = not eliteProgress.toUnlock
        if self.__vehicle.postProgressionAvailability(unlockOnly=True):
            return R.invalid()
        if not isPurchased and not fullyUnlocked:
            return status.notResearchedNotPurchased()
        if not isPurchased:
            return status.notPurchased()
        if not fullyUnlocked:
            return status.notResearched()
        return R.invalid()