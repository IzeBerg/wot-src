import copy, functools, types
from collections import namedtuple
from typing import TYPE_CHECKING
import logging, constants, post_progression_common, year_hare_affair_common
from Event import Event
from constants import IS_TUTORIAL_ENABLED, PremiumConfigs, DAILY_QUESTS_CONFIG, ClansConfig, MAGNETIC_AUTO_AIM_CONFIG, Configs, DOG_TAGS_CONFIG, BATTLE_NOTIFIER_CONFIG, MISC_GUI_SETTINGS, RENEWABLE_SUBSCRIPTION_CONFIG
from helpers import time_utils
from ranked_common import SwitchState
from collector_vehicle import CollectorVehicleConsts
from debug_utils import LOG_WARNING, LOG_DEBUG
from battle_pass_common import BattlePassConfig, BATTLE_PASS_CONFIG_NAME
from gui import GUI_SETTINGS, SystemMessages
from gui.SystemMessages import SM_TYPE
from gui.Scaleform.locale.SYSTEM_MESSAGES import SYSTEM_MESSAGES
from gui.shared.utils.decorators import ReprInjector
from personal_missions import PM_BRANCH
from renewable_subscription_common.settings_constants import GOLD_RESERVE_GAINS_SECTION
from post_progression_common import FEATURE_BY_GROUP_ID, ROLESLOT_FEATURE
from shared_utils import makeTupleByDict, updateDict
from UnitBase import PREBATTLE_TYPE_TO_UNIT_ASSEMBLER, UNIT_ASSEMBLER_IMPL_TO_CONFIG
from BonusCaps import BonusCapsConst
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS as BONUS_CAPS
from telecom_rentals_common import TELECOM_RENTALS_CONFIG
if TYPE_CHECKING:
    from typing import Dict, List
_logger = logging.getLogger(__name__)
_CLAN_EMBLEMS_SIZE_MAPPING = {16: 'clan_emblems_16', 
   32: 'clan_emblems_small', 
   64: 'clan_emblems_big', 
   128: 'clan_emblems_128', 
   256: 'clan_emblems_256'}

@ReprInjector.simple((
 'centerID', 'centerID'), ('dbidMin', 'dbidMin'), (
 'dbidMax', 'dbidMax'), ('regionCode', 'regionCode'))
class _ServerInfo(object):
    __slots__ = ('centerID', 'dbidMin', 'dbidMax', 'regionCode')

    def __init__(self, centerID, dbidMin, dbidMax, regionCode):
        self.centerID = centerID
        self.dbidMin = dbidMin
        self.dbidMax = dbidMax
        self.regionCode = regionCode

    def isPlayerHome(self, playerDBID):
        return self.dbidMin <= playerDBID <= self.dbidMax


class RoamingSettings(namedtuple('RoamingSettings', ('homeCenterID', 'curCenterID', 'servers'))):
    __slots__ = ()

    def getHomeCenterID(self):
        return self.homeCenterID

    def getCurrentCenterID(self):
        return self.curCenterID

    def getRoamingServers(self):
        return self.servers

    def getPlayerHome(self, playerDBID):
        for s in self.getRoamingServers():
            if s.isPlayerHome(playerDBID):
                return (s.centerID, s.regionCode)

        return (None, None)

    def isEnabled(self):
        return GUI_SETTINGS.roaming

    def isSameRealm(self, playerDBID):
        centerID, _ = self.getPlayerHome(playerDBID)
        return centerID == self.getHomeCenterID()

    def isInRoaming(self):
        return self.getCurrentCenterID() != self.getHomeCenterID()

    def isPlayerInRoaming(self, playerDBID):
        centerID, _ = self.getPlayerHome(playerDBID)
        return centerID != self.getCurrentCenterID()

    @classmethod
    def defaults(cls):
        return cls(0, 0, [])


class _FileServerSettings(object):

    def __init__(self, fsSettings):
        self.__urls = dict((n, d.get('url_template', '')) for n, d in fsSettings.iteritems())

    def getUrls(self):
        return self.__urls

    def getClanEmblemBySize(self, clanDBID, size):
        return self.__getUrl(_CLAN_EMBLEMS_SIZE_MAPPING[size], clanDBID)

    def getClanEmblem64x64VehicleUrl(self, clanDBID):
        return self.__getUrl('clan_emblems', clanDBID)

    def getRareAchievement67x71Url(self, rareAchieveID):
        return self.__getUrl('rare_achievements_images', rareAchieveID)

    def getRareAchievement128x128Url(self, rareAchieveID):
        return self.__getUrl('rare_achievements_images_big', rareAchieveID)

    def getRareAchievementTextsUrl(self, langID):
        return self.__getUrl('rare_achievements_texts', langID)

    def getMissionsTokenImageUrl(self, tokenID, size):
        return self.__getUrl('missions_token_image', size, tokenID)

    def getMissionsTokenDescrsUrl(self, langID):
        return self.__getUrl('missions_token_descrs', langID)

    def getMissionsDecorationUrl(self, decorationID, size):
        return self.__getUrl('missions_decoration', size, decorationID)

    def getOffersRootUrl(self):
        return self.__getUrl('offers')

    def __getUrl(self, urlKey, *args):
        try:
            return self.__urls[urlKey] % args
        except (KeyError, TypeError):
            LOG_WARNING('There is invalid url while getting emblem from web', urlKey, args)

        return

    @classmethod
    def defaults(cls):
        return cls({})


class _RegionalSettings(namedtuple('_RegionalSettings', (
 'starting_day_of_a_new_week',
 'starting_time_of_a_new_day',
 'starting_time_of_a_new_game_day'))):
    __slots__ = ()

    def getWeekStartingDay(self):
        return self.starting_day_of_a_new_week

    def getDayStartingTime(self):
        return self.starting_time_of_a_new_day

    def getGameDayStartingTime(self):
        return self.starting_time_of_a_new_game_day

    @classmethod
    def defaults(cls):
        return cls(0, 0, 3)


class _ESportCurrentSeason(namedtuple('_ESportSeason', (
 'eSportSeasonID',
 'eSportSeasonStart',
 'eSportSeasonFinish'))):
    __slots__ = ()

    def getID(self):
        return self.eSportSeasonID

    def getStartTime(self):
        return self.eSportSeasonStart

    def getFinishTime(self):
        return self.eSportSeasonFinish

    @classmethod
    def defaults(cls):
        return cls(0, 0, 0)


class _Wgcg(namedtuple('_Wgcg', ('enabled', 'url', 'type', 'loginOnStart'))):
    __slots__ = ()

    def isEnabled(self):
        return self.enabled

    def getAccessorType(self):
        return self.type

    def getGateUrl(self):
        return self.url

    def getLoginOnStart(self):
        return self.loginOnStart

    @classmethod
    def defaults(cls):
        return cls(False, '', '', False)


class _Wgnp(namedtuple('_Wgnp', ('enabled', 'url'))):
    __slots__ = ()

    def isEnabled(self):
        return self.enabled

    def getUrl(self):
        return self.url

    @classmethod
    def defaults(cls):
        return cls(False, '')


class _ClanProfile(namedtuple('_ClanProfile', ('enabled',))):
    __slots__ = ()

    def isEnabled(self):
        return self.enabled

    @classmethod
    def defaults(cls):
        return cls(False)


class _StrongholdSettings(namedtuple('_StrongholdSettings', ('wgshHostUrl',))):
    __slots__ = ()

    @classmethod
    def defaults(cls):
        return cls('')


class _TournamentSettings(namedtuple('_TournamentSettings', ('tmsHostUrl',))):
    __slots__ = ()

    @classmethod
    def defaults(cls):
        return cls('')


class _FrontlineSettings(namedtuple('_FrontlineSettings', (
 'isEpicTrainingEnabled',))):
    __slots__ = ()

    @classmethod
    def defaults(cls):
        return cls(False)


class _SpgRedesignFeatures(namedtuple('_SpgRedesignFeatures', (
 'stunEnabled',
 'markTargetAreaEnabled'))):
    __slots__ = ()

    def isStunEnabled(self):
        return self.stunEnabled

    @classmethod
    def defaults(cls):
        return cls(False, False)


class _BwHallOfFame(namedtuple('_BwHallOfFame', ('hofHostUrl', 'isHofEnabled', 'isStatusEnabled'))):
    __slots__ = ()

    def __new__(cls, hofHostUrl=None, isHofEnabled=False, isStatusEnabled=False):
        return super(_BwHallOfFame, cls).__new__(cls, hofHostUrl, isHofEnabled, isStatusEnabled)

    @classmethod
    def defaults(cls):
        return cls()


class _BwShop(namedtuple('_BwShop', (
 'hostUrl', 'isStorageEnabled'))):

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


_BwShop.__new__.__defaults__ = (
 '', '', False)

class _BwProductCatalog(namedtuple('_BwProductCatalog', ('url',))):

    @classmethod
    def defaults(cls):
        return cls('')


_BwProductCatalog.__new__.__defaults__ = (
 '',)

class RankedBattlesConfig(namedtuple('RankedBattlesConfig', ('isEnabled', 'peripheryIDs', 'winnerRankChanges', 'loserRankChanges', 'minXP',
 'unburnableRanks', 'unburnableStepRanks', 'minLevel', 'maxLevel', 'accRanks',
 'accSteps', 'cycleFinishSeconds', 'primeTimes', 'seasons', 'cycleTimes', 'shields',
 'divisions', 'bonusBattlesMultiplier', 'expectedSeasons', 'yearAwardsMarks',
 'rankGroups', 'qualificationBattles', 'yearLBSize', 'leaguesBonusBattles',
 'forbiddenClassTags', 'forbiddenVehTypes', 'shopState', 'yearLBState',
 'yearRewardState', 'seasonRatingPageUrl', 'yearRatingPageUrl', 'infoPageUrl',
 'introPageUrl', 'seasonGapPageUrl', 'shopPageUrl', 'hasSpecialSeason'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, peripheryIDs={}, winnerRankChanges=(), loserRankChanges=(), minXP=0, unburnableRanks={}, unburnableStepRanks={}, minLevel=0, maxLevel=0, accRanks=0, accSteps=(), cycleFinishSeconds=0, primeTimes={}, seasons={}, cycleTimes=(), shields={}, divisions={}, bonusBattlesMultiplier=0, expectedSeasons=0, yearAwardsMarks=(), rankGroups=(), qualificationBattles=0, yearLBSize=0, leaguesBonusBattles=(), forbiddenClassTags=(), forbiddenVehTypes=(), shopState=SwitchState.DISABLED, yearLBState=SwitchState.DISABLED, yearRewardState=SwitchState.ENABLED, seasonRatingPageUrl='', yearRatingPageUrl='', infoPageUrl='', introPageUrl='', seasonGapPageUrl='', shopPageUrl='', hasSpecialSeason=False)
        defaults.update(kwargs)
        return super(RankedBattlesConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    @classmethod
    def defaults(cls):
        return cls()


class _ProgressiveReward(namedtuple('_ProgressiveReward', (
 'isEnabled', 'levelTokenID', 'probabilityTokenID', 'maxLevel'))):

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


_ProgressiveReward.__new__.__defaults__ = (
 True, 'pr:level', 'pr:probability', 0)

class _EpicMetaGameConfig(namedtuple('_EpicMetaGameConfig', ['maxCombatReserveLevel', 'seasonData', 'metaLevel', 'rewards', 'defaultSlots', 'slots'])):

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


_EpicMetaGameConfig.__new__.__defaults__ = (
 0, (0, False), (0, 0, 0), {}, {}, {})

class EpicGameConfig(namedtuple('EpicGameConfig', ('isEnabled', 'validVehicleLevels', 'seasons', 'cycleTimes', 'unlockableInBattleVehLevels',
 'peripheryIDs', 'primeTimes', 'url'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, validVehicleLevels=[], unlockableInBattleVehLevels=[], seasons={}, cycleTimes=(), peripheryIDs={}, primeTimes={}, url='')
        defaults.update(kwargs)
        return super(EpicGameConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    @classmethod
    def defaults(cls):
        return cls()


class _UnitAssemblerConfig(namedtuple('_UnitAssemblerConfig', ('squad', 'epic'))):
    __slots__ = ()

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    @staticmethod
    def isPrebattleSupported(prebattleType):
        return prebattleType in PREBATTLE_TYPE_TO_UNIT_ASSEMBLER

    def getConfigOfQueue(self, prebattleType):
        if not self.isPrebattleSupported(prebattleType):
            return {}
        return self.asDict().get(UNIT_ASSEMBLER_IMPL_TO_CONFIG[PREBATTLE_TYPE_TO_UNIT_ASSEMBLER[prebattleType]], {})

    def isVoicePreferenceEnabled(self, prebattleType):
        return self.getConfigOfQueue(prebattleType).get('voiceChatPreferenceEnabled', False)

    def isTankLevelPreferenceEnabled(self, prebattleType):
        return self.getConfigOfQueue(prebattleType).get('tankLevelPreferenceEnabled', False)

    def getAllowedTankLevels(self, prebattleType):
        return self.getConfigOfQueue(prebattleType).get('allowedTankLevels', 0)

    def isAssemblingEnabled(self, prebattleType):
        return self.getConfigOfQueue(prebattleType).get('isAssemblingEnabled', False)

    def getExtendTierFilter(self, prebattleType):
        return self.getConfigOfQueue(prebattleType).get('extendTierFilter', [])

    @classmethod
    def defaults(cls):
        return cls(squad={}, epic={})


class _SquadPremiumBonus(namedtuple('_SquadPremiumBonus', ('isEnabled', 'ownCredits', 'mateCredits'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=True, ownCredits=0, mateCredits=0)
        defaults.update(kwargs)
        return super(_SquadPremiumBonus, cls).__new__(cls, **defaults)

    def replace(self, data):
        return self._replace(**self.__extractFields(data))

    @classmethod
    def create(cls, data):
        return cls(**cls.__extractFields(data))

    @classmethod
    def defaults(cls):
        return cls()

    @staticmethod
    def __extractFields(data):
        creditsSettings = data.get('creditsFactor', {})
        result = {}
        if 'enabled' in data:
            result['isEnabled'] = data['enabled']
        if 'premium_plus' in creditsSettings:
            result['ownCredits'] = creditsSettings['premium_plus']
        if 'premium_owner_squadmate' in creditsSettings:
            result['mateCredits'] = creditsSettings['premium_owner_squadmate']
        return result


class BattleRoyaleConfig(namedtuple('BattleRoyaleConfig', ('isEnabled', 'peripheryIDs', 'unburnableTitles',
 'eventProgression', 'primeTimes', 'seasons', 'cycleTimes',
 'maps', 'battleXP', 'coneVisibility', 'loot', 'defaultAmmo',
 'vehiclesSlotsConfig', 'url'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, peripheryIDs={}, eventProgression={}, unburnableTitles=(), primeTimes={}, seasons={}, cycleTimes={}, maps=(), battleXP={}, coneVisibility={}, loot={}, defaultAmmo={}, vehiclesSlotsConfig={}, url='')
        defaults.update(kwargs)
        return super(BattleRoyaleConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    @classmethod
    def defaults(cls):
        return cls()


class _TelecomConfig(object):
    __slots__ = ('__vehCDToProvider', )

    def __init__(self, telecomConfig):
        self.__vehCDToProvider = {}
        for _, bundleData in telecomConfig['bundles'].iteritems():
            for vehCD in bundleData['vehicles']:
                self.__vehCDToProvider[vehCD] = bundleData['operator']

    def getInternetProvider(self, vehCD):
        provider = self.__vehCDToProvider.get(vehCD, '')
        return provider

    @classmethod
    def defaults(cls):
        return cls({'bundles': {}})


class _BlueprintsConfig(namedtuple('_BlueprintsConfig', ('allowBlueprintsConversion',
 'isEnabled',
 'useBlueprintsForUnlock',
 'levels'))):
    __slots__ = ()

    @classmethod
    def defaults(cls):
        return cls(False, False, False, {})

    def allowConversion(self):
        return self.allowBlueprintsConversion

    def enabled(self):
        return self.isEnabled

    def useBlueprints(self):
        return self.useBlueprintsForUnlock

    def countAndDiscountByLevels(self):
        return self.levels

    def getAllianceConversionCoeffs(self, level):
        if not self.isBlueprintsAvailable() or level not in self.levels:
            return {}
        return self.levels[level][4]

    def getRequiredFragmentsForConversion(self, level):
        if not self.isBlueprintsAvailable() or level not in self.levels:
            return (0, 0)
        return self.levels[level][2]

    def getFragmentCount(self, level):
        if not self.isBlueprintsAvailable():
            return 0
        if level == 1:
            return 1
        if level in self.levels:
            return self.levels[level][0]
        return 0

    def getFragmentDiscount(self, level):
        discount = 0
        if self.isBlueprintsAvailable() and level > 1 and level in self.levels:
            discount = self.levels[level][1]
        return discount

    def isBlueprintsAvailable(self):
        return self.isEnabled and self.useBlueprintsForUnlock

    @staticmethod
    def isBlueprintModeChange(diff):
        return 'isEnabled' in diff or 'useBlueprintsForUnlock' in diff


class _SeniorityAwardsConfig(namedtuple('_SeniorityAwardsConfig', ('enabled', 'endTime'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(enabled=False, endTime=0)
        defaults.update(kwargs)
        return super(_SeniorityAwardsConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    def isEnabled(self):
        return self.enabled

    def endTimestamp(self):
        return self.endTime


class _AdventCalendarConfig(namedtuple('_AdventCalendarConfig', ('calendarURL', 'popupIntervalInHours'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(calendarURL='', popupIntervalInHours=24)
        defaults.update(kwargs)
        return super(_AdventCalendarConfig, cls).__new__(cls, **defaults)

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


_crystalRewardInfo = namedtuple('_crystalRewardInfo', 'level, arenaType, winTop3, loseTop3, winTop10, loseTop10, topLength')

class _crystalRewardConfigSection(namedtuple('_crystalRewardConfigSection', ('level', 'vehicle'))):
    __slots__ = ()

    def __new__(cls, params):
        defaults = {'level': {}, 'vehicle': {}}
        defaults.update(params)
        return super(_crystalRewardConfigSection, cls).__new__(cls, **defaults)


class _crystalRewardsConfig(namedtuple('_crystalRewardsConfig', ('limits', 'rewards'))):
    __slots__ = ()
    CONFIG_NAME = 'crystal_rewards_config'

    def __new__(cls, **kwargs):
        defaults = {'limits': _crystalRewardConfigSection(kwargs.get('limits', {})), 'rewards': _crystalRewardConfigSection(kwargs.get('rewards', {}))}
        return super(_crystalRewardsConfig, cls).__new__(cls, **defaults)

    def getRewardInfoData(self):
        results = []
        for level, rewardData in self.rewards.level.iteritems():
            for arenaBonusType, scoreData in rewardData.iteritems():
                results.append(_crystalRewardInfo(level, arenaBonusType, winTop3=max(scoreData[True].itervalues()), loseTop3=max(scoreData[False].itervalues()), winTop10=min(scoreData[True].itervalues()), loseTop10=min(scoreData[False].itervalues()), topLength=len(scoreData[True])))

        return results


class _ReactiveCommunicationConfig(object):
    __slots__ = ('__isEnabled', '__url')

    def __init__(self, **kwargs):
        super(_ReactiveCommunicationConfig, self).__init__()
        self.__isEnabled = kwargs.get('isEnabled', False)
        self.__url = kwargs.get('url', '')
        if self.__isEnabled and not self.__url:
            _logger.error('Connection to web subscription service is enabled, but url is empty')
            self.__isEnabled = False

    @property
    def isEnabled(self):
        return self.__isEnabled

    @property
    def url(self):
        return self.__url


class _BlueprintsConvertSaleConfig(namedtuple('_BlueprintsConvertSaleConfig', ('enabled', 'options'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(enabled=False, options={})
        defaults.update(kwargs)
        return super(_BlueprintsConvertSaleConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    def isEnabled(self):
        return self.enabled

    def getOptions(self):
        return self.options


class _MapboxConfig(namedtuple('_MapboxConfig', (
 'isEnabled', 'progressionUpdateInterval', 'peripheryIDs', 'forbiddenClassTags', 'forbiddenVehTypes',
 'primeTimes', 'seasons', 'cycleTimes', 'levels', 'geometryIDs'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, peripheryIDs={}, forbiddenClassTags=set(), forbiddenVehTypes=set(), primeTimes={}, seasons={}, cycleTimes={}, levels=[], geometryIDs={}, progressionUpdateInterval=time_utils.ONE_MINUTE * 2)
        defaults.update(kwargs)
        return super(_MapboxConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = {k:v for k, v in data.iteritems() if k in allowedFields}
        return self._replace(**dataToUpdate)

    @classmethod
    def defaults(cls):
        return cls()


class _ShopSalesEventConfig(namedtuple('_ShopSalesEventConfig', (
 'enabled',
 'url',
 'activePhaseStartTime',
 'activePhaseFinishTime',
 'eventFinishTime',
 'rerollPrice'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(enabled=False, url='', activePhaseStartTime=0, activePhaseFinishTime=0, eventFinishTime=0, rerollPrice={})
        defaults.update(kwargs)
        return super(_ShopSalesEventConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


class VehiclePostProgressionConfig(namedtuple('_VehiclePostProgression', (
 'isPostProgressionEnabled',
 'enabledFeatures',
 'forbiddenVehicles',
 'enabledRentedVehicles'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isPostProgressionEnabled=False, enabledFeatures=frozenset(), forbiddenVehicles=frozenset(), enabledRentedVehicles=frozenset())
        defaults.update(kwargs)
        return super(VehiclePostProgressionConfig, cls).__new__(cls, **defaults)

    @classmethod
    def defaults(cls):
        return cls(False, frozenset(), frozenset(), frozenset)

    @property
    def isEnabled(self):
        return self.isPostProgressionEnabled

    @property
    def isRoleSlotEnabled(self):
        return ROLESLOT_FEATURE in self.enabledFeatures

    def isSetupSwitchEnabled(self, groupID):
        return FEATURE_BY_GROUP_ID[groupID] in self.enabledFeatures

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


class YearHareAffairConfig(namedtuple('_YearHareAffair', (
 'isEnabled',
 'url'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, url=None)
        defaults.update(kwargs)
        return super(YearHareAffairConfig, cls).__new__(cls, **defaults)

    @classmethod
    def defaults(cls):
        return cls(False, None)

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)


class ServerSettings(object):

    def __init__(self, serverSettings):
        self.onServerSettingsChange = Event()
        self.__serverSettings = {}
        self.__roamingSettings = RoamingSettings.defaults()
        self.__fileServerSettings = _FileServerSettings.defaults()
        self.__regionalSettings = _RegionalSettings.defaults()
        self.__eSportCurrentSeason = _ESportCurrentSeason.defaults()
        self.__wgcg = _Wgcg.defaults()
        self.__wgnp = _Wgnp.defaults()
        self.__clanProfile = _ClanProfile.defaults()
        self.__spgRedesignFeatures = _SpgRedesignFeatures.defaults()
        self.__strongholdSettings = _StrongholdSettings.defaults()
        self.__tournamentSettings = _TournamentSettings.defaults()
        self.__frontlineSettings = _FrontlineSettings.defaults()
        self.__bwHallOfFame = _BwHallOfFame.defaults()
        self.__bwShop = _BwShop()
        self.__rankedBattlesSettings = RankedBattlesConfig.defaults()
        self.__epicMetaGameSettings = _EpicMetaGameConfig()
        self.__adventCalendar = _AdventCalendarConfig()
        self.__epicGameSettings = EpicGameConfig()
        self.__unitAssemblerConfig = _UnitAssemblerConfig.defaults()
        self.__telecomConfig = _TelecomConfig.defaults()
        self.__squadPremiumBonus = _SquadPremiumBonus.defaults()
        self.__battlePassConfig = BattlePassConfig({})
        self.__crystalRewardsConfig = _crystalRewardsConfig()
        self.__reactiveCommunicationConfig = _ReactiveCommunicationConfig()
        self.__blueprintsConvertSaleConfig = _BlueprintsConvertSaleConfig()
        self.__bwProductCatalog = _BwProductCatalog()
        self.__vehiclePostProgressionConfig = VehiclePostProgressionConfig()
        self.__yearHareAffairConfig = YearHareAffairConfig()
        self.__shopSalesEventConfig = _ShopSalesEventConfig()
        self.set(serverSettings)

    def set(self, serverSettings):
        self.__serverSettings = copy.deepcopy(serverSettings) if serverSettings else {}
        if 'roaming' in self.__serverSettings:
            roamingSettings = self.__serverSettings['roaming']
            self.__roamingSettings = RoamingSettings(roamingSettings[0], roamingSettings[1], [ _ServerInfo(*s) for s in roamingSettings[2] ])
        if 'file_server' in self.__serverSettings:
            self.__fileServerSettings = _FileServerSettings(self.__serverSettings['file_server'])
        if 'regional_settings' in self.__serverSettings:
            self.__regionalSettings = makeTupleByDict(_RegionalSettings, self.__serverSettings['regional_settings'])
        try:
            self.__eSportCurrentSeason = makeTupleByDict(_ESportCurrentSeason, self.__serverSettings)
        except TypeError:
            self.__eSportCurrentSeason = _ESportCurrentSeason.defaults()

        if 'wgcg' in self.__serverSettings:
            self.__updateWgcg(self.__serverSettings)
        if 'wgnp' in self.__serverSettings:
            self.__updateWgnp(self.__serverSettings)
        if 'clanProfile' in self.__serverSettings:
            self.__updateClanProfile(self.__serverSettings)
        if 'spgRedesignFeatures' in self.__serverSettings:
            self.__spgRedesignFeatures = makeTupleByDict(_SpgRedesignFeatures, self.__serverSettings['spgRedesignFeatures'])
        if 'strongholdSettings' in self.__serverSettings:
            settings = self.__serverSettings['strongholdSettings']
            self.__strongholdSettings = _StrongholdSettings(settings.get('wgshHostUrl', ''))
        if 'tournamentSettings' in self.__serverSettings:
            settings = self.__serverSettings['tournamentSettings']
            self.__tournamentSettings = _TournamentSettings(settings.get('tmsHostUrl', ''))
        if 'frontlineSettings' in self.__serverSettings:
            settings = self.__serverSettings['frontlineSettings']
            self.__frontlineSettings = _FrontlineSettings(settings.get('isEpicTrainingEnabled', True))
        if 'hallOfFame' in self.__serverSettings:
            self.__bwHallOfFame = makeTupleByDict(_BwHallOfFame, self.__serverSettings['hallOfFame'])
        if 'shop' in self.__serverSettings:
            self.__bwShop = makeTupleByDict(_BwShop, self.__serverSettings['shop'])
        if 'ranked_config' in self.__serverSettings:
            self.__rankedBattlesSettings = makeTupleByDict(RankedBattlesConfig, self.__serverSettings['ranked_config'])
        if 'advent_calendar_config' in self.__serverSettings:
            self.__adventCalendar = makeTupleByDict(_AdventCalendarConfig, self.__serverSettings['advent_calendar_config'])
        if 'epic_config' in self.__serverSettings:
            LOG_DEBUG('epic_config', self.__serverSettings['epic_config'])
            self.__epicMetaGameSettings = makeTupleByDict(_EpicMetaGameConfig, self.__serverSettings['epic_config']['epicMetaGame'])
            self.__epicGameSettings = makeTupleByDict(EpicGameConfig, self.__serverSettings['epic_config'])
        if 'unit_assembler_config' in self.__serverSettings:
            self.__unitAssemblerConfig = makeTupleByDict(_UnitAssemblerConfig, self.__serverSettings['unit_assembler_config'])
        if PremiumConfigs.PREM_SQUAD in self.__serverSettings:
            self.__squadPremiumBonus = _SquadPremiumBonus.create(self.__serverSettings[PremiumConfigs.PREM_SQUAD])
        if Configs.BATTLE_ROYALE_CONFIG.value in self.__serverSettings:
            LOG_DEBUG('battle_royale_config', self.__serverSettings[Configs.BATTLE_ROYALE_CONFIG.value])
            self.__battleRoyaleSettings = makeTupleByDict(BattleRoyaleConfig, self.__serverSettings[Configs.BATTLE_ROYALE_CONFIG.value])
        else:
            self.__battleRoyaleSettings = BattleRoyaleConfig.defaults()
        if 'telecom_config' in self.__serverSettings:
            self.__telecomConfig = _TelecomConfig(self.__serverSettings['telecom_config'])
        if 'blueprints_config' in self.__serverSettings:
            self.__blueprintsConfig = makeTupleByDict(_BlueprintsConfig, self.__serverSettings['blueprints_config'])
        else:
            self.__blueprintsConfig = _BlueprintsConfig.defaults()
        if 'progressive_reward_config' in self.__serverSettings:
            self.__progressiveReward = makeTupleByDict(_ProgressiveReward, self.__serverSettings['progressive_reward_config'])
        else:
            self.__progressiveReward = _ProgressiveReward()
        if 'seniority_awards_config' in self.__serverSettings:
            self.__seniorityAwardsConfig = makeTupleByDict(_SeniorityAwardsConfig, self.__serverSettings['seniority_awards_config'])
        else:
            self.__seniorityAwardsConfig = _SeniorityAwardsConfig()
        if BATTLE_PASS_CONFIG_NAME in self.__serverSettings:
            self.__battlePassConfig = BattlePassConfig(self.__serverSettings.get(BATTLE_PASS_CONFIG_NAME, {}))
        else:
            self.__battlePassConfig = BattlePassConfig({})
        if _crystalRewardsConfig.CONFIG_NAME in self.__serverSettings:
            self.__crystalRewardsConfig = makeTupleByDict(_crystalRewardsConfig, self.__serverSettings[_crystalRewardsConfig.CONFIG_NAME])
        self.__updateReactiveCommunicationConfig(self.__serverSettings)
        if BonusCapsConst.CONFIG_NAME in self.__serverSettings:
            BONUS_CAPS.OVERRIDE_BONUS_CAPS = self.__serverSettings[BonusCapsConst.CONFIG_NAME]
        else:
            BONUS_CAPS.OVERRIDE_BONUS_CAPS = dict()
        if 'blueprints_convert_sale_config' in self.__serverSettings:
            self.__blueprintsConvertSaleConfig = makeTupleByDict(_BlueprintsConvertSaleConfig, self.__serverSettings['blueprints_convert_sale_config'])
        else:
            self.__blueprintsConvertSaleConfig = _BlueprintsConvertSaleConfig()
        if Configs.MAPBOX_CONFIG.value in self.__serverSettings:
            LOG_DEBUG('mapbox_config', self.__serverSettings[Configs.MAPBOX_CONFIG.value])
            self.__mapboxSettings = makeTupleByDict(_MapboxConfig, self.__serverSettings[Configs.MAPBOX_CONFIG.value])
        else:
            self.__mapboxSettings = _MapboxConfig.defaults()
        if 'productsCatalog' in self.__serverSettings:
            self.__bwProductCatalog = makeTupleByDict(_BwProductCatalog, self.__serverSettings['productsCatalog'])
        if post_progression_common.SERVER_SETTINGS_KEY in self.__serverSettings:
            self.__vehiclePostProgressionConfig = makeTupleByDict(VehiclePostProgressionConfig, self.__serverSettings[post_progression_common.SERVER_SETTINGS_KEY])
        if year_hare_affair_common.SERVER_SETTINGS_KEY in self.__serverSettings:
            self.__yearHareAffairConfig = makeTupleByDict(YearHareAffairConfig, self.__serverSettings[year_hare_affair_common.SERVER_SETTINGS_KEY])
        if constants.SHOP_SALES_CONFIG in self.__serverSettings:
            self.__shopSalesEventConfig = makeTupleByDict(_ShopSalesEventConfig, self.__serverSettings[constants.SHOP_SALES_CONFIG])
        self.onServerSettingsChange(serverSettings)

    def update(self, serverSettingsDiff):
        self.__serverSettings = updateDict(self.__serverSettings, serverSettingsDiff)
        if 'clanProfile' in serverSettingsDiff:
            self.__updateClanProfile(serverSettingsDiff)
        if 'spgRedesignFeatures' in self.__serverSettings:
            self.__spgRedesignFeatures = makeTupleByDict(_SpgRedesignFeatures, self.__serverSettings['spgRedesignFeatures'])
        if 'ranked_config' in serverSettingsDiff:
            self.__updateRanked(serverSettingsDiff)
        if 'hallOfFame' in serverSettingsDiff:
            self.__bwHallOfFame = makeTupleByDict(_BwHallOfFame, serverSettingsDiff['hallOfFame'])
        if 'wgcg' in serverSettingsDiff:
            self.__updateWgcg(serverSettingsDiff)
        if 'wgnp' in serverSettingsDiff:
            self.__updateWgnp(serverSettingsDiff)
        if 'advent_calendar_config' in serverSettingsDiff:
            self.__updateAdventCalendar(serverSettingsDiff)
            self.__serverSettings['advent_calendar_config'] = serverSettingsDiff['advent_calendar_config']
        if 'epic_config' in serverSettingsDiff:
            self.__updateEpic(serverSettingsDiff)
            self.__serverSettings['epic_config'] = serverSettingsDiff['epic_config']
        if Configs.BATTLE_ROYALE_CONFIG.value in serverSettingsDiff:
            self.__updateBattleRoyale(serverSettingsDiff)
        if Configs.MAPBOX_CONFIG.value in serverSettingsDiff:
            self.__updateMapbox(serverSettingsDiff)
        if 'unit_assembler_config' in serverSettingsDiff:
            self.__updateUnitAssemblerConfig(serverSettingsDiff)
            self.__serverSettings['unit_assembler_config'] = serverSettingsDiff['unit_assembler_config']
        if 'telecom_config' in serverSettingsDiff:
            self.__telecomConfig = _TelecomConfig(self.__serverSettings['telecom_config'])
        if 'disabledPMOperations' in serverSettingsDiff:
            self.__serverSettings['disabledPMOperations'] = serverSettingsDiff['disabledPMOperations']
        if 'shop' in serverSettingsDiff:
            self.__updateShop(serverSettingsDiff)
        if 'disabledPersonalMissions' in serverSettingsDiff:
            self.__serverSettings['disabledPersonalMissions'] = serverSettingsDiff['disabledPersonalMissions']
        if 'blueprints_config' in serverSettingsDiff:
            self.__updateBlueprints(serverSettingsDiff['blueprints_config'])
        if 'lootBoxes_config' in serverSettingsDiff:
            self.__serverSettings['lootBoxes_config'] = serverSettingsDiff['lootBoxes_config']
        if 'progressive_reward_config' in serverSettingsDiff:
            self.__updateProgressiveReward(serverSettingsDiff)
        if 'seniority_awards_config' in serverSettingsDiff:
            self.__updateSeniorityAwards(serverSettingsDiff)
        if BonusCapsConst.CONFIG_NAME in serverSettingsDiff:
            BONUS_CAPS.OVERRIDE_BONUS_CAPS = serverSettingsDiff[BonusCapsConst.CONFIG_NAME]
        if PremiumConfigs.PIGGYBANK in serverSettingsDiff:
            self.__serverSettings[PremiumConfigs.PIGGYBANK] = serverSettingsDiff[PremiumConfigs.PIGGYBANK]
        if PremiumConfigs.DAILY_BONUS in serverSettingsDiff:
            self.__serverSettings[PremiumConfigs.DAILY_BONUS] = serverSettingsDiff[PremiumConfigs.DAILY_BONUS]
        if PremiumConfigs.PREM_QUESTS in serverSettingsDiff:
            self.__serverSettings[PremiumConfigs.PREM_QUESTS] = serverSettingsDiff[PremiumConfigs.PREM_QUESTS]
        if PremiumConfigs.PREM_SQUAD in serverSettingsDiff:
            self.__updateSquadBonus(serverSettingsDiff)
        if PremiumConfigs.PREFERRED_MAPS in serverSettingsDiff:
            self.__serverSettings[PremiumConfigs.PREFERRED_MAPS] = serverSettingsDiff[PremiumConfigs.PREFERRED_MAPS]
        if BATTLE_PASS_CONFIG_NAME in serverSettingsDiff:
            self.__serverSettings[BATTLE_PASS_CONFIG_NAME] = serverSettingsDiff[BATTLE_PASS_CONFIG_NAME]
            self.__battlePassConfig = BattlePassConfig(self.__serverSettings.get(BATTLE_PASS_CONFIG_NAME, {}))
        if CollectorVehicleConsts.CONFIG_NAME in serverSettingsDiff:
            self.__serverSettings[CollectorVehicleConsts.CONFIG_NAME] = serverSettingsDiff[CollectorVehicleConsts.CONFIG_NAME]
        if _crystalRewardsConfig.CONFIG_NAME in serverSettingsDiff:
            self.__crystalRewardsConfig = makeTupleByDict(_crystalRewardsConfig, self.__serverSettings[_crystalRewardsConfig.CONFIG_NAME])
        if post_progression_common.SERVER_SETTINGS_KEY in serverSettingsDiff:
            self.__updateVehiclePostProgressionConfig(serverSettingsDiff)
        if year_hare_affair_common.SERVER_SETTINGS_KEY in serverSettingsDiff:
            self.__updateYearHareAffairConfig(serverSettingsDiff)
        self.__updateBlueprintsConvertSaleConfig(serverSettingsDiff)
        self.__updateReactiveCommunicationConfig(serverSettingsDiff)
        if constants.SHOP_SALES_CONFIG in serverSettingsDiff:
            self.__updateShopSalesEvent(serverSettingsDiff)
            self.__serverSettings[constants.SHOP_SALES_CONFIG] = serverSettingsDiff[constants.SHOP_SALES_CONFIG]
        self.onServerSettingsChange(serverSettingsDiff)

    def clear(self):
        self.onServerSettingsChange.clear()

    def getSettings(self):
        return self.__serverSettings

    @property
    def roaming(self):
        return self.__roamingSettings

    @property
    def fileServer(self):
        return self.__fileServerSettings

    @property
    def regionals(self):
        return self.__regionalSettings

    @property
    def eSportCurrentSeason(self):
        return self.__eSportCurrentSeason

    @property
    def clanProfile(self):
        return self.__clanProfile

    @property
    def wgcg(self):
        return self.__wgcg

    @property
    def wgnp(self):
        return self.__wgnp

    @property
    def spgRedesignFeatures(self):
        return self.__spgRedesignFeatures

    @property
    def stronghold(self):
        return self.__strongholdSettings

    @property
    def tournament(self):
        return self.__tournamentSettings

    @property
    def frontline(self):
        return self.__frontlineSettings

    @property
    def bwHallOfFame(self):
        return self.__bwHallOfFame

    @property
    def rankedBattles(self):
        return self.__rankedBattlesSettings

    @property
    def adventCalendar(self):
        return self.__adventCalendar

    @property
    def epicMetaGame(self):
        return self.__epicMetaGameSettings

    @property
    def epicBattles(self):
        return self.__epicGameSettings

    @property
    def battleRoyale(self):
        return self.__battleRoyaleSettings

    @property
    def mapbox(self):
        return self.__mapboxSettings

    @property
    def unitAssemblerConfig(self):
        return self.__unitAssemblerConfig

    @property
    def telecomConfig(self):
        return self.__telecomConfig

    @property
    def blueprintsConfig(self):
        return self.__blueprintsConfig

    @property
    def squadPremiumBonus(self):
        return self.__squadPremiumBonus

    @property
    def vehiclePostProgression(self):
        return self.__vehiclePostProgressionConfig

    @property
    def yearHareAffair(self):
        return self.__yearHareAffairConfig

    @property
    def shopSalesEventConfig(self):
        return self.__shopSalesEventConfig

    def isEpicBattleEnabled(self):
        return self.epicBattles.isEnabled

    def isPersonalMissionsEnabled(self, branch=None):
        if branch == PM_BRANCH.REGULAR:
            return self.__getGlobalSetting('isRegularQuestEnabled', True)
        if branch == PM_BRANCH.PERSONAL_MISSION_2:
            return self.__getGlobalSetting('isPM2QuestEnabled', True)
        return self.__getGlobalSetting('isRegularQuestEnabled', True) or self.__getGlobalSetting('isPM2QuestEnabled', True)

    def isPMBattleProgressEnabled(self):
        return self.__getGlobalSetting('isPMBattleProgressEnabled', True)

    def getDisabledPMOperations(self):
        return self.__getGlobalSetting('disabledPMOperations', dict())

    def getDisabledPersonalMissions(self):
        return self.__getGlobalSetting('disabledPersonalMissions', dict())

    def isStrongholdsEnabled(self):
        return self.__getGlobalSetting('strongholdSettings', {}).get('isStrongholdsEnabled', False)

    def isTournamentEnabled(self):
        return self.__getGlobalSetting('tournamentSettings', {}).get('isTournamentEnabled', False)

    def isLeaguesEnabled(self):
        return self.__getGlobalSetting('strongholdSettings', {}).get('isLeaguesEnabled', False)

    def isElenEnabled(self):
        return self.__getGlobalSetting('elenSettings', {}).get('isElenEnabled', True)

    def elenUpdateInterval(self):
        return self.__getGlobalSetting('elenSettings', {}).get('elenUpdateInterval', 60)

    def isGoldFishEnabled(self):
        return self.__getGlobalSetting('isGoldFishEnabled', False)

    def isStorageEnabled(self):
        return self.__bwShop.isStorageEnabled

    def isLootBoxesEnabled(self):
        return self.__getGlobalSetting('isLootBoxesEnabled')

    def isAnonymizerEnabled(self):
        return self.__getGlobalSetting('isAnonymizerEnabled', False)

    def isSessionStatsEnabled(self):
        return self.__getGlobalSetting('sessionStats', {}).get('isSessionStatsEnabled', False)

    def isLinkWithHoFEnabled(self):
        return self.__getGlobalSetting('sessionStats', {}).get('isLinkWithHoFEnabled', False)

    def isWTREnabled(self):
        wtrSettings = self.__getGlobalSetting('sessionStats', {}).get('WTR', {})
        return wtrSettings.get('enabled', False)

    def isNationChangeEnabled(self):
        return self.__getGlobalSetting('isNationChangeEnabled', True)

    def getCrystalRewardConfig(self):
        return self.__crystalRewardsConfig

    @property
    def shop(self):
        return self.__bwShop

    @property
    def productCatalog(self):
        return self.__bwProductCatalog

    def isShopDataChangedInDiff(self, diff, fieldName=None):
        if 'shop' in diff:
            if fieldName is not None:
                if fieldName in diff['shop']:
                    return True
            else:
                return True
        return False

    def isBlueprintDataChangedInDiff(self, diff):
        return 'blueprints_config' in diff

    def isTutorialEnabled(self):
        return self.__getGlobalSetting('isTutorialEnabled', IS_TUTORIAL_ENABLED)

    def isSandboxEnabled(self):
        return self.__getGlobalSetting('isSandboxEnabled', False)

    def isBootcampEnabled(self):
        return self.__getGlobalSetting('isBootcampEnabled', False)

    def isLinkedSetEnabled(self):
        return self.__getGlobalSetting('isLinkedSetEnabled', False)

    def getBootcampBonuses(self):
        return self.__getGlobalSetting('bootcampBonuses', {})

    def isMapsTrainingEnabled(self):
        return self.__getGlobalSetting('isMapsTrainingEnabled', False)

    def getLootBoxConfig(self):
        return self.__getGlobalSetting('lootBoxes_config', {})

    def getPiggyBankConfig(self):
        return self.__getGlobalSetting(PremiumConfigs.PIGGYBANK, {})

    def getAdditionalBonusConfig(self):
        return self.__getGlobalSetting(PremiumConfigs.DAILY_BONUS, {})

    def getPremQuestsConfig(self):
        return self.__getGlobalSetting(PremiumConfigs.PREM_QUESTS, {})

    def getDailyQuestConfig(self):
        return self.__getGlobalSetting(DAILY_QUESTS_CONFIG, {})

    def getDogTagsConfig(self):
        return self.__getGlobalSetting(DOG_TAGS_CONFIG, {})

    def isDogTagEnabled(self):
        return self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enabled', True)

    def isDogTagCustomizationScreenEnabled(self):
        return self.isDogTagEnabled() and self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enableDogTagsCustomizationScreen', True)

    def isSkillComponentsEnabled(self):
        return self.isDogTagEnabled() and self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enableSkillComponents', True)

    def isDogTagInBattleEnabled(self):
        return self.isDogTagEnabled() and self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enableDogTagsInBattle', True)

    def isDogTagInPostBattleEnabled(self):
        return self.isDogTagEnabled() and self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enableDogTagsInPostBattle', True)

    def isDogTagComponentUnlockingEnabled(self):
        return self.isDogTagEnabled() and self.__getGlobalSetting(DOG_TAGS_CONFIG, {}).get('enableComponentUnlocking', True)

    def isRenewableSubEnabled(self):
        return self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enabled', True)

    def isWotPlusTankRentalEnabled(self):
        return self.isRenewableSubEnabled() and self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enableTankRental', True)

    def isRenewableSubGoldReserveEnabled(self):
        return self.isRenewableSubEnabled() and self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enableGoldReserve', True)

    def isRenewableSubFreeDirectivesEnabled(self):
        return self.isRenewableSubEnabled() and self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enableFreeDirectives', True)

    def isRenewableSubPassiveCrewXPEnabled(self):
        return self.isRenewableSubEnabled() and self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enablePassiveCrewXP', True)

    def isWotPlusNewSubscriptionEnabled(self):
        return self.isRenewableSubEnabled() and self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('enableNewSubscriptions', True)

    def getRenewableSubCrewXPPerMinute(self):
        return self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('crewXPPerMinute', 0)

    def getRenewableSubMaxGoldReserveCapacity(self):
        return self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get('maxGoldReserveCapacity', 0)

    def getArenaTypesWithGoldReserve(self):
        return self.__getGlobalSetting(RENEWABLE_SUBSCRIPTION_CONFIG, {}).get(GOLD_RESERVE_GAINS_SECTION, {}).keys()

    def isTelecomRentalsEnabled(self):
        return self.__getGlobalSetting(TELECOM_RENTALS_CONFIG, {}).get('enabled', True)

    def isBattleNotifierEnabled(self):
        return self.__getGlobalSetting(BATTLE_NOTIFIER_CONFIG, {}).get('enabled', False)

    def isAutoSellCheckBoxEnabled(self):
        return self.getMiscGUISettings()['buyModuleDialog']['enableAutoSellCheckBox']

    def getMiscGUISettings(self):
        return self.__getGlobalSetting(MISC_GUI_SETTINGS, {})

    def getMagneticAutoAimConfig(self):
        return self.__getGlobalSetting(MAGNETIC_AUTO_AIM_CONFIG, {})

    def getPreferredMapsConfig(self):
        return self.__getGlobalSetting(PremiumConfigs.PREFERRED_MAPS, {})

    def isEpicRandomEnabled(self):
        return self.__getGlobalSetting('isEpicRandomEnabled', False)

    def isEpicRandomAchievementsEnabled(self):
        return self.__getGlobalSetting('isEpicRandomAchievementsEnabled', False)

    def isEpicRandomMarkOfMasteryEnabled(self):
        return self.__getGlobalSetting('isEpicRandomMarkOfMasteryEnabled', False)

    def isEpicRandomMarksOnGunEnabled(self):
        return self.__getGlobalSetting('isEpicRandomMarksOnGunEnabled', False)

    def isCommandBattleEnabled(self):
        return self.__getGlobalSetting('isCommandBattleEnabled', False)

    def isHofEnabled(self):
        return self.__getGlobalSetting('hallOfFame', {}).get('isHofEnabled', False)

    def isOnly10ModeEnabled(self):
        return self.__getGlobalSetting('isOnly10ModeEnabled', False)

    def getMaxSPGinSquads(self):
        return self.__getGlobalSetting('maxSPGinSquads', 0)

    def getRandomMapsForDemonstrator(self):
        return self.__getGlobalSetting('randomMapsForDemonstrator', {})

    def getRandomBattleLevelsForDemonstrator(self):
        return self.__getGlobalSetting('randomBattleLevelsForDemonstrator', {})

    def isPremiumInPostBattleEnabled(self):
        return self.__getGlobalSetting('isPremiumInPostBattleEnabled', True)

    def isVehicleComparingEnabled(self):
        return bool(self.__getGlobalSetting('isVehiclesCompareEnabled', True))

    def isTankmanRestoreEnabled(self):
        return self.__getGlobalSetting('isTankmanRestoreEnabled', True)

    def isVehicleRestoreEnabled(self):
        return self.__getGlobalSetting('isVehicleRestoreEnabled', True)

    def isCustomizationEnabled(self):
        return self.__getGlobalSetting('isCustomizationEnabled', True)

    def getHeroVehicles(self):
        return self.__getGlobalSetting('hero_vehicles', {})

    def isManualEnabled(self):
        return self.__getGlobalSetting('isManualEnabled', False)

    def isFieldPostEnabled(self):
        return self.__getGlobalSetting('isFieldPostEnabled', True)

    def isPromoLoggingEnabled(self):
        return self.__getGlobalSetting('isPromoLoggingEnabled', False)

    def isReferralProgramEnabled(self):
        return self.__getGlobalSetting('isReferralProgramEnabled', False)

    def isCrewSkinsEnabled(self):
        return self.__getGlobalSetting('isCrewSkinsEnabled', False)

    def getPremiumXPBonus(self):
        return self.__getGlobalSetting('tankPremiumBonus', {}).get('xp', 0.5)

    def getPremiumCreditsBonus(self):
        return self.__getGlobalSetting('tankPremiumBonus', {}).get('credits', 0.5)

    def isPreferredMapsEnabled(self):
        return self.__getGlobalSetting('isPreferredMapsEnabled', False)

    def isGlobalMapEnabled(self):
        return self.__getGlobalSetting('isGlobalMapEnabled', False)

    def isBattleBoostersEnabled(self):
        return self.__getGlobalSetting('isBattleBoostersEnabled', False)

    def isCrewBooksEnabled(self):
        return self.__getGlobalSetting('isCrewBooksEnabled', False)

    def isCrewBooksPurchaseEnabled(self):
        return self.__getGlobalSetting('isCrewBooksPurchaseEnabled', False)

    def isCrewBooksSaleEnabled(self):
        return self.__getGlobalSetting('isCrewBooksSaleEnabled', False)

    def isTrophyDevicesEnabled(self):
        return self.__getGlobalSetting('isTrophyDevicesEnabled', False)

    def isTrainingBattleEnabled(self):
        return self.__getGlobalSetting('isTrainingBattleEnabled', True)

    def isCollectorVehicleEnabled(self):
        return self.__getGlobalSetting(CollectorVehicleConsts.CONFIG_NAME, {}).get(CollectorVehicleConsts.IS_ENABLED, False)

    def isOffersEnabled(self):
        return self.__getGlobalSetting('isOffersEnabled', False)

    def getProgressiveRewardConfig(self):
        return self.__progressiveReward

    def getMarathonConfig(self):
        return self.__getGlobalSetting('marathon_config', {})

    def getClansConfig(self):
        return self.__getGlobalSetting(ClansConfig.SECTION_NAME, {})

    def getSeniorityAwardsConfig(self):
        return self.__seniorityAwardsConfig

    def getBattlePassConfig(self):
        return self.__battlePassConfig

    def getReactiveCommunicationConfig(self):
        return self.__reactiveCommunicationConfig

    def isLegacyModeSelectorEnabled(self):
        return self.__getGlobalSetting('isLegacyModeSelectorEnabled', False)

    def getBlueprintsConvertSaleConfig(self):
        return self.__blueprintsConvertSaleConfig

    def getActiveTestConfirmationConfig(self):
        return self.__getGlobalSetting(constants.ACTIVE_TEST_CONFIRMATION_CONFIG, {})

    def __getGlobalSetting(self, settingsName, default=None):
        return self.__serverSettings.get(settingsName, default)

    def __updateClanProfile(self, targetSettings):
        cProfile = targetSettings['clanProfile']
        self.__clanProfile = _ClanProfile(cProfile.get('isEnabled', False))

    def __updateWgcg(self, targetSettings):
        cProfile = targetSettings['wgcg']
        self.__wgcg = _Wgcg(cProfile.get('isEnabled', False), cProfile.get('gateUrl', ''), cProfile.get('type', 'gateway'), cProfile.get('loginOnStart', False))

    def __updateWgnp(self, targetSettings):
        cProfile = targetSettings['wgnp']
        self.__wgnp = _Wgnp(cProfile.get('enabled', False), cProfile.get('url', ''))

    def __updateAdventCalendar(self, targetSettings):
        self.__adventCalendar = self.__adventCalendar.replace(targetSettings['advent_calendar_config'])

    def __updateRanked(self, targetSettings):
        self.__rankedBattlesSettings = self.__rankedBattlesSettings.replace(targetSettings['ranked_config'])

    def __updateEpic(self, targetSettings):
        self.__epicMetaGameSettings = self.__epicMetaGameSettings.replace(targetSettings['epic_config'].get('epicMetaGame', {}))
        self.__epicGameSettings = self.__epicGameSettings.replace(targetSettings['epic_config'])

    def __updateUnitAssemblerConfig(self, targetSettings):
        self.__unitAssemblerConfig = self.__unitAssemblerConfig.replace(targetSettings['unit_assembler_config'])

    def __updateSquadBonus(self, sourceSettings):
        self.__squadPremiumBonus = self.__squadPremiumBonus.replace(sourceSettings[PremiumConfigs.PREM_SQUAD])

    def __updateShop(self, targetSettings):
        self.__bwShop = self.__bwShop.replace(targetSettings['shop'])

    def __updateBattleRoyale(self, targetSettings):
        self.__battleRoyaleSettings = self.__battleRoyaleSettings.replace(targetSettings['battle_royale_config'])

    def __updateMapbox(self, targetSettings):
        self.__mapboxSettings = self.__mapboxSettings.replace(targetSettings[Configs.MAPBOX_CONFIG.value])

    def __updateBlueprints(self, targetSettings):
        self.__blueprintsConfig = self.__blueprintsConfig._replace(**targetSettings)
        if self.__blueprintsConfig.isBlueprintModeChange(targetSettings):
            if not self.__blueprintsConfig.isEnabled or not self.__blueprintsConfig.useBlueprintsForUnlock:
                SystemMessages.pushI18nMessage(SYSTEM_MESSAGES.BLUEPRINTS_SWITCH_OFF, type=SM_TYPE.Information, priority='medium')
            else:
                SystemMessages.pushI18nMessage(SYSTEM_MESSAGES.BLUEPRINTS_SWITCH_ON, type=SM_TYPE.Information, priority='medium')

    def __updateProgressiveReward(self, targetSettings):
        self.__progressiveReward = self.__progressiveReward.replace(targetSettings['progressive_reward_config'])

    def __updateSeniorityAwards(self, targetSettings):
        self.__seniorityAwardsConfig = self.__seniorityAwardsConfig.replace(targetSettings['seniority_awards_config'])

    def __updateReactiveCommunicationConfig(self, settings):
        if 'reactiveCommunicationConfig' in settings:
            config = settings['reactiveCommunicationConfig']
            if config is None:
                self.__reactiveCommunicationConfig = _ReactiveCommunicationConfig()
            elif isinstance(config, dict):
                self.__reactiveCommunicationConfig = _ReactiveCommunicationConfig(**config)
            else:
                _logger.error('Unexpected format of subscriptions service config: %r', config)
                self.__reactiveCommunicationConfig = _ReactiveCommunicationConfig()
        return

    def __updateBlueprintsConvertSaleConfig(self, targetSettings):
        if 'blueprints_convert_sale_config' in targetSettings:
            self.__blueprintsConvertSaleConfig = self.__blueprintsConvertSaleConfig.replace(targetSettings['blueprints_convert_sale_config'])

    def __updateVehiclePostProgressionConfig(self, serverSettingsDiff):
        self.__vehiclePostProgressionConfig = self.__vehiclePostProgressionConfig.replace(serverSettingsDiff[post_progression_common.SERVER_SETTINGS_KEY])

    def __updateYearHareAffairConfig(self, serverSettingsDiff):
        self.__yearHareAffairConfig = self.__yearHareAffairConfig.replace(serverSettingsDiff[year_hare_affair_common.SERVER_SETTINGS_KEY])

    def __updateShopSalesEvent(self, targetSettings):
        self.__shopSalesEventConfig = self.__shopSalesEventConfig.replace(targetSettings[constants.SHOP_SALES_CONFIG])


def serverSettingsChangeListener(*configKeys):

    def decorator(func):

        @functools.wraps(func)
        def wrapper(self, diff):
            if any(configKey in diff for configKey in configKeys):
                func(self, diff)

        return wrapper

    return decorator