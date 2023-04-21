from armory_yard.gui.impl.lobby.feature.armory_yard_entry_point_view import ArmoryYardEntryPointView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class ArmoryYardEntryPoint(InjectComponentAdaptor):

    def _makeInjectView(self):
        return ArmoryYardEntryPointView()