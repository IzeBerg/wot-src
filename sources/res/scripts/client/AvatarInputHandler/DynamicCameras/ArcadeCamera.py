from collections import namedtuple
import logging, math, GUI, Keys, Math, BattleReplay, Settings, constants, math_utils, BigWorld
from Math import Vector2, Vector3, Vector4, Matrix
from AvatarInputHandler import cameras, aih_global_binding
from BigWorld import ArcadeAimingSystem, ArcadeAimingSystemRemote
from AvatarInputHandler.DynamicCameras import createOscillatorFromSection, CameraDynamicConfig, AccelerationSmoother, CameraWithSettings, calcYawPitchDelta
from AvatarInputHandler.VideoCamera import KeySensor
from AvatarInputHandler.cameras import readFloat, readVec2, ImpulseReason, FovExtended
from debug_utils import LOG_WARNING, LOG_ERROR
from helpers.CallbackDelayer import CallbackDelayer, TimeDeltaMeter
from gui.battle_control import event_dispatcher
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCache
from account_helpers.settings_core.settings_constants import GAME
from AvatarInputHandler.DynamicCameras.arcade_camera_helper import EScrollDir, EXPONENTIAL_EASING, CollideAnimatorEasing, OverScrollProtector, ZoomStateSwitcher, MinMax
from skeletons.gui.game_control import IBootcampController
from AvatarInputHandler import AimingSystems
_logger = logging.getLogger(__name__)

def getCameraAsSettingsHolder(settingsDataSec):
    return ArcadeCamera(settingsDataSec, None)


_DEFAULT_ZOOM_DURATION = 0.5
_COLLIDE_ANIM_DIST = 1.0
_COLLIDE_ANIM_INTERVAL = 0.2

class CollisionVolumeGroup(namedtuple('CollisionVolumeGroup', (
 'minVolume',
 'lowSpeedLimit',
 'vehicleVisibilityLimit',
 'approachSpeed',
 'cameraSpeedFactor',
 'criticalDistance',
 'canSkip'))):

    def __new__(cls, minVolume=0.0, lowSpeedLimit=0.0, vehicleVisibilityLimit=0.0, approachSpeed=Math.Vector2(1.5, 10000.0), cameraSpeedFactor=0.1, criticalDistance=5.0, canSkip=False):
        return super(CollisionVolumeGroup, cls).__new__(cls, minVolume, lowSpeedLimit, vehicleVisibilityLimit, approachSpeed, cameraSpeedFactor, criticalDistance, canSkip)

    @staticmethod
    def fromSection(dataSection):
        it = iter(CollisionVolumeGroup._fields)
        defaultIt = iter(CollisionVolumeGroup.__new__.__defaults__)
        return CollisionVolumeGroup(dataSection.readFloat(next(it), next(defaultIt)), dataSection.readFloat(next(it), next(defaultIt)), dataSection.readFloat(next(it), next(defaultIt)), dataSection.readVector2(next(it), next(defaultIt)), dataSection.readFloat(next(it), next(defaultIt)), dataSection.readFloat(next(it), next(defaultIt)), dataSection.readBool(next(it), next(defaultIt)))


VOLUME_GROUPS_NAMES = [
 'tiny', 'small', 'medium', 'large']
_INERTIA_EASING = math_utils.Easing.exponentialEasing
ENABLE_INPUT_ROTATION_INERTIA = False

class _InputInertia(object):
    positionDelta = property(lambda self: self.__deltaEasing.value)
    fovZoomMultiplier = property(lambda self: self.__zoomMultiplierEasing.value)
    endZoomMultiplier = property(lambda self: self.__zoomMultiplierEasing.b)

    def __init__(self, minMaxZoomMultiplier, relativeFocusDist, duration=_DEFAULT_ZOOM_DURATION):
        self.__deltaEasing = EXPONENTIAL_EASING(math_utils.VectorConstant.Vector3Zero, math_utils.VectorConstant.Vector3Zero, duration)
        fovMultiplier = math_utils.lerp(minMaxZoomMultiplier.min, minMaxZoomMultiplier.max, relativeFocusDist)
        self.__zoomMultiplierEasing = EXPONENTIAL_EASING(fovMultiplier, fovMultiplier, duration)
        self.__minMaxZoomMultiplier = minMaxZoomMultiplier

    def glide(self, posDelta, duration=_DEFAULT_ZOOM_DURATION, easing=EXPONENTIAL_EASING):
        self.__deltaEasing = easing(posDelta, math_utils.VectorConstant.Vector3Zero, duration)

    def isGliding(self):
        return self.__deltaEasing.value != math_utils.VectorConstant.Vector3Zero and not self.__deltaEasing.stopped

    def glideFov(self, newRelativeFocusDist, duration=_DEFAULT_ZOOM_DURATION):
        minMult, maxMult = self.__minMaxZoomMultiplier
        endMult = math_utils.lerp(minMult, maxMult, newRelativeFocusDist)
        self.__zoomMultiplierEasing.reset(self.__zoomMultiplierEasing.value, endMult, duration)

    def teleport(self, relativeFocusDist, minMaxZoomMultiplier=None, duration=_DEFAULT_ZOOM_DURATION):
        if minMaxZoomMultiplier is not None:
            self.__minMaxZoomMultiplier = minMaxZoomMultiplier
        self.__deltaEasing.reset(math_utils.VectorConstant.Vector3Zero, math_utils.VectorConstant.Vector3Zero, duration)
        fovMultiplier = math_utils.lerp(self.__minMaxZoomMultiplier.min, self.__minMaxZoomMultiplier.max, relativeFocusDist)
        self.__zoomMultiplierEasing.reset(fovMultiplier, fovMultiplier, duration)
        return

    def update(self, deltaTime):
        self.__deltaEasing.update(deltaTime)
        self.__zoomMultiplierEasing.update(deltaTime)

    def calcWorldPos(self, idealBasisMatrix):
        return idealBasisMatrix.translation + idealBasisMatrix.applyVector(self.__deltaEasing.value)


ArcadeCameraState = namedtuple('ArcadeCameraState', ('camDist', 'zoomSwitcherState'))

class ArcadeCamera(CameraWithSettings, CallbackDelayer, TimeDeltaMeter):
    __settingsCache = dependency.descriptor(ISettingsCache)
    __bootcampCtrl = dependency.descriptor(IBootcampController)
    REASONS_AFFECT_CAMERA_DIRECTLY = (
     ImpulseReason.MY_SHOT, ImpulseReason.OTHER_SHOT, ImpulseReason.VEHICLE_EXPLOSION,
     ImpulseReason.HE_EXPLOSION)
    _DYNAMIC_ENABLED = True

    @staticmethod
    def enableDynamicCamera(enable):
        ArcadeCamera._DYNAMIC_ENABLED = enable

    @staticmethod
    def isCameraDynamic():
        return ArcadeCamera._DYNAMIC_ENABLED

    _FILTER_LENGTH = 5
    _DEFAULT_MAX_ACCELERATION_DURATION = 1.5
    _FOCAL_POINT_CHANGE_SPEED = 100.0
    _FOCAL_POINT_MIN_DIFF = 5.0
    _MIN_REL_SPEED_ACC_SMOOTHING = 0.7

    def getReasonsAffectCameraDirectly(self):
        return ArcadeCamera.REASONS_AFFECT_CAMERA_DIRECTLY

    def __getVehicleMProv(self):
        refinedMProv = self.__aimingSystem.vehicleMProv
        return refinedMProv.b.source

    def __setVehicleMProv(self, vehicleMProv):
        prevAimRel = self.__cam.aimPointProvider.a if self.__cam.aimPointProvider is not None else None
        refinedVehicleMProv = self.__refineVehicleMProv(vehicleMProv)
        self.__aimingSystem.vehicleMProv = refinedVehicleMProv
        self.__setupCameraProviders(refinedVehicleMProv)
        self.__cam.speedTreeTarget = self.__aimingSystem.vehicleMProv
        self.__aimingSystem.update(0.0)
        if prevAimRel is not None:
            self.__cam.aimPointProvider.a = prevAimRel
        baseTranslation = Matrix(refinedVehicleMProv).translation
        relativePosition = self.__aimingSystem.matrixProvider.translation - baseTranslation
        self.__setCameraPosition(relativePosition)
        return

    camera = property(lambda self: self.__cam)
    angles = property(lambda self: (self.__aimingSystem.yaw, self.__aimingSystem.pitch))
    aimingSystem = property(lambda self: self.__aimingSystem)
    vehicleMProv = property(__getVehicleMProv, __setVehicleMProv)
    __aimOffset = aih_global_binding.bindRW(aih_global_binding.BINDING_ID.AIM_OFFSET)

    def __init__(self, dataSec, defaultOffset=None):
        super(ArcadeCamera, self).__init__()
        CallbackDelayer.__init__(self)
        TimeDeltaMeter.__init__(self)
        self.__shiftKeySensor = None
        self.__movementOscillator = None
        self.__impulseOscillator = None
        self.__noiseOscillator = None
        self.__dynamicCfg = CameraDynamicConfig()
        self.__accelerationSmoother = None
        self.__zoomStateSwitcher = ZoomStateSwitcher()
        self._readConfigs(dataSec)
        self.__onChangeControlMode = None
        self.__aimingSystem = None
        self.__curSense = 0
        self.__curScrollSense = 0
        self.__postmortemMode = False
        self.__focalPointDist = 1.0
        self.__autoUpdateDxDyDz = Vector3(math_utils.VectorConstant.Vector3Zero)
        self.__updatedByKeyboard = False
        self.__isCamInTransition = False
        self.__aimingSystemVectorHelper = Vector3(math_utils.VectorConstant.Vector3Zero)
        self.__rotationMatrixVectorHelper = Vector3(math_utils.VectorConstant.Vector3Zero)
        self.__collideAnimatorEasing = CollideAnimatorEasing()
        if defaultOffset is not None:
            self.__defaultAimOffset = defaultOffset
            self.__cam = BigWorld.HomingCamera(self.__adCfg['enable'])
            if self.__adCfg['enable']:
                self.__cam.initAdvancedCollider(self.__adCfg['fovRatio'], self.__adCfg['rollbackSpeed'], self.__adCfg['minimalCameraDistance'], self.__adCfg['speedThreshold'], self.__adCfg['minimalVolume'])
                for group_name in VOLUME_GROUPS_NAMES:
                    self.__cam.addVolumeGroup(self.__adCfg['volumeGroups'][group_name])

            self.__cam.aimPointClipCoords = defaultOffset
        else:
            self.__defaultAimOffset = Vector2()
            self.__cam = None
        self.__cameraTransition = BigWorld.TransitionCamera()
        self.__overScrollProtector = OverScrollProtector()
        self.__updateProperties(state=None)
        return

    @staticmethod
    def _getConfigsKey():
        return ArcadeCamera.__name__

    def cloneState(self, **kwargs):
        currentDistance = kwargs.get('distance', self.getCameraDistance())
        currentState = kwargs.get('state')
        if not currentState:
            currentState = self.__zoomStateSwitcher.getCurrentState()
            if currentState is not None:
                currentState = currentState.settingsKey
        return ArcadeCameraState(currentDistance, currentState)

    def create(self, onChangeControlMode=None, postmortemMode=False, smartPointCalculator=True):
        super(ArcadeCamera, self).create()
        self.__onChangeControlMode = onChangeControlMode
        self.__postmortemMode = postmortemMode
        targetMat = self.getTargetMProv()
        aimingSystemClass = ArcadeAimingSystem
        if BigWorld.player().isObserver():
            self.__onChangeControlMode = None
            aimingSystemClass = ArcadeAimingSystemRemote
        self.__aimingSystem = aimingSystemClass(self.__refineVehicleMProv(targetMat), self._cfg['heightAboveBase'], self._cfg['focusRadius'], self.__calcAimMatrix(), self._cfg['angleRange'], not postmortemMode and smartPointCalculator)
        if self.__adCfg['enable']:
            self.__aimingSystem.initAdvancedCollider(self.__adCfg['fovRatio'], self.__adCfg['rollbackSpeed'], self.__adCfg['minimalCameraDistance'], self.__adCfg['speedThreshold'], self.__adCfg['minimalVolume'])
            for group_name in VOLUME_GROUPS_NAMES:
                self.__aimingSystem.addVolumeGroup(self.__adCfg['volumeGroups'][group_name])

        self.setCameraDistance(self._cfg['startDist'])
        self.__aimingSystem.pitch = self._cfg['startAngle']
        self.__aimingSystem.yaw = Math.Matrix(targetMat).yaw
        self.__aimingSystem.cursorShouldCheckCollisions(shouldCheckCollisions=False)
        self.__updateAngles(0, 0)
        cameraPosProvider = Math.Vector4Translation(self.__aimingSystem.matrixProvider)
        self.__cam.cameraPositionProvider = cameraPosProvider
        return

    def getTargetMProv(self):
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and not replayCtrl.isServerSideReplay and replayCtrl.playerVehicleID != 0:
            vehicleID = replayCtrl.playerVehicleID
        else:
            vehicleID = BigWorld.player().playerVehicleID
        return BigWorld.entity(vehicleID).matrix

    def reinitMatrix(self):
        self.__setVehicleMProv(self.getTargetMProv())

    def setToVehicleDirection(self):
        if not self.__aimingSystem:
            return
        matrix = Math.Matrix(self.getTargetMProv())
        self.setYawPitch(matrix.yaw, matrix.pitch)

    def destroy(self):
        self.disable()
        self.__onChangeControlMode = None
        self.__cam = None
        self.__cameraTransition = None
        if self.__aimingSystem is not None:
            self.__aimingSystem.destroy()
            self.__aimingSystem = None
        CallbackDelayer.destroy(self)
        CameraWithSettings.destroy(self)
        return

    def getPivotSettings(self):
        return self.__aimingSystem.getPivotSettings()

    def setPivotSettings(self, heightAboveBase, focusRadius):
        self.__aimingSystem.setPivotSettings(heightAboveBase, focusRadius)

    def __setDynamicCollisions(self, enable):
        if self.__cam is not None:
            self.__cam.setDynamicCollisions(enable)
        if self.__aimingSystem is not None:
            self.__aimingSystem.setDynamicCollisions(enable)
        return

    def focusOnPos(self, preferredPos):
        self.__aimingSystem.focusOnPos(preferredPos)

    def shiftCamPos(self, shift=None):
        matrixProduct = self.__aimingSystem.vehicleMProv
        shiftMat = matrixProduct.a
        if shift is not None:
            camDirection = Math.Vector3(math.sin(self.angles[0]), 0, math.cos(self.angles[0]))
            normal = Math.Vector3(camDirection)
            normal.x = camDirection.z
            normal.z = -camDirection.x
            shiftMat.translation += camDirection * shift.z + math_utils.VectorConstant.Vector3J * shift.y + normal * shift.x
        else:
            shiftMat.setIdentity()
        return

    def enable(self, preferredPos=None, closesDist=False, postmortemParams=None, turretYaw=None, gunPitch=None, camTransitionParams=None, initialVehicleMatrix=None, arcadeState=None):
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isRecording:
            replayCtrl.setAimClipPosition(self.__aimOffset)
        self.measureDeltaTime()
        player = BigWorld.player()
        vehicle = player.getVehicleAttached()
        if player.observerSeesAll() and player.arena.period == constants.ARENA_PERIOD.BATTLE:
            if vehicle and vehicle.id == player.playerVehicleID:
                self.delayCallback(0.0, self.enable, preferredPos, closesDist, postmortemParams, turretYaw, gunPitch, camTransitionParams, initialVehicleMatrix)
                return
        if initialVehicleMatrix is None:
            initialVehicleMatrix = player.getOwnVehicleMatrix(Math.Matrix(self.vehicleMProv)) if vehicle is None else vehicle.matrix
        vehicleMProv = initialVehicleMatrix
        if self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM) or arcadeState is not None:
            state = None
            newCameraDistance = self.__distRange.max
            if arcadeState is not None:
                self.__zoomStateSwitcher.switchToState(arcadeState.zoomSwitcherState)
                state = self.__zoomStateSwitcher.getCurrentState()
                newCameraDistance = arcadeState.camDist
            self.__updateProperties(state=state)
            self.__updateCameraSettings(newCameraDistance)
            self.__inputInertia.glideFov(self.__calcRelativeDist())
            if arcadeState is None:
                self.__aimingSystem.aimMatrix = self.__calcAimMatrix()
        camDist = None
        if not self.__postmortemMode:
            if closesDist:
                camDist = self.__distRange.min
        elif postmortemParams is not None:
            self.__aimingSystem.yaw = postmortemParams[0][0]
            self.__aimingSystem.pitch = postmortemParams[0][1]
            camDist = postmortemParams[1]
        else:
            camDist = self.__distRange.max
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and not replayCtrl.isServerSideReplay:
            camDist = None
            vehicle = BigWorld.entity(replayCtrl.playerVehicleID)
            if vehicle is not None:
                vehicleMProv = vehicle.matrix
        if camDist is not None:
            self.setCameraDistance(camDist)
        else:
            self.__inputInertia.teleport(self.__calcRelativeDist())
        self.vehicleMProv = vehicleMProv
        self.__setDynamicCollisions(True)
        self.__aimingSystem.enable(preferredPos, turretYaw, gunPitch)
        self.__aimingSystem.aimMatrix = self.__calcAimMatrix()
        if camTransitionParams is not None and BigWorld.camera() is not self.__cam:
            cameraTransitionDuration = camTransitionParams.get('cameraTransitionDuration', -1)
            if cameraTransitionDuration > 0:
                self.__setupCameraTransition(cameraTransitionDuration)
            else:
                self.__setCamera()
        else:
            self.__setCamera()
        self.__cameraUpdate()
        self.delayCallback(0.0, self.__cameraUpdate)
        from gui import g_guiResetters
        g_guiResetters.add(self.__onRecreateDevice)
        self.__updateAdvancedCollision()
        self.__updateLodBiasForTanks()
        return

    def __setCamera(self):
        if self.__cameraTransition.isInTransition():
            self.__cameraTransition.finish()
        else:
            BigWorld.camera(self.__cam)

    def __setupCameraTransition(self, duration):
        self.__cameraTransition.start(BigWorld.camera().matrix, self.__cam, duration)
        BigWorld.camera(self.__cameraTransition)
        invMatrix = Math.Matrix()
        invMatrix.set(BigWorld.camera().invViewMatrix)
        previousAimVector = invMatrix.applyToAxis(2)
        self.setYawPitch(previousAimVector.yaw, -previousAimVector.pitch)
        self.__isCamInTransition = True

    def _handleSettingsChange(self, diff):
        if 'fov' in diff or 'dynamicFov' in diff:
            self.__inputInertia.teleport(self.__calcRelativeDist(), self.__calculateInputInertiaMinMax())
        if GAME.PRE_COMMANDER_CAM in diff or GAME.COMMANDER_CAM in diff:
            self.__inputInertia.glideFov(self.__calcRelativeDist())

    def _updateSettingsFromServer(self):
        super(ArcadeCamera, self)._updateSettingsFromServer()
        if self.settingsCore.isReady:
            ucfg = self._userCfg
            ucfg['sniperModeByShift'] = self.settingsCore.getSetting('sniperModeByShift')
            cfg = self._cfg
            cfg['sniperModeByShift'] = ucfg['sniperModeByShift']

    def __calculateInputInertiaMinMax(self):
        if self.settingsCore.getSetting('dynamicFov'):
            _, minFov, maxFov = self.settingsCore.getSetting('fov')
            kMin = minFov / maxFov
        else:
            kMin = 1.0
        return MinMax(kMin, 1.0)

    def restartCameraTransition(self, duration):
        if self.__cam is not None and not self.__cameraTransition.isInTransition():
            self.__isCamInTransition = True
            self.__cameraTransition.start(BigWorld.camera().matrix, self.__cam, duration)
        return

    def __refineVehicleMProv(self, vehicleMProv):
        vehicleTranslationOnly = Math.WGTranslationOnlyMP()
        vehicleTranslationOnly.source = vehicleMProv
        refinedMatrixProvider = Math.MatrixProduct()
        refinedMatrixProvider.a = math_utils.createIdentityMatrix()
        refinedMatrixProvider.b = vehicleTranslationOnly
        return refinedMatrixProvider

    def __setupCameraProviders(self, vehicleMProv):
        vehiclePos = Math.Vector4Translation(vehicleMProv)
        cameraPositionProvider = Math.Vector4Combiner()
        cameraPositionProvider.fn = Math.Vector4Combiner.Fn.ADD
        cameraPositionProvider.a = math_utils.VectorConstant.Vector4Zero
        cameraPositionProvider.b = vehiclePos
        cameraAimPointProvider = Math.Vector4Combiner()
        cameraAimPointProvider.fn = Math.Vector4Combiner.Fn.ADD
        cameraAimPointProvider.a = math_utils.VectorConstant.Vector4Zero
        cameraAimPointProvider.b = vehiclePos
        self.__cam.cameraPositionProvider = cameraPositionProvider
        self.__cam.aimPointProvider = cameraAimPointProvider
        self.__cam.pivotPositionProvider = self.__aimingSystem.positionAboveVehicleProv

    def __setCameraPosition(self, relativeToVehiclePosition):
        self.__cam.cameraPositionProvider.a = Vector4(relativeToVehiclePosition.x, relativeToVehiclePosition.y, relativeToVehiclePosition.z, 1.0)

    def __setCameraAimPoint(self, relativeToVehiclePosition):
        self.__cam.aimPointProvider.a = Vector4(relativeToVehiclePosition.x, relativeToVehiclePosition.y, relativeToVehiclePosition.z, 1.0)

    def disable(self):
        from gui import g_guiResetters
        if self.__onRecreateDevice in g_guiResetters:
            g_guiResetters.remove(self.__onRecreateDevice)
        self.__setDynamicCollisions(False)
        self.__cam.speedTreeTarget = None
        if self.__shiftKeySensor is not None:
            self.__shiftKeySensor.reset(Math.Vector3())
        self.clearCallbacks()
        self.__movementOscillator.reset()
        self.__impulseOscillator.reset()
        self.__noiseOscillator.reset()
        self.__accelerationSmoother.reset()
        self.__autoUpdateDxDyDz.set(0)
        self.__updatedByKeyboard = False
        dist = self.__calcRelativeDist()
        if dist is not None:
            self.__inputInertia.teleport(dist)
        FovExtended.instance().resetFov()
        BigWorld.setMinLodBiasForTanks(0.0)
        self.__collideAnimatorEasing.stop()
        self.__cam.shiftCamera(Vector3(0.0))
        return

    def update(self, dx, dy, dz, rotateMode=True, zoomMode=True, updatedByKeyboard=False):
        eScrollDirection = EScrollDir.convertDZ(dz)
        if eScrollDirection:
            self.__overScrollProtector.updateOnScroll(eScrollDirection)
        self.__curSense = self._cfg['keySensitivity'] if updatedByKeyboard else self.__sensitivity
        self.__curScrollSense = self._cfg['keySensitivity'] if updatedByKeyboard else self.__scrollSensitivity
        self.__updatedByKeyboard = updatedByKeyboard
        if updatedByKeyboard:
            self.__autoUpdateDxDyDz.set(dx, dy, dz)
        else:
            self.__autoUpdateDxDyDz.set(0)
            self.__update(dx, dy, dz, rotateMode, zoomMode)

    def setUserConfigValue(self, name, value):
        if name not in self._userCfg:
            return
        else:
            self._userCfg[name] = value
            if name not in ('keySensitivity', 'sensitivity', 'scrollSensitivity'):
                self._cfg[name] = self._userCfg[name]
                if name == 'fovMultMinMaxDist' and getattr(self, '_ArcadeCamera__aimingSystem', None) is not None:
                    self.__inputInertia.teleport(self.__calcRelativeDist(), value)
            else:
                self._cfg[name] = self._baseCfg[name] * self._userCfg[name]
            zoomState = self.__zoomStateSwitcher.getCurrentState()
            self.__updateProperties(zoomState)
            return

    def setCameraDistance(self, distance):
        distRange = self.__distRange
        clampedDist = math_utils.clamp(distRange.min, distRange.max, distance)
        self.__aimingSystem.distanceFromFocus = clampedDist
        self.__inputInertia.teleport(self.__calcRelativeDist())

    def getCameraDistance(self):
        return self.__aimingSystem.distanceFromFocus

    def setYawPitch(self, yaw, pitch):
        self.__aimingSystem.yaw = yaw
        self.__aimingSystem.pitch = pitch

    def __updateAngles(self, dx, dy):
        yawDelta, pitchDelta = calcYawPitchDelta(self._cfg, self.__curSense, dx, dy)
        self.__aimingSystem.handleMovement(yawDelta, -pitchDelta)
        return (
         self.__aimingSystem.yaw, self.__aimingSystem.pitch, 0)

    def __update(self, dx, dy, dz, rotateMode=True, zoomMode=True):
        if not self.__aimingSystem:
            return
        eScrollDir = EScrollDir.convertDZ(dz)
        prevPos = self.__inputInertia.calcWorldPos(self.__aimingSystem.matrixProvider)
        prevDist = self.__aimingSystem.distanceFromFocus
        distMinMax = self.__distRange
        if self.__isCamInTransition:
            self.__isCamInTransition = self.__cameraTransition.isInTransition()
        isColliding = self.__cam.hasCollision()
        collisionWhileGlide = False
        if self.__inputInertia.isGliding() and not isColliding and eScrollDir is EScrollDir.OUT and not self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM):
            cameraPos = self.__aimingSystem.matrix.translation
            collisionWhileGlide = self.__cam.isColliding(BigWorld.player().spaceID, cameraPos)
        preventScrollOut = (isColliding or collisionWhileGlide) and eScrollDir is EScrollDir.OUT and not self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM)
        if preventScrollOut and prevDist == distMinMax.max and self.__isSettingsEnabled(GAME.COMMANDER_CAM):
            if self.__isInArcadeZoomState() and not self.__isSettingsEnabled(GAME.PRE_COMMANDER_CAM) or self.__compareCurrStateSettingsKey(GAME.PRE_COMMANDER_CAM):
                preventScrollOut = False
        if isColliding and eScrollDir is EScrollDir.OUT:
            self.__collideAnimatorEasing.start(_COLLIDE_ANIM_DIST, _COLLIDE_ANIM_INTERVAL)
        distChanged = False
        if zoomMode and eScrollDir and not self.__overScrollProtector.isProtecting() and not preventScrollOut:
            if eScrollDir is EScrollDir.OUT and not self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM):
                if self.__isSettingsEnabled(GAME.COMMANDER_CAM):
                    event_dispatcher.showCommanderCamHint(show=True)
            distDelta = dz * float(self.__curScrollSense)
            newDist = math_utils.clamp(distMinMax.min, distMinMax.max, prevDist - distDelta)
            floatEps = 0.001
            if abs(newDist - prevDist) > floatEps:
                self.__updateCameraSettings(newDist)
                self.__inputInertia.glideFov(self.__calcRelativeDist())
                self.__aimingSystem.aimMatrix = self.__calcAimMatrix()
                distChanged = True
            if abs(newDist - prevDist) < floatEps and math_utils.almostZero(newDist - distMinMax.min):
                if self.__isInArcadeZoomState() and self.__onChangeControlMode and not self.__updatedByKeyboard:
                    self.__onChangeControlMode()
                    return
                self.__changeZoomState(EScrollDir.IN)
            elif abs(newDist - prevDist) < floatEps and math_utils.almostZero(newDist - distMinMax.max):
                self.__changeZoomState(EScrollDir.OUT)
        if rotateMode and not self.__isCamInTransition:
            self.__updateAngles(dx, dy)
        if ENABLE_INPUT_ROTATION_INERTIA and not distChanged:
            self.__aimingSystem.update(0.0)
        if ENABLE_INPUT_ROTATION_INERTIA or distChanged:
            self.__startInputInertiaTransition(prevPos)

    def __adjustMinDistForShotPointCalc(self):
        if self.__aimingSystem:
            vehPos = Matrix(self.__aimingSystem.vehicleMProv).translation
            camPos = self.__inputInertia.calcWorldPos(self.__aimingSystem.matrix)
            vehCamDiff = vehPos.distTo(camPos)
            minDist = AimingSystems.SHOT_POINT_PLANAR_DEFAULT_MIN_DISTANCE + vehCamDiff
            self.__aimingSystem.setMinDistanceForShotPointCalc(minDist)

    def __startInputInertiaTransition(self, prevPos, duration=_DEFAULT_ZOOM_DURATION, easing=EXPONENTIAL_EASING):
        worldDeltaPos = prevPos - self.__aimingSystem.matrix.translation
        matInv = Matrix(self.__aimingSystem.matrix)
        matInv.invert()
        self.__inputInertia.glide(matInv.applyVector(worldDeltaPos), duration=duration, easing=easing)
        if not self.__isSettingsEnabled(GAME.SCROLL_SMOOTHING):
            self.__inputInertia.update(duration)

    def __checkNewDistance(self, newDistance):
        distMinMax = self.__distRange
        return math_utils.clamp(distMinMax.min, distMinMax.max, newDistance)

    def __updateProperties(self, state=None):
        self.__zoomStateSwitcher.setCurrentState(state)
        self.__distRange = state.distRange if state else self._cfg['distRange']
        self.__overScrollProtectOnMax = state.overScrollProtectOnMax if state else self._cfg['overScrollProtectOnMax']
        self.__overScrollProtectOnMin = state.overScrollProtectOnMin if state else self._cfg['overScrollProtectOnMin']
        self.__sensitivity = state.sensitivity * self._userCfg['sensitivity'] if state else self._cfg['sensitivity']
        self.__scrollSensitivity = state.scrollSensitivity if state else self._cfg['scrollSensitivity']
        if state is None:
            if self.__isSettingsEnabled(GAME.PRE_COMMANDER_CAM):
                self.__overScrollProtectOnMax = 0.0
            self.__zoomStateSwitcher.reset()
        self.__updateLodBiasForTanks()
        return

    def __changeZoomState(self, eScrollDirection):
        if eScrollDirection not in (EScrollDir.IN, EScrollDir.OUT):
            return
        else:
            if self.__zoomStateSwitcher.isEmpty() or self.__bootcampCtrl.isInBootcamp():
                self.__updateProperties(state=None)
                return
            state = None
            if eScrollDirection is EScrollDir.OUT:
                state = self.__zoomStateSwitcher.getNextState()
                if state is None:
                    return
            elif eScrollDirection is EScrollDir.IN:
                state = self.__zoomStateSwitcher.getPrevState()
                if self.__isInArcadeZoomState() and state is None:
                    return
            self.__updateProperties(state=state)
            prevPos = self.__inputInertia.calcWorldPos(self.__aimingSystem.matrix)
            if eScrollDirection is EScrollDir.OUT:
                if self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM):
                    self.delayCallback(2, self.__hideCommanderCamHint)
                self.__updateCameraSettings(self.__distRange.min)
                self.__inputInertia.glideFov(self.__calcRelativeDist())
                self.__aimingSystem.aimMatrix = self.__calcAimMatrix()
                if not self.__updatedByKeyboard:
                    interval = self.__overScrollProtectOnMin
                    self.__overScrollProtector.start(interval=interval, eScrollDirection=EScrollDir.OUT)
                duration = state.transitionDurationOut if state else _DEFAULT_ZOOM_DURATION
                easing = state.transitionEasingOut if state else EXPONENTIAL_EASING
                self.__startInputInertiaTransition(prevPos, duration, easing)
            elif eScrollDirection is EScrollDir.IN:
                self.__updateCameraSettings(self.__distRange.max)
                self.__inputInertia.glideFov(self.__calcRelativeDist())
                self.__aimingSystem.aimMatrix = self.__calcAimMatrix()
                duration = state.transitionDurationIn if state else _DEFAULT_ZOOM_DURATION
                easing = state.transitionEasingIn if state else EXPONENTIAL_EASING
                self.__startInputInertiaTransition(prevPos, duration, easing)
            self.__updateAdvancedCollision()
            return

    def __hideCommanderCamHint(self):
        event_dispatcher.showCommanderCamHint(show=False)

    def __updateCameraSettings(self, newDist):
        distMinMax = self.__distRange
        state = self.__zoomStateSwitcher.getCurrentState()
        if state:
            totalDiff = distMinMax.max - distMinMax.min
            ratio = (newDist - distMinMax.min) / totalDiff if totalDiff is not 0 else 0
            angle = Math.Vector2(state.angleRangeOnMinDist)
            angle += (state.angleRangeOnMaxDist - angle) * ratio
            heightAboveBaseTotalDiff = state.heightAboveBaseOnMinMaxDist.max - state.heightAboveBaseOnMinMaxDist.min
            heightAboveBase = state.heightAboveBaseOnMinMaxDist.min + heightAboveBaseTotalDiff * ratio
            focusRadiusTotalDiff = state.focusRadiusOnMinMaxDist.max - state.focusRadiusOnMinMaxDist.min
            focusRadius = state.focusRadiusOnMinMaxDist.min + focusRadiusTotalDiff * ratio
            self.aimingSystem.setAnglesRange(angle)
            self.setPivotSettings(heightAboveBase, focusRadius)
        else:
            self.aimingSystem.setAnglesRange(self._cfg['angleRange'])
            self.setPivotSettings(self._cfg['heightAboveBase'], self._cfg['focusRadius'])
        if newDist == distMinMax.max and not self.__updatedByKeyboard:
            interval = self.__overScrollProtectOnMax
            self.__overScrollProtector.start(interval=interval, eScrollDirection=EScrollDir.OUT)
        self.__aimingSystem.distanceFromFocus = newDist
        if self.__isInArcadeZoomState():
            self._userCfg['startDist'] = newDist
        heightAboveBase, _ = self.getPivotSettings()
        diff = heightAboveBase - self._cfg['heightAboveBase']
        self.__cam.shiftPivotPos(Vector3(0, -diff, 0))

    def __isInArcadeZoomState(self):
        return self.__zoomStateSwitcher.getCurrentState() is None

    def __compareCurrStateSettingsKey(self, key):
        state = self.__zoomStateSwitcher.getCurrentState()
        if state:
            return state.settingsKey == key
        return False

    def __isSettingsEnabled(self, settingsKey):
        if settingsKey and self.__settingsCache.isSynced():
            option = self.settingsCore.options.getSetting(settingsKey)
            if option:
                return bool(option.get())
        return False

    def __updateAdvancedCollision(self):
        enable = self.__compareCurrStateSettingsKey(GAME.COMMANDER_CAM)
        self.__cam.setCollisionCheckOnlyAtPos(enable)
        self.__aimingSystem.cursorShouldCheckCollisions(not enable)

    def __updateLodBiasForTanks(self):
        state = self.__zoomStateSwitcher.getCurrentState()
        minLodBias = state.minLODBiasForTanks if state else 0.0
        BigWorld.setMinLodBiasForTanks(minLodBias)

    def __cameraUpdate(self):
        if not self.__autoUpdateDxDyDz.isZero():
            self.__update(*self.__autoUpdateDxDyDz.tuple())
        inertDt = deltaTime = self.measureDeltaTime()
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying:
            repSpeed = replayCtrl.playbackSpeed
            if repSpeed == 0.0:
                inertDt = 0.01
                deltaTime = 0.0
            else:
                inertDt = deltaTime = deltaTime / repSpeed
        self.__aimingSystem.update(deltaTime)
        virginShotPoint = self.__aimingSystem.getThirdPersonShotPoint()
        delta = self.__inputInertia.positionDelta
        sign = delta.dot(math_utils.VectorConstant.Vector3K)
        self.__inputInertia.update(inertDt)
        delta = (delta - self.__inputInertia.positionDelta).length
        if delta != 0.0:
            self.__cam.setScrollDelta(math.copysign(delta, sign))
        FovExtended.instance().setFovByMultiplier(self.__inputInertia.fovZoomMultiplier)
        unshakenPos = self.__inputInertia.calcWorldPos(self.__aimingSystem.matrixProvider)
        vehMatrix = Math.Matrix(self.__aimingSystem.vehicleMProv)
        vehiclePos = vehMatrix.translation
        fromVehicleToUnshakedPos = unshakenPos - vehiclePos
        self.__aimingSystemVectorHelper.x = self.__aimingSystem.yaw
        deviationBasis = math_utils.createRotationMatrix(self.__aimingSystemVectorHelper)
        impulseDeviation, movementDeviation, oscillationsZoomMultiplier = self.__updateOscillators(deltaTime)
        relCamPosMatrix = math_utils.createTranslationMatrix(impulseDeviation + movementDeviation)
        relCamPosMatrix.postMultiply(deviationBasis)
        relCamPosMatrix.translation += fromVehicleToUnshakedPos
        self.__rotationMatrixVectorHelper.z = -impulseDeviation.x * self.__dynamicCfg['sideImpulseToRollRatio'] - self.__noiseOscillator.deviation.z
        upRotMat = math_utils.createRotationMatrix(self.__rotationMatrixVectorHelper)
        upRotMat.postMultiply(relCamPosMatrix)
        self.__cam.up = upRotMat.applyVector(math_utils.VectorConstant.Vector3J)
        relTranslation = relCamPosMatrix.translation
        if self.__inputInertia.isGliding():
            self.__adjustMinDistForShotPointCalc()
            shotPoint = virginShotPoint
        else:
            shotPoint = self.__calcFocalPoint(virginShotPoint, deltaTime)
        vehToShotPoint = shotPoint - vehiclePos
        self.__setCameraAimPoint(vehToShotPoint)
        self.__setCameraPosition(relTranslation)
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and replayCtrl.isControllingCamera:
            aimOffset = replayCtrl.getAimClipPosition()
            if not BigWorld.player().isForcedGuiControlMode() and GUI.mcursor().inFocus:
                GUI.mcursor().position = aimOffset
        else:
            aimOffset = self.__calcAimOffset(oscillationsZoomMultiplier)
            if replayCtrl.isRecording:
                replayCtrl.setAimClipPosition(aimOffset)
        self.__cam.aimPointClipCoords = aimOffset
        self.__aimOffset = aimOffset
        if self.__shiftKeySensor is not None:
            self.__shiftKeySensor.update(1.0)
            if self.__shiftKeySensor.currentVelocity.lengthSquared > 0.0:
                self.shiftCamPos(self.__shiftKeySensor.currentVelocity)
                self.__shiftKeySensor.currentVelocity = Math.Vector3()
        self.__updateCollideAnimator(deltaTime)
        return 0.0

    def __updateCollideAnimator(self, deltaTime):
        result = self.__collideAnimatorEasing.update(deltaTime)
        posOnVehicleProv = self.__aimingSystem.positionAboveVehicleProv.value
        pivotPos = Vector3(posOnVehicleProv.x, posOnVehicleProv.y, posOnVehicleProv.z)
        camPosition = self.__aimingSystem.matrix.translation
        zAxis = camPosition - pivotPos
        zAxis.normalise()
        if self.__cam:
            self.__cam.shiftCamera(result * zAxis)

    def __calcFocalPoint(self, shotPoint, deltaTime):
        aimStartPoint = self.__aimingSystem.matrixProvider.translation
        aimDir = shotPoint - aimStartPoint
        distToShotPoint = aimDir.length
        if distToShotPoint < 0.001:
            return shotPoint
        aimDir /= distToShotPoint
        absDiff = abs(distToShotPoint - self.__focalPointDist)
        if absDiff < ArcadeCamera._FOCAL_POINT_MIN_DIFF or absDiff <= ArcadeCamera._FOCAL_POINT_CHANGE_SPEED * deltaTime:
            self.__focalPointDist = distToShotPoint
            return shotPoint
        changeDir = (distToShotPoint - self.__focalPointDist) / absDiff
        self.__focalPointDist += changeDir * ArcadeCamera._FOCAL_POINT_CHANGE_SPEED * deltaTime
        return aimStartPoint + aimDir * self.__focalPointDist

    def __calcAimOffset(self, oscillationsZoomMultiplier):
        fov = BigWorld.projection().fov
        aspect = cameras.getScreenAspectRatio()
        yTan = math.tan(fov * 0.5)
        xTan = yTan * aspect
        defaultX = self.__defaultAimOffset[0]
        defaultY = self.__defaultAimOffset[1]
        yawFromImpulse = self.__impulseOscillator.deviation.x * self.__dynamicCfg['sideImpulseToYawRatio']
        xImpulseDeviationTan = math.tan(-(yawFromImpulse + self.__noiseOscillator.deviation.x) * oscillationsZoomMultiplier)
        pitchFromImpulse = self.__impulseOscillator.deviation.z * self.__dynamicCfg['frontImpulseToPitchRatio']
        yImpulseDeviationTan = math.tan((pitchFromImpulse + self.__noiseOscillator.deviation.y) * oscillationsZoomMultiplier)
        return Vector2((defaultX * xTan + xImpulseDeviationTan) / (xTan * (1 - defaultX * xTan * xImpulseDeviationTan)), (defaultY * yTan + yImpulseDeviationTan) / (yTan * (1 - defaultY * yTan * yImpulseDeviationTan)))

    def __calcRelativeDist(self):
        if self.__aimingSystem is not None:
            distRange = self.__getAbsoluteDistRange()
            curDist = self.__aimingSystem.distanceFromFocus
            return (curDist - distRange.min) / (distRange.max - distRange.min)
        else:
            return

    def __getAbsoluteDistRange(self):
        minDist = self._cfg['distRange'].min
        maxDist = self._cfg['distRange'].max
        for state in self.__zoomStateSwitcher:
            if not state.settingsKey or self.__isSettingsEnabled(state.settingsKey):
                minDist = min(minDist, state.distRange.min)
                maxDist = max(maxDist, state.distRange.max)

        return MinMax(minDist, maxDist)

    def __calcCurOscillatorAcceleration(self, deltaTime):
        vehicle = BigWorld.player().getVehicleAttached()
        if vehicle is None:
            return Vector3(math_utils.VectorConstant.Vector3Zero)
        else:
            vehFilter = vehicle.filter
            curVelocity = getattr(vehFilter, 'velocity', math_utils.VectorConstant.Vector3Zero)
            relativeSpeed = curVelocity.length / vehicle.typeDescriptor.physics['speedLimits'][0]
            if relativeSpeed >= ArcadeCamera._MIN_REL_SPEED_ACC_SMOOTHING:
                self.__accelerationSmoother.maxAllowedAcceleration = self.__dynamicCfg['accelerationThreshold']
            else:
                self.__accelerationSmoother.maxAllowedAcceleration = self.__dynamicCfg['accelerationMax']
            acceleration = self.__accelerationSmoother.update(vehicle, deltaTime)
            yawMat = math_utils.createRotationMatrix((-self.__aimingSystem.yaw, 0, 0))
            acceleration = yawMat.applyVector(-acceleration)
            oscillatorAcceleration = Vector3(acceleration)
            return oscillatorAcceleration * self.__dynamicCfg['accelerationSensitivity']

    def __updateOscillators(self, deltaTime):
        if not ArcadeCamera.isCameraDynamic():
            self.__impulseOscillator.reset()
            self.__movementOscillator.reset()
            self.__noiseOscillator.reset()
            return (
             Vector3(math_utils.VectorConstant.Vector3Zero), Vector3(math_utils.VectorConstant.Vector3Zero), 1.0)
        oscillatorAcceleration = self.__calcCurOscillatorAcceleration(deltaTime)
        self.__movementOscillator.externalForce += oscillatorAcceleration
        self.__impulseOscillator.update(deltaTime)
        self.__movementOscillator.update(deltaTime)
        self.__noiseOscillator.update(deltaTime)
        self.__impulseOscillator.externalForce = math_utils.VectorConstant.Vector3Zero
        self.__movementOscillator.externalForce = math_utils.VectorConstant.Vector3Zero
        self.__noiseOscillator.externalForce = math_utils.VectorConstant.Vector3Zero
        relDist = self.__calcRelativeDist()
        zoomMultiplier = math_utils.lerp(1.0, self.__dynamicCfg['zoomExposure'], relDist)
        impulseDeviation = Vector3(self.__impulseOscillator.deviation)
        impulseDeviation.set(impulseDeviation.x * zoomMultiplier, impulseDeviation.y * zoomMultiplier, impulseDeviation.z * zoomMultiplier)
        movementDeviation = Vector3(self.__movementOscillator.deviation)
        movementDeviation.set(movementDeviation.x * zoomMultiplier, movementDeviation.y * zoomMultiplier, movementDeviation.z * zoomMultiplier)
        return (impulseDeviation, movementDeviation, zoomMultiplier)

    def applyImpulse(self, position, impulse, reason=ImpulseReason.ME_HIT):
        adjustedImpulse, noiseMagnitude = self.__dynamicCfg.adjustImpulse(impulse, reason)
        yawMat = math_utils.createRotationMatrix((-self.__aimingSystem.yaw, 0, 0))
        impulseLocal = yawMat.applyVector(adjustedImpulse)
        self.__impulseOscillator.applyImpulse(impulseLocal)
        self.__applyNoiseImpulse(noiseMagnitude)

    def applyDistantImpulse(self, position, impulseValue, reason=ImpulseReason.ME_HIT):
        applicationPosition = self.__cam.position
        if reason == ImpulseReason.SPLASH:
            applicationPosition = Matrix(self.vehicleMProv).translation
        impulse = applicationPosition - position
        distance = impulse.length
        if distance < 1.0:
            distance = 1.0
        impulse.normalise()
        if reason == ImpulseReason.OTHER_SHOT and distance <= self.__dynamicCfg['maxShotImpulseDistance']:
            impulse *= impulseValue / distance
        elif reason == ImpulseReason.SPLASH or reason == ImpulseReason.HE_EXPLOSION:
            impulse *= impulseValue / distance
        elif reason == ImpulseReason.VEHICLE_EXPLOSION and distance <= self.__dynamicCfg['maxExplosionImpulseDistance']:
            impulse *= impulseValue / distance
        else:
            return
        self.applyImpulse(position, impulse, reason)

    def __applyNoiseImpulse(self, noiseMagnitude):
        noiseImpulse = math_utils.RandomVectors.random3(noiseMagnitude)
        self.__noiseOscillator.applyImpulse(noiseImpulse)

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if self.__shiftKeySensor is None:
            return False
        else:
            if BigWorld.isKeyDown(Keys.KEY_CAPSLOCK) and mods & 4:
                if key == Keys.KEY_C:
                    self.shiftCamPos()
                return self.__shiftKeySensor.handleKeyEvent(key, isDown)
            self.__shiftKeySensor.reset(Math.Vector3())
            return False

    def reload(self):
        if not constants.IS_DEVELOPMENT:
            return
        import ResMgr
        ResMgr.purge('gui/avatar_input_handler.xml')
        cameraSec = ResMgr.openSection('gui/avatar_input_handler.xml/arcadeMode/camera/')
        self._reloadConfigs(cameraSec)

    def __calcAimMatrix(self):
        endMult = self.__inputInertia.endZoomMultiplier
        fov = FovExtended.instance().actualDefaultVerticalFov * endMult
        offset = self.__defaultAimOffset
        return cameras.getAimMatrix(-offset[0], -offset[1], fov)

    def _readConfigs(self, dataSec):
        if dataSec is None:
            LOG_WARNING('Invalid section <arcadeMode/camera> in avatar_input_handler.xml')
        super(ArcadeCamera, self)._readConfigs(dataSec)
        enableShift = dataSec.readBool('shift', False)
        if enableShift:
            movementMappings = dict()
            movementMappings[Keys.KEY_A] = Math.Vector3(-1, 0, 0)
            movementMappings[Keys.KEY_D] = Math.Vector3(1, 0, 0)
            movementMappings[Keys.KEY_Q] = Math.Vector3(0, 1, 0)
            movementMappings[Keys.KEY_E] = Math.Vector3(0, -1, 0)
            movementMappings[Keys.KEY_W] = Math.Vector3(0, 0, 1)
            movementMappings[Keys.KEY_S] = Math.Vector3(0, 0, -1)
            shiftSensitivity = dataSec.readFloat('shiftSensitivity', 0.5)
            self.__shiftKeySensor = KeySensor(movementMappings, shiftSensitivity)
            self.__shiftKeySensor.reset(Math.Vector3())
        dynamicsSection = dataSec['dynamics']
        self.__impulseOscillator = createOscillatorFromSection(dynamicsSection['impulseOscillator'], False)
        self.__movementOscillator = createOscillatorFromSection(dynamicsSection['movementOscillator'], False)
        self.__movementOscillator = Math.PyCompoundOscillator(self.__movementOscillator, Math.PyOscillator(1.0, Vector3(50.0, 50.0, 50.0), Vector3(20.0, 20.0, 20.0), Vector3(0.01, 0.0, 0.01)))
        self.__noiseOscillator = createOscillatorFromSection(dynamicsSection['randomNoiseOscillatorSpherical'])
        self.__dynamicCfg.readImpulsesConfig(dynamicsSection)
        self.__dynamicCfg['accelerationSensitivity'] = readFloat(dynamicsSection, 'accelerationSensitivity', -1000, 1000, 0.1)
        self.__dynamicCfg['frontImpulseToPitchRatio'] = math.radians(readFloat(dynamicsSection, 'frontImpulseToPitchRatio', -1000, 1000, 0.1))
        self.__dynamicCfg['sideImpulseToRollRatio'] = math.radians(readFloat(dynamicsSection, 'sideImpulseToRollRatio', -1000, 1000, 0.1))
        self.__dynamicCfg['sideImpulseToYawRatio'] = math.radians(readFloat(dynamicsSection, 'sideImpulseToYawRatio', -1000, 1000, 0.1))
        accelerationThreshold = readFloat(dynamicsSection, 'accelerationThreshold', 0.0, 1000.0, 0.1)
        self.__dynamicCfg['accelerationThreshold'] = accelerationThreshold
        self.__dynamicCfg['accelerationMax'] = readFloat(dynamicsSection, 'accelerationMax', 0.0, 1000.0, 0.1)
        self.__dynamicCfg['maxShotImpulseDistance'] = readFloat(dynamicsSection, 'maxShotImpulseDistance', 0.0, 1000.0, 10.0)
        self.__dynamicCfg['maxExplosionImpulseDistance'] = readFloat(dynamicsSection, 'maxExplosionImpulseDistance', 0.0, 1000.0, 10.0)
        self.__dynamicCfg['zoomExposure'] = readFloat(dynamicsSection, 'zoomExposure', 0.0, 1000.0, 0.25)
        accelerationFilter = math_utils.RangeFilter(self.__dynamicCfg['accelerationThreshold'], self.__dynamicCfg['accelerationMax'], 100.0, math_utils.SMAFilter(ArcadeCamera._FILTER_LENGTH))
        maxAccelerationDuration = readFloat(dynamicsSection, 'maxAccelerationDuration', 0.0, 10000.0, ArcadeCamera._DEFAULT_MAX_ACCELERATION_DURATION)
        self.__accelerationSmoother = AccelerationSmoother(accelerationFilter, maxAccelerationDuration)
        self.__inputInertia = _InputInertia(self.__calculateInputInertiaMinMax(), 0.0)
        advancedCollider = dataSec['advancedCollider']
        self.__adCfg = dict()
        cfg = self.__adCfg
        if advancedCollider is None:
            LOG_ERROR('<advancedCollider> dataSection is not found!')
            cfg['enable'] = False
        else:
            cfg['enable'] = advancedCollider.readBool('enable', False)
            cfg['fovRatio'] = advancedCollider.readFloat('fovRatio', 2.0)
            cfg['rollbackSpeed'] = advancedCollider.readFloat('rollbackSpeed', 1.0)
            cfg['minimalCameraDistance'] = self._cfg['distRange'][0]
            cfg['speedThreshold'] = advancedCollider.readFloat('speedThreshold', 0.1)
            cfg['minimalVolume'] = advancedCollider.readFloat('minimalVolume', 200.0)
            cfg['volumeGroups'] = dict()
            for group in VOLUME_GROUPS_NAMES:
                groups = advancedCollider['volumeGroups']
                cfg['volumeGroups'][group] = CollisionVolumeGroup.fromSection(groups[group])

        self.__zoomStateSwitcher.loadConfig(dataSec['additionalZoomStates'])
        return

    def _readBaseCfg(self, dataSec):
        bcfg = self._baseCfg
        bcfg['keySensitivity'] = readFloat(dataSec, 'keySensitivity', 0, 10, 0.01)
        bcfg['sensitivity'] = readFloat(dataSec, 'sensitivity', 0, 10, 0.01)
        bcfg['scrollSensitivity'] = readFloat(dataSec, 'scrollSensitivity', 0, 10, 0.01)
        bcfg['angleRange'] = readVec2(dataSec, 'angleRange', (0, 0), (180, 180), (10,
                                                                                  110))
        distRangeVec = readVec2(dataSec, 'distRange', (1, 1), (100, 100), (2, 20))
        bcfg['distRange'] = MinMax(distRangeVec.x, distRangeVec.y)
        bcfg['minStartDist'] = readFloat(dataSec, 'minStartDist', bcfg['distRange'][0], bcfg['distRange'][1], bcfg['distRange'][0])
        bcfg['optimalStartDist'] = readFloat(dataSec, 'optimalStartDist', bcfg['distRange'][0], bcfg['distRange'][1], bcfg['distRange'][0])
        bcfg['angleRange'][0] = math.radians(bcfg['angleRange'][0]) - math.pi * 0.5
        bcfg['angleRange'][1] = math.radians(bcfg['angleRange'][1]) - math.pi * 0.5
        bcfg['fovMultMinMaxDist'] = MinMax(readFloat(dataSec, 'fovMultMinDist', 0.1, 100, 1.0), readFloat(dataSec, 'fovMultMaxDist', 0.1, 100, 1.0))
        bcfg['focusRadius'] = readFloat(dataSec, 'focusRadius', -100, 100, 3)
        bcfg['heightAboveBase'] = readFloat(dataSec, 'heightAboveBase', 0, 100, 4)
        bcfg['overScrollProtectOnMax'] = readFloat(dataSec, 'overScrollProtectOnMax', 0, 10, 0)
        bcfg['overScrollProtectOnMin'] = readFloat(dataSec, 'overScrollProtectOnMin', 0, 10, 0)

    def _readUserCfg(self):
        bcfg = self._baseCfg
        ucfg = self._userCfg
        dataSec = Settings.g_instance.userPrefs[Settings.KEY_CONTROL_MODE]
        if dataSec is not None:
            dataSec = dataSec['arcadeMode/camera']
        ucfg['horzInvert'] = False
        ucfg['vertInvert'] = False
        ucfg['sniperModeByShift'] = False
        ucfg['keySensitivity'] = readFloat(dataSec, 'keySensitivity', 0.0, 10.0, 1.0)
        ucfg['sensitivity'] = readFloat(dataSec, 'sensitivity', 0.0, 10.0, 1.0)
        ucfg['scrollSensitivity'] = readFloat(dataSec, 'scrollSensitivity', 0.0, 10.0, 1.0)
        ucfg['startDist'] = readFloat(dataSec, 'startDist', bcfg['distRange'][0], 500, bcfg['optimalStartDist'])
        if ucfg['startDist'] < bcfg['minStartDist']:
            ucfg['startDist'] = bcfg['optimalStartDist']
        ucfg['startAngle'] = readFloat(dataSec, 'startAngle', 5, 180, 60)
        ucfg['startAngle'] = math.radians(ucfg['startAngle']) - math.pi * 0.5
        ucfg['fovMultMinMaxDist'] = MinMax(readFloat(dataSec, 'fovMultMinDist', 0.1, 100, bcfg['fovMultMinMaxDist'].min), readFloat(dataSec, 'fovMultMaxDist', 0.1, 100, bcfg['fovMultMinMaxDist'].max))
        return

    def _makeCfg(self):
        bcfg = self._baseCfg
        ucfg = self._userCfg
        cfg = self._cfg
        cfg['keySensitivity'] = bcfg['keySensitivity']
        cfg['sensitivity'] = bcfg['sensitivity']
        cfg['scrollSensitivity'] = bcfg['scrollSensitivity']
        cfg['angleRange'] = bcfg['angleRange']
        cfg['distRange'] = bcfg['distRange']
        cfg['minStartDist'] = bcfg['minStartDist']
        cfg['focusRadius'] = bcfg['focusRadius']
        cfg['heightAboveBase'] = bcfg['heightAboveBase']
        cfg['overScrollProtectOnMax'] = bcfg['overScrollProtectOnMax']
        cfg['overScrollProtectOnMin'] = bcfg['overScrollProtectOnMin']
        cfg['horzInvert'] = ucfg['horzInvert']
        cfg['vertInvert'] = ucfg['vertInvert']
        cfg['keySensitivity'] *= ucfg['keySensitivity']
        cfg['sensitivity'] *= ucfg['sensitivity']
        cfg['scrollSensitivity'] *= ucfg['scrollSensitivity']
        cfg['startDist'] = ucfg['startDist']
        cfg['startAngle'] = ucfg['startAngle']
        cfg['fovMultMinMaxDist'] = ucfg['fovMultMinMaxDist']
        cfg['sniperModeByShift'] = ucfg['sniperModeByShift']

    def writeUserPreferences(self):
        ds = Settings.g_instance.userPrefs
        if not ds.has_key(Settings.KEY_CONTROL_MODE):
            ds.write(Settings.KEY_CONTROL_MODE, '')
        ucfg = self._userCfg
        ds = ds[Settings.KEY_CONTROL_MODE]
        ds.writeBool('arcadeMode/camera/horzInvert', ucfg['horzInvert'])
        ds.writeBool('arcadeMode/camera/vertInvert', ucfg['vertInvert'])
        ds.writeFloat('arcadeMode/camera/keySensitivity', ucfg['keySensitivity'])
        ds.writeFloat('arcadeMode/camera/sensitivity', ucfg['sensitivity'])
        ds.writeFloat('arcadeMode/camera/scrollSensitivity', ucfg['scrollSensitivity'])
        ds.writeFloat('arcadeMode/camera/startDist', ucfg['startDist'])
        ds.writeFloat('arcadeMode/camera/fovMultMinDist', ucfg['fovMultMinMaxDist'].min)
        ds.writeFloat('arcadeMode/camera/fovMultMaxDist', ucfg['fovMultMinMaxDist'].max)
        startAngle = math.degrees(ucfg['startAngle'] + math.pi * 0.5)
        ds.writeFloat('arcadeMode/camera/startAngle', startAngle)

    def __onRecreateDevice(self):
        self.__aimingSystem.aimMatrix = self.__calcAimMatrix()


class ArcadeCameraEpic(ArcadeCamera):

    @staticmethod
    def _getConfigsKey():
        return ArcadeCameraEpic.__name__

    def reload(self):
        if not constants.IS_DEVELOPMENT:
            return
        import ResMgr
        ResMgr.purge('gui/avatar_input_handler.xml')
        cameraSec = ResMgr.openSection('gui/avatar_input_handler.xml/arcadeEpicMinefieldMode/camera/')
        self._reloadConfigs(cameraSec)