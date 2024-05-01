import BigWorld
from typing import TYPE_CHECKING
from constants import NULL_ENTITY_ID
if TYPE_CHECKING:
    from ArenaInfoScoreSystemComponent import ArenaInfoScoreSystemComponent

def getArenaScoreComponent():
    player = BigWorld.player()
    if player and player.arena is not None:
        arenaInfo = player.arena.arenaInfo
        if arenaInfo:
            return arenaInfo.dynamicComponents.get('ArenaInfoScoreSystemComponent', None)
    return


def getVictimToKillerInfo():
    arenScoreComp = getArenaScoreComponent()
    if arenScoreComp is None:
        return {}
    else:
        return arenScoreComp.victimToKiller


def isMyKiller(myVehicleID, otherVehicleID, victimToKiller):
    return victimToKiller.get(myVehicleID, NULL_ENTITY_ID) == otherVehicleID