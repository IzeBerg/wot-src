from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class LiveOpsWebEventsEntryPointInjectMeta(InjectComponentAdaptor):

    def as_setIsSmallS(self, isSmall):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsSmall(isSmall)