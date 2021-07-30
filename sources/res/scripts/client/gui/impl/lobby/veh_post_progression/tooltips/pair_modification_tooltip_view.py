import typing
from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.common.bonus_model import BonusModel
from gui.impl.gen.view_models.common.bonus_value_model import BonusValueModel
from gui.impl.gen.view_models.views.lobby.post_progression.tooltip.modification_model import ModificationModel
from gui.impl.gen.view_models.views.lobby.post_progression.tooltip.pair_modification_tooltip_view_model import PairModificationTooltipViewModel, PairModificationState
from gui.impl.pub import ViewImpl
from gui.impl.wrappers.user_compound_price_model import PriceModelBuilder
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from uilogging.veh_post_progression.constants import LogGroups, ParentScreens
from uilogging.veh_post_progression.loggers import VehPostProgressionModificationTooltipLogger
if typing.TYPE_CHECKING:
    from frameworks.wulf import Array
    from gui.shared.gui_items.Vehicle import Vehicle
    from gui.veh_post_progression.models.modifications import MultiModsItem, SimpleModItem
    from gui.veh_post_progression.models.progression_step import PostProgressionStepItem

class BasePairModificationTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.veh_post_progression.tooltip.PairModificationTooltipView())
        settings.model = PairModificationTooltipViewModel()
        settings.args = args
        settings.kwargs = kwargs
        super(BasePairModificationTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(BasePairModificationTooltipView, self).getViewModel()

    def _onLoading(self, vehicle, stepID, modificationId, *args, **kwargs):
        super(BasePairModificationTooltipView, self)._onLoading(*args, **kwargs)
        step = vehicle.postProgression.getStep(stepID)
        pairModification = step.action
        currentModification = pairModification.getModificationByID(modificationId)
        state = self._getState(step, modificationId)
        with self.viewModel.transaction() as (model):
            model.setNameRes(currentModification.getLocNameRes()())
            model.setState(state)
            model.setLevel(step.getLevel())
            self.__fillModifications(state, model.getModifications(), pairModification, modificationId)
            self.__fillModifiers(vehicle, model.modifiers.getItems(), currentModification)

    def _getState(self, step, modificationId):
        if step.isLocked():
            return PairModificationState.LOCKED
        else:
            purchasedId = step.action.getPurchasedID()
            if purchasedId == modificationId:
                return PairModificationState.BOUGHT
            if purchasedId is None:
                return PairModificationState.UNLOCKED
            return PairModificationState.ANOTHERISINSTALLED

    def __fillModifications(self, state, modifications, pairModification, modificationId):
        modifications.clear()
        hasInstall = state in (PairModificationState.BOUGHT, PairModificationState.ANOTHERISINSTALLED)
        for modification in pairModification.modifications:
            modificationModel = ModificationModel()
            modificationModel.setIconResName(modification.getImageName())
            modificationModel.setIsCurrent(modification.actionID == modificationId)
            modificationModel.setIsInstalled(hasInstall and pairModification.getPurchasedID() == modification.actionID)
            modifications.addViewModel(modificationModel)

        modifications.invalidate()

    def __fillModifiers(self, vehicle, modifiers, modification):
        modifiers.clear()
        for kpi in modification.getKpi(vehicle):
            value = BonusValueModel()
            value.setValue(kpi.value)
            value.setValueKey(kpi.name)
            value.setValueType(kpi.type)
            value.setIsDebuff(kpi.isDebuff)
            bonusModel = BonusModel()
            bonusModel.setLocaleName(kpi.name)
            bonusModel.getValues().addViewModel(value)
            modifiers.addViewModel(bonusModel)

        modifiers.invalidate()


class CmpPairModificationTooltipView(BasePairModificationTooltipView):
    _uiLogger = VehPostProgressionModificationTooltipLogger(LogGroups.PAIR_MODIFICATION)
    __slots__ = ()

    def _onLoaded(self, *args, **kwargs):
        super(CmpPairModificationTooltipView, self)._onLoaded(*args, **kwargs)
        self._uiLogger.onTooltipOpened()

    def _onLoading(self, vehicle, stepID, modificationId, *args, **kwargs):
        super(CmpPairModificationTooltipView, self)._onLoading(vehicle, stepID, modificationId, *args, **kwargs)
        self.viewModel.setIsPriceExist(False)

    def _finalize(self):
        self._uiLogger.onTooltipClosed(parentScreen=ParentScreens.COMPARE_MODIFICATIONS_TREE)
        super(CmpPairModificationTooltipView, self)._finalize()

    def _getState(self, step, modificationId):
        return PairModificationState.UNLOCKED


class CmpPanelPairModificationTooltipView(CmpPairModificationTooltipView):
    __slots__ = ()

    def _onLoading(self, vehicle, stepID, modificationId, *args, **kwargs):
        super(CmpPanelPairModificationTooltipView, self)._onLoading(vehicle, stepID, modificationId, *args, **kwargs)
        self.viewModel.setShowCTABlock(False)


class CfgPairModificationTooltipView(BasePairModificationTooltipView):
    _itemsCache = dependency.descriptor(IItemsCache)
    _uiLogger = VehPostProgressionModificationTooltipLogger(LogGroups.PAIR_MODIFICATION)
    __slots__ = ()

    @property
    def viewModel(self):
        return super(CfgPairModificationTooltipView, self).getViewModel()

    def _onLoading(self, vehicle, stepID, modificationId, *args, **kwargs):
        super(CfgPairModificationTooltipView, self)._onLoading(vehicle, stepID, modificationId, *args, **kwargs)
        if self.viewModel.getState() == PairModificationState.BOUGHT:
            return
        currentModification = vehicle.postProgression.getStep(stepID).action.getModificationByID(modificationId)
        moneyShortage = self._itemsCache.items.stats.money.getShortage(currentModification.getPrice())
        with self.viewModel.transaction() as (model):
            PriceModelBuilder.fillPriceModel(model.price, currentModification.getPrice())
            PriceModelBuilder.fillPriceModel(model.moneyShortage, moneyShortage)

    def _onLoaded(self, *args, **kwargs):
        super(CfgPairModificationTooltipView, self)._onLoaded(*args, **kwargs)
        self._uiLogger.onTooltipOpened()

    def _finalize(self):
        self._uiLogger.onTooltipClosed(parentScreen=ParentScreens.MODIFICATIONS_TREE)
        super(CfgPairModificationTooltipView, self)._finalize()