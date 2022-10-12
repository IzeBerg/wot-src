from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class FunRandomHangarWidgetMeta(InjectComponentAdaptor):

    def as_setModifiersCountS(self, count):
        if self._isDAAPIInited():
            return self.flashObject.as_setModifiersCount(count)