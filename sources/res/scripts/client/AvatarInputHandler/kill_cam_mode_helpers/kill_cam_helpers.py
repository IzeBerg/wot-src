import Math
from projectile_trajectory import computeProjectileTrajectoryWithEnd
_SHELL_TRAJECTORY_EPSILON_CAMERA = 0.03

def calculateSPGTrajectory(start, end, velocity, gravity):
    points = computeProjectileTrajectoryWithEnd(start, end, velocity, gravity, _SHELL_TRAJECTORY_EPSILON_CAMERA)
    points.insert(0, start)
    return points


def getMiddlePointWithOffset(points, direction, offset):
    middlePoint = (points[(-1)] - points[0]) / 2.0
    offsetVector = Math.Vector3(middlePoint)
    offsetVector.normalise()
    offsetVector = offsetVector * Math.Vector3(0.0, direction, 0.0)
    middlePoint += offsetVector * offset
    middlePoint += points[0]
    return middlePoint