from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class PackItemsPopoverMeta(SmartPopOverView):

    def as_setItemsS(self, title, items):
        if self._isDAAPIInited():
            return self.flashObject.as_setItems(title, items)