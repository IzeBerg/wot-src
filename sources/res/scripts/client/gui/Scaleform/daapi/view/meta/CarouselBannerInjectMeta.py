from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class CarouselBannerInjectMeta(InjectComponentAdaptor):

    def setIsExtended(self, value):
        self._printOverrideError('setIsExtended')