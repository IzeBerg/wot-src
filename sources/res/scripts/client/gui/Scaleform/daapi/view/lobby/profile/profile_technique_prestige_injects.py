from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.prestige.prestige_profile_technique_views import PrestigeProfileTechniqueView, PrestigeProfileTechniqueEmblemView
from gui.prb_control.entities.listener import IGlobalListener

class CommonPrestigeInject(InjectComponentAdaptor, IGlobalListener):

    def setDatabaseID(self, value):
        self._injectView.setDatabaseID(value)

    def setSelectedVehicleIntCD(self, value):
        self._injectView.setSelectedVehicleIntCD(value)

    def _makeInjectView(self):
        raise NotImplementedError


class ProfileTechniquePrestigeInject(CommonPrestigeInject):

    def _makeInjectView(self):
        return PrestigeProfileTechniqueView()


class ProfileTechniquePrestigeEmblemInject(CommonPrestigeInject):

    def _makeInjectView(self):
        return PrestigeProfileTechniqueEmblemView()