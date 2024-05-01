from BWUtil import AsyncReturn
from cosmic_event.gui.impl.battle.cosmic_hud.leaving_view import LeavingView
from gui.Scaleform.daapi.view.battle.shared.ingame_menu import IngameMenu
from gui.Scaleform.genConsts.INGAMEMENU_CONSTANTS import INGAMEMENU_CONSTANTS
from gui.impl.dialogs import dialogs
from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogWindowWrapper
from gui.impl.pub.dialog_window import DialogButtons
from wg_async import wg_await, wg_async

@wg_async
def _showLeaverAliveWindow():
    view = LeavingView()
    wrapper = FullScreenDialogWindowWrapper(view)
    result = yield wg_await(dialogs.show(wrapper))
    raise AsyncReturn(result.result == DialogButtons.SUBMIT)


class CosmicIngameMenu(IngameMenu):

    @staticmethod
    def _showLeaverAliveWindow(isPlayerIGR):
        return _showLeaverAliveWindow()

    def _setMenuButtons(self):
        buttons = [
         INGAMEMENU_CONSTANTS.QUIT, INGAMEMENU_CONSTANTS.SETTINGS,
         INGAMEMENU_CONSTANTS.CANCEL]
        self.as_setMenuButtonsS(buttons)