from frameworks.wulf import WindowFlags
from gui.impl.pub.window_impl import WindowImpl
from gui.impl.pub.window_view import WindowView

class StandardWindow(WindowImpl):
    __slots__ = ()

    def __init__(self, content=None, parent=None, areaID=0):
        super(StandardWindow, self).__init__(WindowFlags.WINDOW, decorator=WindowView(), content=content, parent=parent, areaID=areaID)