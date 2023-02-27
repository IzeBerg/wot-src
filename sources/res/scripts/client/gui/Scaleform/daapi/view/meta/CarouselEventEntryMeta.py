from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class CarouselEventEntryMeta(InjectComponentAdaptor):

    def updateState(self):
        self._printOverrideError('updateState')