from constants import PREBATTLE_TYPE
from fun_random.gui.fun_gui_constants import RequestType
from gui.prb_control.entities.base.squad.ctx import SquadSettingsCtx
from gui.prb_control.entities.base.unit.ctx import UnitRequestCtx
from gui.prb_control.settings import FUNCTIONAL_FLAG
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('getDesiredSubModeID', 'desiredSubModeID'))
class FunSquadSettingsCtx(SquadSettingsCtx):
    __slots__ = ('__desiredSubModeID', )

    def __init__(self, desiredSubModeID, flags=FUNCTIONAL_FLAG.UNDEFINED, accountsToInvite=None, isForced=False):
        prebattleType, waitingID = PREBATTLE_TYPE.FUN_RANDOM, 'prebattle/create'
        super(FunSquadSettingsCtx, self).__init__(prebattleType, waitingID, flags, accountsToInvite, isForced)
        self.__desiredSubModeID = desiredSubModeID

    def getDesiredSubModeID(self):
        return self.__desiredSubModeID


@ReprInjector.withParent(('getDesiredSubModeID', 'desiredSubModeID'))
class FunSquadChangeSubModeCtx(UnitRequestCtx):
    __slots__ = ('__desiredSubModeID', )

    def __init__(self, desiredSubModeID):
        super(FunSquadChangeSubModeCtx, self).__init__()
        self.__desiredSubModeID = desiredSubModeID

    def getCooldown(self):
        return 2.0

    def getDesiredSubModeID(self):
        return self.__desiredSubModeID

    def getRequestType(self):
        return RequestType.CHANGE_FUN_SUB_MODE