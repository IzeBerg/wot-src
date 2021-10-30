import weakref
from functools import wraps
import Event
from client_arena_component_system import ClientArenaComponent
from constants import ARENA_SYNC_OBJECTS, EVENT_SOULS_CHANGE_REASON
import BigWorld
from debug_utils import LOG_ERROR

class GameEventComponent(ClientArenaComponent):

    def __init__(self, componentSystem):
        super(GameEventComponent, self).__init__(componentSystem)
        self._teammateResurrectEquipment = TeammateResurrectEquipment(self)
        self._scenarioAnimationTriggers = ScenarioAnimationTriggers(self)
        self._environmentData = EnvironmentEventData(self)
        self._bossFightData = BossFightEventData(self)
        self._souls = Souls(self)
        self._soulCollector = SoulCollector(self)
        self._damageData = DamageData(self)
        self._blockedDamageData = BlockedDamageData(self)
        self._ecpState = ECPState(self)
        self._nearbyIndicator = NearbyIndicatorData(self)
        self._enemySpottedData = EnemySpottedData(self)

    def activate(self):
        super(GameEventComponent, self).activate()
        self._teammateResurrectEquipment.activate()
        self._scenarioAnimationTriggers.activate()
        self._environmentData.activate()
        self._bossFightData.activate()
        self._souls.activate()
        self._soulCollector.activate()
        self._damageData.activate()
        self._nearbyIndicator.activate()
        self._ecpState.activate()
        self._enemySpottedData.activate()

    def deactivate(self):
        self._scenarioAnimationTriggers.deactivate()
        self._teammateResurrectEquipment.deactivate()
        self._environmentData.deactivate()
        self._bossFightData.deactivate()
        self._damageData.deactivate()
        self._souls.deactivate()
        self._soulCollector.deactivate()
        self._nearbyIndicator.deactivate()
        self._ecpState.deactivate()
        self._enemySpottedData.deactivate()
        super(GameEventComponent, self).deactivate()

    def getTeammateResurrectEquipment(self):
        return self._teammateResurrectEquipment

    def scenarioAnimationTriggers(self):
        return self._scenarioAnimationTriggers

    def getEnvironmentData(self):
        return self._environmentData

    def getBossFightData(self):
        return self._bossFightData

    def getSouls(self):
        return self._souls

    def getSoulCollector(self):
        return self._soulCollector

    def getDamageData(self):
        return self._damageData

    def getBlockedDamageData(self):
        return self._blockedDamageData

    @property
    def ecpState(self):
        return self._ecpState

    def getNearbyIndicator(self):
        return self._nearbyIndicator

    def getEnemySpottedData(self):
        return self._enemySpottedData


class GameEventData(object):

    def __init__(self, gameEventComponent, dataDictName):
        super(GameEventData, self).__init__()
        self._gameEventComponent = weakref.proxy(gameEventComponent)
        self._dataDictName = dataDictName
        self._eventManager = Event.EventManager()
        self.onUpdated = Event.Event(self._eventManager)

    def activate(self):
        self._gameEventComponent.addSyncDataCallback(ARENA_SYNC_OBJECTS.GAME_EVENT, self._dataDictName, self._onUpdated)

    def deactivate(self):
        self._gameEventComponent.removeSyncDataCallback(ARENA_SYNC_OBJECTS.GAME_EVENT, self._dataDictName, self._onUpdated)
        self._eventManager.clear()

    def hasSyncData(self):
        return self._gameEventComponent.hasSyncDataObjectData(ARENA_SYNC_OBJECTS.GAME_EVENT, self._dataDictName)

    def getSyncData(self):
        return self._gameEventComponent.getSyncDataObjectData(ARENA_SYNC_OBJECTS.GAME_EVENT, self._dataDictName)

    def _onUpdated(self, _):
        self.onUpdated()


def _hasSyncData(default=None):

    def wrapper(func):

        @wraps(func)
        def wrapped(self, *args, **kwargs):
            if not self.hasSyncData():
                return default
            return func(self, *args, **kwargs)

        return wrapped

    return wrapper


class EnemySpottedData(GameEventData):

    def __init__(self, gameEventComponent):
        super(EnemySpottedData, self).__init__(gameEventComponent, 'enemySpottedData')
        self.onEnemySpottedDataUpdate = Event.Event(self._eventManager)

    def checkVehicleSpottedByRole(self, roleNameStr):
        if self.hasSyncData():
            return self.getSyncData().get(roleNameStr, 0)
        return 0

    def _onUpdated(self, diff):
        super(EnemySpottedData, self)._onUpdated(diff)
        self.onEnemySpottedDataUpdate(diff)


class NearbyIndicatorData(GameEventData):

    def __init__(self, gameEventComponent):
        super(NearbyIndicatorData, self).__init__(gameEventComponent, 'nearbyVehicleIndicator')
        self.onNearByIndicatorChanged = Event.Event(self._eventManager)

    def getIndicatorValue(self, avatarID):
        if not self.hasSyncData():
            return 0
        return int(self.getSyncData().get(avatarID, 0))


class TeammateResurrectEquipment(GameEventData):

    def __init__(self, gameEventComponent):
        super(TeammateResurrectEquipment, self).__init__(gameEventComponent, 'teammateResurrectEquipment')
        self.onTeammateResurrectUpdate = Event.Event(self._eventManager)

    @_hasSyncData(default=False)
    def getTeammateResurrect(self, vehID):
        return self.getSyncData().get(vehID, False)

    def _onUpdated(self, diff):
        super(TeammateResurrectEquipment, self)._onUpdated(diff)
        self.onTeammateResurrectUpdate(diff)


class ScenarioAnimationTriggers(GameEventData):

    def __init__(self, gameEventComponent):
        super(ScenarioAnimationTriggers, self).__init__(gameEventComponent, 'scenarioAnimationTriggers')
        self.onScenarioAnimationTriggersUpdate = Event.Event(self._eventManager)

    @_hasSyncData(default=set())
    def getTriggers(self):
        return {trigger for trigger, enabled in self.getSyncData().iteritems() if enabled if enabled}

    def _onUpdated(self, diff):
        super(ScenarioAnimationTriggers, self)._onUpdated(diff)
        for trigger, enabled in diff.iteritems():
            if enabled:
                BigWorld.wg_setTrigger(trigger)

        self.onScenarioAnimationTriggersUpdate(diff)


class Souls(GameEventData):

    def __init__(self, gameEventComponent):
        super(Souls, self).__init__(gameEventComponent, 'souls')
        self.onSoulsChanged = Event.Event(self._eventManager)

    def getSouls(self, vehID):
        return self._getSoulData(vehID)[0]

    def getLastSoulsModifiedReason(self, vehID):
        return self._getSoulData(vehID)[1]

    @_hasSyncData(default=(0, EVENT_SOULS_CHANGE_REASON.NONE))
    def _getSoulData(self, vehID):
        return self.getSyncData().get(vehID, (0, EVENT_SOULS_CHANGE_REASON.NONE))

    def _onUpdated(self, diff):
        super(Souls, self)._onUpdated(diff)
        self.onSoulsChanged(diff)


class SoulCollector(GameEventData):

    def __init__(self, gameEventComponent):
        super(SoulCollector, self).__init__(gameEventComponent, 'ecpSouls')
        self.onSoulsChanged = Event.Event(self._eventManager)

    @_hasSyncData(default=(0, EVENT_SOULS_CHANGE_REASON.NONE))
    def getSoulCollectorData(self):
        return self.getSyncData()

    def _onUpdated(self, diff):
        super(SoulCollector, self)._onUpdated(diff)
        self.onSoulsChanged(diff)


class DamageData(GameEventData):

    def __init__(self, gameEventComponent):
        super(DamageData, self).__init__(gameEventComponent, 'damage')
        self.onDamageChanged = Event.Event(self._eventManager)

    def getDamage(self, vehID):
        return self._getDamageData(vehID)

    @_hasSyncData(default=0)
    def _getDamageData(self, vehID):
        return self.getSyncData().get(vehID, 0)

    def _onUpdated(self, damage):
        super(DamageData, self)._onUpdated(damage)
        self.onDamageChanged(damage)


class BlockedDamageData(GameEventData):

    def __init__(self, gameEventComponent):
        super(BlockedDamageData, self).__init__(gameEventComponent, 'blockedDamage')
        self.onBlockedDamageChanged = Event.Event(self._eventManager)

    @_hasSyncData(default=0)
    def getBlockedDamage(self, vehID):
        return self.getSyncData().get(vehID, 0)

    def _onUpdated(self, blockedDamage):
        super(BlockedDamageData, self)._onUpdated(blockedDamage)
        self.onBlockedDamageChanged(blockedDamage)


class ECPState(GameEventData):

    def __init__(self, gameEventComponent):
        super(ECPState, self).__init__(gameEventComponent, 'ecpState')

    def getStateByID(self, ecpID):
        if not self.hasSyncData():
            return 0
        else:
            return self.getSyncData().get(ecpID, None)

    def getStates(self):
        if not self.hasSyncData():
            return {}
        return self.getSyncData()


class EnvironmentEventData(GameEventData):

    def __init__(self, gameEventComponent):
        super(EnvironmentEventData, self).__init__(gameEventComponent, 'environment')
        self.onEnvironmentEventIDUpdate = Event.Event(self._eventManager)

    def getCurrentEnvironmentID(self):
        if not self.hasSyncData():
            return 0
        return int(self.getSyncData().get('currentID', 0))

    def getEnvironmentsList(self):
        if not self.hasSyncData():
            return []
        return self.getSyncData().get('environmentsList', [])

    def getEnvironmentMappingByID(self, envID):
        result = next((envData for envData in self.getEnvironmentsList() if envData['id'] == envID), {})
        if not result:
            LOG_ERROR('Requested environment ID [%s] is not available' % envID)
        return result

    def getSoundEnvironmentID(self, envID):
        return self.getEnvironmentMappingByID(envID)['sound']

    def getVisualLayerEnvironmentID(self, envID):
        return self.getEnvironmentMappingByID(envID)['visualLayer']

    def getL10nID(self, envID):
        return self.getEnvironmentMappingByID(envID)['l10n']

    def getMaxEnvironmentID(self):
        if not self.hasSyncData():
            return 0
        return int(self.getSyncData().get('maxID', 0))

    def getBossFightEnvironmentID(self):
        if not self.hasSyncData():
            return
        else:
            envID = self.getSyncData().get('bossFightEnvironmentID')
            if envID:
                return int(envID)
            return

    def _onUpdated(self, diff):
        super(EnvironmentEventData, self)._onUpdated(diff)
        envID = diff.get('currentID')
        if envID is not None:
            self.onEnvironmentEventIDUpdate(envID)
        return


class BossFightEventData(GameEventData):

    def __init__(self, gameEventComponent):
        super(BossFightEventData, self).__init__(gameEventComponent, 'bossFightData')
        self.onBossFightDataUpdate = Event.Event(self._eventManager)

    def getPhaseHealth(self):
        if not self.hasSyncData():
            return None
        else:
            phaseHealth = self.getSyncData()
            if not phaseHealth:
                return None
            if len(phaseHealth) < 2:
                LOG_ERROR('Incorrect data format came as the boss fight event data!')
                return None
            return tuple(phaseHealth)