import typing, BigWorld
from frameworks.wulf import WindowStatus, WindowSettings, Window
from gui.Scaleform.framework import ScopeTemplates
from gui.Scaleform.framework.entities.DisposableEntity import DisposableEntity
from gui.Scaleform.framework.entities.View import ViewKey
from gui.Scaleform.framework.entities.view_interface import ViewInterface
from gui.Scaleform.framework.settings import UIFrameworkImpl
from soft_exception import SoftException

class ViewImplAdaptor(DisposableEntity, ViewInterface):
    __slots__ = ('__window', '__loadID', '__scope', '__key')

    def __init__(self):
        super(ViewImplAdaptor, self).__init__()
        self.__window = None
        self.__loadID = None
        self.__scope = ScopeTemplates.DEFAULT_SCOPE
        self.__key = None
        return

    def __repr__(self):
        return ('{}(key={})').format(self.__class__.__name__, self.__key)

    @property
    def view(self):
        return self.__window.content

    @property
    def uiImpl(self):
        return UIFrameworkImpl.GUI_IMPL

    @property
    def layer(self):
        layer = self.view.layer
        if not layer:
            return None
        else:
            return layer

    @property
    def viewScope(self):
        return self.__scope

    @property
    def key(self):
        return self.__key

    @property
    def alias(self):
        return self.__key.alias

    @property
    def uniqueName(self):
        return self.__key.name

    @property
    def settings(self):
        return

    @property
    def soundManager(self):
        return self.view.soundManager

    def isViewModal(self):
        return False

    def getAlias(self):
        return self.view.layoutID

    def setAlias(self, alias):
        raise SoftException('This method is not implemented')

    def getSubContainersSettings(self):
        return ()

    def getUniqueName(self):
        return self.__key.name

    def setUniqueName(self, name):
        raise SoftException('This method is not implemented')

    def getCurrentScope(self):
        return self.__scope

    def setCurrentScope(self, scope):
        self.__scope = scope

    def isLoaded(self):
        if self.__window is None:
            return False
        else:
            return self.__window.windowStatus == WindowStatus.LOADED

    def setView(self, view, parent=None):
        settings = WindowSettings()
        settings.content = view
        settings.parent = parent
        settings.layer = view.layer
        self.__key = ViewKey(view.layoutID, view.uniqueID)
        self.__window = Window(settings)
        self.__window.onStatusChanged += self.__onStatusChanged

    def loadView(self):
        if self.__loadID is not None:
            BigWorld.cancelCallback(self.__loadID)
            self.__loadID = None
        self.__loadID = BigWorld.callback(0.0, self.__startToLoad)
        return

    def destroy(self):
        if self.__loadID is not None:
            BigWorld.cancelCallback(self.__loadID)
            self.__loadID = None
        if self.__window is not None:
            self.__window.onStatusChanged -= self.__onStatusChanged
        super(ViewImplAdaptor, self).destroy()
        return

    def _destroy(self):
        if self.__window is not None:
            self.__window.destroy()
            self.__window = None
        return

    def __onStatusChanged(self, state):
        if state == WindowStatus.LOADED:
            self.create()
        elif state == WindowStatus.DESTROYED:
            self.destroy()

    def __startToLoad(self):
        self.__loadID = None
        if self.__window is None:
            raise SoftException('Window is not defined.')
        self.__window.load()
        return