from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.rts.rts_submode_selector_view import RTSSubModeSelectorView

class RTSSubModeSelector(InjectComponentAdaptor):

    def _makeInjectView(self):
        return RTSSubModeSelectorView()