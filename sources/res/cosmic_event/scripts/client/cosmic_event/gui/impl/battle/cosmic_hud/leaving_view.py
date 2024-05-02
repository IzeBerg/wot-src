import logging
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.leaving_view_model import LeavingViewModel
from frameworks.wulf import ViewFlags, ViewSettings
from gui.impl.gen import R
from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogBaseView
from gui.impl.pub.dialog_window import DialogButtons
_logger = logging.getLogger(__name__)

class LeavingView(FullScreenDialogBaseView):

    def __init__(self):
        settings = ViewSettings(R.views.cosmic_event.battle.cosmic_hud.LeavingView())
        settings.flags = ViewFlags.VIEW
        settings.model = LeavingViewModel()
        super(LeavingView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(LeavingView, self).getViewModel()

    def _getEvents(self):
        events = (
         (
          self.viewModel.onCancel, self.onClose),
         (
          self.viewModel.cancelWithEsc, self.onClose),
         (
          self.viewModel.onLeave, self.onLeave))
        return events

    def onClose(self):
        self._setResult(DialogButtons.CANCEL)

    def onLeave(self):
        self._setResult(DialogButtons.SUBMIT)