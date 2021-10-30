import BigWorld, Math
from math import pi, fabs
from debug_utils import *

def calcPitchLimitsFromDesc(turretYaw, pitchLimitsDesc, turretPitch=0.0, gunJointPitch=0.0):
    minPitch = pitchLimitsDesc['minPitch']
    maxPitch = pitchLimitsDesc['maxPitch']
    return BigWorld.wg_calcGunPitchLimits(turretYaw, minPitch, maxPitch, turretPitch, gunJointPitch)


def calcGunPitchCorrection(turretYaw, turretPitch, gunJointPitch):
    return turretPitch * (1.0 - 2.0 * (fabs(turretYaw) / pi)) + gunJointPitch


def encodeAngleToUint(angle, bits):
    mask = (1 << bits) - 1
    return int(round((mask + 1) * (angle + pi) / (pi * 2.0))) & mask


def decodeAngleFromUint(code, bits):
    return pi * 2.0 * code / (1 << bits) - pi


def encodeRestrictedValueToUint(angle, bits, minBound, maxBound):
    t = 0 if maxBound == minBound else (angle - minBound) / (maxBound - minBound)
    t = _clamp(0.0, t, 1.0)
    mask = (1 << bits) - 1
    return int(round(mask * t)) & mask


def decodeRestrictedValueFromUint(code, bits, minBound, maxBound):
    t = float(code) / ((1 << bits) - 1)
    return minBound + t * (maxBound - minBound)


def encodeGunAngles(yaw, pitch, pitchLimits):
    return encodeAngleToUint(yaw, 10) << 6 | encodeRestrictedValueToUint(pitch, 6, *pitchLimits)


def decodeGunAngles(code, pitchLimits):
    return (
     decodeAngleFromUint(code >> 6 & 1023, 10),
     decodeRestrictedValueFromUint((code & 63), 6, *pitchLimits))


def _clamp(minBound, value, maxBound):
    if value < minBound:
        return minBound
    if value > maxBound:
        return maxBound
    return value


def getLocalAimPoint(vehicleDescriptor):
    if vehicleDescriptor is None:
        return Math.Vector3(0.0, 0.0, 0.0)
    else:
        hullBox = vehicleDescriptor.hull.hitTester.bbox
        hullPosition = vehicleDescriptor.chassis.hullPosition
        if hullBox is None or hullPosition is None:
            return Math.Vector3(0.0, 0.0, 0.0)
        middleX = (hullBox[0].x + hullBox[1].x) * 0.5 + hullPosition.x
        middleZ = (hullBox[0].z + hullBox[1].z) * 0.5 + hullPosition.z
        calculatedHullPosition = (middleX, hullPosition.y, middleZ)
        turretPosition = vehicleDescriptor.hull.turretPositions[0] * 0.5
        maxZOffset = abs(hullBox[1].z - hullBox[0].z) * 0.2
        turretPosition.z = max(-maxZOffset, min(maxZOffset, turretPosition.z))
        localAimPoint = calculatedHullPosition + turretPosition
        return localAimPoint