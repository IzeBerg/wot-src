from gui.prb_control.storages.local_storage import SessionStorage
from helpers import dependency
from skeletons.gui.game_control import IMapboxController

class MapboxStorage(SessionStorage):
    __mapboxCtrl = dependency.descriptor(IMapboxController)

    def isModeSelected(self):
        isMapboxAvailable = self.__mapboxCtrl.isEnabled() and self.__mapboxCtrl.getCurrentSeason() is not None
        return super(MapboxStorage, self).isModeSelected() and isMapboxAvailable

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isMapbox()