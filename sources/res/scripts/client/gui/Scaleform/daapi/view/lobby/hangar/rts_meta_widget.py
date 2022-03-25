from gui.impl.lobby.rts.meta_widget_view import MetaWidgetView
from gui.Scaleform.daapi.view.meta.RtsMetaWidgetMeta import RtsMetaWidgetMeta

class RTSMetaWidget(RtsMetaWidgetMeta):

    def _makeInjectView(self):
        return MetaWidgetView()

    def _addInjectContentListeners(self):
        super(RTSMetaWidget, self)._addInjectContentListeners()
        self.getInjectView().onNewElementChanged += self.__onNewElementChanged

    def _removeInjectContentListeners(self):
        super(RTSMetaWidget, self)._removeInjectContentListeners()
        self.getInjectView().onNewElementChanged -= self.__onNewElementChanged

    def __onNewElementChanged(self, hasNewElement):
        self.as_setSparkVisibleS(hasNewElement)