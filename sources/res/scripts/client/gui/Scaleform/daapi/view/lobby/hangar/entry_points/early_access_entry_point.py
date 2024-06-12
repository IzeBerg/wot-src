from gui.impl.lobby.early_access.early_access_entry_point_view import EarlyAccessEntryPointView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class EarlyAccessEntryPoint(InjectComponentAdaptor):

    def _makeInjectView(self):
        self.__view = EarlyAccessEntryPointView()
        return self.__view