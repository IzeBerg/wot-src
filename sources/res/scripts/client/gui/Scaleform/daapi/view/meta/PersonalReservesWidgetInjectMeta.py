from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class PersonalReservesWidgetInjectMeta(InjectComponentAdaptor):

    def as_setTargetWidthS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTargetWidth(value)