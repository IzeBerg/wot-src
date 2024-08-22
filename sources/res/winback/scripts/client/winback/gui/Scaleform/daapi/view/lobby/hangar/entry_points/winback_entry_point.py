from frameworks.wulf import ViewFlags
from winback.gui.impl.lobby.views.winback_widget_view import WinbackWidgetView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class WinbackEntryPointWidget(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = WinbackWidgetView(ViewFlags.VIEW)
        return self.__view