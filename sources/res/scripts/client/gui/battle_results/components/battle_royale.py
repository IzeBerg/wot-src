import logging
from collections import defaultdict
from constants import DEATH_REASON_ALIVE, ARENA_BONUS_TYPE
from gui.battle_control.battle_constants import WinStatus
from gui.battle_results.components import base
from gui.battle_results.components.personal import PersonalVehiclesBlock
from gui.battle_results.components.progress import isQuestCompleted
from gui.battle_results.reusable import sort_keys
from gui.impl import backport
from gui.impl.gen import R
from gui.server_events import IEventsCache
from gui.server_events.battle_royale_formatters import StatsItemType, SOLO_ITEMS_ORDER, SQUAD_ITEMS_ORDER
from gui.server_events.events_helpers import isBattleRoyale
from gui.shared.utils.functions import replaceHyphenToUnderscore
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from skeletons.gui.game_control import IBattleRoyaleController, IBattlePassController
from battle_pass_common import BattlePassConsts
_logger = logging.getLogger(__name__)
_logger.addHandler(logging.NullHandler())
_THE_BEST_RANK = 1

def _isSquadMode(reusable):
    return reusable.common.arenaBonusType in (ARENA_BONUS_TYPE.BATTLE_ROYALE_SQUAD,
     ARENA_BONUS_TYPE.BATTLE_ROYALE_TRN_SQUAD)


class BattleRoyaleArenaNameBlock(base.StatsItem):
    __slots__ = ()

    def _convert(self, record, reusable):
        geometryName = replaceHyphenToUnderscore(reusable.common.arenaType.getGeometryName())
        return backport.text(R.strings.arenas.num(geometryName).name())


class ArenaBonusTypeNameBlock(base.StatsItem):
    __slots__ = ()

    def _convert(self, record, reusable):
        arenaBonusType = reusable.common.arenaVisitor.getArenaBonusType()
        return arenaBonusType


class PersonalPlayerNameBlock(base.StatsBlock):
    __slots__ = ('userName', 'clanAbbrev')

    def __init__(self, meta=None, field='', *path):
        super(PersonalPlayerNameBlock, self).__init__(meta, field, *path)
        self.userName = ''
        self.clanAbbrev = ''

    def setRecord(self, result, reusable):
        player = reusable.getPlayerInfo()
        self.userName = player.realName
        self.clanAbbrev = player.clanAbbrev


class BattleRoyalePlayerPlaceBlock(base.StatsItem):
    __slots__ = ()
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _convert(self, value, reusable):
        playerRank = reusable.personal.avatar.extensionInfo.get('playerRank', 0)
        if self.__sessionProvider.getCtx().extractLastArenaWinStatus() is not None:
            winStatus = WinStatus.WIN if playerRank == _THE_BEST_RANK else WinStatus.LOSE
            self.__sessionProvider.getCtx().setLastArenaWinStatus(WinStatus(winStatus))
        return playerRank


class BattleRoyaleIsSquadModeBlock(base.StatsItem):
    __slots__ = ()

    def _convert(self, value, reusable):
        return _isSquadMode(reusable)


class BattleRoyalePersonalVehicleBlock(base.StatsBlock):
    __slots__ = ('nationName', 'vehicleName', 'isObserver')

    def __init__(self, meta=None, field='', *path):
        super(BattleRoyalePersonalVehicleBlock, self).__init__(meta, field, *path)
        self.nationName = ''
        self.vehicleName = ''
        self.isObserver = False

    def setVehicle(self, item):
        if item is not None:
            self.nationName = item.nationName
            self.vehicleName = item.shortUserName
            self.isObserver = item.isObserver
        return

    def setRecord(self, result, reusable):
        pass


class BattleRoyaleVehiclesBlock(PersonalVehiclesBlock):
    __slots__ = ()

    def _createComponent(self):
        return BattleRoyalePersonalVehicleBlock()


class BattleRoyaleVehicleStatusBlock(base.StatsBlock):
    __slots__ = ('killer', 'vehicleState', 'isSelfDestroyer')

    def __init__(self, meta=None, field='', *path):
        super(BattleRoyaleVehicleStatusBlock, self).__init__(meta, field, *path)
        self.killer = None
        self.vehicleState = DEATH_REASON_ALIVE
        self.isSelfDestroyer = False
        return

    def setRecord(self, result, reusable):
        playerInfo = reusable.getPlayerInfo()
        vehicleId = reusable.vehicles.getVehicleID(playerInfo.dbID)
        vehicleInfo = reusable.vehicles.getVehicleInfo(vehicleId)
        self.vehicleState = vehicleInfo.deathReason
        killerVehicleID = result[vehicleInfo.intCD]['killerID']
        if killerVehicleID:
            killerInfo = reusable.getPlayerInfoByVehicleID(killerVehicleID)
            isSelf = playerInfo.realName == killerInfo.realName
            isSquad = playerInfo.squadIndex > 0 and playerInfo.squadIndex == killerInfo.squadIndex or isSelf
            if killerInfo.realName == killerInfo.fakeName or isSquad:
                self.killer = {'userName': killerInfo.realName, 'clanAbbrev': killerInfo.clanAbbrev}
            else:
                self.killer = {'userName': killerInfo.fakeName, 'clanAbbrev': ''}
            self.isSelfDestroyer = killerInfo.realName == playerInfo.realName


class BattleRoyaleFinancialBlock(base.StatsBlock):
    __slots__ = ('credits', 'xp', 'crystal')

    def __init__(self, meta=None, field='', *path):
        super(BattleRoyaleFinancialBlock, self).__init__(meta, field, *path)
        self.credits = 0
        self.xp = 0
        self.crystal = 0

    def setRecord(self, result, reusable):
        avatarInfo = result['personal']['avatar']
        self.credits = avatarInfo['credits']
        self.xp = avatarInfo['xp']
        self.crystal = avatarInfo['crystal']


class BattleRoyaleStatsItemBlock(base.StatsBlock):
    __slots__ = ('type', 'value', 'maxValue', 'wreathImage')
    _ICON_PATH = R.images.gui.maps.icons.battleRoyale.battleResult.stat_list
    _DEFAULT_ICON = _ICON_PATH.wreath_transparent

    def __init__(self, itemType, meta=None, field='', *path):
        super(BattleRoyaleStatsItemBlock, self).__init__(meta, field, *path)
        self.type = itemType
        self.value = 0
        self.maxValue = 0
        self.wreathImage = R.invalid()

    def setRecord(self, result, reusable):
        self.value = self._getValue(result, reusable)
        self.maxValue = self._getMaxValue(result, reusable)
        self.wreathImage = self._getWreathImage(result, reusable)

    def _getValue(self, result, reusable):
        return 0

    def _getMaxValue(self, result, reusable):
        return -1

    def _getWreathImage(self, result, reusable):
        if self._isTop(result, reusable):
            return self._ICON_PATH.wreath_silver()
        return self._DEFAULT_ICON()

    def _isTop(self, result, reusable):
        return False


class SimpleEfficiencyParameter(BattleRoyaleStatsItemBlock):
    __slots__ = ()

    def _getValue(self, result, reusable):
        personalInfo = reusable.getPersonalVehiclesInfo(result['personal'])
        return getattr(personalInfo, self.type)

    def _isTop(self, result, reusable):
        if self.value == 0:
            return False
        for player in reusable.getAllPlayersIterator(result['vehicles']):
            playerValue = getattr(player, self.type)
            if playerValue > 0 and playerValue > self.value:
                return False

        return True


class PlaceParameter(BattleRoyaleStatsItemBlock):
    __slots__ = ()

    def _getValue(self, result, reusable):
        personalInfo = reusable.getPersonalVehiclesInfo(result['personal'])
        avatar = personalInfo.avatar
        return avatar.extensionInfo.get('playerRank', 0)

    def _getMaxValue(self, result, reusable):

        def observerFilter(player):
            return not player.vehicle.isObserver

        allPlayers = filter(observerFilter, list(reusable.getAllPlayersIterator(result['vehicles'])))
        if _isSquadMode(reusable):
            return len(set(item.player.team for item in allPlayers))
        return len(allPlayers)

    def _getWreathImage(self, result, reusable):
        if self.value == _THE_BEST_RANK:
            return self._ICON_PATH.wreath_gold()
        return self._DEFAULT_ICON()


class KilledBySquadParameter(BattleRoyaleStatsItemBlock):
    __slots__ = ()

    def _getValue(self, result, reusable):
        allPlayers = reusable.getAllPlayersIterator(result['vehicles'])
        team = reusable.getPlayerInfo().team
        return sum(list(item.kills for item in allPlayers if team != 0 and team == item.player.team))

    def _isTop(self, result, reusable):
        if self.value == 0:
            return False
        killesBySquads = defaultdict(int)
        for item in reusable.getAllPlayersIterator(result['vehicles']):
            killesBySquads[item.player.team] += item.kills
            if killesBySquads[item.player.team] > self.value:
                return False

        return True


class BattleRoyaleStatsBlock(base.StatsBlock):
    __slots__ = ()
    _itemsFactory = {StatsItemType.PLACE: PlaceParameter, 
       StatsItemType.KILLS_SOLO: SimpleEfficiencyParameter, 
       StatsItemType.KILLS_SQUAD: KilledBySquadParameter, 
       StatsItemType.DAMAGE_DEAL: SimpleEfficiencyParameter, 
       StatsItemType.DAMAGE_BLOCK: SimpleEfficiencyParameter}

    def setRecord(self, result, reusable):
        items = SQUAD_ITEMS_ORDER if _isSquadMode(reusable) else SOLO_ITEMS_ORDER
        for itemType in items:
            classType = self._itemsFactory.get(itemType)
            if classType is None:
                _logger.error('Incorrect parameter of personal efficiency')
            component = classType(itemType)
            component.setRecord(result, reusable)
            self.addComponent(self.getNextComponentIndex(), component)

        return


class BattleRoyaleRewardsBlock(base.StatsBlock):
    __slots__ = ('achievements', 'bonuses', 'completedQuestsCount', 'completedQuests')
    __eventsCache = dependency.descriptor(IEventsCache)
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)
    __QUESTS_WITH_MEDALS = frozenset(['br_battle_result_solo_1', 'br_battle_result_squad_1'])

    def __init__(self, meta=None, field='', *path):
        super(BattleRoyaleRewardsBlock, self).__init__(meta, field, *path)
        self.achievements = []
        self.bonuses = []
        self.completedQuestsCount = 0
        self.completedQuests = {}

    def setRecord(self, result, reusable):
        questProgress = reusable.personal.getQuestsProgress()
        allQuests = self.__eventsCache.getAllQuests()
        self.achievements = self.__getAchievements(questProgress, allQuests)
        self.completedQuests = self.__getCompletedQuests(questProgress, self.__getDailyQuestsCondition, allQuests)
        self.completedQuestsCount = len(self.completedQuests)
        self.bonuses = self.__getBonuses(allQuests, self.completedQuests)

    def __getAchievements(self, questProgress, allQuests):
        completedQuestsWithMedals = self.__getCompletedQuests(questProgress, self.__getAchievementQuestsCondition, allQuests)
        if completedQuestsWithMedals:
            allBonuses = self.__getBonuses(allQuests, completedQuestsWithMedals)
            allAchievements = [ bonus.getAchievements() for bonuses in allBonuses for bonus in bonuses if bonus.getName() == 'dossier' ]
            return [ achievement.getName() for achievementList in allAchievements for achievement in achievementList ]
        return []

    def __getAchievementQuestsCondition(self, qID, _):
        return qID in self.__QUESTS_WITH_MEDALS

    def __getDailyQuestsCondition(self, qID, allQuests):
        return isBattleRoyale(allQuests.get(qID).getGroupID())

    @staticmethod
    def __getCompletedQuests(questProgress, condition, allQuests):
        return {qID:qProgress for qID, qProgress in questProgress.iteritems() if condition(qID, allQuests) and isQuestCompleted(*qProgress)}

    @staticmethod
    def __getBonuses(allQuests, completedQuests):
        return [ allQuests.get(qID).getBonuses() for qID in completedQuests ]


class BattlePassBlock(base.StatsBlock):
    __slots__ = ('currentLevel', 'maxPoints', 'earnedPoints', 'currentLevelPoints',
                 'isDone')
    __battlePassController = dependency.descriptor(IBattlePassController)

    def __init__(self, meta=None, field='', *path):
        super(BattlePassBlock, self).__init__(meta, field, *path)
        self.currentLevel = 0
        self.maxPoints = 0
        self.earnedPoints = 0
        self.currentLevelPoints = 0
        self.isDone = False

    def setRecord(self, result, reusable):
        if reusable.battlePassProgress is not None:
            progressionInfo = reusable.battlePassProgress.get(BattlePassConsts.PROGRESSION_INFO, reusable.battlePassProgress.get(BattlePassConsts.PROGRESSION_INFO_PREV))
            if progressionInfo is not None:
                self.currentLevel = progressionInfo.level
                self.maxPoints = progressionInfo.pointsTotal
                self.earnedPoints = progressionInfo.pointsBattleDiff
                self.currentLevelPoints = progressionInfo.pointsNew
                self.isDone = progressionInfo.isDone
        return


class BattleRoyalePlayerBlock(base.StatsBlock):
    __slots__ = ('isPersonal', 'userName', 'clanAbbrev', 'place', 'isPersonalSquad',
                 'squadIdx', 'hiddenName', 'achievedLevel', 'kills', 'damage', 'vehicleName',
                 'nationName')

    def __init__(self, meta=None, field='', *path):
        super(BattleRoyalePlayerBlock, self).__init__(meta, field, *path)
        self.isPersonal = False
        self.userName = ''
        self.hiddenName = ''
        self.clanAbbrev = ''
        self.place = 0
        self.squadIdx = 0
        self.isPersonalSquad = False
        self.achievedLevel = 0
        self.kills = 0
        self.damage = 0
        self.vehicleName = ''
        self.nationName = ''

    def setRecord(self, vehicleSummarizeInfo, reusable):
        player = vehicleSummarizeInfo.player
        dbID = player.dbID
        if player.realName == player.fakeName:
            self.userName = player.realName
            self.clanAbbrev = player.clanAbbrev
        elif self.isPersonal or self.isPersonalSquad:
            self.userName = player.realName
            self.clanAbbrev = player.clanAbbrev
            self.hiddenName = player.fakeName
        else:
            self.userName = player.fakeName
            self.hiddenName = player.realName
            self.clanAbbrev = ''
        avatarInfo = reusable.avatars.getAvatarInfo(dbID)
        if avatarInfo is not None and avatarInfo.extensionInfo is not None:
            self.place = avatarInfo.extensionInfo.get('playerRank', 0)
        return


class BattleRoyaleTeamStatsBlock(base.StatsBlock):
    __slots__ = ()

    def setRecord(self, result, reusable):
        allPlayers = reusable.getAllPlayersIterator(result, sortKey=sort_keys.placeSortKey)
        personalInfo = reusable.getPlayerInfo()
        personalDBID = personalInfo.dbID
        team = personalInfo.team if personalInfo.squadIndex else 0
        for item in allPlayers:
            if item.vehicle is not None and item.vehicle.isObserver:
                continue
            block = BattleRoyalePlayerBlock()
            player = item.player
            block.isPersonal = player.dbID == personalDBID
            block.squadIdx = player.team
            block.isPersonalSquad = team != 0 and team == player.team
            block.achievedLevel = item.vehicles[0].achievedLevel
            block.damage = item.damageDealt
            block.kills = item.kills
            block.nationName = item.vehicle.nationName
            block.vehicleName = item.vehicle.shortUserName
            block.setRecord(item, reusable)
            self.addComponent(self.getNextComponentIndex(), block)

        return