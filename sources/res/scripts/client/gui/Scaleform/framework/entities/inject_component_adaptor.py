import logging
from frameworks.wulf import WindowSettings, Window, WindowStatus, WindowLayer
from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent
_logger = logging.getLogger(__name__)

class InjectComponentAdaptor(BaseDAAPIComponent):
    __slots__ = ('__injected', )

    @property
    def _injectView(self):
        if self.__injected:
            return self.__injected.content
        else:
            return

    def __init__(self):
        super(InjectComponentAdaptor, self).__init__()
        self.__injected = None
        return

    @property
    def injectView(self):
        return self.__injectView

    def registerFlashComponent(self, component, alias, *args):
        _logger.warning('InjectComponentAdaptor %s does not support internal components', self.getAlias())

    def isFlashComponentRegistered(self, alias):
        return False

    def unregisterFlashComponent(self, alias):
        _logger.warning('InjectComponentAdaptor %s does not support internal components', self.getAlias())

    def getInjectView(self):
        if self.__injected:
            return self.__injected.content
        else:
            return

    def _populate(self):
        super(InjectComponentAdaptor, self)._populate()
        self._onPopulate()

    def _onPopulate(self):
        self._createInjectView()

    def _dispose(self):
        self._destroyInjected()
        super(InjectComponentAdaptor, self)._dispose()

    def _makeInjectView(self):
        raise NotImplementedError

    def _addInjectContentListeners(self):
        pass

    def _removeInjectContentListeners(self):
        pass

    def _createInjectView(self):
        if self.__injected is not None:
            _logger.error('Inject view %r is already created in component %s', self.__injected.content, self.getAlias())
            return
        else:
            view = self._makeInjectView()
            settings = WindowSettings()
            settings.content = view
            self.__injected = InjectWindow(settings)
            self.__injected.onStatusChanged += self.__onStatusChanged
            self.__injected.load()
            self._addInjectContentListeners()
            return

    def _destroyInjected(self, wasAdded=True):
        if self.__injected is None:
            return
        else:
            if wasAdded and self.flashObject is not None:
                self.flashObject.removeViewImpl(self.__injected.content.uniqueID)
            self.__injected.onStatusChanged -= self.__onStatusChanged
            self._removeInjectContentListeners()
            self.__injected.destroy()
            self.__injected = None
            return

    def __addInjectView(self):
        if self.flashObject is not None:
            if not self.flashObject.addViewImpl(self.__injected.content.uniqueID):
                _logger.error('Inject view can not be added to component %s', self.getAlias())
                self._destroyInjected(wasAdded=False)
        else:
            _logger.error('GFxValue is not created for %s', self.getAlias())
        return

    def __onStatusChanged(self, state):
        if state == WindowStatus.LOADED:
            self.__addInjectView()
        elif state == WindowStatus.DESTROYING:
            self._destroyInjected()


class InjectWindow(Window):

    @property
    def layer(self):
        return WindowLayer.UNDEFINED