from gui.prb_control.storages.local_storage import SessionStorage
from helpers import dependency
from versus_ai.skeletons.versus_ai_controller import IVersusAIController

class VersusAIStorage(SessionStorage):
    __versusAICtrl = dependency.descriptor(IVersusAIController)

    def isModeSelected(self):
        return super(VersusAIStorage, self).isModeSelected() and self.__versusAICtrl.isEnabled()

    def shouldBeSelectedByDefault(self):
        return self.__versusAICtrl.shouldBeDefaultMode()

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isVersusAI()