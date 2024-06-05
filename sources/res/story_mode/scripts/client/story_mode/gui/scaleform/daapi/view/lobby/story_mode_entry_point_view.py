from story_mode.gui.impl.lobby.entry_point_view import EntryPointView
from story_mode.gui.scaleform.daapi.view.meta.StoryModeEntryPointMeta import StoryModeEntryPointMeta

class StoryModeEntryPointView(StoryModeEntryPointMeta):

    def _makeInjectView(self):
        self.__view = EntryPointView()
        return self.__view