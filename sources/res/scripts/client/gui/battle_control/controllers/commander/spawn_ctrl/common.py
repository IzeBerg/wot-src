import logging
from collections import namedtuple
_logger = logging.getLogger(__name__)
PointData = namedtuple('PointData', 'guid x y vehicleTag yaw')
ChosenPointData = namedtuple('ChosenPointData', 'guid x y yaw')

def createPointData(dataDict):
    coordX, coordY = dataDict['position']
    return PointData(dataDict['guid'], coordX, coordY, dataDict['vehicleTag'], dataDict['yaw'])


def createChosenPointData(dataDict):
    coordX, coordY = dataDict['position']
    return ChosenPointData(dataDict['guid'], coordX, coordY, dataDict['yaw'])