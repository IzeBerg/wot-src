from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class Comp7TournamentBannerInjectMeta(InjectComponentAdaptor):

    def setIsExtended(self, value):
        self._printOverrideError('setIsExtended')