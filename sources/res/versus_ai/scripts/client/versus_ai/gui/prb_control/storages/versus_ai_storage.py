from gui.prb_control.storages.local_storage import SessionStorage
from helpers import dependency
from skeletons.gui.game_control import IVersusAIController

class VersusAIStorage(SessionStorage):
    __versusAICtrl = dependency.descriptor(IVersusAIController)

    def isModeSelected(self):
        return super(VersusAIStorage, self).isModeSelected() and self.__versusAICtrl.isEnabled()

    def shouldBeSelectedByDefault(self):
        return self.__versusAICtrl.shouldBeDefaultMode()

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isVersusAI()