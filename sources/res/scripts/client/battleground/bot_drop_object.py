import logging
from functools import partial
import AnimationSequence, BigWorld, Math, CGF
from helpers import dependency
from battleground import getKamikazeEquipmentDescr
from battleground.components import SequenceComponent
from battleground.iself_assembler import ISelfAssembler
from helpers.CallbackDelayer import CallbackDelayer
from skeletons.dynamic_objects_cache import IBattleDynamicObjectsCache
from skeletons.gui.battle_session import IBattleSessionProvider
from cgf_obsolete_script.script_game_object import ScriptGameObject
from vehicle_systems.stricted_loading import makeCallbackWeak
_logger = logging.getLogger(__name__)

class BotAirdrop(ScriptGameObject, CallbackDelayer, ISelfAssembler):
    __dynamicObjectsCache = dependency.descriptor(IBattleDynamicObjectsCache)
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)
    ALTITUDE_CORRECTING = 0.5
    END_ANIMATION_TIME_CORRECTING = 0.18
    __slots__ = ('owner', '__deliveryPosition', '__markerArea', '__deliveryEffect',
                 '__teamID', '__yawAxis', '__plannedAnimDuration', '__deliveryTime')

    def __init__(self, dropID, deliveryPosition, teamID, yawAxis, deliveryTime):
        self.__spaceID = BigWorld.player().spaceID
        ScriptGameObject.__init__(self, self.__spaceID)
        CallbackDelayer.__init__(self)
        self.__deliveryTime = deliveryTime
        self.__deliveryPosition = deliveryPosition
        self.__markerArea = None
        self.__deliveryEffect = None
        self.__teamID = teamID
        self.__yawAxis = yawAxis
        self.__plannedAnimDuration = 0.0
        return

    def start(self, *args, **kwargs):
        config = self.__dynamicObjectsCache.getConfig(BigWorld.player().arenaGuiType)
        equipmentDescr = getKamikazeEquipmentDescr()
        self.__markerArea = self.__createMarkerArea(config, equipmentDescr)
        deliveryAnimationStartDelay = equipmentDescr.clientVisuals.deliveringAnimationStartDelay
        self.__plannedAnimDuration = equipmentDescr.delay - deliveryAnimationStartDelay
        timeToSpawn = self.__deliveryTime - BigWorld.serverTime()
        plannedAnimDuration = equipmentDescr.delay - equipmentDescr.clientVisuals.deliveringAnimationStartDelay
        timeToStartDeliveryAnim = timeToSpawn - plannedAnimDuration
        if self.__markerArea:
            self.delayCallback(equipmentDescr.delay, self.__removeMarkerArea)
        if timeToStartDeliveryAnim > 0:
            self.delayCallback(timeToStartDeliveryAnim, partial(self.__createDeliveryEffect, config))
        else:
            _logger.error('Delivery animation of Kamikaze will not be playing, no time for it!')
        self.activate()
        self.transferOwnershipToWorld()

    def destroy(self):
        super(BotAirdrop, self).destroy()
        CallbackDelayer.destroy(self)
        self.__removeMarkerArea()
        self.__removeDeliveryEffect()
        ScriptGameObject.destroy(self)
        CallbackDelayer.destroy(self)

    def __getEffect(self, effects):
        if self.__sessionProvider.getArenaDP().isAllyTeam(self.__teamID):
            return effects.ally
        return effects.enemy

    def __createMarkerArea(self, config, equipmentDescr):
        markerArea = CGF.GameObject(self.__spaceID)
        effect3D = self.__getEffect(config.getBotDeliveryMarker())
        if effect3D is not None:
            effectPath = effect3D.path
            markerTerrainPosition = self.__deliveryPosition - equipmentDescr.botSpawnPointOffset
            BigWorld.loadResourceListBG((AnimationSequence.Loader(effectPath, self.__spaceID),), makeCallbackWeak(self.__on3dEffectLoaded, equipmentDescr, effectPath, markerTerrainPosition))
            return markerArea
        else:
            _logger.error('Marker Effect is not defined!')
            return

    def __on3dEffectLoaded(self, equipmentDescr, effectP, position, resourceRefs):
        markerArea = self.__markerArea
        if effectP in resourceRefs.failedIDs or markerArea is None:
            return
        clientVisuals = equipmentDescr.clientVisuals
        sequenceComponent = markerArea.createComponent(SequenceComponent, resourceRefs[effectP])
        sequenceComponent.createTerrainEffect(position + clientVisuals.markerPositionOffset, scale=clientVisuals.markerScale, loopCount=-1)
        markerArea.activate()
        return

    def __createDeliveryEffect(self, config):
        effect = self.__getEffect(config.getBotDeliveryEffect())
        if effect is not None:
            effectPath = effect.path
            BigWorld.loadResourceListBG((
             AnimationSequence.Loader(effectPath, self.__spaceID),), makeCallbackWeak(self.__onDeliverEffectLoaded, effectPath, self.__deliveryPosition))
            return
        else:
            return

    def __onDeliverEffectLoaded(self, effectP, position, resourceRefs):
        if effectP in resourceRefs.failedIDs:
            _logger.error('Effect %s has not been loaded!', effectP)
            return
        effectAnimation = CGF.GameObject(self.__spaceID)
        sequenceComponent = effectAnimation.createComponent(SequenceComponent, resourceRefs[effectP])
        correctedPosition = position + Math.Vector3(0, self.ALTITUDE_CORRECTING, 0)
        sequenceComponent.createTerrainEffect(correctedPosition, loopCount=1, rotation=(self.__yawAxis, 0, 0))
        effectAnimation.activate()
        self.__deliveryEffect = effectAnimation
        timeToSpawn = self.__deliveryTime - BigWorld.serverTime()
        self.delayCallback(timeToSpawn + self.END_ANIMATION_TIME_CORRECTING, self.__removeDeliveryEffect)

    def __removeMarkerArea(self):
        if self.__markerArea is not None:
            self.__markerArea.destroy()
        self.__markerArea = None
        return

    def __removeDeliveryEffect(self):
        if self.__deliveryEffect is not None:
            self.__deliveryEffect.destroy()
        self.__deliveryEffect = None
        return