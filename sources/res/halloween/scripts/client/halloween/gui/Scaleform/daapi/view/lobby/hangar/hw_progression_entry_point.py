from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from halloween.gui.impl.lobby.witches_view import WitchesView

class HW22ProgressionEntryPoint(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = WitchesView()
        return self.__view