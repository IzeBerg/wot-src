import BigWorld
from AvatarInputHandler.AimingSystems import SPG_MINIMAL_AIMING_RADIUS_SQ, SPG_MINIMAL_AIMING_RADIUS
from Math import Vector3, Matrix
import math_utils
from AvatarInputHandler.AimingSystems.StrategicAimingSystem import BaseStrategicAimingSystem
from constants import SERVER_TICK_LENGTH, SHELL_TRAJECTORY_EPSILON_CLIENT

class ArtyAimingSystem(BaseStrategicAimingSystem):

    def __init__(self):
        super(ArtyAimingSystem, self).__init__(0.0, 0.0)
        self.__direction = Vector3(0.0, 0.0, 0.0)
        self.__aimMatrix = Matrix()

    @property
    def aimMatrix(self):
        return self.__aimMatrix

    @property
    def aimPoint(self):
        return self.__aimMatrix.translation

    @aimPoint.setter
    def aimPoint(self, point):
        self.__aimMatrix.setTranslate(point)

    @property
    def hitPoint(self):
        return self._matrix.translation

    @property
    def direction(self):
        return self.__direction

    def getDesiredShotPoint(self, terrainOnlyCheck=False):
        return self.__aimMatrix.translation

    def _updateMatrix(self):
        self._clampMinimalAimingRadius()
        self._clampToArenaBB()
        hitPoint = BigWorld.wg_collideSegment(BigWorld.player().spaceID, self._planePosition + Vector3(0.0, 1000.0, 0.0), self._planePosition + Vector3(0.0, -250.0, 0.0), 128, 8)
        aimPoint = Vector3(self._planePosition)
        if hitPoint is not None:
            aimPoint.y = hitPoint.closestPoint[1]
        r0, v0, g0 = BigWorld.player().gunRotator.getShotParams(aimPoint, True)
        hitPoint = BigWorld.wg_simulateProjectileTrajectory(r0, v0, g0, SERVER_TICK_LENGTH, SHELL_TRAJECTORY_EPSILON_CLIENT, 128)
        if hitPoint is not None:
            time = (aimPoint.x - r0.x) / v0.x
            self.__direction = v0 + g0 * time
            self.__direction.normalise()
            self._matrix = math_utils.createRTMatrix((
             self.__direction.yaw, -self.__direction.pitch, 0.0), hitPoint[1])
        self.__aimMatrix.setTranslate(aimPoint)
        return

    def _clampMinimalAimingRadius(self):
        vehiclePosition = Vector3(BigWorld.player().getVehicleAttached().position)
        vehiclePosition.y = self._planePosition.y
        diff = self._planePosition - vehiclePosition
        if diff.lengthSquared < SPG_MINIMAL_AIMING_RADIUS_SQ:
            diff.normalise()
            self._planePosition = vehiclePosition + diff * SPG_MINIMAL_AIMING_RADIUS