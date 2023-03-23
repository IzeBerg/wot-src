import logging, random, CGF, Vehicular
from cgf_script.managers_registrator import autoregister, onAddedQuery, onRemovedQuery
from items.components.component_constants import MAIN_TRACK_PAIR_IDX
from items.vehicle_items import CHASSIS_ITEM_TYPE
from vehicle_systems import tankStructure
import math_utils
from vehicle_systems.tankStructure import TankSoundObjectsIndexes
import GenericComponents
from constants import IS_CGF_DUMP, IS_EDITOR
if not IS_CGF_DUMP:
    from CustomEffectManager import CustomEffectManager
_logger = logging.getLogger(__name__)

class TrackCrashWithDebrisComponent(object):
    MAX_DEBRIS_COUNT = (14, 10, 4)
    CURRENT_DEBRIS_COUNT = 0
    isLeft = property(lambda self: self.__isLeft)
    pairIndex = property(lambda self: self.__pairIndex)
    vehicleDescriptor = property(lambda self: self.__vehicleDescriptor)
    wheelsGameObject = property(lambda self: self.__wheelsGameObject)
    boundEffects = property(lambda self: self.__boundEffects)
    vehicleFilter = property(lambda self: self.__vehicleFilter)
    debrisGameObject = property(lambda self: self.__debrisGameObject)
    trackPairDesc = property(lambda self: self.vehicleDescriptor.chassis.tracks.trackPairs[self.pairIndex])

    @property
    def debrisDesc(self):
        if self.isLeft:
            return self.trackPairDesc.tracksDebris.left
        return self.trackPairDesc.tracksDebris.right

    @property
    def hitPoint(self):
        return self.__hitPoint

    @property
    def shouldCreateDebris(self):
        return self.__shouldCreateDebris

    @property
    def isPlayer(self):
        return self.__isPlayer

    @property
    def modelsSet(self):
        return self.__modelsSet

    def __init__(self, isLeft, pairIndex, vehicleDescriptor, wheelsGameObject, boundEffects, vehicleFilter, isPlayerVehicle, shouldCreateDebris, hitPoint, modelsSet='default'):
        self.__isLeft = isLeft
        self.__pairIndex = pairIndex
        self.__vehicleDescriptor = vehicleDescriptor
        self.__wheelsGameObject = wheelsGameObject
        self.__boundEffects = boundEffects
        self.__vehicleFilter = vehicleFilter
        self.__isPlayer = isPlayerVehicle
        self.__shouldCreateDebris = shouldCreateDebris
        self.__hitPoint = hitPoint
        self.__modelsSet = modelsSet
        self.__debrisGameObject = None
        if shouldCreateDebris:
            TrackCrashWithDebrisComponent.CURRENT_DEBRIS_COUNT += 1
        return

    def createDebrisGameObject(self, spaceID):
        if self.__debrisGameObject is not None:
            _logger.error('Debris go already created, something went wrong')
            CGF.removeGameObject(self.__debrisGameObject)
        self.__debrisGameObject = CGF.GameObject(spaceID)
        return self.__debrisGameObject

    def removeDebrisGameObject(self):
        if self.__debrisGameObject is not None:
            CGF.removeGameObject(self.__debrisGameObject)
            self.__debrisGameObject = None
        return


class NodeRemapperComponent(object):
    nodes = property(lambda self: self.__nodes)

    def __init__(self, nodes):
        self.__nodes = nodes


@autoregister(presentInAllWorlds=True, domain=CGF.DomainOption.DomainClient | CGF.DomainOption.DomainEditor)
class DebrisCrashedTracksManager(CGF.ComponentManager):
    RTPC_OUTER_TRACK_STATE = 'RTPC_ext_treads_outer'
    DEBRIS_MAX_LIFETIME = 10

    def __switchVehicleTrackVisibility(self, track, debris, isVisible):
        amountOfBrokenTracks = 0 if isVisible else 1
        track.disableTrack(not isVisible)
        if not debris.wheelsGameObject.isValid():
            return amountOfBrokenTracks
        else:
            animator = debris.wheelsGameObject.findComponentByType(Vehicular.GeneralWheelsAnimator)
            chassisType = debris.vehicleDescriptor.chassis.chassisType
            isYohMechanics = chassisType == CHASSIS_ITEM_TYPE.TRACK_WITHIN_TRACK and debris.pairIndex != MAIN_TRACK_PAIR_IDX
            if animator is not None and isYohMechanics:
                for wheelIdx in track.connectedWheels:
                    if isVisible:
                        animator.relinkTrack(wheelIdx, track.trackThickness)
                    else:
                        animator.unlinkFromTrack(wheelIdx, track.trackThickness)

            vehicleTracks = debris.wheelsGameObject.findComponentByType(Vehicular.VehicleTracks)
            amountOfBrokenTracks = 0
            if vehicleTracks is not None:
                for otherTrackIdx in xrange(vehicleTracks.getPairsCount()):
                    otherTrackGo = vehicleTracks.getTrackGameObject(track.isLeft, otherTrackIdx)
                    otherTrack = otherTrackGo.findComponentByType(Vehicular.CompositeTrack)
                    thicknessAdjustment = 0 if isVisible else -track.trackThickness
                    otherTrack.adjustTrackThickness(thicknessAdjustment)
                    otherTrack.forceSendLeadingWheelScrollLinks(animator)
                    if otherTrackGo.findComponentByType(TrackCrashWithDebrisComponent) is not None:
                        amountOfBrokenTracks += 1
                    otherTrackGo = vehicleTracks.getTrackGameObject(not track.isLeft, otherTrackIdx)
                    if otherTrackGo.findComponentByType(TrackCrashWithDebrisComponent) is not None:
                        amountOfBrokenTracks += 1

            suspension = debris.wheelsGameObject.findComponentByType(Vehicular.Suspension)
            if suspension is not None:
                suspension.forceCorrectionRecalculation()
            return amountOfBrokenTracks

    def __generateDestructionEffect(self, debris):
        if debris.trackPairDesc.tracksDebris is None:
            return
        else:
            debrisDesc = debris.debrisDesc
            effectData = debrisDesc.destructionEffectData
            if effectData is not None:
                keyPoints, effects, _ = random.choice(effectData)
                debris.boundEffects.addNewToNode(tankStructure.TankPartNames.CHASSIS, math_utils.createIdentityMatrix(), effects, keyPoints, isPlayerVehicle=debris.isPlayer)
            return

    def __remapNodes(self, debris):
        if debris.trackPairDesc.tracksDebris is None:
            return
        else:
            go = debris.wheelsGameObject
            if IS_EDITOR and not go.isValid():
                return
            debrisDesc = debris.debrisDesc
            nodes = {}
            existingRemap = go.findComponentByType(NodeRemapperComponent)
            if existingRemap is not None:
                nodes = dict(existingRemap.nodes)
                go.removeComponentByType(NodeRemapperComponent)
            for fromNode, toNode in debrisDesc.nodesRemap.iteritems():
                nodes[fromNode] = toNode

            go.createComponent(NodeRemapperComponent, nodes)
            return

    def __unmapNodes(self, debris):
        go = debris.wheelsGameObject
        if not go.isValid():
            return
        else:
            existingRemap = go.findComponentByType(NodeRemapperComponent)
            if existingRemap is None:
                return
            nodes = dict(existingRemap.nodes)
            debrisDesc = debris.debrisDesc
            for fromNode, _ in debrisDesc.nodesRemap.iteritems():
                del nodes[fromNode]

            go.removeComponentByType(NodeRemapperComponent)
            if nodes:
                go.createComponent(NodeRemapperComponent, nodes)
            return

    def __adjustTrackAudition(self, amountOfBrokenTracks, appearanceGo):
        if not appearanceGo.isValid():
            return
        else:
            audition = appearanceGo.findComponentByType(Vehicular.VehicleAudition)
            if audition is None:
                return
            soundObject = audition.getSoundObject(TankSoundObjectsIndexes.CHASSIS)
            rtpcValue = 0 if amountOfBrokenTracks == 0 else 1
            soundObject.setRTPC(DebrisCrashedTracksManager.RTPC_OUTER_TRACK_STATE, rtpcValue)
            return

    def createDebris(self, track, debrisComponent):
        if not debrisComponent.shouldCreateDebris:
            return
        else:
            if debrisComponent.trackPairDesc.tracksDebris is None or debrisComponent.debrisDesc.physicalParams is None or not debrisComponent.wheelsGameObject.isValid():
                return
            vehicleTracks = debrisComponent.wheelsGameObject.findComponentByType(Vehicular.VehicleTracks)
            trackGO = vehicleTracks.getTrackGameObject(debrisComponent.isLeft, debrisComponent.pairIndex)
            go = debrisComponent.createDebrisGameObject(self.spaceID)
            go.createComponent(GenericComponents.HierarchyComponent, trackGO)
            track.createDebris(go, debrisComponent.hitPoint, debrisComponent.vehicleFilter, debrisComponent.debrisDesc.physicalParams, debrisComponent.modelsSet, debrisComponent.isPlayer)
            go.activate()
            return

    @onAddedQuery(Vehicular.CompositeTrack, TrackCrashWithDebrisComponent)
    def processCrash(self, track, debris):
        self.createDebris(track, debris)
        amountOfBrokenTracks = self.__switchVehicleTrackVisibility(track, debris, False)
        self.__adjustTrackAudition(amountOfBrokenTracks, debris.wheelsGameObject)
        self.__generateDestructionEffect(debris)
        self.__remapNodes(debris)

    @onRemovedQuery(Vehicular.CompositeTrack, TrackCrashWithDebrisComponent)
    def processRepair(self, track, debris):
        self.__unmapNodes(debris)
        amountOfBrokenTracks = self.__switchVehicleTrackVisibility(track, debris, True)
        self.__adjustTrackAudition(amountOfBrokenTracks, debris.wheelsGameObject)
        debris.removeDebrisGameObject()
        if debris.shouldCreateDebris:
            TrackCrashWithDebrisComponent.CURRENT_DEBRIS_COUNT -= 1


if not IS_CGF_DUMP:

    @onAddedQuery(NodeRemapperComponent, CustomEffectManager)
    def performNodeRemap(self, nodeRemapper, customEffectManager):
        for fromNode, toNode in nodeRemapper.nodes.iteritems():
            customEffectManager.remapNode(fromNode, toNode)


    @onRemovedQuery(NodeRemapperComponent, CustomEffectManager)
    def performNodeUnmap(self, nodeRemapper, customEffectManager):
        for fromNode, _ in nodeRemapper.nodes.iteritems():
            customEffectManager.remapNode(fromNode, '')