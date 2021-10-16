from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class YHAEntrancePointWidgetMeta(InjectComponentAdaptor):

    def setIsSmall(self, value):
        self._printOverrideError('setIsSmall')