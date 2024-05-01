import BigWorld
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from typing import List
    from DeliveryZone import DeliveryZone

def getFragmentManager():
    player = BigWorld.player()
    if player and player.arena is not None:
        arenaInfo = player.arena.arenaInfo
        if arenaInfo:
            return arenaInfo.dynamicComponents.get('FragmentManager', None)
    return


def getVehicleFragments(vehicleID):
    fragmentManagerComp = getFragmentManager()
    if fragmentManagerComp is None:
        return 0
    else:
        return fragmentManagerComp.getFragmentsByVehicleID(vehicleID)


def getGamePhaseComponent():
    player = BigWorld.player()
    if player and player.arena is not None:
        arenaInfo = player.arena.arenaInfo
        if arenaInfo:
            return arenaInfo.dynamicComponents.get('gamePhaseComponent', None)
    return


def getDeliveryZones():
    return BigWorld.entities.valuesOfType('DeliveryZone')