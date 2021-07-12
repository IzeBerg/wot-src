from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogView

class BaseItemDialog(FullScreenDialogView):
    __slots__ = ('_itemCD', '_item')

    def __init__(self, settings, compDescr):
        super(BaseItemDialog, self).__init__(settings)
        self._itemCD = compDescr
        self._item = self._itemsCache.items.getItemByCD(self._itemCD)

    def _finalize(self):
        super(BaseItemDialog, self)._finalize()
        self._item = None
        return