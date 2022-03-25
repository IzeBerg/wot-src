from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.rts.warning_widget_view import WarningWidgetView

class RtsWarningWidget(InjectComponentAdaptor):

    def _makeInjectView(self):
        return WarningWidgetView()