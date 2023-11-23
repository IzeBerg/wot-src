from gui_lootboxes.gui.bonuses.bonus_tooltips import LootBoxVehicleBlueprintFragmentTooltipData
from gui_lootboxes.gui.impl.lobby.gui_lootboxes.tooltips.guaranteed_reward_tooltip import GuaranteedRewardTooltip
from gui_lootboxes.gui.impl.lobby.gui_lootboxes.tooltips.lootbox_tooltip import LootboxTooltip
from gui.impl.backport.backport_tooltip import DecoratedTooltipWindow
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, ToolTipBaseData
from gui.shared.tooltips.builders import DataBuilder, TooltipWindowBuilder
from helpers import dependency
from skeletons.gui.shared import IItemsCache
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.LOOT_BOXES_VEHICLE_BLUEPRINT_FRAGMENT, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, LootBoxVehicleBlueprintFragmentTooltipData(contexts.ToolTipContext(None))),
     TooltipWindowBuilder(TOOLTIPS_CONSTANTS.LOOT_BOX_TOOLTIP, None, LootBoxTooltipData(contexts.ToolTipContext(None))),
     TooltipWindowBuilder(TOOLTIPS_CONSTANTS.LOOT_BOX_GUARANTEED_REWARD_TOOLTIP, None, LootBoxGuaranteedRewardTooltipData(contexts.ToolTipContext(None))))


class LootBoxTooltipData(ToolTipBaseData):
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, context):
        super(LootBoxTooltipData, self).__init__(context, TOOLTIPS_CONSTANTS.LOOT_BOX_TOOLTIP)

    def getDisplayableData(self, lootboxId):
        lootBox = self.__itemsCache.items.tokens.getLootBoxByTokenID(lootboxId)
        if lootBox is None:
            return
        else:
            return DecoratedTooltipWindow(LootboxTooltip(lootBox), useDecorator=False)


class LootBoxGuaranteedRewardTooltipData(ToolTipBaseData):
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, context):
        super(LootBoxGuaranteedRewardTooltipData, self).__init__(context, TOOLTIPS_CONSTANTS.LOOT_BOX_GUARANTEED_REWARD_TOOLTIP)

    def getDisplayableData(self, lootboxId):
        lootBox = self.__itemsCache.items.tokens.getLootBoxByID(lootboxId)
        if lootBox is None:
            return
        else:
            return DecoratedTooltipWindow(GuaranteedRewardTooltip(lootBox), useDecorator=False)