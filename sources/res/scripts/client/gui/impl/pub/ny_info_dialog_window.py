from gui.impl.lobby.dialogs.contents.balance_content_with_ny_shards import BalanceContentWithShards
from gui.impl.pub.simple_dialog_window import SimpleDialogWindow

class NYInfoDialogWindow(SimpleDialogWindow):

    def __init__(self, *args, **kwargs):
        if kwargs.get('balanceContent') is not None:
            kwargs['balanceContent'] = BalanceContentWithShards()
        super(NYInfoDialogWindow, self).__init__(*args, **kwargs)
        return