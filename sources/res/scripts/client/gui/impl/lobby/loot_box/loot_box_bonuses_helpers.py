from collections import namedtuple, OrderedDict
from copy import deepcopy
from itertools import izip_longest
import typing
from gui.impl.gen.view_models.common.missions.bonuses.compensation_bonus_model import CompensationBonusModel
from shared_utils import first
from constants import PREMIUM_ENTITLEMENTS
from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import MERGED_BONUS_NAME, LootBoxBonusComposer
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.auxiliary.rewards_helper import CrewBonusTypes, preparationRewardsCurrency, checkAndFillVehicles, checkAndFillCustomizations, checkAndFillTokens, formatEliteVehicle
from gui.impl.backport import createTooltipData
from gui.impl.gen import R
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel
from gui.impl.gen.view_models.views.lobby.new_year.views.lootboxes.bonus_items_names import BonusItemsNames
from gui.impl.gen.view_models.views.lobby.new_year.views.lootboxes.loot_box_reward_row_model import LootBoxRewardRowModel
from gui.impl.gen.view_models.views.lobby.new_year.views.lootboxes.new_year_toy_icon_bonus_model import NewYearToyIconBonusModel
from gui.impl.gen.view_models.views.loot_box_view.loot_congrats_types import LootCongratsTypes
from gui.impl.new_year.new_year_bonus_packer import NewYearTmanTemplateBonusPacker, packBonusModelAndTooltipData
from gui.impl.new_year.new_year_bonus_packer import NYToyFragmentsBonusPacker
from gui.server_events.awards_formatters import AWARDS_SIZES, EPIC_AWARD_SIZE, getLootboxesAutoOpenAwardsPacker, getNYAwardsPacker, getNYEpicAwardsPacker, getNYItemBonusResName
from gui.server_events.bonuses import getNonQuestBonuses, SimpleBonus, splitBonuses
from gui.shared.gui_items.Vehicle import getNationLessName, getIconResourceName
from gui.shared.missions.packers.bonus import BaseBonusUIPacker, getDefaultBonusPackersMap, BonusUIPacker, VehiclesBonusUIPacker, ItemBonusUIPacker, BACKPORT_TOOLTIP_CONTENT_ID, Customization3Dand2DbonusUIPacker, SimpleBonusUIPacker
from gui.shared.money import Currency
from helpers import int2roman, dependency
from items import parseIntCompactDescr, ITEM_TYPE_INDICES, EQUIPMENT_TYPES
from items.components.ny_constants import CurrentNYConstants
from items.vehicles import getItemByCompactDescr
from new_year.ny_level_helper import NewYearAtmospherePresenter
from new_year.ny_toy_info import NewYearCurrentToyInfo
from skeletons.new_year import INewYearController
if typing.TYPE_CHECKING:
    from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
AWARDS_MAX_COUNT = 6
MULTIOPEN_AWARDS_MAX_COUNT = 5
_BONUSES_ORDER = (
 CurrentNYConstants.FILLERS, CurrentNYConstants.TOY_FRAGMENTS, CurrentNYConstants.TOYS, Currency.CREDITS,
 Currency.GOLD, Currency.CRYSTAL,
 'customizations', 'vehicles', 'slots', 'tankmen', PREMIUM_ENTITLEMENTS.PLUS, 'freeXP', 'freeXPFactor',
 'creditsFactor', 'items', 'berths', 'dossier', 'goodies', 'tokens', 'blueprints', 'crewSkins',
 CrewBonusTypes.CREW_BOOK_BONUSES, CrewBonusTypes.CREW_SKIN_BONUSES, 'finalBlueprints')
VEH_COMP_R_ID = R.views.common.tooltip_window.loot_box_compensation_tooltip.LootBoxVehicleCompensationTooltipContent()
RewardsGroup = namedtuple('RewardsGroup', ('name', 'bonusTypes', 'bonuses', 'filterFuncs'))

def isConsumable(itemTypeID, itemCD):
    if itemTypeID != ITEM_TYPE_INDICES['equipment']:
        return False
    itemDescr = getItemByCompactDescr(itemCD)
    return itemDescr.equipmentType == EQUIPMENT_TYPES.regular


def isBattleBooster(itemTypeID, itemCD):
    if itemTypeID != ITEM_TYPE_INDICES['equipment']:
        return False
    itemDescr = getItemByCompactDescr(itemCD)
    return itemDescr.equipmentType == EQUIPMENT_TYPES.battleBoosters


def isCrewBook(itemTypeID, _):
    return itemTypeID == ITEM_TYPE_INDICES['crewBook']


def getItemsFilter(conditions):

    def itemsFilter(items):
        filtered = {}
        for itemCD, count in items.items():
            itemTypeID, _, _ = parseIntCompactDescr(itemCD)
            if any(condition(itemTypeID, itemCD) for condition in conditions):
                filtered[itemCD] = count
                del items[itemCD]

        return filtered

    return itemsFilter


class CompensationBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def packCompensation(cls, bonus):
        return cls._pack(bonus)[0]

    @classmethod
    def _getBonusModel(cls):
        return CompensationBonusModel()


class NYToyBonusUIPacker(BaseBonusUIPacker):
    __nyController = dependency.descriptor(INewYearController)

    @classmethod
    def _pack(cls, bonus):
        result = []
        toys = bonus.getValue()
        for toyId, count in toys.iteritems():
            result.append(cls._packSingleBonus(bonus, toyId, count))

        return result

    @classmethod
    def _packSingleBonus(cls, bonus, toyId, count):
        toyInfo = NewYearCurrentToyInfo(toyId)
        model = NewYearToyIconBonusModel()
        model.setName(bonus.getName())
        model.setValue(str(count['count']))
        model.setIcon(backport.image(toyInfo.getIcon(cls._getImageSize())))
        model.setRankIcon(backport.image(toyInfo.getRankIcon()))
        model.setRankValue(toyInfo.getRank())
        model.setIsMega(toyInfo.isMega())
        model.setToyID(toyId)
        isNewToy = bool(count['newCount'])
        model.setIsNew(isNewToy)
        hasAtmosphere = isNewToy and not cls.__nyController.isMaxAtmosphereLevel()
        model.setAtmosphereBonus(NewYearAtmospherePresenter.getAtmPointsForNewToy(toyId) if hasAtmosphere else 0)
        return model

    @classmethod
    def _getToolTip(cls, bonus):
        result = []
        toys = bonus.getValue()
        for toyId, count in toys.iteritems():
            tooltipData = backport.createTooltipData(tooltip='', specialArgs=(toyId, count))
            result.append(tooltipData)

        return result

    @classmethod
    def _getContentId(cls, bonus):
        return [BACKPORT_TOOLTIP_CONTENT_ID] * len(bonus.getValue())

    @classmethod
    def _getImageSize(cls):
        return AWARDS_SIZES.BIG


class NYToyBonusUIPackerExtra(NYToyBonusUIPacker):

    @classmethod
    def _getImageSize(cls):
        return EPIC_AWARD_SIZE


class MergedBonusUIPacker(BaseBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        model = IconBonusModel()
        cls._packCommon(bonus, model)
        model.setName('default')
        model.setValue(backport.text(R.strings.quests.missions.awards.merged(), count=len(bonus.getValue())))
        return [
         model]

    @classmethod
    def _getToolTip(cls, bonus):
        tooltipData = backport.createTooltipData(tooltip=None, isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.ADDITIONAL_AWARDS, specialArgs=cls._getShortBonusesData(bonus.getValue()))
        return [
         tooltipData]

    @classmethod
    def _getShortBonusesData(cls, bonuses):
        result = []
        formatter = getLootboxesAutoOpenAwardsPacker()
        for bonus in formatter.format(bonuses):
            shortData = {'name': bonus.userName, 
               'label': bonus.getFormattedLabel(), 
               'imgSource': bonus.getImage(AWARDS_SIZES.BIG), 
               'highlightIcon': bonus.getHighlightIcon(AWARDS_SIZES.BIG), 
               'overlayIcon': bonus.getOverlayIcon(AWARDS_SIZES.BIG)}
            result.append(shortData)

        return result


class NYItemBonusUIPacker(ItemBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, item, count):
        model = super(NYItemBonusUIPacker, cls)._packSingleBonus(bonus, item, count)
        name = getNYItemBonusResName(item, AWARDS_SIZES.BIG)
        model.setItem(name)
        return model


class NYVehiclesBonusUIPacker(VehiclesBonusUIPacker):

    @classmethod
    def _packVehicles(cls, bonus, vehicles):
        packedVehicles = []
        for vehicle, vehInfo in vehicles:
            compensation = bonus.compensation(vehicle, bonus)
            if compensation:
                packer = CompensationBonusUIPacker()
                for bonusComp in compensation:
                    compensationModel = packer.packCompensation(bonusComp)
                    vehicleModel = compensationModel.compensatedItem
                    vehicleModel.setName(bonus.getName())
                    vehicleModel.setIsCompensation(bonus.isCompensation())
                    vehicleModel.setLabel(vehicle.shortUserName)
                    vehicleModel.setValue(vehicle.shortUserName)
                    packedVehicles.append(compensationModel)

            else:
                packedVehicles.append(cls._packVehicle(bonus, vehInfo, vehicle))

        return packedVehicles

    @classmethod
    def _packTooltip(cls, bonus, vehicle, vehInfo):
        compensation = bonus.compensation(vehicle, bonus)
        if bonus.compensation(vehicle, bonus):
            return first(cls._packCompensationTooltip(first(compensation), vehicle))
        return super(NYVehiclesBonusUIPacker, cls)._packTooltip(bonus, vehicle, vehInfo)

    @classmethod
    def _packCompensationTooltip(cls, bonusComp, vehicle):
        tooltipDataList = super(NYVehiclesBonusUIPacker, cls)._packCompensationTooltip(bonusComp, vehicle)
        return [ cls.__convertCompensationTooltip(bonusComp, vehicle, tooltipData) for tooltipData in tooltipDataList ]

    @classmethod
    def _packVehicleBonusModel(cls, bonus, vehInfo, isRent, vehicle):
        model = super(NYVehiclesBonusUIPacker, cls)._packVehicleBonusModel(bonus, vehInfo, isRent, vehicle)
        model.setIsCompensation(bool(bonus.compensation(vehicle, bonus)))
        model.setValue(vehicle.shortUserName)
        return model

    @classmethod
    def _getContentId(cls, bonus):
        outcome = []
        for vehicle, _ in bonus.getVehicles():
            compensation = bonus.compensation(vehicle, bonus)
            if compensation:
                outcome.append(R.views.common.tooltip_window.loot_box_compensation_tooltip.LootBoxVehicleCompensationTooltipContent())
            else:
                outcome.append(BACKPORT_TOOLTIP_CONTENT_ID)

        return outcome

    @classmethod
    def __convertCompensationTooltip(cls, bonusComp, vehicle, tooltipData):
        specialArgs = {'iconBefore': backport.image(R.images.gui.maps.shop.vehicles.c_180x135.dyn(getIconResourceName(getNationLessName(vehicle.name)))()), 
           'labelBefore': '', 
           'iconAfter': backport.image(R.images.gui.maps.icons.quests.bonuses.big.gold()), 
           'labelAfter': bonusComp.getIconLabel(), 
           'bonusName': bonusComp.getName(), 
           'vehicleName': vehicle.shortUserName, 
           'vehicleType': formatEliteVehicle(vehicle.isElite, vehicle.type), 
           'isElite': vehicle.isElite, 
           'vehicleLvl': int2roman(vehicle.level)}
        return createTooltipData(tooltip=tooltipData.tooltip, specialAlias=VEH_COMP_R_ID, specialArgs=specialArgs)


def getLootBoxBonusPacker(isExtra=False):
    mapping = getDefaultBonusPackersMap()
    mapping.update({'items': NYItemBonusUIPacker(), 
       'vehicles': NYVehiclesBonusUIPacker(), 
       'customizations': Customization3Dand2DbonusUIPacker(), 
       MERGED_BONUS_NAME: MergedBonusUIPacker(), 
       CurrentNYConstants.TOYS: NYToyBonusUIPackerExtra() if isExtra else NYToyBonusUIPacker(), 
       CurrentNYConstants.TOY_FRAGMENTS: NYToyFragmentsBonusPacker(), 
       'tmanToken': NewYearTmanTemplateBonusPacker()})
    return BonusUIPacker(mapping)


def packBonusGroups(bonuses, groupModelsList, groupsLayout, packer, tooltipsData=None):
    __groupBonuses(bonuses, groupsLayout)
    groupModelsList.clear()
    for group in groupsLayout:
        groupBonuses, _ = getLootboxBonuses(group.bonuses)
        if not groupBonuses:
            continue
        groupModel = LootBoxRewardRowModel()
        bonusModelsList = groupModel.rewards
        groupModel.setLabel(backport.text(group.name))
        bonusesCount = packBonusModelAndTooltipData(groupBonuses, bonusModelsList, packer, tooltipsData)
        if not bonusesCount:
            continue
        groupModel.setRewardsCount(bonusesCount)
        if not group.bonusTypes:
            groupModel.setBonusType(BonusItemsNames.OTHER)
        elif CurrentNYConstants.TOY_FRAGMENTS in group.bonusTypes:
            groupModel.setBonusType(BonusItemsNames.TOYS)
        bonusModelsList.invalidate()
        groupModelsList.addViewModel(groupModel)

    groupModelsList.invalidate()


def getFormattedLootboxBonuses(rewards, maxAwardCount):
    bonuses, alwaysVisibleBonuses, specialRewardType = __getLootboxBonusesData(rewards)
    __preformatBonuses(bonuses)
    __preformatBonuses(alwaysVisibleBonuses)
    formatter = LootBoxBonusComposer(maxAwardCount, getNYAwardsPacker())
    formattedBonuses = formatter.getVisibleFormattedBonuses(bonuses, alwaysVisibleBonuses, size=AWARDS_SIZES.BIG)
    return (
     formattedBonuses, specialRewardType)


def getEpicFormattedLootboxBonuses(rewards, maxAwardCount):
    bonuses, alwaysVisibleBonuses, specialRewardType = __getLootboxBonusesData(rewards, postponeMegaToys=True)
    __preformatBonuses(bonuses)
    __preformatBonuses(alwaysVisibleBonuses)
    formatter = LootBoxBonusComposer(maxAwardCount, getNYEpicAwardsPacker())
    formattedBonuses = formatter.getVisibleFormattedBonuses(bonuses, alwaysVisibleBonuses, size=EPIC_AWARD_SIZE)
    return (
     formattedBonuses, specialRewardType)


def getLootboxBonuses(rewards, maxAwardCount=None):
    bonuses, alwaysVisibleBonuses, specialRewardType = __getLootboxBonusesData(rewards)
    if maxAwardCount is not None:
        bonuses = __composeBonuses(bonuses, alwaysVisibleBonuses, maxAwardCount)
    else:
        bonuses += alwaysVisibleBonuses
    __preformatBonuses(bonuses)
    return (
     bonuses, specialRewardType)


def __getLootboxBonusesData(rewards, postponeMegaToys=False):
    preparationRewardsCurrency(rewards)
    specialRewardType = ''
    bonuses = []
    alwaysVisibleBonuses = []
    for rewardType, rewardValue in rewards.iteritems():
        if rewardType == 'vehicles' and isinstance(rewardValue, list):
            for vehicleData in rewardValue:
                bonus = getNonQuestBonuses(rewardType, vehicleData)
                if checkAndFillVehicles(bonus, alwaysVisibleBonuses, bonuses, onlyVideoVehicle=False):
                    specialRewardType = LootCongratsTypes.CONGRAT_TYPE_VEHICLE

        elif rewardType == 'customizations':
            bonus = getNonQuestBonuses(rewardType, rewardValue)
            if checkAndFillCustomizations(bonus, alwaysVisibleBonuses, bonuses):
                specialRewardType = LootCongratsTypes.CONGRAT_TYPE_STYLE
        elif rewardType == 'tokens':
            bonus = getNonQuestBonuses(rewardType, rewardValue)
            if checkAndFillTokens(bonus, alwaysVisibleBonuses, bonuses):
                specialRewardType = LootCongratsTypes.CONGRAT_TYPE_TANKMAN
        elif rewardType == 'blueprints':
            bonuses += getNonQuestBonuses(rewardType, rewardValue, ctx={'isPacked': True})
        elif rewardType == 'slots' and 'vehicles' in rewards:
            alwaysVisibleBonuses += getNonQuestBonuses(rewardType, rewardValue)
        elif rewardType == CurrentNYConstants.TOYS:
            __fillToysBonuses(rewardValue, alwaysVisibleBonuses, bonuses, postponeMegaToys)
        else:
            bonuses += getNonQuestBonuses(rewardType, rewardValue)

    return (
     bonuses, alwaysVisibleBonuses, specialRewardType)


def __bonusesOrderKey(bonus):
    name = bonus.getName()
    key = _BONUSES_ORDER.index(name) if name in _BONUSES_ORDER else len(_BONUSES_ORDER)
    return key


def __handlePremiumTankSpecialCase(bonuses):
    premiumTankIndex = -1
    slotsIndex = -1
    for bonus in bonuses:
        if bonus.getName() == 'vehicles':
            premiumTankIndex = bonuses.index(bonus)
        if bonus.getName() == 'slots':
            slotsIndex = bonuses.index(bonus)

    if premiumTankIndex > -1:
        slotBonus = bonuses.pop(slotsIndex)
        bonuses.insert(premiumTankIndex, slotBonus)


def __composeBonuses(bonuses, alwaysVisibleBonuses, maxAwardCount):
    bonuses = splitBonuses(bonuses)
    alwaysVisibleBonuses = splitBonuses(alwaysVisibleBonuses)
    if len(bonuses) + len(alwaysVisibleBonuses) > maxAwardCount:
        bonusesLimit = max(0, maxAwardCount - len(alwaysVisibleBonuses) - 1)
        mergedBonus = SimpleBonus(MERGED_BONUS_NAME, bonuses[bonusesLimit:])
        return bonuses[:bonusesLimit] + alwaysVisibleBonuses + [mergedBonus]
    return bonuses + alwaysVisibleBonuses


def __fillToysBonuses(rewardValue, alwaysVisibleBonuses, bonuses, postponeMegaToys):
    toys, megaToys = __getToysSortedByRankAndCount(rewardValue)
    rewardType = CurrentNYConstants.TOYS
    toysBonuses = getNonQuestBonuses(rewardType, toys) if toys else []
    megaToysBonuses = getNonQuestBonuses(rewardType, megaToys) if megaToys else []
    if postponeMegaToys:
        bonuses += toysBonuses
        alwaysVisibleBonuses += megaToysBonuses
    else:
        bonuses += megaToysBonuses + toysBonuses


@dependency.replace_none_kwargs(nyController=INewYearController)
def __getToysSortedByRankAndCount(toys, nyController=None):
    orderedToys = OrderedDict()
    megaToys = OrderedDict()
    toysDescriptors = [ (nyController.getToyDescr(toyId), count) for toyId, count in toys.iteritems() ]
    sortedToysDescriptors = sorted(toysDescriptors, cmp=__compareToysByRankAndCount, reverse=True)
    for toyDesc, count in sortedToysDescriptors:
        if not toyDesc.isMegaToy():
            orderedToys[toyDesc.id] = count
        else:
            megaToys[toyDesc.id] = count

    return (
     orderedToys, megaToys)


def __compareToysByRankAndCount(toy1, toy2):
    toyADesc, toyACount = toy1
    toyBDesc, toyBCount = toy2
    return cmp((toyADesc.rank, toyACount), (toyBDesc.rank, toyBCount))


def __preformatBonuses(bonuses):
    bonuses.sort(key=__bonusesOrderKey)


def __groupBonuses(bonuses, groupsLayout):
    bonuses = deepcopy(bonuses)
    for group in groupsLayout:
        if not group.bonusTypes:
            group.bonuses.update(bonuses)
            bonuses.clear()
        filterFuncs = group.filterFuncs or ()
        for bonusType, filterFunc in izip_longest(group.bonusTypes, filterFuncs):
            if bonusType not in bonuses:
                continue
            if filterFunc is None:
                group.bonuses[bonusType] = bonuses.pop(bonusType)
            else:
                bonus = bonuses[bonusType]
                filtered = filterFunc(bonus)
                if filtered:
                    group.bonuses[bonusType] = filtered
                if not bonus:
                    del bonuses[bonusType]

        if not bonuses:
            break

    return