import typing
from .window import Window
from ..gui_constants import PositionAnchor
from ..py_object_binder import PyObjectEntity
from ..py_object_wrappers import PyObjectWindowsArea

class WindowsArea(PyObjectEntity):
    __slots__ = ()

    def __init__(self):
        super(WindowsArea, self).__init__(cppObject=PyObjectWindowsArea())

    @property
    def areaID(self):
        proxy = self.proxy
        if proxy is not None:
            return proxy.areaID
        else:
            return 0

    def addWindow(self, window):
        return self.proxy.addPyWindow(window.proxy)

    def removeWindow(self, window):
        return self.proxy.removePyWindow(window.proxy)

    def getFirstWindow(self):
        return self.proxy.getFirstPyWindow()

    def getLastWindow(self):
        return self.proxy.getLastPyWindow()

    def getPreviousNeighbor(self, window):
        return self.proxy.getPreviousPyNeighbor(window.uniqueID)

    def getNextNeighbor(self, window):
        return self.proxy.getNextPyNeighbor(window.uniqueID)

    def move(self, window, x, y, xAnchor=PositionAnchor.LEFT, yAnchor=PositionAnchor.TOP):
        return self.proxy.movePyWindow(window.uniqueID, x, y, xAnchor, yAnchor)

    def center(self, window):
        return self.proxy.centerPyWindow(window.uniqueID)

    def cascade(self, window):
        return self.proxy.cascadePyWindow(window.uniqueID)