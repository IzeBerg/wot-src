import BigWorld
from constants import IS_CLIENT, ARENA_PERIOD, WT_TEAMS, ARENA_BONUS_TYPE, WT_TAGS, WT_BATTLE_STAGE
if IS_CLIENT:
    import CGF, GenericComponents
    from ArenaInfo import ArenaInfo
    from shared_utils import first
    from helpers import dependency
    from skeletons.gui.battle_session import IBattleSessionProvider
    from gui.battle_control.battle_constants import PERSONAL_EFFICIENCY_TYPE
    from cgf_components import BossTag, HunterTag, PlayerVehicleTag
    from Vehicle import Vehicle
    from IndexPool import IndexPool
_SECONDS_IN_MINUTE = 60.0

def isBoss():
    return getattr(BigWorld.player(), 'team', 0) == WT_TEAMS.BOSS_TEAM


def isBossVehicle(vehicle):
    return vehicle.entityGameObject.findComponentByType(BossTag) is not None


def isBossTeam(vehicle):
    vehicleInfo = getVehicleInfo(vehicle.id)
    return vehicleInfo['team'] == WT_TEAMS.BOSS_TEAM


def isPlayerVehicle(vehicle):
    return vehicle.entityGameObject.findComponentByType(PlayerVehicleTag) is not None


def getBossVehicle():
    query = CGF.Query(BigWorld.player().spaceID, (BossTag, Vehicle))
    vehData = first(query)
    if vehData is not None:
        return vehData[1]
    else:
        return


def getPlayerVehicle():
    query = CGF.Query(BigWorld.player().spaceID, (PlayerVehicleTag, Vehicle))
    vehData = first(query)
    if vehData is not None:
        return vehData[1]
    else:
        return


def getVehicleInfo(vehicleId):
    arena = getattr(BigWorld.player(), 'arena')
    if arena is not None:
        return arena.vehicles.get(vehicleId)
    else:
        return


def canRespawn():
    return getPlayerLives() > 1


def getHuntersCount():
    query = CGF.Query(BigWorld.player().spaceID, (HunterTag, Vehicle))
    hunters = [ v for _, v in query.values() if v.isAlive() or getLives(v.id) > 0 ]
    return len(hunters)


def getPlayerVehicleHealthPercent():
    query = CGF.Query(BigWorld.player().spaceID, (PlayerVehicleTag, Vehicle))
    vehData = first(query)
    if vehData is not None:
        return 100.0 * vehData[1].health / vehData[1].maxHealth
    else:
        return 0.0


def getBossVehicleHealthPercent():
    arenaInfoQuery = CGF.Query(BigWorld.player().spaceID, ArenaInfo)
    arenaInfo = first(arenaInfoQuery)
    if arenaInfo is not None:
        publicHealth = arenaInfo.dynamicComponents.get('arenaPublicHealth')
        if publicHealth is not None:
            for healthInfo in publicHealth.healthInfoList:
                vehicleInfo = getVehicleInfo(healthInfo['vehicleID'])
                if vehicleInfo is not None and WT_TAGS.BOSS in vehicleInfo['vehicleType'].type.tags:
                    return 100.0 * healthInfo['health'] / vehicleInfo['maxHealth']

    return 0.0


def getLives(vehicleId):
    if vehicleId is not None:
        avatar = BigWorld.player()
        if avatar is not None and avatar.arena is not None and avatar.arena.arenaInfo is not None:
            teamLivesComponent = avatar.arena.arenaInfo.dynamicComponents.get('teamLivesComponent')
            if teamLivesComponent is not None:
                return teamLivesComponent.getLives(vehicleId)
    return 0


def getPlayerLives():
    return getLives(getattr(BigWorld.player(), 'playerVehicleID', None))


def getBattleTimeLeft():
    arena = getattr(BigWorld.player(), 'arena', None)
    if arena is not None and arena.period == ARENA_PERIOD.BATTLE:
        return (arena.periodEndTime - BigWorld.serverTime()) / _SECONDS_IN_MINUTE
    else:
        return 0.0


def getDestroyedGeneratorsCount():
    query = CGF.Query(BigWorld.player().spaceID, GenericComponents.BattleStage)
    stageComponent = first(query.values())
    if stageComponent is not None:
        return stageComponent.maximum - stageComponent.current
    else:
        return 0


def getCampCount():
    campsQuery = CGF.Query(BigWorld.player().spaceID, IndexPool)
    camps = [ camp for camp in campsQuery.values() if camp.label == 'camp' ]
    return len(camps)


def getKilledByBoss():
    inputHandler = getattr(BigWorld.player(), 'inputHandler', None)
    if inputHandler is not None:
        killerInfo = getVehicleInfo(inputHandler.getKillerVehicleID())
        return killerInfo is not None and WT_TAGS.BOSS in killerInfo['vehicleType'].type.tags
    else:
        return False


def getHasDebuff():
    arenaInfoQuery = CGF.Query(BigWorld.player().spaceID, ArenaInfo)
    arenaInfo = first(arenaInfoQuery)
    if arenaInfo is not None:
        state = WT_BATTLE_STAGE.getCurrent(arenaInfo)
        return state == WT_BATTLE_STAGE.DEBUFF or state == WT_BATTLE_STAGE.END_GAME
    else:
        return False


def getTotalPlayerDamage():
    sessionProvider = dependency.instance(IBattleSessionProvider)
    efficiencyCtrl = sessionProvider.shared.personalEfficiencyCtrl
    return int(efficiencyCtrl.getTotalEfficiency(PERSONAL_EFFICIENCY_TYPE.DAMAGE))


def isEventBattle():
    sessionProvider = dependency.instance(IBattleSessionProvider)
    bonusType = sessionProvider.arenaVisitor.getArenaBonusType()
    return bonusType in ARENA_BONUS_TYPE.WT_BATTLES_RANGE