import sys, BigWorld
from SpaceVisibilityFlags import SpaceVisibilityFlagsFactory
from constants import ARENA_GAMEPLAY_IDS
DEFAULT_VISIBILITY_MASK = -1

def gameModeVisibilityMask(spaceName):
    if 'gameMode' not in sys.argv:
        return DEFAULT_VISIBILITY_MASK
    gameModeArgIndex = sys.argv.index('gameMode') + 1
    if gameModeArgIndex >= len(sys.argv):
        return DEFAULT_VISIBILITY_MASK
    gameMode = sys.argv[gameModeArgIndex].lower()
    if gameMode not in ARENA_GAMEPLAY_IDS:
        return DEFAULT_VISIBILITY_MASK
    spaceVisibilityFlags = SpaceVisibilityFlagsFactory.create(spaceName)
    return spaceVisibilityFlags.getMaskForGameplayID(gameMode)


def createFakeAvatar():
    entityID = BigWorld.createEntity('OfflineEntity', BigWorld.camera().spaceID, 0, (0,
                                                                                     0,
                                                                                     0), (0,
                                                                                          0,
                                                                                          0), {})
    entity = BigWorld.entity(entityID)
    BigWorld.player = lambda : entity