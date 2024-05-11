from adisp import adisp_process, adisp_async
import wg_async as future_async
from gui.impl.dialogs import dialogs
from gui.impl.dialogs.builders import WarningDialogBuilder
from gui.impl.gen import R
from helpers import dependency
from story_mode.skeletons.story_mode_controller import IStoryModeController

@adisp_async
@future_async.wg_async
def checkTasksAvailable(callback):
    ctrl = dependency.instance(IStoryModeController)
    mission = ctrl.missions.getMission(ctrl.selectedMissionId)
    if mission and all(ctrl.isMissionTaskCompleted(mission.missionId, task.id) for task in mission.getUnlockedTasks()):
        builder = WarningDialogBuilder()
        rMsg = R.strings.sm_lobby.dialogs.missionCompleted
        builder.setMessagesAndButtons(rMsg, rMsg)
        builder.setShowBalance(True)
        success = yield future_async.wg_await(dialogs.showSimple(builder.buildInLobby()))
        callback(success)
    else:
        callback(True)


def tasksAvailableCheck(func):

    @adisp_process
    def wrapper(*args, **kwargs):
        res = yield checkTasksAvailable()
        if res:
            func(*args, **kwargs)
        elif kwargs.get('callback') is not None:
            kwargs.get('callback')(False)
        return

    return wrapper