from collections import namedtuple
import BigWorld
from gui.battle_control.arena_info.interfaces import IArenaLoadController
from gui.battle_control.battle_constants import BATTLE_CTRL_ID
_TimersData = namedtuple('_TimersData', 'timeToStrike waveDuration')

class DeathZonesController(IArenaLoadController):

    def __init__(self):
        self.__timersData = {}
        self.__timeToStrikeInCurrentNotification = None
        return

    def startControl(self, battleCtx, arenaVisitor):
        pass

    def stopControl(self):
        pass

    def getControllerID(self):
        return BATTLE_CTRL_ID.DEATHZONES

    def updateDeathZoneWarningNotification(self, zoneId, show, timeToStrike, waveDuration):
        if show:
            self.__timersData[zoneId] = _TimersData(timeToStrike, waveDuration)
        elif zoneId in self.__timersData:
            self.__timersData.pop(zoneId)
        player = BigWorld.player()
        if player is None:
            return
        else:
            if self.__timersData:
                closestStrikeData = min(self.__timersData.itervalues(), key=lambda timersData: timersData.timeToStrike)
                if closestStrikeData.timeToStrike != self.__timeToStrikeInCurrentNotification:
                    player.updateDeathZoneWarningNotification(True, closestStrikeData.timeToStrike, closestStrikeData.waveDuration)
                    self.__timeToStrikeInCurrentNotification = closestStrikeData.timeToStrike
            else:
                player.updateDeathZoneWarningNotification(False, 0, 0)
                self.__timeToStrikeInCurrentNotification = None
            return