from fun_random_common.fun_constants import UNKNOWN_EVENT_ID
from gui.prb_control.storages.local_storage import SessionStorage
from helpers import dependency
from skeletons.gui.game_control import IFunRandomController

class FunRandomStorage(SessionStorage):
    __funRandomController = dependency.descriptor(IFunRandomController)

    def isModeSelected(self):
        desiredSubMode = self.__funRandomController.subModesHolder.getDesiredSubMode()
        isSelected = desiredSubMode is not None and desiredSubMode.isAvailable()
        desiredSubModeID = desiredSubMode.getSubModeID() if isSelected else UNKNOWN_EVENT_ID
        self.__funRandomController.setDesiredSubModeID(desiredSubModeID)
        return isSelected