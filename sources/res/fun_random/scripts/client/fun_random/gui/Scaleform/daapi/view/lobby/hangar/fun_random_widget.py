from fun_random.gui.impl.lobby.feature.fun_random_hangar_widget_view import FunRandomHangarWidgetView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class FunRandomHangarWidgetComponent(InjectComponentAdaptor):

    def _makeInjectView(self):
        return FunRandomHangarWidgetView()