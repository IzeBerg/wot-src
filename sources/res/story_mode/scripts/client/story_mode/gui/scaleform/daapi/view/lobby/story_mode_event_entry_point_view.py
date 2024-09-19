from story_mode.gui.impl.lobby.event_entry_point_view import EventEntryPointView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class StoryModeEventEntryPointView(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = EventEntryPointView()
        return self.__view