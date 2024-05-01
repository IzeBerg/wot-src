import os
from calendar import timegm
from datetime import datetime
from typing import TYPE_CHECKING
import ArenaType, ResMgr, section2dict
from ExtensionsManager import makeExtensionPath
from base_schema_manager import GameParamsSchema
from constants import IS_BASEAPP, IS_CLIENT
from cosmic_event_common.cosmic_constants import COSMIC_EVENT_GAME_PARAMS_KEY, COSMIC_EVENT_CONFIG, PhaseTypes, ZoneTypes
from debug_utils import LOG_ERROR
from dict2model import models, fields, validate, schemas
from items import vehicles
from soft_exception import SoftException
from arena_vscript_config.schemas import configSchema
if IS_BASEAPP:
    from game_region_params import get as getGameParams
    from server_constants import CENTER
elif IS_CLIENT:
    from helpers import dependency
    from skeletons.gui.lobby_context import ILobbyContext
if TYPE_CHECKING:
    from typing import List, Optional
    from arena_vscript_config.schemas import ConfigModel

class CosmicBattleConfigModel(models.Model):
    __slots__ = ('eventVehicle', 'eventVehicleCD', 'loot', 'mapsInfo', 'maps', 'scoreSystem',
                 'rewardSettings', 'fragments', 'vehicleRentQuestID', 'zonesConfig',
                 'effects', 'phasesConfig')

    def __init__(self, eventVehicle, loot, mapsInfo, scoreSystem, fragments, rewardSettings, vehicleRentQuestID, zonesConfig, effects, phasesConfig):
        super(CosmicBattleConfigModel, self).__init__()
        self.eventVehicle = eventVehicle
        self.loot = loot
        self.fragments = fragments
        self.scoreSystem = scoreSystem
        self.rewardSettings = rewardSettings
        self.vehicleRentQuestID = vehicleRentQuestID
        self.mapsInfo = mapsInfo
        self.maps = self.makeMapsList()
        self.zonesConfig = zonesConfig
        self.effects = effects
        self.phasesConfig = phasesConfig

    def asDict(self):
        configDict = super(CosmicBattleConfigModel, self).toDict()
        configDict.update(self.realmConfig)
        return configDict

    @property
    def isEnabled(self):
        return self.realmConfig.get('isEnabled', False)

    @property
    def eventVehicleCD(self):
        return vehicles.makeVehicleTypeCompDescrByName(self.eventVehicle)

    @property
    def isBattleEnabled(self):
        return self.realmConfig.get('isBattleEnabled', False)

    @property
    def seasons(self):
        return self.realmConfig.get('seasons', {})

    @property
    def primeTimes(self):
        return self.realmConfig.get('primeTimes', {})

    @property
    def cycleTimes(self):
        return self.realmConfig.get('cycleTimes', tuple())

    @property
    def realms(self):
        return self.realmConfig.get('realms', [])

    @property
    def peripheryIDs(self):
        return self.realmConfig.get('peripheryIDs', [])

    @property
    def battleModifiersDescr(self):
        return self.realmConfig.get('battleModifiersDescr', None)

    @property
    def realmConfig(self):
        cosmicRealmConfig = None
        if IS_BASEAPP:
            cosmicRealmConfig = getGameParams(account=None, rev=None, centerID=CENTER.ID).get(COSMIC_EVENT_CONFIG)
        elif IS_CLIENT:
            lobbyContext = dependency.instance(ILobbyContext)
            cosmicRealmConfig = lobbyContext.getServerSettings().getSettings().get(COSMIC_EVENT_CONFIG)
        if not cosmicRealmConfig:
            raise SoftException('Trying to access realmConfig of CosmicBattleConfigModel with not initialised game params')
        return cosmicRealmConfig

    def makeMapsList(self):
        mapsList = []
        for mapModel in self.mapsInfo:
            geometryName = mapModel.geometryName
            gameplayName = mapModel.gameplayName
            if geometryName and gameplayName:
                try:
                    geometryID = ArenaType.g_geometryNamesToIDs[geometryName]
                    mapsList.append(geometryID | ArenaType.getGameplayIDForName(gameplayName) << 16)
                except validate.ValidationError:
                    LOG_ERROR('Invalid arena geometry name: %s' % (geometryName,))
                    raise validate.ValidationError

        return mapsList


class LootSettingsModel(models.Model):
    __slots__ = ('visualScriptConfig', 'pickupRange', 'pickupHeight', 'pickupDepth',
                 'pickupOffset')

    def __init__(self, visualScriptConfig, pickupRange, pickupHeight, pickupDepth, pickupOffset):
        super(LootSettingsModel, self).__init__()
        self.visualScriptConfig = visualScriptConfig
        self.pickupRange = pickupRange
        self.pickupHeight = pickupHeight
        self.pickupDepth = pickupDepth
        self.pickupOffset = pickupOffset


class FragmentTypeModel(models.Model):
    __slots__ = ('manager', 'clientPrefab', 'clientPrefabHint')

    def __init__(self, manager, clientPrefab, clientPrefabHint):
        super(FragmentTypeModel, self).__init__()
        self.manager = manager
        self.clientPrefab = clientPrefab
        self.clientPrefabHint = clientPrefabHint


class VSEManagerModel(models.Model):
    __slots__ = ('visualScript', )

    def __init__(self, visualScript):
        super(VSEManagerModel, self).__init__()
        self.visualScript = visualScript


class ScoreSystemModel(models.Model):
    __slots__ = ('isEnabled', 'damageTagDuration', 'eventsConfig', '_scoreEventsUpper',
                 'killAssistDuration')

    def __init__(self, isEnabled, damageTagDuration, killAssistDuration, eventsConfig):
        super(ScoreSystemModel, self).__init__()
        self.isEnabled = isEnabled
        self.damageTagDuration = damageTagDuration
        self.killAssistDuration = killAssistDuration
        self.eventsConfig = eventsConfig
        self._scoreEventsUpper = {scoreEvent.upper():value for scoreEvent, value in self.eventsConfig.toDict().iteritems()}

    @property
    def scoreEventsUpper(self):
        return self._scoreEventsUpper


class EventsConfigModel(models.Model):
    __slots__ = ('shot', 'ramming', 'kill', 'kill_assist', 'ability_pickup', 'ability_hit',
                 'fragment_pickup', 'fragment_carrying', 'fragment_delivering', 'fragment_holder_kill',
                 'evacuation_0', 'evacuation_1', 'evacuation_2', 'evacuation_3',
                 'evacuation_4', 'evacuation_5', 'evacuation_6', 'evacuation_7')

    def __init__(self, shot, ramming, kill, kill_assist, ability_pickup, ability_hit, fragment_pickup, fragment_carrying, fragment_delivering, fragment_holder_kill, evacuation_0, evacuation_1, evacuation_2, evacuation_3, evacuation_4, evacuation_5, evacuation_6, evacuation_7):
        super(EventsConfigModel, self).__init__()
        self.shot = shot
        self.ramming = ramming
        self.kill = kill
        self.kill_assist = kill_assist
        self.ability_pickup = ability_pickup
        self.fragment_delivering = fragment_delivering
        self.fragment_holder_kill = fragment_holder_kill
        self.ability_hit = ability_hit
        self.fragment_pickup = fragment_pickup
        self.fragment_carrying = fragment_carrying
        self.evacuation_0 = evacuation_0
        self.evacuation_1 = evacuation_1
        self.evacuation_2 = evacuation_2
        self.evacuation_3 = evacuation_3
        self.evacuation_4 = evacuation_4
        self.evacuation_5 = evacuation_5
        self.evacuation_6 = evacuation_6
        self.evacuation_7 = evacuation_7

    def getEventScore(self, eventName, defaultScore=0):
        return getattr(self, eventName.lower(), defaultScore)

    def getFirstPlaceEvacuationScore(self):
        return self.evacuation_0


class RewardSettingModel(models.Model):
    __slots__ = ('questPrefix', 'progressionQuestGroupId', 'rewardToken', 'limit',
                 'expirationDateInfo', 'expirationDate', 'chapter1TokenComplete',
                 'chapter2TokenComplete', 'chapter3TokenComplete', 'artifactToken')

    def __init__(self, questPrefix, rewardToken, progressionQuestGroupId, expirationDateInfo, limit, chapter1TokenComplete, chapter2TokenComplete, chapter3TokenComplete, artifactToken):
        super(RewardSettingModel, self).__init__()
        self.questPrefix = questPrefix
        self.progressionQuestGroupId = progressionQuestGroupId
        self.rewardToken = rewardToken
        self.limit = limit
        self.expirationDateInfo = expirationDateInfo
        self.expirationDate = self.parseTime(self.expirationDateInfo)
        self.chapter1TokenComplete = chapter1TokenComplete
        self.chapter2TokenComplete = chapter2TokenComplete
        self.chapter3TokenComplete = chapter3TokenComplete
        self.artifactToken = artifactToken

    @staticmethod
    def parseTime(datetimeObj):
        if isinstance(datetimeObj, int):
            return datetimeObj
        return int(timegm(datetimeObj.timetuple()))


class MapSettingsModel(models.Model):
    __slots__ = ('geometryName', 'gameplayName')

    def __init__(self, geometryName, gameplayName):
        super(MapSettingsModel, self).__init__()
        self.geometryName = geometryName
        self.gameplayName = gameplayName


class ZoneModel(models.Model):
    __slots__ = ('name', 'prefabs')

    def __init__(self, name, prefabs):
        super(ZoneModel, self).__init__()
        self.name = name
        self.prefabs = prefabs


class EffectsSettingsModel(models.Model):
    __slots__ = ('spawnEffectPrefab', 'despawnEffectPrefab')

    def __init__(self, spawnEffectPrefab, despawnEffectPrefab):
        super(EffectsSettingsModel, self).__init__()
        self.spawnEffectPrefab = spawnEffectPrefab
        self.despawnEffectPrefab = despawnEffectPrefab


class ZonesTypesModel(models.Model):
    __slots__ = ('zones', '_zoneNames')

    def __init__(self, zones):
        super(ZonesTypesModel, self).__init__()
        self.zones = zones
        self._zoneNames = [ zone.name for zone in self.zones ]

    @property
    def zoneNames(self):
        return self._zoneNames

    def getZoneByName(self, name):
        return next((zone for zone in self.zones if zone.name == name), None)


class PhasesConfigModel(models.Model):
    __slots__ = ('phaseCount', 'phaseTypes', '_phaseNames')

    def __init__(self, phaseCount, phaseTypes):
        super(PhasesConfigModel, self).__init__()
        self.phaseCount = phaseCount
        self.phaseTypes = phaseTypes
        self._phaseNames = [ phase.name for phase in self.phaseTypes ]

    @property
    def phaseNames(self):
        return self._phaseNames

    def getPhaseTypeByName(self, name):
        return next((phaseType for phaseType in self.phaseTypes if phaseType.name == name), None)


class PhaseTypeConfigModel(models.Model):
    __slots__ = ('name', )

    def __init__(self, name):
        super(PhaseTypeConfigModel, self).__init__()
        self.name = name


mapSettingsSchema = schemas.Schema(fields={'geometryName': fields.String(required=True), 
   'gameplayName': fields.String(required=True)}, modelClass=MapSettingsModel, checkUnknown=True)
lootSettingsSchema = schemas.Schema(fields={'visualScriptConfig': fields.Nested(schema=configSchema, required=True), 
   'pickupRange': fields.Float(required=True, deserializedValidators=validate.Range(minValue=0.0)), 
   'pickupHeight': fields.Float(required=True, deserializedValidators=validate.Range(minValue=0.0)), 
   'pickupDepth': fields.Float(required=True, deserializedValidators=validate.Range(minValue=0.0)), 
   'pickupOffset': fields.Float(required=True, deserializedValidators=validate.Range(minValue=0.0))}, modelClass=LootSettingsModel, checkUnknown=True)
VSEManagerSchema = schemas.Schema(fields={'visualScript': fields.String(required=True)}, modelClass=VSEManagerModel, checkUnknown=True)
fragmentsSchema = schemas.Schema(fields={'manager': fields.Nested(schema=VSEManagerSchema, required=True), 
   'clientPrefab': fields.String(required=True, deserializedValidators=validate.Regexp('((content/CGFPrefabs/cosmic_event/).*\\.prefab)')), 
   'clientPrefabHint': fields.String(required=True, deserializedValidators=validate.Regexp('((content/CGFPrefabs/cosmic_event/).*\\.prefab)'))}, modelClass=FragmentTypeModel, checkUnknown=True)
eventsConfigSchema = schemas.Schema(fields={'shot': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'ramming': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'kill': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'kill_assist': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'ability_pickup': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'ability_hit': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'fragment_pickup': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'fragment_carrying': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'fragment_delivering': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'fragment_holder_kill': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_0': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_1': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_2': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_3': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_4': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_5': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_6': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'evacuation_7': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1))}, modelClass=EventsConfigModel, checkUnknown=True)
scoreSystemSchema = schemas.Schema(fields={'isEnabled': fields.Boolean(required=True), 
   'damageTagDuration': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1, maxValue=60)), 
   'killAssistDuration': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1, maxValue=60)), 
   'eventsConfig': fields.Nested(schema=eventsConfigSchema, required=True)}, modelClass=ScoreSystemModel, checkUnknown=True)
rewardSettingSchema = schemas.Schema(fields={'questPrefix': fields.String(required=True), 
   'progressionQuestGroupId': fields.String(required=True), 
   'rewardToken': fields.String(required=True, deserializedValidators=[
                 validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()]), 
   'expirationDateInfo': fields.DateTime(required=True, deserializedValidators=validate.Range(minValue=datetime(2023, 7, 1), maxValue=datetime(2025, 1, 1))), 
   'limit': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=1)), 
   'chapter1TokenComplete': fields.String(required=True, deserializedValidators=[
                           validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()]), 
   'chapter2TokenComplete': fields.String(required=True, deserializedValidators=[
                           validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()]), 
   'chapter3TokenComplete': fields.String(required=True, deserializedValidators=[
                           validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()]), 
   'artifactToken': fields.String(required=True, deserializedValidators=[
                   validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()])}, modelClass=RewardSettingModel, checkUnknown=True)
zonesConfigSchema = schemas.Schema(fields={'name': fields.String(required=True, deserializedValidators=[
          validate.Length(minValue=4, maxValue=15),
          validate.OneOf([ZoneTypes.STATIC, ZoneTypes.EVACUATION])]), 
   'prefabs': fields.UniCapList(fieldOrSchema=fields.String(deserializedValidators=[
             validate.Length(minValue=1),
             validate.Regexp('((content/CGFPrefabs/cosmic_event/).*\\.prefab)')]), required=True)}, modelClass=ZoneModel, checkUnknown=True)
effectsSettingsSchema = schemas.Schema(fields={'spawnEffectPrefab': fields.String(required=True, deserializedValidators=validate.Regexp('((content/CGFPrefabs/cosmic_event/).*\\.prefab)')), 
   'despawnEffectPrefab': fields.String(required=True, deserializedValidators=validate.Regexp('((content/CGFPrefabs/cosmic_event/).*\\.prefab)'))}, modelClass=EffectsSettingsModel, checkUnknown=True)
zonesSchema = schemas.Schema(fields={'zones': fields.UniCapList(fieldOrSchema=zonesConfigSchema, required=True, deserializedValidators=validate.Length(minValue=1, maxValue=15))}, modelClass=ZonesTypesModel, checkUnknown=True)
phaseTypeConfigSchema = schemas.Schema(fields={'name': fields.String(required=True, deserializedValidators=validate.OneOf([PhaseTypes.PREBATTLE, PhaseTypes.IDLE,
          PhaseTypes.DELIVERY, PhaseTypes.EVACUATION,
          PhaseTypes.NONE]))}, modelClass=PhaseTypeConfigModel, checkUnknown=True)
phasesConfigSchema = schemas.Schema(fields={'phaseCount': fields.Integer(required=True, deserializedValidators=validate.Range(minValue=0, maxValue=20)), 
   'phaseTypes': fields.UniCapList(fieldOrSchema=phaseTypeConfigSchema, required=True)}, modelClass=PhasesConfigModel, checkUnknown=True)
cosmicBattleConfigSchema = GameParamsSchema(gameParamsKey=COSMIC_EVENT_GAME_PARAMS_KEY, fields={'eventVehicle': fields.String(required=True, deserializedValidators=[
                  validate.Regexp('.*:.*'), validate.ValidateUniqueValidator()]), 
   'loot': fields.Nested(schema=lootSettingsSchema, required=True), 
   'mapsInfo': fields.UniCapList(fieldOrSchema=mapSettingsSchema, required=True), 
   'fragments': fields.Nested(schema=fragmentsSchema, required=True), 
   'scoreSystem': fields.Nested(schema=scoreSystemSchema, required=True), 
   'rewardSettings': fields.Nested(schema=rewardSettingSchema, required=True), 
   'vehicleRentQuestID': fields.String(required=True), 
   'zonesConfig': fields.Nested(schema=zonesSchema, required=True), 
   'effects': fields.Nested(schema=effectsSettingsSchema, required=True), 
   'phasesConfig': fields.Nested(schema=phasesConfigSchema, required=True)}, modelClass=CosmicBattleConfigModel, checkUnknown=True)
CONFIG_NAME_TO_SCHEMA_MAPPING = {'zonesConfig': zonesSchema, 
   'phasesConfig': phasesConfigSchema}

def getCosmicConfig(configName):
    configPath = os.path.join('scripts/server_xml/', 'cosmic_event_battles_config.xml')
    xmlPath = makeExtensionPath('cosmic_event', configPath)
    root = ResMgr.openSection(xmlPath)
    config = CONFIG_NAME_TO_SCHEMA_MAPPING[configName].deserialize(section2dict.parse(root[configName]))
    return config