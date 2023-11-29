import logging
from collections import namedtuple
from math import ceil
from typing import TYPE_CHECKING
from constants import LOOTBOX_TOKEN_PREFIX, PREMIUM_ENTITLEMENTS, RESOURCE_TOKEN_PREFIX
from gui.Scaleform.genConsts.SLOT_HIGHLIGHT_TYPES import SLOT_HIGHLIGHT_TYPES
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.QUESTS import QUESTS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.Scaleform.settings import ICONS_SIZES
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen_utils import INVALID_RES_ID
from gui.ranked_battles.constants import YEAR_POINTS_TOKEN
from gui.server_events.formatters import parseComplexToken, TOKEN_SIZES
from gui.server_events.recruit_helper import getRecruitInfo
from gui.shared.formatters import text_styles
from gui.shared.gui_items import GUI_ITEM_TYPE, getItemIconName
from gui.shared.gui_items.Tankman import getRoleUserName
from gui.shared.gui_items.badge import Badge
from gui.shared.gui_items.crew_skin import localizedFullName, Rarity
from gui.shared.gui_items.customization import CustomizationTooltipContext
from gui.shared.money import Currency
from gui.shared.utils.functions import makeTooltip
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import time_utils, i18n, dependency
from items.components.ny_constants import CurrentNYConstants
from new_year.gift_machine_helper import getCoinToken
from new_year.ny_constants import GuestsQuestsTokens
from items.tankmen import RECRUIT_TMAN_TOKEN_PREFIX
from new_year.ny_toy_info import NewYearCurrentToyInfo
from personal_missions import PM_BRANCH
from shared_utils import CONST_CONTAINER, findFirst
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.offers import IOffersDataProvider
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from skeletons.new_year import INewYearController
if TYPE_CHECKING:
    from typing import Callable, List, Optional, Any, Union
    from account_helpers.offers.events_data import OfferEventData
    from gui.goodies.goodie_items import Booster
    from gui.server_events.bonuses import SimpleBonus, CrystalBonus, GoodiesBonus, PlusPremiumDaysBonus, EpicSelectTokensBonus, CurrenciesBonus, X5BattleTokensBonus, X3CrewTokensBonus
    from gui.server_events.cond_formatters.formatters import ConditionFormatter
_logger = logging.getLogger(__name__)
EPIC_AWARD_SIZE = 's360x270'
EXTRA_BIG_AWARD_SIZE = 'extra_big'
MEDIUM_AWARD_SIZE = 'medium'
LARGE_AWARD_SIZE = 'large'

class AWARDS_SIZES(CONST_CONTAINER):
    SMALL = 'small'
    BIG = 'big'


class COMPLETION_TOKENS_SIZES(CONST_CONTAINER):
    SMALL = 'small'
    BIG = 'big'
    HUGE = 'huge'


class LABEL_ALIGN(CONST_CONTAINER):
    RIGHT = 'right'
    CENTER = 'center'


PACK_RENT_VEHICLES_BONUS = 'packRentVehicleBonus'
BATTLE_BONUS_X5_TOKEN = 'battle_bonus_x5'
CREW_BONUS_X3_TOKEN = 'crew_bonus_x3'
GOLD_MISSION = 'goldmission'
BR_PROGRESSION_TOKEN = 'img:battle_royale:progression'
AWARD_IMAGES = {AWARDS_SIZES.SMALL: {Currency.CREDITS: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_CREDITS, 
                        Currency.GOLD: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_GOLD, 
                        Currency.CRYSTAL: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_CRYSTAL, 
                        Currency.EVENT_COIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_EVENTCOIN, 
                        Currency.BPCOIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_BPCOIN, 
                        Currency.EQUIP_COIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_EQUIPCOIN, 
                        'creditsFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_CREDITS, 
                        'freeXP': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_FREEEXP, 
                        'freeXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_FREEEXP, 
                        'tankmenXP': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_TANKMENXP, 
                        'tankmenXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_TANKMENXP, 
                        'xp': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_EXP, 
                        'xpFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_EXP, 
                        'dailyXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_FREEEXP}, 
   AWARDS_SIZES.BIG: {Currency.CREDITS: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_CREDITS, 
                      Currency.GOLD: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_GOLD, 
                      Currency.CRYSTAL: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_CRYSTAL, 
                      Currency.EVENT_COIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_EVENTCOIN, 
                      Currency.BPCOIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_BPCOIN, 
                      Currency.EQUIP_COIN: RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_EQUIPCOIN, 
                      'creditsFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_CREDITS, 
                      'freeXP': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_FREEXP, 
                      'freeXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_FREEXP, 
                      'tankmenXP': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_TANKMENXP, 
                      'tankmenXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_TANKMENXP, 
                      'xp': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_EXP, 
                      'xpFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_EXP, 
                      'dailyXPFactor': RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_FREEXP}}

def getRecertificationFormImages():
    result = {AWARDS_SIZES.SMALL: backport.image(R.images.gui.maps.icons.recertification.common_48x48()), 
       AWARDS_SIZES.BIG: backport.image(R.images.gui.maps.icons.recertification.common_80x80())}
    return result


def _getMultiplierFormatter(formatter):

    def wrapper(text):
        return formatter(('x{}').format(text))

    return wrapper


TEXT_FORMATTERS = {Currency.CREDITS: text_styles.credits, 
   Currency.GOLD: text_styles.gold, 
   Currency.CRYSTAL: text_styles.crystal, 
   Currency.EVENT_COIN: text_styles.eventCoin, 
   Currency.BPCOIN: text_styles.bpcoin, 
   Currency.EQUIP_COIN: text_styles.equipCoin, 
   'creditsFactor': _getMultiplierFormatter(text_styles.credits), 
   'freeXP': text_styles.expText, 
   'freeXPFactor': _getMultiplierFormatter(text_styles.expText), 
   'tankmenXP': text_styles.expText, 
   'tankmenXPFactor': _getMultiplierFormatter(text_styles.expText), 
   'xp': text_styles.expText, 
   'xpFactor': _getMultiplierFormatter(text_styles.expText), 
   'dailyXPFactor': _getMultiplierFormatter(text_styles.expText), 
   'vehicles': text_styles.gold, 
   'tmanToken': text_styles.stats, 
   'ny_amber': text_styles.nyAmber, 
   'ny_iron': text_styles.nyIron, 
   'ny_crystal': text_styles.nyCrystal, 
   'ny_emerald': text_styles.nyEmerald}
TEXT_ALIGNS = {'creditsFactor': LABEL_ALIGN.RIGHT, 
   'freeXPFactor': LABEL_ALIGN.RIGHT, 
   'tankmenXPFactor': LABEL_ALIGN.RIGHT, 
   'dailyXPFactor': LABEL_ALIGN.RIGHT, 
   'xpFactor': LABEL_ALIGN.RIGHT}

def getCompensationFormattersMap():
    return {'vehicles': VehiclesCompensationFormatter(), 
       'crewSkins': CrewSkinsCompensationFormatter()}


def getCompensationEpicFormattersMap():
    mapping = getCompensationFormattersMap()
    mapping.update({'vehicles': VehiclesCompensationEpicFormatter()})
    return mapping


def getDefaultFormattersMap():
    simpleBonusFormatter = SimpleBonusFormatter()
    tokenBonusFormatter = TokenBonusFormatter()
    countableIntegralBonusFormatter = CountableIntegralBonusFormatter()
    return {'strBonus': simpleBonusFormatter, 
       Currency.GOLD: simpleBonusFormatter, 
       Currency.CREDITS: simpleBonusFormatter, 
       Currency.CRYSTAL: simpleBonusFormatter, 
       Currency.EVENT_COIN: simpleBonusFormatter, 
       Currency.BPCOIN: simpleBonusFormatter, 
       Currency.EQUIP_COIN: simpleBonusFormatter, 
       'freeXP': simpleBonusFormatter, 
       'xp': simpleBonusFormatter, 
       'tankmenXP': simpleBonusFormatter, 
       'xpFactor': simpleBonusFormatter, 
       'creditsFactor': simpleBonusFormatter, 
       'freeXPFactor': simpleBonusFormatter, 
       'tankmenXPFactor': simpleBonusFormatter, 
       'dailyXPFactor': simpleBonusFormatter, 
       'groups': EmptyFormatter(), 
       'collectionItem': EmptyFormatter(), 
       PREMIUM_ENTITLEMENTS.BASIC: PremiumDaysBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: PremiumDaysBonusFormatter(), 
       'vehicles': VehiclesBonusFormatter(), 
       'meta': simpleBonusFormatter, 
       'tokens': tokenBonusFormatter, 
       'tankwomanBonus': TankwomanBonusFormatter(), 
       'battleToken': tokenBonusFormatter, 
       'tankmen': TankmenBonusFormatter(), 
       'customizations': CustomizationsBonusFormatter(), 
       'goodies': GoodiesBonusFormatter(), 
       'items': ItemsBonusFormatter(), 
       'dossier': DossierBonusFormatter(), 
       'progressionXPToken': tokenBonusFormatter, 
       'blueprints': BlueprintBonusFormatter(), 
       'blueprintsAny': BlueprintBonusFormatter(), 
       'finalBlueprints': BlueprintBonusFormatter(), 
       'crewSkins': CrewSkinsBonusFormatter(), 
       'crewBooks': CrewBooksBonusFormatter(), 
       'slots': countableIntegralBonusFormatter, 
       'berths': countableIntegralBonusFormatter, 
       'entitlements': EntitlementFormatter(), 
       'rankedDailyBattles': countableIntegralBonusFormatter, 
       'rankedBonusBattles': countableIntegralBonusFormatter, 
       'tmanToken': TmanTemplateBonusFormatter(), 
       'battlePassPoints': BattlePassBonusFormatter(), 
       'currencies': CurrenciesBonusFormatter(), 
       'nyRandomResource': NYRandomResourceBonusFormatter(), 
       'nyCoinToken': NYCoinBonusFormatter()}


def getEpicFormattersMap():
    return {Currency.CRYSTAL: CrystalEpicBonusFormatter(), 
       'goodies': GoodiesEpicBonusFormatter(), 
       'crewBooks': CrewBooksEpicBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: PremiumDaysEpicBonusFormatter(), 
       'items': ItemsEpicBonusFormatter(), 
       'blueprints': BlueprintGroupEpicBonusFormatter(), 
       'battlePassPoints': BattlePassEpicBonusFormatter()}


def getEventBoardsFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'dossier': EventBoardsDossierBonusFormatter(), 
       'badgesGroup': BadgesGroupBonusFormatter()})
    return mapping


def getEpicBattleFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'abilityPts': EpicAbilityPtsFormatter(), 
       'items': EpicItemsBonusFormatter(), 
       'dossier': EpicDossierBonusFormatter(), 
       'vehicles': RankedVehiclesBonusFormatter(), 
       'epicSelectToken': InstructionEpicBattleBonusFormatter(), 
       'goodies': GoodiesEpicBattleBonusFormatter()})
    return mapping


def getEpicSetFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'abilityPts': EpicAbilityPtsFormatter(), 
       'items': EpicItemsBonusFormatter(), 
       'dossier': EpicDossierBonusFormatter(), 
       'vehicles': RankedVehiclesBonusFormatter()})
    return mapping


def getPackRentVehiclesFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'vehicles': RentVehiclesBonusFormatter()})
    return mapping


def getLootboxesFormatterMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'vehicles': RentVehiclesBonusFormatter()})
    return mapping


def getPostBattleFormatterMap():
    mapping = getLootboxesFormatterMap()
    mapping.update({'blueprints': BlueprintBonusFormatter(), 
       'finalBlueprints': BlueprintGroupBonusFormatter(), 
       CurrentNYConstants.TOYS: NewYearToyFormatter()})
    return mapping


def getMissionsDefaultFormatterMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'blueprints': BlueprintGroupBonusFormatter(), 
       'finalBlueprints': BlueprintGroupBonusFormatter()})
    return mapping


def getNYFormatterMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'vehicles': NYRentVehiclesBonusFormatter(), 
       'tmanToken': TmanTemplateBonusFormatter(), 
       'blueprints': BlueprintNYBonusFormatter(), 
       'customizations': CustomizationsNYBonusFormatter(), 
       CurrentNYConstants.TOYS: NewYearToyFormatter()})
    return mapping


def getNYGiftFormatterMap():
    simpleGiftMachineEpicBonusFormatter = SimpleGiftMachineEpicBonusFormatter()
    premiumDaysNYEpicBonusFormatter = PremiumDaysGiftMachineEpicBonusFormatter()
    mapping = getDefaultFormattersMap()
    mapping.update({Currency.GOLD: simpleGiftMachineEpicBonusFormatter, 
       Currency.CREDITS: simpleGiftMachineEpicBonusFormatter, 
       Currency.EQUIP_COIN: simpleGiftMachineEpicBonusFormatter, 
       PREMIUM_ENTITLEMENTS.BASIC: premiumDaysNYEpicBonusFormatter, 
       PREMIUM_ENTITLEMENTS.PLUS: premiumDaysNYEpicBonusFormatter, 
       'freeXP': simpleGiftMachineEpicBonusFormatter, 
       'goodies': GoodiesGiftMachineEpicBonusFormatter(), 
       'crewBooks': CrewBooksGiftMachineEpicBonusFormatter(), 
       'vehicles': NYRentVehiclesBonusFormatter(), 
       'tmanToken': TmanTemplateBonusFormatter(), 
       'blueprints': BlueprintNYBonusFormatter(), 
       'customizations': CustomizationsNYBonusFormatter(), 
       'items': ItemsGiftMachineEpicBonusFormatter()})
    return mapping


def getNYEpicFormatterMap():
    simpleNYEpicBonusFormatter = SimpleNYEpicBonusFormatter()
    premiumDaysNYEpicBonusFormatter = PremiumDaysNYEpicBonusFormatter()
    mapping = getDefaultFormattersMap()
    mapping.update({Currency.GOLD: simpleNYEpicBonusFormatter, 
       Currency.CREDITS: simpleNYEpicBonusFormatter, 
       PREMIUM_ENTITLEMENTS.BASIC: premiumDaysNYEpicBonusFormatter, 
       PREMIUM_ENTITLEMENTS.PLUS: premiumDaysNYEpicBonusFormatter, 
       'vehicles': VehiclesNYEpicBonusFormatter(), 
       'tmanToken': TmanTemplateNYEpicBonusFormatter(), 
       'blueprints': BlueprintNYEpicBonusFormatter(), 
       'crewBooks': CrewBooksNYEpicBonusFormatter(), 
       'slots': SlotNYEpicBonusFormatter(), 
       'items': ItemsNYEpicBonusFormatter(), 
       'customizations': CustomizationsNYEpicBonusFormatter(), 
       'currencies': NyCurrenciesEpicBonusFormatter(), 
       'battleToken': NyBattleTokeEpicBonusFormatter(), 
       CurrentNYConstants.TOYS: NewYearToyEpicFormatter()})
    return mapping


def getRankedFormatterMap(context=None):
    tokenBonusFormatter = RankedPointFormatter()
    mapping = getDefaultFormattersMap()
    mapping.update({'tokens': tokenBonusFormatter, 
       'selectableBonus': RankedSelectableAwardFormatter(context.get('selectionsLeft') if context else None), 
       'battleToken': tokenBonusFormatter, 
       'vehicles': RankedVehiclesBonusFormatter(), 
       'items': RankedItemsBonusFormatter(), 
       'customizations': RankedCustomizationsBonusFormatter()})
    return mapping


def getBattlePassFormatterMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'blueprints': BlueprintGroupBonusFormatter(), 
       'finalBlueprints': BlueprintGroupBonusFormatter(), 
       'items': EpicItemsBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.BASIC: BattlePassPremiumDaysBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: BattlePassPremiumDaysBonusFormatter()})
    return mapping


def getRoyaleFormatterMap():
    simpleBonusFormatter = SimpleBonusFormatter()
    return {Currency.GOLD: simpleBonusFormatter, 
       Currency.CREDITS: simpleBonusFormatter, 
       Currency.CRYSTAL: simpleBonusFormatter, 
       PREMIUM_ENTITLEMENTS.BASIC: PremiumDaysBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: PremiumDaysBonusFormatter(), 
       'customizations': CustomizationsBonusFormatter(), 
       'dossier': DossierBonusFormatter()}


def getLootboxesAutoOpenFormatterMap():
    mapping = getNYFormatterMap()
    mapping.update({CurrentNYConstants.TOYS: NewYearToyFormatter()})
    return mapping


def getNewYearFormattersMap():
    countableIntegralBonusFormatter = CountableIntegralBonusFormatter()
    mapping = getDefaultFormattersMap()
    mapping.update({'tokens': NewYearTokenBonusFormatter(), 
       'battleToken': NewYearTokenBonusFormatter(), 
       'slots': countableIntegralBonusFormatter, 
       'berths': countableIntegralBonusFormatter, 
       'tmanToken': TmanTemplateBonusFormatter()})
    return mapping


def getPackRentNewYearAwardPacker():
    return AwardsPacker(getNewYearFormattersMap())


def getMarathonRewardScrenFormatterMap():
    mapping = getDefaultFormattersMap()
    mapping[PREMIUM_ENTITLEMENTS.BASIC] = PremiumDaysMarathonFormatter()
    mapping[PREMIUM_ENTITLEMENTS.PLUS] = PremiumDaysMarathonFormatter()
    mapping['tankmen'] = TankmenMarathonRewardBonusFormatter()
    return mapping


def getDefaultAwardFormatter():
    return AwardsPacker(getDefaultFormattersMap())


def getMissionsDefaultAwardFormatter():
    return AwardsPacker(getMissionsDefaultFormatterMap())


def getEpicAwardFormatter():
    return AwardsPacker(getEpicFormattersMap())


def getEpicBattleViewAwardPacker():
    return AwardsPacker(getEpicBattleFormattersMap())


def getEpicViewAwardPacker():
    return AwardsPacker(getEpicSetFormattersMap())


def getEventBoardsAwardPacker():
    return AwardsPacker(getEventBoardsFormattersMap())


def getPackRentVehiclesAwardPacker():
    return AwardsPacker(getPackRentVehiclesFormattersMap())


def getPostBattleAwardsPacker():
    return AwardsPacker(getPostBattleFormatterMap())


def getNYAwardsPacker():
    return AwardsPacker(getNYFormatterMap())


def getNYGiftAwardsPacker():
    return AwardsPacker(getNYGiftFormatterMap())


def getNYEpicAwardsPacker():
    return AwardsPacker(getNYEpicFormatterMap())


def getRankedAwardsPacker(context=None):
    return AwardsPacker(getRankedFormatterMap(context))


def getRoyaleAwardsPacker():
    return AwardsPacker(getRoyaleFormatterMap())


def getLootboxesAutoOpenAwardsPacker():
    return AwardsPacker(getLootboxesAutoOpenFormatterMap())


def getPersonalMissionAwardPacker():
    mapping = getDefaultFormattersMap()
    mapping.update({'completionTokens': CompletionTokensBonusFormatter(), 
       'freeTokens': FreeTokensBonusFormatter()})
    return AwardsPacker(mapping)


def getOperationPacker():
    mapping = getDefaultFormattersMap()
    mapping.update({'customizations': OperationCustomizationsBonusFormatter(), 
       'battleToken': CustomizationUnlockFormatter()})
    return AwardsPacker(mapping)


def getAnniversaryPacker():
    formattersMap = getDefaultFormattersMap()
    formattersMap['dossier'] = LoyalServiceBonusFormatter()
    return AwardsPacker(formattersMap)


def getBattlePassAwardsPacker():
    return AwardsPacker(getBattlePassFormatterMap())


def getMarathonRewardScreenPacker():
    return AwardsPacker(getMarathonRewardScrenFormatterMap())


def formatCountLabel(count, defaultStr=''):
    if count > 1:
        return ('x{}').format(count)
    return defaultStr


def formatTimeLabel(hours):
    time = hours
    if hours >= time_utils.HOURS_IN_DAY:
        time = ceil(hours / time_utils.HOURS_IN_DAY)
        timeMetric = i18n.makeString('#menu:header/account/premium/days')
    else:
        timeMetric = i18n.makeString('#menu:header/account/premium/hours')
    return str(int(time)) + ' ' + timeMetric


_PreformattedBonus = namedtuple('_PreformattedBonus', 'bonusName label userName images tooltip labelFormatter areTokensPawned specialArgs specialAlias isSpecial isCompensation align highlightType overlayType highlightIcon overlayIcon compensationReason postProcessTags newCount ')

class PostProcessTags(CONST_CONTAINER):
    IS_SUFFIX_BADGE = 'isSuffixBadge'
    IS_PREFIX_BADGE = 'isPrefixBadge'

    @classmethod
    def getBadgeTag(cls, badge):
        if badge.isSuffixLayout():
            return cls.IS_SUFFIX_BADGE
        return cls.IS_PREFIX_BADGE


class PreformattedBonus(_PreformattedBonus):

    def getImage(self, size):
        return self.images.get(size, '')

    def getFormattedLabel(self, formatter=None):
        formatter = formatter or self.labelFormatter
        if formatter and self.label:
            return formatter(self.label)
        return self.label

    def getHighlightType(self, size):
        types = self.highlightType
        return types and types.get(size, SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT) or SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT

    def getOverlayType(self, size):
        types = self.overlayType
        return types and types.get(size, SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT) or SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT

    def getHighlightIcon(self, size):
        icons = self.highlightIcon
        return icons and icons.get(size, SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT) or SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT

    def getOverlayIcon(self, size):
        icons = self.overlayIcon
        return icons and icons.get(size, SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT) or SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT


PreformattedBonus.__new__.__defaults__ = (
 None, None, None, None, None, None, False, None, None,
 False, False, LABEL_ALIGN.CENTER, None, None, None, None, None, tuple(), 0)

class QuestsBonusComposer(object):

    def __init__(self, awardsFormatter=None):
        self.__bonusFormatter = awardsFormatter or getDefaultAwardFormatter()

    def getPreformattedBonuses(self, bonuses):
        return self.__bonusFormatter.format(bonuses)

    def getFormattedBonuses(self, bonuses, size=AWARDS_SIZES.SMALL):
        preformattedBonuses = self.getPreformattedBonuses(bonuses)
        return self._packBonuses(preformattedBonuses, size)

    def _packBonuses(self, preformattedBonuses, size):
        result = []
        for b in preformattedBonuses:
            result.append(self._packBonus(b, size))

        return result

    def _packBonus(self, bonus, size=AWARDS_SIZES.SMALL):
        return {'label': bonus.getFormattedLabel(), 
           'imgSource': bonus.getImage(size), 
           'tooltip': bonus.tooltip, 
           'isSpecial': bonus.isSpecial, 
           'specialAlias': bonus.specialAlias, 
           'specialArgs': bonus.specialArgs, 
           'align': bonus.align, 
           'userName': bonus.userName}


class AwardsPacker(object):

    def __init__(self, formatters=None):
        self.__formatters = formatters or {}

    def format(self, bonuses):
        preformattedBonuses = []
        for b in bonuses:
            if b.isShowInGUI():
                bonusName = b.getName()
                formatter = self._getBonusFormatter(bonusName)
                if formatter:
                    preformattedBonuses.extend(formatter.format(b))
                else:
                    _logger.warn('No formatter found for %s', bonusName)

        return preformattedBonuses

    def getFormatters(self):
        return self.__formatters

    def _getBonusFormatter(self, bonusName):
        return self.__formatters.get(bonusName)


class AwardFormatter(object):

    def format(self, bonus):
        return self._format(bonus)

    def _format(self, bonus):
        return


class EmptyFormatter(AwardFormatter):

    def _format(self, bonus):
        return []


class SimpleBonusFormatter(AwardFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus), highlightType=self._getHighlightType(bonus), overlayType=self._getOverlayType(bonus), highlightIcon=self._getHighlightIcon(bonus), overlayIcon=self._getOverlayIcon(bonus), compensationReason=self._getCompensationReason(bonus))]

    @classmethod
    def _getUserName(cls, bonus):
        return i18n.makeString(QUESTS.getBonusName(bonus.getName()))

    @classmethod
    def _getLabel(cls, bonus):
        return bonus.formatValue()

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return TEXT_FORMATTERS.get(bonus.getName(), text_styles.stats)

    @classmethod
    def _getLabelAlign(cls, bonus):
        return TEXT_ALIGNS.get(bonus.getName(), LABEL_ALIGN.CENTER)

    @classmethod
    def _getImages(cls, bonus):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = AWARD_IMAGES.get(size, {}).get(bonus.getName())

        return result

    @classmethod
    def _isCompensation(cls, bonus):
        return bonus.isCompensation()

    @classmethod
    def _getHighlightType(cls, item):
        return {}

    @classmethod
    def _getOverlayType(cls, item):
        return {}

    @classmethod
    def _getHighlightIcon(cls, item):
        return {}

    @classmethod
    def _getOverlayIcon(cls, item):
        return {}

    @classmethod
    def _getCompensationReason(cls, bonus):
        compensationReasonBonus = bonus.getCompensationReason()
        if compensationReasonBonus is not None:
            bonusName = compensationReasonBonus.getName()
            bonusFormatter = cls._getCompensationFormattersMap().get(bonusName)
            if bonusFormatter is not None:
                formattedReason = bonusFormatter.format(compensationReasonBonus)
                if formattedReason:
                    return formattedReason[0]
                return
        return

    @classmethod
    def _getCompensationFormattersMap(cls):
        return getCompensationFormattersMap()


class SimpleNYEpicBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getImages(cls, bonus):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, bonus.getName())}

    @classmethod
    def _getCompensationFormattersMap(cls):
        return getCompensationEpicFormattersMap()


class SimpleGiftMachineEpicBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getLabel(cls, bonus):
        if bonus.getValue():
            return str(bonus.getValue())
        else:
            return

    @classmethod
    def _getImages(cls, bonus):
        size = EPIC_AWARD_SIZE
        return {size: bonus.getName()}


class CrystalEpicBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.textEpic

    @classmethod
    def _getImages(cls, bonus):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, bonus.getName())}


class CountableIntegralBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus))]

    @classmethod
    def _getLabel(cls, bonus):
        return formatCountLabel(bonus.getValue())

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.stats

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.RIGHT

    @classmethod
    def _getImages(cls, bonus):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, bonus.getName())

        return result


class SlotNYEpicBonusFormatter(CountableIntegralBonusFormatter):

    @classmethod
    def _getLabel(cls, bonus):
        count = bonus.getValue()
        if count == 1:
            label = backport.text(R.strings.quests.bonusName.slots())
        else:
            label = backport.text(R.strings.ny.reward.label.slots(), count=count)
        return label

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getImages(cls, bonus):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, bonus.getName())}


class CompletionTokensBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        uniqueName = self._getUniqueName(bonus)
        return [
         PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(uniqueName), label=formatCountLabel(bonus.getCount()), images=self._getImages(uniqueName), tooltip=self._getTooltip(uniqueName), labelFormatter=self._getLabelFormatter(bonus), align=LABEL_ALIGN.RIGHT)]

    @classmethod
    def _getUserName(cls, nameID):
        return i18n.makeString(QUESTS.getBonusName(nameID))

    @classmethod
    def _getImages(cls, imageID):
        result = {}
        for size in COMPLETION_TOKENS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, imageID)

        return result

    @classmethod
    def _getTooltip(cls, tooltipID):
        header = i18n.makeString(TOOLTIPS.getAwardHeader(tooltipID))
        body = i18n.makeString(TOOLTIPS.getAwardBody(tooltipID))
        if header or body:
            return makeTooltip(header or None, body or None)
        return ''

    @classmethod
    def _getUniqueName(cls, bonus):
        context = bonus.getContext()
        operationID = context['operationID']
        chainID = context['chainID']
        return '%s_%s_%s' % (bonus.getName(), operationID, chainID)


class FreeTokensBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        areTokensPawned = bonus.areTokensPawned()
        ctx = bonus.getContext()
        if areTokensPawned:
            specialAlias = TOOLTIPS_CONSTANTS.FREE_SHEET_USED
            specialArgs = [ctx.get('campaignID')]
        else:
            specialAlias = TOOLTIPS_CONSTANTS.FREE_SHEET
            specialArgs = [ctx.get('campaignID')]
        return [
         PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(bonus), label=formatCountLabel(bonus.getCount()), images=self._getImages(bonus.getImageFileName()), labelFormatter=self._getLabelFormatter(bonus), align=LABEL_ALIGN.RIGHT, isCompensation=bonus.isCompensation(), isSpecial=True, specialAlias=specialAlias, specialArgs=specialArgs, areTokensPawned=areTokensPawned)]

    @classmethod
    def _getImages(cls, imageID):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, imageID)

        return result


class PremiumDaysBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus))]

    @classmethod
    def _getLabel(cls, bonus):
        return

    @classmethod
    def _getImages(cls, bonus):
        result = {}
        for size in AWARDS_SIZES.ALL():
            imgPath = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), bonus.getValue())
            if imgPath is None:
                imgPath = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), 'universal')
            result[size] = imgPath

        return result


class PremiumDaysMarathonFormatter(PremiumDaysBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName='items', label=formatCountLabel(bonus.getValue()), userName=self._getUserName(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus))]

    @classmethod
    def _getImages(cls, bonus):
        result = {}
        for size in AWARDS_SIZES.ALL():
            imgPath = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), 'universal')
            result[size] = imgPath

        return result


class PremiumDaysEpicBonusFormatter(PremiumDaysBonusFormatter):

    @classmethod
    def _getImages(cls, bonus):
        size = EPIC_AWARD_SIZE
        imgPath = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), bonus.getValue())
        if imgPath is None:
            imgPath = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), 'universal')
        return {size: imgPath}


class PremiumDaysNYEpicBonusFormatter(PremiumDaysEpicBonusFormatter):

    @classmethod
    def _getLabel(cls, bonus):
        count = bonus.getValue()
        if count == 1:
            label = backport.text(R.strings.ny.reward.label.premiumDay())
        else:
            label = backport.text(R.strings.ny.reward.label.premiumDays(), count=count)
        return label


class PremiumDaysGiftMachineEpicBonusFormatter(PremiumDaysNYEpicBonusFormatter):

    @classmethod
    def _getUserName(cls, bonus):
        return cls._getLabel(bonus)


class BattlePassPremiumDaysBonusFormatter(SimpleBonusFormatter):
    __PREMIUM_DAYS_ICONS = (1, 2, 3, 7, 14, 30, 90, 180, 360)

    def _format(self, bonus):
        count = bonus.getValue()
        hasOwnIcon = count in self.__PREMIUM_DAYS_ICONS
        return [
         PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(bonus), label=formatCountLabel(1 if hasOwnIcon else bonus.getValue()), labelFormatter=self._getLabelFormatter(bonus), align=LABEL_ALIGN.RIGHT, images=self._getImages(bonus, hasIcon=hasOwnIcon), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus))]

    @classmethod
    def _getImages(cls, bonus, hasIcon=False):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getPremiumDaysAwardIcon(size, bonus.getName(), bonus.getValue() if hasIcon else 1)

        return result


class SeniorityPremiumDaysBonusFormatter(PremiumDaysBonusFormatter):
    __PREMIUM_DAYS_ICONS = (1, 2, 3, 7, 14, 30, 90, 180, 360)

    def _format(self, bonus):
        return [
         PreformattedBonus(label=self._getLabel(bonus), bonusName=bonus.getName(), userName=self._getUserName(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus))]

    @classmethod
    def _getLabel(cls, bonus):
        return formatTimeLabel(bonus.getValue() * time_utils.HOURS_IN_DAY)


class TokenBonusFormatter(SimpleBonusFormatter):
    eventsCache = dependency.descriptor(IEventsCache)
    itemsCache = dependency.descriptor(IItemsCache)

    @staticmethod
    def getBonusFactorTooltip(name):
        return makeTooltip(header=backport.text(R.strings.tooltips.quests.bonuses.token.dyn(name).header()), body=backport.text(R.strings.tooltips.quests.bonuses.token.dyn(name).body()))

    def _format(self, bonus):
        result = []
        for tokenID, token in bonus.getTokens().iteritems():
            formatted = self._getFormattedBonus(tokenID, token, bonus)
            if formatted is not None:
                result.append(formatted)

        return result

    def _getFormattedBonus(self, tokenID, token, bonus):
        formatted = None
        complexToken = parseComplexToken(tokenID)
        if tokenID.startswith(BR_PROGRESSION_TOKEN):
            return self._formatBRComplexToken(complexToken, token, bonus)
        else:
            if complexToken.isDisplayable:
                formatted = self._formatComplexToken(complexToken, token, bonus)
            elif tokenID.startswith(LOOTBOX_TOKEN_PREFIX) and tokenID != getCoinToken():
                formatted = self._formatLootBoxToken(tokenID, token, bonus)
            elif tokenID.startswith(BATTLE_BONUS_X5_TOKEN):
                formatted = self._formatBonusToken(BATTLE_BONUS_X5_TOKEN, token, bonus)
            elif tokenID.startswith(CREW_BONUS_X3_TOKEN):
                formatted = self._formatBonusToken(CREW_BONUS_X3_TOKEN, token, bonus)
            elif tokenID.startswith(RESOURCE_TOKEN_PREFIX):
                formatted = self._formatResource(token, bonus)
            return formatted

    def _formatBRComplexToken(self, complexToken, token, bonus):
        formatted = self._formatComplexToken(complexToken, token, bonus)
        return formatted._replace(tooltip=self.__getBRProgressionTooltip())

    def _formatBonusLabel(self, count):
        return formatCountLabel(count)

    def _getUserName(self, styleID):
        webCache = self.eventsCache.prefetcher
        return i18n.makeString(webCache.getTokenInfo(styleID))

    def _getTokenImages(self, styleID):
        result = {}
        webCache = self.eventsCache.prefetcher
        for awardSizeKey, awardSizeValue in AWARDS_SIZES.getIterator():
            for tokenSizeKey, tokenSizeValue in TOKEN_SIZES.getIterator():
                if awardSizeKey == tokenSizeKey:
                    result[awardSizeValue] = webCache.getTokenImage(styleID, tokenSizeValue)

        return result

    def _formatComplexToken(self, complexToken, token, bonus):
        userName = self._getUserName(complexToken.styleID)
        tokenBase = R.strings.tooltips.quests.bonuses.token
        eventTokenBase = tokenBase.dyn(complexToken.styleID)
        bodyResID = eventTokenBase.body() if eventTokenBase() != INVALID_RES_ID else tokenBase.body()
        description = self.eventsCache.prefetcher.getTokenDetailedInfo(complexToken.styleID)
        if description is None:
            description = backport.text(bodyResID)
        tooltip = makeTooltip(userName, description if description else None)
        return PreformattedBonus(bonusName=bonus.getName(), images=self._getTokenImages(complexToken.styleID), label=self._formatBonusLabel(token.count), userName=self._getUserName(complexToken.styleID), labelFormatter=self._getLabelFormatter(bonus), tooltip=tooltip, align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus))

    def _formatResource(self, token, bonus):
        images = {}
        tooltip = ''
        header = ''
        if hasattr(R.strings.tooltips.quests.bonuses.token.resource, bonus.resourceName):
            header = backport.text(getattr(R.strings.tooltips.quests.bonuses.token.resource, bonus.resourceName).header())
            tooltip = makeTooltip(header, backport.text(getattr(R.strings.tooltips.quests.bonuses.token.resource, bonus.resourceName).body()))
        for size in AWARDS_SIZES.ALL():
            images[size] = RES_ICONS.getResource(size, bonus.resourceName)

        return PreformattedBonus(bonusName=bonus.resourceName, images=images, label=self._formatBonusLabel(token.count), userName=header, labelFormatter=self._getLabelFormatter(bonus), tooltip=tooltip, align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus))

    def _formatLootBoxToken(self, tokenID, token, bonus):
        lootBox = self.itemsCache.items.tokens.getLootBoxByTokenID(tokenID)
        if lootBox is None or token.count <= 0:
            return
        images = {}
        for size in AWARDS_SIZES.ALL():
            images[size] = RES_ICONS.getLootBoxBonusIcon(size, lootBox.getType())

        return PreformattedBonus(bonusName=bonus.getName(), label=self._formatBonusLabel(token.count), userName=lootBox.getUserName(), labelFormatter=self._getLabelFormatter(bonus), images=images, tooltip=makeTooltip(header=lootBox.getUserName(), body=TOOLTIPS.QUESTS_BONUSES_LOOTBOXTOKEN_BODY), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus), postProcessTags=tokenID)

    def _formatBonusToken(self, name, token, bonus):
        if token.count <= 0:
            return None
        else:
            return PreformattedBonus(bonusName=bonus.getName(), label=self._formatBonusLabel(token.count), userName=bonus.getUserName(), labelFormatter=self._getLabelFormatter(bonus), images=self.__getBonusFactorImages(name), tooltip=self.getBonusFactorTooltip(name), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus))

    @staticmethod
    def __getBonusFactorImages(name):
        images = {}
        for size in AWARDS_SIZES.ALL():
            bonusTaskRes = R.images.gui.maps.icons.quests.bonuses.dyn(size).dyn(name)
            images[size] = backport.image(bonusTaskRes()) if bonusTaskRes.isValid() else None

        return images

    @staticmethod
    def __getBRProgressionTooltip():
        tokenBase = R.strings.battle_royale_progression.quests.bonuses.progressionToken
        return makeTooltip(backport.text(tokenBase.header()), backport.text(tokenBase.body()))


class RankedPointFormatter(TokenBonusFormatter):

    def _format(self, bonus):
        result = []
        for tokenID, token in bonus.getTokens().iteritems():
            formatted = None
            if tokenID.startswith(YEAR_POINTS_TOKEN):
                formatted = self.__formatRankedPointToken(tokenID, token, bonus)
            if formatted is not None:
                result.append(formatted)

        return result

    @classmethod
    def _getUserName(cls, bonus):
        return backport.text(R.strings.tooltips.rankedBattleView.scorePoint.short.header())

    def __formatRankedPointToken(self, tokenID, token, bonus):
        return PreformattedBonus(label=self._formatBonusLabel(token.count), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self.__getImages(tokenID), tooltip=makeTooltip(header=backport.text(R.strings.tooltips.rankedBattleView.scorePoint.header()), body=backport.text(R.strings.tooltips.rankedBattleView.scorePoint.body())), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus))

    def __getImages(self, tokenID):
        return {size:backport.image(self.__getImagePath(tokenID, size)()) for size in AWARDS_SIZES.ALL() if self.__getImagePath(tokenID, size)}

    @staticmethod
    def __getImagePath(tokenID, size):
        if tokenID.startswith(YEAR_POINTS_TOKEN):
            return R.images.gui.maps.icons.quests.bonuses.dyn(size).dyn('rankedPoint')
        else:
            return

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.RIGHT


class RankedSelectableAwardFormatter(TokenBonusFormatter):
    __offersDP = dependency.descriptor(IOffersDataProvider)

    def __init__(self, overloadCount=None):
        super(RankedSelectableAwardFormatter, self).__init__()
        self.__overloadCount = overloadCount

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._formatBonusLabel(self.__overloadCount or self.__getCountForLabel(bonus)), userName=backport.text(R.strings.ranked_battles.yearRewards.tooltip.equipmentChoice.title()), labelFormatter=self._getLabelFormatter(bonus), images=self.__getImages(), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), specialAlias=TOOLTIPS_CONSTANTS.RANKED_BATTLES_SELECTABLE_REWARD, specialArgs=[], isSpecial=True)]

    def __getCountForLabel(self, bonus):
        for tokenID, token in bonus.getTokens().iteritems():
            if self.__offersDP.getOfferByToken(tokenID) is not None:
                return self.__offersDP.getAmountOfGiftsGenerated(tokenID, token.count)
            return int(tokenID.split(':')[(-1)])

        return 0

    def __getImages(self):
        imagesRoot = R.images.gui.maps.icons.quests.bonuses
        return {size:backport.image(imagesRoot.dyn(size).dyn('deluxe_gift')()) for size in AWARDS_SIZES.ALL()}


class EpicAbilityPtsFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(label=self._formatBonusLabel(bonus.getValue()), userName=backport.text(R.strings.epic_battle.epicBattleItem.supplyPoints.header()), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=makeTooltip(header=backport.text(R.strings.epic_battle.epicBattleItem.supplyPoints.header()), body=backport.text(R.strings.epic_battle.epicBattleItem.supplyPoints.description())), align=LABEL_ALIGN.CENTER, isCompensation=self._isCompensation(bonus))]

    def _formatBonusLabel(self, count):
        return count

    @classmethod
    def _getImages(cls, bonus):
        images = {}
        for size in AWARDS_SIZES.ALL():
            res = R.images.gui.maps.icons.quests.bonuses.dyn(size).dyn('epicAbilityPoint')
            if res:
                images[size] = backport.image(res())

        return images

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.RIGHT


class TmanTemplateBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for tokenID in bonus.getTokens().iterkeys():
            if tokenID.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
                formatted = self.__formatTmanTemplateToken(tokenID, bonus)
                if formatted is None:
                    _logger.error('Received wrong tman_template token from server: %s', tokenID)
                else:
                    result.append(formatted)

        return result

    def __formatTmanTemplateToken(self, tokenID, bonus):
        recruitInfo = getRecruitInfo(tokenID)
        if recruitInfo is None:
            return
        else:
            imageName = 'tankwoman' if recruitInfo.isFemale() else 'tankman'
            nameStr = recruitInfo.getFullUserNameByNation(nationID=None)
            return PreformattedBonus(bonusName=bonus.getName(), userName=nameStr, label=self._getLabel(bonus), images=self._getImages(imageName), labelFormatter=self._getLabelFormatter(bonus), align=self._getLabelAlign(bonus), specialAlias=TOOLTIPS_CONSTANTS.TANKMAN_NOT_RECRUITED, specialArgs=[
             tokenID], isSpecial=True)

    @classmethod
    def _getLabel(cls, bonus):
        return ''

    @classmethod
    def _getImages(cls, imageName):
        images = {}
        for size in AWARDS_SIZES.ALL():
            images[size] = RES_ICONS.getBonusIcon(size, imageName)

        return images


class TmanTemplateNYEpicBonusFormatter(TmanTemplateBonusFormatter):

    @classmethod
    def _getImages(cls, imageName):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, imageName)}


class NewYearTokenBonusFormatter(TokenBonusFormatter):
    _nyController = dependency.descriptor(INewYearController)

    def _format(self, bonus):
        result = []
        for tokenID, token in bonus.getTokens().iteritems():
            complexToken = parseComplexToken(tokenID)
            if complexToken.isDisplayable:
                result.append(self._formatComplexToken(complexToken, token, bonus))
            elif tokenID.startswith(LOOTBOX_TOKEN_PREFIX) and tokenID != getCoinToken():
                formatted = self._formatLootBoxToken(tokenID, token, bonus)
                if formatted is None:
                    _logger.error('Received wrong loot box token from server: %s', tokenID)
                else:
                    result.append(formatted)

        return result


class LinkedSetTokenBonusFormatter(TokenBonusFormatter):

    def _formatBonusLabel(self, count):
        return ('x{}').format(count)


class CustomizationUnlockFormatter(TokenBonusFormatter):
    c11n = dependency.descriptor(ICustomizationService)
    __TOKEN_POSTFIX = ':camouflage'
    __ICON_NAME = 'camouflage'

    def _format(self, bonus):
        tokens = bonus.getTokens()
        unlockTokenID = findFirst(lambda ID: ID.endswith(self.__TOKEN_POSTFIX), tokens.keys())
        if unlockTokenID is not None:
            camouflages = self.c11n.getCamouflages(criteria=REQ_CRITERIA.CUSTOMIZATION.UNLOCKED_BY(unlockTokenID))
            branch = bonus.getContext().get('branch')
            if branch == PM_BRANCH.REGULAR:
                tooltip = makeTooltip(TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_HEADER, TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_BODY)
            elif branch == PM_BRANCH.PERSONAL_MISSION_2:
                tooltip = makeTooltip(TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_ALLIANCE_HEADER, TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_ALLIANCE_BODY)
            else:
                tooltip = None
            images = {size:RES_ICONS.getBonusIcon(size, self.__ICON_NAME) for size in AWARDS_SIZES.ALL()}
            result = [
             PreformattedBonus(bonusName=bonus.getName(), label=formatCountLabel(len(camouflages)), align=LABEL_ALIGN.RIGHT, images=images, isSpecial=False, tooltip=tooltip)]
        else:
            result = []
        return result


class VehiclesBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        result.extend(self._formatVehicle(bonus, bonus.getVehicles()))
        return result

    def _formatVehicle(self, bonus, vehicles):
        result = []
        for vehicle, vehInfo in vehicles:
            compensation = bonus.compensation(vehicle, bonus)
            if compensation:
                formatter = self._getCompensationFormatter()
                for bonusComp in compensation:
                    formattedComp = formatter.format(bonusComp)
                    result.extend(formattedComp)

            else:
                result.append(self._appendFormattedVehicle(bonus, vehicle, vehInfo))

        return result

    def _getUserName(self, vehicle):
        return vehicle.userName

    @classmethod
    def _getLabel(cls, vehicle):
        if cls.__hasUniqueIcon(vehicle):
            return vehicle.userName
        return ''

    @classmethod
    def _getVehicleLabel(cls, bonus, vehicle, vehInfo):
        return cls._getLabel(vehicle)

    @classmethod
    def _getImages(cls, vehicle, isRent=False):
        result = {}
        for size in AWARDS_SIZES.ALL():
            image = ('../maps/icons/quests/bonuses/{}/{}').format(size, getItemIconName(vehicle.name))
            if image in RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_ALL_ENUM:
                result[size] = image
            else:
                if isRent:
                    image = RES_ICONS.getRentVehicleAwardIcon(size)
                else:
                    image = RES_ICONS.getVehicleAwardIcon(size)
                result[size] = image

        return result

    @classmethod
    def __hasUniqueIcon(cls, vehicle):
        for size in AWARDS_SIZES.ALL():
            if cls._getImages(vehicle).get(size) != RES_ICONS.getVehicleAwardIcon(size):
                return True

        return False

    def _appendFormattedVehicle(self, bonus, vehicle, vehInfo):
        tmanRoleLevel = bonus.getTmanRoleLevel(vehInfo)
        rentDays = bonus.getRentDays(vehInfo)
        rentBattles = bonus.getRentBattles(vehInfo)
        rentWins = bonus.getRentWins(vehInfo)
        rentSeason = bonus.getRentSeason(vehInfo)
        rentCycle = bonus.getRentCycle(vehInfo)
        if rentDays:
            rentExpiryTime = time_utils.getCurrentTimestamp()
            rentExpiryTime += rentDays * time_utils.ONE_DAY
        else:
            rentExpiryTime = 0
        isRent = rentDays or rentBattles or rentWins or rentSeason or rentCycle
        return PreformattedBonus(bonusName=bonus.getName(), label=self._getVehicleLabel(bonus, vehicle, vehInfo), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(vehicle), images=self._getImages(vehicle, isRent), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.AWARD_VEHICLE, specialArgs=[
         vehicle.intCD, tmanRoleLevel, rentExpiryTime, rentBattles, rentWins, rentSeason, rentCycle], isCompensation=self._isCompensation(bonus))

    @classmethod
    def _getCompensationFormatter(cls):
        return SimpleBonusFormatter()


class VehiclesNYEpicBonusFormatter(VehiclesBonusFormatter):

    @classmethod
    def _getLabel(cls, vehicle):
        return vehicle.shortUserName

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getImages(cls, vehicle, isRent=False):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getVehicleAwardIcon(size)}

    @classmethod
    def _getCompensationFormatter(cls):
        return SimpleNYEpicBonusFormatter()


class RankedVehiclesBonusFormatter(VehiclesBonusFormatter):

    @classmethod
    def _getLabel(cls, vehicle):
        return vehicle.shortUserName

    @classmethod
    def _getVehicleLabel(cls, bonus, vehicle, vehInfo):
        return cls._getLabel(vehicle)

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.stats


class VehiclesCompensationFormatter(VehiclesBonusFormatter):

    def _formatVehicle(self, bonus, vehicles):
        result = []
        for vehicle, vehInfo in vehicles:
            compensation = bonus.checkIsCompensatedVehicle(vehicle)
            if compensation:
                result.append(self._appendFormattedVehicle(bonus, vehicle, vehInfo))

        return result

    @classmethod
    def _getLabel(cls, vehicle):
        if cls.__hasUniqueIcon(vehicle):
            return vehicle.shortUserName
        return ''

    @classmethod
    def __hasUniqueIcon(cls, vehicle):
        return True


class VehiclesCompensationEpicFormatter(VehiclesCompensationFormatter):

    @classmethod
    def _getImages(cls, vehicle, isRent=False):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getVehicleAwardIcon(size)}


class RentVehiclesBonusFormatter(VehiclesBonusFormatter):

    def _format(self, bonus):
        result = []
        rentVehicles = []
        restVehicles = []
        for vehicle, vehInfo in bonus.getVehicles():
            if bonus.isRentVehicle(vehInfo):
                rentVehicles.append((vehicle, vehInfo))
            elif bonus.isNonZeroCompensation(vehInfo):
                restVehicles.append((vehicle, vehInfo))

        result.extend(self._formatRent(bonus, rentVehicles))
        result.extend(self._formatVehicle(bonus, restVehicles))
        return result

    def _formatRent(self, bonus, vehicles):
        result = []
        if not vehicles:
            return result
        if len(vehicles) == 1:
            result.extend(self._formatVehicle(bonus, vehicles))
        else:
            result.append(PreformattedBonus(bonusName=PACK_RENT_VEHICLES_BONUS, label=formatCountLabel(len(vehicles)), labelFormatter=text_styles.stats, images=self._getRentImages(), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.PACK_RENT_VEHICLES, specialArgs=self._getRentArgs(bonus, vehicles)))
        return result

    @classmethod
    def _getRentImages(cls):
        result = {}
        for size in AWARDS_SIZES.ALL():
            image = RES_ICONS.getRentVehicleAwardIcon(size)
            result[size] = image

        return result

    @classmethod
    def _getRentArgs(cls, bonus, vehicles):
        rentArgs = []
        for vehicle, vehInfo in vehicles:
            rentDays = bonus.getRentDays(vehInfo)
            rentBattles = bonus.getRentBattles(vehInfo)
            rentWins = bonus.getRentWins(vehInfo)
            shortData = {'vehicleName': vehicle.userName, 
               'isPremium': vehicle.isPremium, 
               'vehicleType': vehicle.type, 
               'rentDays': rentDays, 
               'rentBattles': rentBattles, 
               'rentWins': rentWins}
            rentArgs.append(shortData)

        return rentArgs


class NYRentVehiclesBonusFormatter(RentVehiclesBonusFormatter):

    @classmethod
    def _getLabel(cls, vehicle):
        return vehicle.userName


class LinkedSetVehiclesBonusFormatter(VehiclesBonusFormatter):

    @classmethod
    def _getVehicleLabel(cls, bonus, vehicle, vehInfo):
        return formatTimeLabel(bonus.getRentDays(vehInfo) * time_utils.HOURS_IN_DAY)


class DossierBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for badge in bonus.getBadges():
            result.append(PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(badge), images=self._getBadgeImages(badge), isSpecial=True, specialAlias=self._getBadgeTooltipAlias(), specialArgs=[
             badge.badgeID], isCompensation=self._isCompensation(bonus), postProcessTags=(
             PostProcessTags.getBadgeTag(badge),)))

        for achievement in bonus.getAchievements():
            result.append(PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(achievement), images=self._getImages(achievement), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS, specialArgs=[
             achievement.getBlock(), achievement.getName(), achievement.getValue()], isCompensation=self._isCompensation(bonus)))

        return result

    @classmethod
    def _getUserName(cls, achievement):
        return achievement.getUserName()

    @classmethod
    def _getImages(cls, bonus):
        return {AWARDS_SIZES.SMALL: bonus.getSmallIcon(), 
           AWARDS_SIZES.BIG: bonus.getBigIcon()}

    @classmethod
    def _getBadgeImages(cls, bonus):
        return {AWARDS_SIZES.SMALL: bonus.getAwardBadgeIcon(ICONS_SIZES.X48), 
           AWARDS_SIZES.BIG: bonus.getAwardBadgeIcon(ICONS_SIZES.X80)}

    @classmethod
    def _getBadgeTooltipAlias(cls):
        return TOOLTIPS_CONSTANTS.BADGE


class LoyalServiceBonusFormatter(DossierBonusFormatter):

    def _format(self, bonus):
        result = super(LoyalServiceBonusFormatter, self)._format(bonus)
        result.sort(key=lambda preFormattedBonus: int(not (PostProcessTags.IS_PREFIX_BADGE in preFormattedBonus.postProcessTags or PostProcessTags.IS_SUFFIX_BADGE in preFormattedBonus.postProcessTags)))
        return result

    @classmethod
    def _getBadgeTooltipAlias(cls):
        return TOOLTIPS_CONSTANTS.BADGE_LOYAL_SERVICE


class EventBoardsDossierBonusFormatter(DossierBonusFormatter):

    @classmethod
    def _getBadgeTooltipAlias(cls):
        return TOOLTIPS_CONSTANTS.EVENT_BOARDS_BADGE


class BadgesGroupBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        badges = bonus.getBadges()
        groupID = bonus.getValue()
        result.append(PreformattedBonus(images={AWARDS_SIZES.SMALL: RES_ICONS.getEventBoardBadgesGroup(groupID)}, isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.EVENT_BOARDS_BADGES_GROUP, specialArgs=self.__badgesTooltipData(badges), isCompensation=self._isCompensation(bonus)))
        return result

    @classmethod
    def __badgesTooltipData(cls, badges):
        result = []
        for badge in badges:
            result.append({'name': badge.getUserName(), 
               'imgSource': badge.getSmallIcon(), 
               'desc': badge.getUserDescription()})

        return result


class TankmenBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for group in bonus.getTankmenGroups().itervalues():
            if group['skills']:
                key = 'with_skills'
            else:
                key = 'no_skills'
            label = '#quests:bonuses/item/tankmen/%s' % key
            result.append(PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(key), images=self._getImages(bonus), tooltip=makeTooltip(TOOLTIPS.getAwardHeader(bonus.getName()), i18n.makeString(label, **group)), isCompensation=self._isCompensation(bonus)))

        return result

    @classmethod
    def _getUserName(cls, key):
        return i18n.makeString('#quests:bonusName/tankmen/%s' % key)

    @classmethod
    def _getImages(cls, bonus):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, bonus.getName())

        return result


class TankmenMarathonRewardBonusFormatter(TankmenBonusFormatter):

    def _format(self, bonus):
        result = []
        for group in bonus.getTankmenGroups().itervalues():
            if group['skills']:
                key = 'with_skills'
            else:
                key = 'no_skills'
            label = '#quests:bonuses/item/tankmen/%s' % key
            result.append(PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(key), images=self._getImages(bonus), specialAlias=TOOLTIPS_CONSTANTS.TANKMAN, tooltip=makeTooltip(backport.text(R.strings.marathon.rewardTooltip.tankmen.header()), i18n.makeString(label, **group)), isCompensation=self._isCompensation(bonus)))

        return result


class TankwomanBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for tmanInfo in bonus.getTankmenData():
            if tmanInfo.isFemale:
                bonusID = 'tankwoman'
                username = i18n.makeString(QUESTS.BONUSES_ITEM_TANKWOMAN)
                result.append(PreformattedBonus(bonusName=bonus.getName(), userName=username, images=self._getImages(bonusID), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.PERSONAL_MISSIONS_TANKWOMAN, specialArgs=[]))
            else:
                bonusID = 'tankman'
                username = i18n.makeString(QUESTS.BONUSES_TANKMEN_DESCRIPTION, value=getRoleUserName(tmanInfo.role))
                result.append(PreformattedBonus(bonusName=bonus.getName(), userName=username, images=self._getImages(bonusID), tooltip=makeTooltip(i18n.makeString(QUESTS.BONUSES_TANKMEN_DESCRIPTION, value=getRoleUserName(tmanInfo.role)))))

        return result

    @classmethod
    def _getImages(cls, imageID):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, imageID)

        return result


class CustomizationsBonusFormatter(SimpleBonusFormatter):
    c11n = dependency.descriptor(ICustomizationService)

    def _format(self, bonus):
        customizations = zip(bonus.getCustomizations(), bonus.getList())
        result = [ self._createCustomizationBonus(bonus, item, data) for item, data in customizations ]
        return result

    def _formatBonusLabel(self, c11nItem, count):
        return formatCountLabel(count)

    def _makePostprocessTags(self, c11nItem):
        return ''

    def _createCustomizationBonus(self, bonus, item, data):
        c11nItem = bonus.getC11nItem(item)
        return PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(c11nItem), userName=self._getUserName(c11nItem), label=self._formatBonusLabel(c11nItem, count=item.get('value')), labelFormatter=self._getLabelFormatter(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM_AWARD, specialArgs=CustomizationTooltipContext(itemCD=data.get('intCD')), isCompensation=self._isCompensation(bonus), align=LABEL_ALIGN.RIGHT, postProcessTags=self._makePostprocessTags(c11nItem))

    @classmethod
    def _getImages(cls, c11nItem):
        result = {size:cls._getImage(c11nItem, size) for size in AWARDS_SIZES.ALL()}
        return result

    @classmethod
    def _getImage(cls, c11nItem, size):
        iconName = c11nItem.itemTypeName
        if iconName == 'style' and c11nItem.modelsSet:
            iconName = 'style_3d'
        return RES_ICONS.getBonusIcon(size, iconName)

    @classmethod
    def _getUserName(cls, c11nItem):
        return i18n.makeString(QUESTS.getBonusName(c11nItem.itemTypeName))


class RankedCustomizationsBonusFormatter(CustomizationsBonusFormatter):

    @classmethod
    def _getImages(cls, c11nItem):
        result = {}
        for size in AWARDS_SIZES.ALL():
            resource = R.images.gui.maps.icons.rankedBattles.bonusIcons.dyn(('style_{}').format(c11nItem.id))
            iconName = c11nItem.itemTypeName
            if not resource.isValid():
                if iconName == 'style' and c11nItem.modelsSet:
                    iconName = 'style_3d'
                resource = R.images.gui.maps.icons.quests.bonuses.dyn(size).dyn(iconName)
            if resource.isValid():
                result[size] = backport.image(resource())

        return result


class CustomizationsNYBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getImage(cls, c11nItem, size):
        iconName = c11nItem.itemTypeName
        return RES_ICONS.getBonusIcon(size, iconName)

    def _makePostprocessTags(self, c11nItem):
        return c11nItem.itemTypeName


class NyCurrenciesEpicBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getCode(), label=self._getLabel(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus.getCode()), tooltip=str(R.views.lobby.new_year.tooltips.NyResourceTooltip()), align=self._getLabelAlign(bonus), isSpecial=True)]

    @classmethod
    def _getImages(cls, name):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, name)}

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getLabel(cls, bonus):
        label = backport.text(R.strings.ny.resource.withCounter.dyn(bonus.getCode())(), currency=bonus.formatValue())
        return label


class NyBattleTokeEpicBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        for tokenID in bonus.getTokens().iterkeys():
            name = GuestsQuestsTokens.GUEST_C if tokenID == GuestsQuestsTokens.TOKEN_CAT else tokenID
            return [
             PreformattedBonus(bonusName=name, label=self._getLabel(name), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(name), tooltip=str(R.views.lobby.new_year.tooltips.NyRewardKitGuestCTooltip()), align=self._getLabelAlign(bonus), isSpecial=True)]

    @classmethod
    def _getLabel(cls, name):
        label = ''
        if name == GuestsQuestsTokens.GUEST_C:
            label = backport.text(R.strings.ny.guestC.name())
        return label

    @classmethod
    def _getImages(cls, name):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, name)}

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return


class CustomizationsNYEpicBonusFormatter(CustomizationsBonusFormatter):

    @classmethod
    def _formatBonusLabel(cls, c11nItem, count):
        label = c11nItem.userName
        if c11nItem.itemTypeName == 'style':
            res = R.strings.ny.reward.label.style.c_3d if c11nItem.is3D else R.strings.ny.reward.label.style.c_2d
            label = backport.text(res(), name=label)
        return label

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getImages(cls, c11nItem):
        size = EPIC_AWARD_SIZE
        result = {size: cls._getImage(c11nItem, size)}
        return result


class LinkedSetCustomizationsBonusFormatter(CustomizationsBonusFormatter):

    def _formatBonusLabel(self, c11nItem, count):
        return ('x{}').format(count)


class OperationCustomizationsBonusFormatter(CustomizationsBonusFormatter):

    def _format(self, bonus):
        customizations = {}
        for item in bonus.getCustomizations():
            cType = item.get('custType')
            if cType in customizations:
                item, count = customizations[cType]
                customizations[cType] = (item, count + 1)
            else:
                customizations[cType] = (
                 item, 1)

        branch = bonus.getContext().get('branch')
        if branch == PM_BRANCH.REGULAR:
            tooltip = makeTooltip(TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_HEADER, TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_BODY)
        else:
            if branch == PM_BRANCH.PERSONAL_MISSION_2:
                tooltip = makeTooltip(TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_ALLIANCE_HEADER, TOOLTIPS.PERSONALMISSIONS_AWARDS_CAMOUFLAGE_ALLIANCE_BODY)
            else:
                tooltip = None
            result = []
            for item, count in customizations.itervalues():
                c11nItem = bonus.getC11nItem(item)
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(c11nItem), userName=self._getUserName(c11nItem), label=formatCountLabel(count), labelFormatter=self._getLabelFormatter(bonus), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), isSpecial=False, tooltip=tooltip))

        return result


class InstructionEpicBattleBonusFormatter(SimpleBonusFormatter):
    _offersProvider = dependency.descriptor(IOffersDataProvider)

    def _getLabel(self, bonus):
        gifts = self._getGiftsCount(bonus)
        if gifts > 0:
            return formatCountLabel(gifts)
        return ''

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), compensationReason=self._getCompensationReason(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.EPIC_BATTLE_INSTRUCTION_TOOLTIP, specialArgs=[
          self._getTokenName(bonus)])]

    @classmethod
    def _getImages(cls, bonus):
        bonusType = cls._getType(bonus)
        result = {AWARDS_SIZES.SMALL: backport.image(R.images.gui.maps.icons.quests.bonuses.small.dyn(bonusType)()), 
           AWARDS_SIZES.BIG: backport.image(R.images.gui.maps.icons.quests.bonuses.big.dyn(bonusType)())}
        return result

    def _getGiftsCount(self, bonus):
        bonusOffers = []
        for k in bonus.getValue().iterkeys():
            tokenName = k.replace('_gift', '')
            bonusOffers.append(self._offersProvider.getOfferByToken(tokenName))

        giftsCount = 0
        for bonusOffer in bonusOffers:
            if bonusOffer and hasattr(bonusOffer, 'getFirstGift'):
                gift = bonusOffer.getFirstGift()
                giftsCount += gift.giftCount if gift is not None else 0

        return giftsCount

    @classmethod
    def _getTokenName(cls, bonus):
        return bonus.getValue().keys()[0]

    @classmethod
    def _getType(cls, bonus):
        bonusType = cls._getTokenName(bonus).split(':')[2]
        return bonusType


class GoodiesEpicBattleBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        goodID = list(bonus.getValue())[0]
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), compensationReason=self._getCompensationReason(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.EPIC_BATTLE_RECERTIFICATION_FORM_TOOLTIP, specialArgs=[
          goodID])]

    def _getLabel(self, bonus):
        return formatCountLabel(list(bonus.getValue().values())[0]['count'])

    @classmethod
    def _getImages(cls, _):
        return getRecertificationFormImages()


class GoodiesBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for booster, count in bonus.getBoosters().iteritems():
            if booster is not None:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(booster), isSpecial=True, label=formatCountLabel(count), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(booster), specialAlias=TOOLTIPS_CONSTANTS.SHOP_BOOSTER, specialArgs=[
                 booster.boosterID], align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus)))

        for demountKit, count in bonus.getDemountKits().iteritems():
            if demountKit is not None:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getDemountKitImages(demountKit), isSpecial=True, label=formatCountLabel(count), labelFormatter=self._getLabelFormatter(bonus), userName=demountKit.userName, specialAlias=TOOLTIPS_CONSTANTS.AWARD_DEMOUNT_KIT, specialArgs=[
                 demountKit.intCD], align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus)))

        for form, count in bonus.getRecertificationForms().iteritems():
            if form is not None:
                result.append(PreformattedBonus(bonusName=bonus.getName(), label=formatCountLabel(count), userName=form.userName, labelFormatter=self._getLabelFormatter(bonus), images=self._getImagesRecertificationForm(form), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.EPIC_BATTLE_RECERTIFICATION_FORM_TOOLTIP, specialArgs=[
                 form.goodieID]))

        return result

    @classmethod
    def _getImagesRecertificationForm(cls, _):
        return getRecertificationFormImages()

    @classmethod
    def _getImages(cls, booster):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, booster.getFullNameForResource())

        return result

    @classmethod
    def _getDemountKitImages(cls, demountKit):
        return {AWARDS_SIZES.SMALL: demountKit.getIcon(ICONS_SIZES.X48), 
           AWARDS_SIZES.BIG: demountKit.getIcon(ICONS_SIZES.X80)}

    @classmethod
    def _getUserName(cls, booster):
        return booster.userName


class GoodiesEpicBonusFormatter(GoodiesBonusFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.textEpic

    @classmethod
    def _getIcon(cls, guiTypeName):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, guiTypeName)}

    @classmethod
    def _getImages(cls, booster):
        return cls._getIcon(booster.getFullNameForResource())

    @classmethod
    def _getDemountKitImages(cls, demountKit):
        return cls._getIcon(demountKit.demountKitGuiType)


class GoodiesGiftMachineEpicBonusFormatter(GoodiesBonusFormatter):

    @classmethod
    def _getImages(cls, booster):
        size = EPIC_AWARD_SIZE
        return {size: booster.getFullNameForResource()}

    @classmethod
    def _getLabel(cls, bonus):
        if bonus.getValue():
            return str(bonus.getValue())
        else:
            return

    @classmethod
    def _getDemountKitImages(cls, demountKit):
        size = EPIC_AWARD_SIZE
        return {size: demountKit.demountKitGuiType}


class ItemsBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for item, count in sorted(bonus.getItems().items(), key=lambda i: i[0]):
            if item is not None and count:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(item), isSpecial=True, label=self._formatBonusLabel(item, count), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(item), specialAlias=self.getTooltip(item), specialArgs=[
                 item.intCD], align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), highlightType=self._getHighlightType(item), overlayType=self._getOverlayType(item), highlightIcon=self._getHighlightIcon(item), overlayIcon=self._getOverlayIcon(item)))

        return result

    def _formatBonusLabel(self, item, count):
        return formatCountLabel(count)

    @classmethod
    def _getUserName(cls, item):
        return item.userName

    @classmethod
    def _getImages(cls, item):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, item.getGUIEmblemID())

        return result

    @classmethod
    def getTooltip(cls, item):
        if item.itemTypeID == GUI_ITEM_TYPE.EQUIPMENT and 'avatar' in item.tags:
            return TOOLTIPS_CONSTANTS.BATTLE_CONSUMABLE
        if item.itemTypeID == GUI_ITEM_TYPE.SHELL:
            return TOOLTIPS_CONSTANTS.AWARD_SHELL
        if item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER:
            return TOOLTIPS_CONSTANTS.AWARD_BATTLE_BOOSTER
        return TOOLTIPS_CONSTANTS.AWARD_MODULE

    @classmethod
    def _getHighlightType(cls, item):
        return {AWARDS_SIZES.BIG: item.getBigHighlightType(), 
           AWARDS_SIZES.SMALL: item.getHighlightType()}

    @classmethod
    def _getOverlayType(cls, item):
        return {AWARDS_SIZES.BIG: item.getBigOverlayType(), 
           AWARDS_SIZES.SMALL: item.getOverlayType()}

    @classmethod
    def _getHighlightIcon(cls, item):
        result = {}
        for size in AWARDS_SIZES.ALL():
            if item.itemTypeName == SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_NAME:
                result[size] = RES_ICONS.getBonusHighlight(size, SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER)
            else:
                result[size] = SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT

        return result

    @classmethod
    def _getOverlayIcon(cls, item):
        result = {}
        itemTypeName = item.itemTypeName
        for size in AWARDS_SIZES.ALL():
            if itemTypeName == SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_NAME:
                if item.isCrewBooster():
                    result[size] = RES_ICONS.getBonusOverlay(size, SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_CREW_REPLACE)
                else:
                    result[size] = RES_ICONS.getBonusOverlay(size, SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER)
            elif item.getOverlayType():
                name = item.getOverlayType()
                if name == SLOT_HIGHLIGHT_TYPES.EQUIPMENT_MODERNIZED:
                    name = ('{}_{}').format(name, item.level)
                result[size] = RES_ICONS.getBonusOverlay(size, name)

        return result


class ItemsEpicBonusFormatter(ItemsBonusFormatter):

    @classmethod
    def _getImages(cls, item):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, item.getGUIEmblemID())}


class ItemsGiftMachineEpicBonusFormatter(ItemsBonusFormatter):

    @classmethod
    def _getImages(cls, item):
        size = EPIC_AWARD_SIZE
        return {size: item.getGUIEmblemID()}

    @classmethod
    def _getOverlayType(cls, item):
        size = EPIC_AWARD_SIZE
        return {size: item.getOverlayType()}

    @classmethod
    def _formatBonusLabel(cls, item, count):
        return count


class ItemsNYEpicBonusFormatter(ItemsEpicBonusFormatter):

    def _format(self, bonus):
        result = []
        for item, count in sorted(bonus.getItems().items(), key=lambda i: i[0]):
            if item is not None and count:
                result.append(PreformattedBonus(bonusName=item.getGUIEmblemID() if item.isModernized else bonus.getName(), images=self._getImages(item), isSpecial=True, label=self._formatBonusLabel(item, count), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(item), specialAlias=self.getTooltip(item), specialArgs=[
                 item.intCD], align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonus), highlightType=self._getHighlightType(item), overlayType=self._getOverlayType(item), highlightIcon=self._getHighlightIcon(item), overlayIcon=self._getOverlayIcon(item)))

        return result

    @classmethod
    def _formatBonusLabel(cls, item, count):
        label = ''
        if item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER:
            if count == 1:
                label = backport.text(R.strings.ny.reward.label.booster())
            else:
                label = backport.text(R.strings.ny.reward.label.boosters(), count=count)
        elif item.itemTypeID == GUI_ITEM_TYPE.EQUIPMENT:
            if count == 1:
                label = item.descriptor.i18n.shortString
            else:
                res = R.strings.ny.reward.label.equipment.dyn(item.name)
                if res.exists():
                    label = backport.text(res(), count=count)
        return label

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return


class LinkedSetItemsBonusFormatter(ItemsBonusFormatter):

    def _formatBonusLabel(self, item, count):
        return ('x{}').format(count)


class NewYearToyFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        toys = self.__mergeToys(bonus.getValue())
        for toyId, toyData in toys.iteritems():
            result.append(self._toyFormat(bonus, toyId, toyData['count'], toyData['newCount']))

        return result

    def _toyFormat(self, bonus, toyID, count, newCount):
        return PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(toyID), label=self._getToyLabel(toyID, count), labelFormatter=self._getLabelFormatter(bonus), align=self._getLabelAlign(bonus), userName=self._getUserName(toyID), specialArgs=[
         toyID, count], newCount=newCount)

    def __mergeToys(self, toys):
        result = {}
        for toysData in toys.itervalues():
            newCount = toysData.pop('newCount', 0)
            for toyId, _ in toysData.iteritems():
                if result.get(toyId):
                    result[toyId]['count'] += toysData[toyId]
                    result[toyId]['newCount'] += newCount
                else:
                    result[toyId] = {'count': toysData[toyId], 'newCount': newCount}

        return result

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.RIGHT

    @classmethod
    def _getToyLabel(cls, toyID, count):
        toyName = backport.text(NewYearCurrentToyInfo(toyID).getName())
        if count > 1:
            return backport.text(R.strings.ny.reward.label.toyWithCount()).format(toyName=toyName, count=count)
        return toyName

    @classmethod
    def _getImages(cls, toyID):
        toyInfo = NewYearCurrentToyInfo(toyID)
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = backport.image(toyInfo.getIcon())

        return result

    @classmethod
    def _getUserName(cls, toyID):
        toyInfo = NewYearCurrentToyInfo(toyID)
        return backport.text(toyInfo.getName())


class NewYearToyEpicFormatter(NewYearToyFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getLabelAlign(cls, bonus):
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getImages(cls, toyID):
        toyInfo = NewYearCurrentToyInfo(toyID)
        return {EPIC_AWARD_SIZE: backport.image(toyInfo.getIcon(size=LARGE_AWARD_SIZE))}


class EpicItemsBonusFormatter(ItemsBonusFormatter):

    @classmethod
    def _getImages(cls, item):
        result = {}
        for size in AWARDS_SIZES.ALL():
            if item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER and item.isCrewBooster():
                result[size] = RES_ICONS.getBonusIcon(size, item.name)
            else:
                result[size] = RES_ICONS.getBonusIcon(size, item.getGUIEmblemID())

        result['tooltip'] = item.getBonusIcon(AWARDS_SIZES.BIG)
        return result

    @classmethod
    def _getOverlayType(cls, item):
        result = super(EpicItemsBonusFormatter, cls)._getOverlayType(item)
        if item.itemTypeName == SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_NAME:
            if not item.isCrewBooster():
                result[AWARDS_SIZES.BIG] = SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_BIG
                result[AWARDS_SIZES.SMALL] = SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER
            else:
                result[AWARDS_SIZES.BIG] = result[AWARDS_SIZES.SMALL] = SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT
        return result

    @classmethod
    def _getOverlayIcon(cls, item):
        result = super(EpicItemsBonusFormatter, cls)._getOverlayIcon(item)
        itemTypeName = item.itemTypeName
        for size in AWARDS_SIZES.ALL():
            if itemTypeName == SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER_NAME:
                if not item.isCrewBooster():
                    result[size] = RES_ICONS.getBonusOverlay(size, SLOT_HIGHLIGHT_TYPES.BATTLE_BOOSTER)
                else:
                    result[size] = SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT

        return result


class RankedItemsBonusFormatter(ItemsBonusFormatter):

    @classmethod
    def _getHighlightType(cls, item):
        if item.itemTypeID == GUI_ITEM_TYPE.OPTIONALDEVICE and item.isDeluxe:
            return {}
        return super(RankedItemsBonusFormatter, cls)._getHighlightType(item)


class EpicDossierBonusFormatter(DossierBonusFormatter):

    @classmethod
    def _getImages(cls, bonus):
        if isinstance(bonus, Badge):
            return {AWARDS_SIZES.SMALL: bonus.getSmallIcon(), 
               AWARDS_SIZES.BIG: bonus.getBigIcon()}
        bonus, record = bonus.getRecordName()
        return {AWARDS_SIZES.SMALL: RES_ICONS.getEpicAchievementIcon(ICONS_SIZES.X48, record), 
           AWARDS_SIZES.BIG: RES_ICONS.getEpicAchievementIcon(ICONS_SIZES.X80, record)}


class BlueprintBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonuses):
        isPackedBonuses = bonuses.canPacked()
        bonus = [
         PreformattedBonus(bonusName=bonuses.getBlueprintName(), label=self._getLabel(bonuses), userName=bonuses.getBlueprintTooltipName(), labelFormatter=self._getLabelFormatter(bonuses), images=self._getIcons(bonuses), tooltip=bonuses.getTooltip(), align=self._getLabelAlign(bonuses), isCompensation=self._isCompensation(bonuses), specialArgs=[
          bonuses.getBlueprintSpecialArgs()], isSpecial=True, specialAlias=bonuses.getBlueprintSpecialAlias())]
        if not isPackedBonuses:
            return bonus * bonuses.getCount()
        return bonus

    @classmethod
    def _getLabel(cls, bonuses):
        isPackedBonuses = bonuses.canPacked()
        if isPackedBonuses:
            return formatCountLabel(bonuses.getCount())
        return bonuses.formatBlueprintValue()

    @classmethod
    def _getLabelAlign(cls, bonuses):
        return LABEL_ALIGN.RIGHT

    def _getIcons(self, bonus):
        res = {}
        for size in AWARDS_SIZES.ALL():
            res[size] = bonus.getImage(size)

        return res


class BlueprintNYBonusFormatter(BlueprintBonusFormatter):

    def _format(self, bonuses):
        bonus = [
         PreformattedBonus(bonusName=bonuses.getBlueprintName(), label=self._getLabel(bonuses), userName=bonuses.formatUserNameValue(), labelFormatter=self._getLabelFormatter(bonuses), images=self._getIcons(bonuses), tooltip=bonuses.getTooltip(), align=self._getLabelAlign(bonuses), isCompensation=self._isCompensation(bonuses), specialArgs=[
          bonuses.getBlueprintSpecialArgs()], isSpecial=True, specialAlias=bonuses.getBlueprintSpecialAlias())]
        return bonus

    @classmethod
    def _getLabel(cls, bonuses):
        return formatCountLabel(bonuses.getCount())

    @classmethod
    def _getLabelAlign(cls, bonuses):
        return LABEL_ALIGN.RIGHT

    def _getIcons(self, bonuses):
        res = {}
        iconName = bonuses.getImageCategory()
        for size in AWARDS_SIZES.ALL():
            sizeFolderResId = R.images.gui.maps.icons.blueprints.fragment.dyn(size, None)
            if sizeFolderResId is None and not sizeFolderResId.exists():
                res[size] = ''
            iconResId = sizeFolderResId.dyn(iconName, None)
            if iconResId is None and not iconResId.exists():
                res[size] = ''
            res[size] = backport.image(iconResId())

        return res


class BlueprintNYEpicBonusFormatter(BlueprintNYBonusFormatter):

    @classmethod
    def _getLabel(cls, bonuses):
        try:
            label = bonuses.getEpicAwardLabel()
        except NameError:
            _logger.error('Wrong blueprint bonus type: %s', bonuses.getBlueprintName())
            label = ''

        return label

    @classmethod
    def _getLabelFormatter(cls, bonuses):
        return

    @classmethod
    def _getLabelAlign(cls, bonuses):
        return LABEL_ALIGN.CENTER

    def _getIcons(self, item):
        size = EPIC_AWARD_SIZE
        image = backport.image(R.images.gui.maps.icons.blueprints.fragment.s360x270.dyn(item.getImageCategory())())
        return {size: image}


class BlueprintGroupBonusFormatter(BlueprintBonusFormatter):

    def _format(self, bonuses):
        return [
         PreformattedBonus(bonusName=bonuses.getBlueprintName(), label=formatCountLabel(bonuses.getCount()), userName=bonuses.getBlueprintTooltipName(), labelFormatter=self._getLabelFormatter(bonuses), images=self._getIcons(bonuses), tooltip=bonuses.getTooltip(), align=LABEL_ALIGN.RIGHT, isCompensation=self._isCompensation(bonuses), specialArgs=[
          bonuses.getBlueprintSpecialArgs()], isSpecial=True, specialAlias=bonuses.getBlueprintSpecialAlias(), postProcessTags='blueprints')]


class BlueprintGroupEpicBonusFormatter(BlueprintGroupBonusFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.textEpic

    def _getIcons(self, bonuses):
        size = EPIC_AWARD_SIZE
        return {size: RES_ICONS.getBonusIcon(size, bonuses.getImageCategory())}


class CrewSkinsBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        compensationFormatter = SimpleBonusFormatter()
        for item, count, customCompensation, compensatedNumber in bonus.getItems():
            compensations = bonus.compensation(compensatedNumber, customCompensation, bonus)
            if compensations:
                for bonusComp in compensations:
                    formattedComp = compensationFormatter.format(bonusComp)
                    result.extend(formattedComp)

            elif item is not None and count:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(item), isSpecial=True, label=formatCountLabel(count), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(item), align=self._getLabelAlign(count), isCompensation=self._isCompensation(bonus), specialAlias=TOOLTIPS_CONSTANTS.CREW_SKIN, specialArgs=[
                 item.getID(), count], postProcessTags='crewSkin'))

        return result

    @classmethod
    def _getLabelAlign(cls, count):
        if count > 1:
            return LABEL_ALIGN.RIGHT
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getUserName(cls, item):
        return localizedFullName(item)

    @classmethod
    def _getImages(cls, item):
        result = {}
        rarity = item.getRarity()
        for size in AWARDS_SIZES.ALL():
            sizePath = R.images.gui.maps.icons.quests.bonuses.dyn(size, None)
            if sizePath is not None:
                img = sizePath.dyn(item.itemTypeName + str(rarity))
                if img is not None and img.exists():
                    result[size] = backport.image(img())

        return result


class CrewBooksBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        result = []
        for item, count in bonus.getItems():
            if item is not None and count:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(item), isSpecial=True, label=self._getLabel(count), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(item), align=self._getLabelAlign(count), isCompensation=self._isCompensation(bonus), specialAlias=TOOLTIPS_CONSTANTS.CREW_BOOK, specialArgs=[
                 item.intCD, count], postProcessTags=item.getBookType()))

        return result

    @classmethod
    def _getLabel(cls, count):
        return formatCountLabel(count)

    @classmethod
    def _getLabelAlign(cls, count):
        if count > 1:
            return LABEL_ALIGN.RIGHT
        return LABEL_ALIGN.CENTER

    @classmethod
    def _getUserName(cls, item):
        return item.userName

    @classmethod
    def _getImages(cls, item):
        result = {}
        for size in AWARDS_SIZES.ALL():
            sizePath = R.images.gui.maps.icons.crewBooks.books.dyn(size, None)
            if sizePath is not None:
                img = sizePath.dyn(item.getBonusIconName())
                if img is not None and img.exists():
                    result[size] = backport.image(img())

        return result


class CrewBooksEpicBonusFormatter(CrewBooksBonusFormatter):

    @classmethod
    def _getImages(cls, item):
        result = {}
        size = EPIC_AWARD_SIZE
        sizePath = R.images.gui.maps.icons.crewBooks.books.dyn(size, None)
        if sizePath is not None:
            img = sizePath.dyn(item.getBonusIconName())
            if img is not None and img.exists():
                result[size] = backport.image(img())
        return result


class CrewBooksNYEpicBonusFormatter(CrewBooksEpicBonusFormatter):

    @classmethod
    def _getLabel(cls, count):
        if count == 1:
            label = backport.text(R.strings.ny.reward.label.crewbook())
        else:
            label = backport.text(R.strings.ny.reward.label.crewbooks(), count=count)
        return label

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return

    @classmethod
    def _getLabelAlign(cls, count):
        return LABEL_ALIGN.CENTER


class CrewBooksGiftMachineEpicBonusFormatter(CrewBooksEpicBonusFormatter):

    @classmethod
    def _getImages(cls, item):
        size = EPIC_AWARD_SIZE
        return {size: item.getBonusIconName()}


class CrewSkinsCompensationFormatter(CrewSkinsBonusFormatter):

    def _format(self, bonus):
        result = []
        for item, count, _, compensatedNumber in bonus.getItems():
            if item is not None and compensatedNumber > 0:
                result.append(PreformattedBonus(bonusName=bonus.getName(), images=self._getImages(item), isSpecial=True, label=self._formatBonusLabel(item, count, compensatedNumber), labelFormatter=self._getLabelFormatter(bonus), userName=self._getUserName(item), align=self._getLabelAlign(compensatedNumber), isCompensation=self._isCompensation(bonus), specialAlias=TOOLTIPS_CONSTANTS.CREW_SKIN, specialArgs=[
                 item.getID(), compensatedNumber]))

        return result

    def _formatBonusLabel(self, item, _, compensatedNumber):
        defaultStr = text_styles.stats(backport.text(R.strings.item_types.crewSkins.itemType.dyn(Rarity.STRINGS[item.getRarity()])()))
        formattedStr = formatCountLabel(count=compensatedNumber, defaultStr=defaultStr)
        return formattedStr


class NewYearFillersBonusFormatter(CountableIntegralBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=formatCountLabel(bonus.getValue()), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.NY_FILLERS, specialArgs=[])]


class EntitlementFormatter(SimpleBonusFormatter):

    @classmethod
    def _getImages(cls, bonus):
        images = {}
        for size in AWARDS_SIZES.ALL():
            images[size] = bonus.getIconBySize(size)

        return images

    def _format(self, bonus):
        result = []
        if bonus.isShowInGUI():
            result.append(self.__formatEntitlement(bonus))
        return result

    def __formatEntitlement(self, bonus):
        value = bonus.getValue()
        tooltipData = bonus.getTooltipData()
        isFormattedAmount = bonus.isFormattedAmount(value.id)
        return PreformattedBonus(bonusName=bonus.getName(), userName=bonus.getUserName(value.id), label=formatCountLabel(value.amount) if isFormattedAmount else backport.getIntegralFormat(value.amount), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=tooltipData.tooltip, isSpecial=tooltipData.isSpecial, specialAlias=tooltipData.specialAlias, specialArgs=tooltipData.specialArgs, align=LABEL_ALIGN.RIGHT if isFormattedAmount else LABEL_ALIGN.CENTER, isCompensation=self._isCompensation(bonus))


class BattlePassBonusFormatter(SimpleBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus), compensationReason=self._getCompensationReason(bonus), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BATTLE_PASS_POINTS, specialArgs=[])]

    @classmethod
    def _getImages(cls, bonus):
        images = {}
        for size in AWARDS_SIZES.ALL():
            image = bonus.getIconBySize(size)
            if image is not None:
                images[size] = image

        return images


class BattlePassEpicBonusFormatter(BattlePassBonusFormatter):

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return text_styles.textEpic

    @classmethod
    def _getImages(cls, bonus):
        images = {}
        size = EPIC_AWARD_SIZE
        image = bonus.getIconBySize(size)
        if image is not None:
            images[size] = image
        return images


class CurrenciesBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getUserName(cls, bonus):
        return i18n.makeString(QUESTS.getBonusName(bonus.getCode()))

    @classmethod
    def _getImages(cls, bonus):
        return {AWARDS_SIZES.SMALL: bonus.getIconBySize(AWARDS_SIZES.SMALL), 
           AWARDS_SIZES.BIG: bonus.getIconBySize(AWARDS_SIZES.BIG)}

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return TEXT_FORMATTERS.get(bonus.getCode(), text_styles.stats)

    def _format(self, bonus):
        tooltipData = bonus.getTooltipData()
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=tooltipData.tooltip, isSpecial=tooltipData.isSpecial, specialAlias=tooltipData.specialAlias, specialArgs=tooltipData.specialArgs, align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus), highlightType=self._getHighlightType(bonus), overlayType=self._getOverlayType(bonus), highlightIcon=self._getHighlightIcon(bonus), overlayIcon=self._getOverlayIcon(bonus), compensationReason=self._getCompensationReason(bonus))]


class NYRandomResourceBonusFormatter(CurrenciesBonusFormatter):

    @classmethod
    def _getUserName(cls, bonus):
        return i18n.makeString(QUESTS.getBonusName(bonus.getName()))

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return TEXT_FORMATTERS.get(text_styles.stats)


class NYCoinBonusFormatter(TokenBonusFormatter):

    @classmethod
    def _getImages(cls, bonus):
        return {AWARDS_SIZES.SMALL: bonus.getIconBySize(AWARDS_SIZES.SMALL), 
           AWARDS_SIZES.BIG: bonus.getIconBySize(AWARDS_SIZES.BIG)}

    def _format(self, bonus):
        tooltipData = bonus.getTooltipData()
        return [
         PreformattedBonus(bonusName=bonus.getName(), label=self._getLabel(bonus), userName=self._getUserName(bonus), labelFormatter=self._getLabelFormatter(bonus), images=self._getImages(bonus), tooltip=tooltipData.tooltip, isSpecial=tooltipData.isSpecial, specialAlias=tooltipData.specialAlias, specialArgs=tooltipData.specialArgs, align=self._getLabelAlign(bonus), isCompensation=self._isCompensation(bonus), highlightType=self._getHighlightType(bonus), overlayType=self._getOverlayType(bonus), highlightIcon=self._getHighlightIcon(bonus), overlayIcon=self._getOverlayIcon(bonus), compensationReason=self._getCompensationReason(bonus))]

    @classmethod
    def _getUserName(cls, bonus):
        return backport.text(R.strings.lootboxes.type.nyCoin())

    @classmethod
    def _getLabelFormatter(cls, bonus):
        return TEXT_FORMATTERS.get(text_styles.stats)


class EpicSelectTokenFormatter(SimpleBonusFormatter):

    @classmethod
    def _getImages(cls, bonus):
        result = {AWARDS_SIZES.SMALL: backport.image(R.images.gui.maps.icons.epicBattles.awards.c_48x48.abilityToken()), 
           AWARDS_SIZES.BIG: backport.image(R.images.gui.maps.icons.epicBattles.awards.c_80x80.abilityToken())}
        return result