import BattleReplay, BigWorld, GUI
from AvatarInputHandler import cameras

def getMousePositionOnTerrain():
    direction, start = cameras.getWorldRayAndPoint(*getRTSMCursorPosition())
    collideResult = BigWorld.wg_collideSegment(BigWorld.player().spaceID, start, start + direction * 10000.0, 119)
    if collideResult is not None:
        return collideResult.closestPoint
    else:
        return


def getRTSMCursorPosition():
    replayCtrl = BattleReplay.g_replayCtrl
    if replayCtrl.isPlaying:
        return replayCtrl.mouseCursor.position
    return GUI.mcursor().position