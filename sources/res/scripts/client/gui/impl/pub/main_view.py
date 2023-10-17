from frameworks.wulf import ViewFlags, ViewSettings, ViewModel
from gui.impl.pub import ViewImpl

class MainView(ViewImpl):
    __slots__ = ()

    def __init__(self, entryID):
        super(MainView, self).__init__(ViewSettings(entryID, ViewFlags.MAIN_VIEW, ViewModel()))