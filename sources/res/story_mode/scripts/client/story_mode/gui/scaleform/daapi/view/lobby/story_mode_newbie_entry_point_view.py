from story_mode.gui.impl.lobby.newbie_entry_point_view import NewbieEntryPointView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class StoryModeNewbieEntryPointView(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = NewbieEntryPointView()
        return self.__view