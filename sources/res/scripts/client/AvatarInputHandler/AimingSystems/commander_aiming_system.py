import math, BigWorld
from Math import Vector2, Vector3
import math_utils
from AvatarInputHandler import AimingSystems
from AvatarInputHandler.AimingSystems import IAimingSystem
from AvatarInputHandler.cameras import _clampPoint2DInBox2D

class CommanderAimingSystem(IAimingSystem):
    _LOOK_DIR = Vector3(0, -math.cos(0.001), math.sin(0.001))
    height = property(lambda self: self.__height)
    heightFromPlane = property(lambda self: self.__heightFromPlane)
    planePosition = property(lambda self: self._planePosition)

    def __init__(self, height, yaw):
        super(CommanderAimingSystem, self).__init__()
        self.__enabled = False
        self._matrix = math_utils.createRotationMatrix((yaw, 0, 0))
        self._planePosition = Vector3(0, 0, 0)
        self.__camDist = 0.0
        self.__height = height
        self.__heightFromPlane = 0.0
        self.__desiredHeightFromPlane = 0.0
        self.__heightFromPlaneVelocity = 0.0

    def destroy(self):
        pass

    def enable(self, targetPos):
        self.updateTargetPos(targetPos)
        BigWorld.callback(0.0, self.__update)
        self.__enabled = True

    def disable(self):
        self.__enabled = False

    def __update(self):
        if not self.__enabled:
            return
        timeDelta = 0.01
        springConstant = 50.0
        springForce = (self.__desiredHeightFromPlane - self.__heightFromPlane) * springConstant
        dampingForce = self.__heightFromPlaneVelocity * 2 * math.sqrt(springConstant)
        self.__heightFromPlaneVelocity += (springForce - dampingForce) * timeDelta
        self.__heightFromPlane += self.__heightFromPlaneVelocity * timeDelta
        self._matrix.translation = self._planePosition + Vector3(0, self.__heightFromPlane + self.__height, 0)
        BigWorld.callback(timeDelta, self.__update)

    def getDesiredShotPoint(self, terrainOnlyCheck=False):
        return AimingSystems.getDesiredShotPoint(self._matrix.translation, Vector3(0, -1, 0), True, True, terrainOnlyCheck)

    def handleMovement(self, dx, dy):
        shift = self._matrix.applyVector(Vector3(dx, 0, dy))
        self._planePosition += Vector3(shift.x, 0, shift.z)
        self._updateMatrix()

    def updateTargetPos(self, targetPos):
        self._planePosition.x = targetPos.x
        self._planePosition.z = targetPos.z
        self._updateMatrix(True)

    def getCamDist(self):
        return self.__camDist

    def overrideCamDist(self, camDist):
        self.__camDist = camDist
        return camDist

    def getShotPoint(self):
        desiredShotPoint = self.getDesiredShotPoint()
        return Vector3(desiredShotPoint.x, self.getCamDist(), desiredShotPoint.z)

    def getZoom(self):
        return 0

    def _clampToArenaBB(self):
        bb = BigWorld.player().arena.arenaType.boundingBox
        pos2D = _clampPoint2DInBox2D(bb[0], bb[1], Vector2(self._planePosition.x, self._planePosition.z))
        self._planePosition.x = pos2D[0]
        self._planePosition.z = pos2D[1]

    def _updateMatrix(self, snap=False):
        self._clampToArenaBB()
        collPoint = BigWorld.wg_collideSegment(BigWorld.player().spaceID, self._planePosition + Vector3(0, -250.0, 0), self._planePosition + Vector3(0, 1000.0, 0), 119)
        self.__desiredHeightFromPlane = 0.0 if collPoint is None else collPoint.closestPoint.y
        if snap:
            self.__heightFromPlaneVelocity = 0.0
            self.__heightFromPlane += self.__desiredHeightFromPlane
            self._matrix.translation = self._planePosition + Vector3(0, self.__heightFromPlane + self.__height, 0)
        return