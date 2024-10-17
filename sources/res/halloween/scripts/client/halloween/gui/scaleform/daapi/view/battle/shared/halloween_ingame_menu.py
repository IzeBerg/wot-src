from BWUtil import AsyncReturn
import BattleReplay
from halloween_common.halloween_constants import ARENA_GUI_TYPE
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from wg_async import wg_async, wg_await
from gui.impl.gen import R
from HWArenaPhasesComponent import HWArenaPhasesComponent
from gui.Scaleform.daapi.view.battle.shared.ingame_menu import IngameMenu
from gui.Scaleform.daapi.view.battle.shared.premature_leave import showResDialogWindow, showLeaverReplayWindow
from gui.Scaleform.daapi.view.battle.shared.premature_leave import showExitWindow
from halloween.gui.impl.battle.help_view import HelpWindow

@wg_async
def showLeaverAliveWindow(arenaGuiType):
    quitBattleR = R.strings.dialogs.halloweenQuitBattle
    title = quitBattleR.leaver.title()
    confirm = quitBattleR.leaver.submit()
    if arenaGuiType == ARENA_GUI_TYPE.HALLOWEEN_DEFENCE:
        description = quitBattleR.leaver.descriptionAliveDefence()
    else:
        description = quitBattleR.leaver.descriptionAlive()
    icon = R.images.halloween.gui.maps.icons.battle.deserterLeaveBattle()
    result = yield wg_await(showResDialogWindow(title, confirm=confirm, description=description, icon=icon))
    raise AsyncReturn(result)


class HWIngameMenu(IngameMenu):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    @property
    def arenaPhases(self):
        return HWArenaPhasesComponent.getInstance()

    def helpClick(self):
        HelpWindow().load()

    @wg_async
    def _doLeaveArena(self):
        prematureLeave = self._isEventPrematureLeave()
        self.as_setVisibilityS(False)
        if BattleReplay.isPlaying():
            result = yield wg_await(showLeaverReplayWindow())
        elif prematureLeave:
            result = yield wg_await(showLeaverAliveWindow(self.sessionProvider.arenaVisitor.getArenaGuiType()))
        else:
            result = yield wg_await(showExitWindow())
        if result:
            self._doExit()
        else:
            self.destroy()

    def _isEventPrematureLeave(self):
        arenaPhases = self.arenaPhases
        if arenaPhases is None:
            return False
        else:
            lastPhase = arenaPhases.activePhase == arenaPhases.phasesCount
            inPostmortem = self.sessionProvider.shared.vehicleState.isInPostmortem
            if not arenaPhases.isRespawnEnabled and lastPhase and inPostmortem:
                return False
            return True