from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.battle.postmortem_panel.postmortem_panel_view import PostmortemPanelView

class PostmortemInfoPanel(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = PostmortemPanelView()
        return self.__view