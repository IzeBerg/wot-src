from frameworks.wulf import ViewSettings
from event_lootboxes.gui.event_lootboxes.bonuses_packers import getEventLootBoxesInfoTypeBonusPacker
from gui.impl.gen import R
from event_lootboxes.gui.impl.gen.view_models.views.lobby.event_lootboxes.tooltips.infotype_slot_model import InfotypeSlotModel, RewardType
from event_lootboxes.gui.impl.gen.view_models.views.lobby.event_lootboxes.tooltips.loot_box_tooltip_model import BoxType, LootBoxTooltipModel
from gui.impl.pub import ViewImpl
from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from gui.server_events.bonuses import BlueprintsBonusSubtypes
from gui.shared.gui_items.loot_box import EventLootBoxes
from helpers import dependency
from items.components.crew_books_constants import CREW_BOOK_RARITY
from skeletons.gui.game_control import IEventLootBoxesController
_VEHICLES_BONUS_NAME = 'vehicles'
_REWARDS_WHICH_NEED_MERGE = (
 BlueprintsBonusSubtypes.NATION_FRAGMENT,
 CREW_BOOK_RARITY.CREW_COMMON)

class LootBoxSlot(object):
    __slots__ = ('__probability', '__bonuses', '__rewardsType', '__isGuaranteedBonus')

    def __init__(self, probability, bonuses, isGuaranteedBonus):
        self.__probability = round(probability * 100, 2)
        self.__bonuses = bonuses
        self.__detectRewardsType(bonuses)
        self.__isGuaranteedBonus = isGuaranteedBonus

    def getProbability(self):
        return self.__probability

    def getRewards(self):
        return self.__bonuses.copy()

    def getRewardsType(self):
        return self.__rewardsType

    def getIsGuaranteedBonus(self):
        return self.__isGuaranteedBonus

    def getViewModel(self):
        slotModel = InfotypeSlotModel()
        slotModel.setProbability(self.__probability)
        slotModel.setRewardType(RewardType(self.__rewardsType))
        slotModel.setIsGuaranteedBonus(self.__isGuaranteedBonus)
        rewardsModelArray = slotModel.getRewards()
        for bonus in self.__packBonuses():
            rewardsModelArray.addViewModel(bonus)

        rewardsModelArray.invalidate()
        return slotModel

    def __detectRewardsType(self, bonuses):
        if any(bonus.getName() == _VEHICLES_BONUS_NAME for bonus in bonuses):
            self.__rewardsType = RewardType.VEHICLE
        else:
            self.__rewardsType = RewardType.DEFAULT

    def __packBonuses(self):
        packer = getEventLootBoxesInfoTypeBonusPacker()
        bonusList = []
        mergeRewards = {}
        for bonus in self.__bonuses:
            if not self.__isValidBonus(bonus):
                continue
            packedBonuses = packer.pack(bonus)
            for packedBonus in packedBonuses:
                packedBonusName = packedBonus.getName()
                if packedBonusName in _REWARDS_WHICH_NEED_MERGE:
                    if packedBonusName in mergeRewards:
                        count = mergeRewards[packedBonusName].getCount()
                        mergeRewards[packedBonusName].setCount(max(count, packedBonus.getCount()))
                        packedBonus.unbind()
                    else:
                        mergeRewards[packedBonusName] = packedBonus
                        bonusList.append(packedBonus)
                elif not self.__isExistingVehicle(packedBonus, bonusList):
                    bonusList.append(packedBonus)

        return bonusList

    def __isValidBonus(self, bonus):
        return bonus.isShowInGUI() and (self.__rewardsType == RewardType.VEHICLE and bonus.getName() == _VEHICLES_BONUS_NAME or self.__rewardsType == RewardType.DEFAULT)

    def __isExistingVehicle(self, packedBonus, bonusList):
        return self.__rewardsType == RewardType.VEHICLE and packedBonus.getName() in (b.getName() for b in bonusList)


class EventLootBoxTooltip(ViewImpl):
    __slots__ = ('__boxType', )
    __eventLootBoxes = dependency.descriptor(IEventLootBoxesController)

    def __init__(self, boxType):
        settings = ViewSettings(R.views.event_lootboxes.lobby.event_lootboxes.tooltips.LootBoxesTooltip())
        settings.model = LootBoxTooltipModel()
        self.__boxType = boxType
        super(EventLootBoxTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(EventLootBoxTooltip, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(EventLootBoxTooltip, self)._onLoading(*args, **kwargs)
        boxesInfo = self.__eventLootBoxes.getBoxesInfo().get(self.__boxType, {})
        slots = boxesInfo.get('slots', {})
        with self.viewModel.transaction() as (model):
            model.setGuaranteedLimit(self.__eventLootBoxes.getGuaranteedBonusLimit(EventLootBoxes.PREMIUM))
            model.setBoxType(BoxType(self.__boxType))
            self.__updateSlots(slots=slots, model=model)

    def _getEvents(self):
        return (
         (
          self.__eventLootBoxes.onBoxInfoUpdated, self.__onBoxInfoUpdated),)

    def __onBoxInfoUpdated(self):
        boxesInfo = self.__eventLootBoxes.getBoxesInfo().get(self.__boxType, {})
        slots = boxesInfo.get('slots', {})
        self.__updateSlots(slots=slots)

    @replaceNoneKwargsModel
    def __updateSlots(self, slots, model=None):
        slotsModel = model.getSlots()
        slotsModel.clear()
        for slot in slots.values():
            lbSlot = LootBoxSlot(slot.get('probability', [[0]])[0][0], slot.get('bonuses', []), slot.get('isGuaranteedBonus', False))
            slotsModel.addViewModel(lbSlot.getViewModel())

        slotsModel.invalidate()