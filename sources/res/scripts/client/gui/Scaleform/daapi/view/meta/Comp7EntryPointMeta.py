from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class Comp7EntryPointMeta(InjectComponentAdaptor):

    def isSingle(self, value):
        self._printOverrideError('isSingle')