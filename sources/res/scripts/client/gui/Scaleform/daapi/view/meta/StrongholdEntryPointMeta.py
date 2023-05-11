from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class StrongholdEntryPointMeta(InjectComponentAdaptor):

    def isSingle(self, value):
        self._printOverrideError('isSingle')