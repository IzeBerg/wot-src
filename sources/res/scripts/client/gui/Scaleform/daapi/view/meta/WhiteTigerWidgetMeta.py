from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class WhiteTigerWidgetMeta(InjectComponentAdaptor):

    def setIsSmall(self, value):
        self._printOverrideError('setIsSmall')

    def as_setIsMouseEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsMouseEnabled(value)