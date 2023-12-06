from frameworks.wulf import WindowLayer
from gui.impl.dialogs.gf_builders import ConfirmCancelDialogBuilder
from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogWindowWrapper

class ResetLootBoxStatisticsBuilder(ConfirmCancelDialogBuilder):

    def build(self, withBlur=False):
        return FullScreenDialogWindowWrapper(self.buildView(), doBlur=withBlur, layer=WindowLayer.OVERLAY)