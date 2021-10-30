from gui.Scaleform.daapi.view.meta.AbstractRallyViewMeta import AbstractRallyViewMeta

class AbstractRallyView(AbstractRallyViewMeta):

    def __init__(self):
        super(AbstractRallyView, self).__init__()
        self.isMinimising = False

    def setData(self, itemID):
        pass