from gui.battle_control.arena_info.interfaces import IArenaVehiclesController
from helpers import dependency
from skeletons.gui.game_control import IGameSessionController
from bootcamp.BootCampEvents import g_bootcampEvents

class BootcampController(IArenaVehiclesController):
    gameSession = dependency.descriptor(IGameSessionController)

    def getControllerID(self):
        return

    def arenaLoadCompleted(self):
        g_bootcampEvents.onArenaLoadCompleted()