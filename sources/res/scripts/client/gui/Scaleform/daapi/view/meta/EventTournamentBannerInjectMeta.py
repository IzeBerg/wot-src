from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class EventTournamentBannerInjectMeta(InjectComponentAdaptor):

    def setIsExtended(self, value):
        self._printOverrideError('setIsExtended')