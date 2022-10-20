import BigWorld
from constants import QUEUE_TYPE, PREBATTLE_TYPE_NAMES, ARENA_GUI_TYPE, PREBATTLE_TYPE, DEFAULT_LANGUAGE, ACCOUNT_ATTR
from gui.prb_control.settings import makePrebattleSettings, VEHICLE_MAX_LEVEL
from helpers import dependency
from skeletons.gui.game_control import IGameSessionController
from skeletons.gui.game_control import IBootcampController
from skeletons.gui.lobby_context import ILobbyContext
from soft_exception import SoftException
from PlayerEvents import g_playerEvents

def getQueueType():
    return getattr(BigWorld.player(), 'battleQueueType', QUEUE_TYPE.UNKNOWN)


@dependency.replace_none_kwargs(bootcampController=IBootcampController)
def isInBootcampAccount(bootcampController=None):
    return bootcampController is not None and bootcampController.isInBootcampAccount()


def getClientPrebattle():
    return getattr(BigWorld.player(), 'prebattle', None)


def getPrebattleID():
    clientPrb = getClientPrebattle()
    prbID = 0
    if clientPrb:
        prbID = clientPrb.id
    return prbID


def isPrebattleSettingsReceived(prebattle=None):
    prb = prebattle or getClientPrebattle()
    if prb is not None:
        return prb.settings is not None
    else:
        return False


def getPrebattleSettings(prebattle=None):
    prb = prebattle or getClientPrebattle()
    if prb and prb.settings:
        return makePrebattleSettings(prb.settings)
    return makePrebattleSettings()


def getPrebattleProps(prebattle=None):
    prb = prebattle or getClientPrebattle()
    result = {}
    if prb and prb.properties:
        result = prb.properties
    return result


def getPrebattleRosters(prebattle=None):
    prb = prebattle or getClientPrebattle()
    result = {}
    if prb:
        result = prb.rosters
    return result


def getPrebattleTeamStates(prebattle=None):
    prb = prebattle or getClientPrebattle()
    result = [None, 0, 0]
    if prb:
        result = prb.teamStates
    return result


def getPrebattleAutoInvites():
    autoInvites = {}
    player = BigWorld.player()
    if hasattr(player, 'prebattleAutoInvites'):
        autoInvites = player.prebattleAutoInvites
    g_playerEvents.onCollectPrebattleInvites(autoInvites)
    return autoInvites


def getPrebattleType(prebattle=None, settings=None):
    try:
        if settings is None:
            settings = getPrebattleSettings(prebattle=prebattle)
        return settings['type']
    except KeyError:
        return

    return


def getPrebattleTypeName(prbType=None):
    if prbType is None:
        prbType = getPrebattleType()
    if prbType in PREBATTLE_TYPE_NAMES:
        prbTypeName = PREBATTLE_TYPE_NAMES[prbType]
    else:
        prbTypeName = 'PREBATTLE'
    return prbTypeName


_ARENA_GUI_TYPE_BY_PRB_TYPE = {PREBATTLE_TYPE.SQUAD: ARENA_GUI_TYPE.RANDOM, 
   PREBATTLE_TYPE.TRAINING: ARENA_GUI_TYPE.TRAINING, 
   PREBATTLE_TYPE.EVENT: ARENA_GUI_TYPE.EVENT_BATTLES}
_ARENA_GUI_TYPE_BY_QUEUE_TYPE = {QUEUE_TYPE.RANDOMS: ARENA_GUI_TYPE.RANDOM, 
   QUEUE_TYPE.EVENT_BATTLES: ARENA_GUI_TYPE.EVENT_BATTLES, 
   QUEUE_TYPE.EVENT_BATTLES_2: ARENA_GUI_TYPE.EVENT_BATTLES, 
   QUEUE_TYPE.RANKED: ARENA_GUI_TYPE.RANKED, 
   QUEUE_TYPE.EPIC: ARENA_GUI_TYPE.EPIC_BATTLE, 
   QUEUE_TYPE.BATTLE_ROYALE: ARENA_GUI_TYPE.BATTLE_ROYALE, 
   QUEUE_TYPE.BATTLE_ROYALE_TOURNAMENT: ARENA_GUI_TYPE.BATTLE_ROYALE, 
   QUEUE_TYPE.MAPBOX: ARENA_GUI_TYPE.MAPBOX, 
   QUEUE_TYPE.MAPS_TRAINING: ARENA_GUI_TYPE.MAPS_TRAINING, 
   QUEUE_TYPE.COMP7: ARENA_GUI_TYPE.COMP7}

def getArenaGUIType(prbType=None, queueType=None):
    if prbType is None:
        prbType = getPrebattleType()
    if queueType is None:
        queueType = getQueueType()
    arenaGuiType = ARENA_GUI_TYPE.RANDOM
    if prbType is not None:
        arenaGuiType = ARENA_GUI_TYPE.UNKNOWN
        if prbType in _ARENA_GUI_TYPE_BY_PRB_TYPE:
            arenaGuiType = _ARENA_GUI_TYPE_BY_PRB_TYPE[prbType]
    elif queueType:
        if queueType in _ARENA_GUI_TYPE_BY_QUEUE_TYPE:
            arenaGuiType = _ARENA_GUI_TYPE_BY_QUEUE_TYPE[queueType]
    return arenaGuiType


def getTotalLevelLimits(teamLimits):
    return teamLimits['totalLevel']


def getLevelLimits(teamLimits):
    limit = teamLimits['level']
    return (limit[0], min(limit[1], VEHICLE_MAX_LEVEL))


def getNationsLimits(teamLimits):
    return teamLimits['nations']


def getMaxSizeLimits(teamLimits):
    return teamLimits['maxCount']


def getClassLevelLimits(teamLimits, classType):
    classesLimits = teamLimits['classes']
    if classesLimits is not None and classType not in classesLimits:
        return (0, 0)
    else:
        classLevel = teamLimits['classLevel']
        if classType in classLevel:
            limit = teamLimits['classLevel'][classType]
        else:
            limit = getLevelLimits(teamLimits)
        return (limit[0], min(limit[1], VEHICLE_MAX_LEVEL))


def getPrebattleLocalizedData(extraData=None):
    led = {}
    if extraData is None:
        extraData = getPrebattleSettings()['extraData']
    if extraData:
        from helpers import getClientLanguage
        lng = getClientLanguage()
        ld = extraData.get('localized_data', {})
        if ld:
            if lng in ld:
                led = ld[lng]
            elif DEFAULT_LANGUAGE in ld:
                led = ld[DEFAULT_LANGUAGE]
            else:
                sortedItems = ld.items()
                sortedItems.sort()
                led = sortedItems[0][1]
        else:
            return extraData.get('descr', {})
    return led


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getCreatorFullName(lobbyContext=None):
    settings = getPrebattleSettings()
    creatorName = settings['creator']
    clanAbbrev = settings['creatorClanAbbrev']
    if lobbyContext is not None:
        creatorRegion = lobbyContext.getRegionCode(settings['creatorDBID'])
    else:
        creatorRegion = None
    if clanAbbrev:
        fullName = ('{0:>s}[{1:>s}]').format(creatorName, clanAbbrev)
    else:
        fullName = creatorName
    if creatorRegion:
        fullName = ('{0:>s} {1:>s}').format(fullName, creatorRegion)
    return fullName


def areSpecBattlesHidden():
    return not getattr(BigWorld.player(), 'prebattleAutoInvites', None)


def isTraining(settings=None):
    return getPrebattleType(settings=settings) == PREBATTLE_TYPE.TRAINING


def isBattleSession(settings=None):
    return getPrebattleType(settings=settings) in (
     PREBATTLE_TYPE.TOURNAMENT, PREBATTLE_TYPE.CLAN)


@dependency.replace_none_kwargs(gameSession=IGameSessionController)
def isParentControlActivated(gameSession=None):
    return gameSession is not None and gameSession.isParentControlActive


def getClientUnitMgr():
    return getattr(BigWorld.player(), 'unitMgr', None)


def getUnitMgrID():
    return getattr(getClientUnitMgr(), 'id', None)


def getBattleID():
    return getattr(getClientUnitMgr(), 'battleID', 0)


def getClientUnitBrowser():
    return getattr(BigWorld.player(), 'unitBrowser', None)


def getUnit(safe=False):
    unitMgr = getClientUnitMgr()
    if not unitMgr:
        if not safe:
            raise SoftException('Unit manager not found')
        return
    unit = None
    try:
        unit = unitMgr.unit
    except AttributeError:
        if not safe:
            raise SoftException('Unit not found')

    return unit


def hasModalEntity():
    return getClientPrebattle() or getUnit()


def getTrainingBattleRoundLimits(accountAttrs):
    if accountAttrs & ACCOUNT_ATTR.DAILY_BONUS_1:
        return (60, 14400)
    return (
     300, 1800)