from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.MarathonEntryPointMeta import MarathonEntryPointMeta
from gui.impl.lobby.marathon.marathon_entry_point import MarathonEntryPoint as MarathonEntryPointView

class MarathonEntryPoint(MarathonEntryPointMeta):

    def _makeInjectView(self):
        self.__view = MarathonEntryPointView(ViewFlags.COMPONENT)
        return self.__view