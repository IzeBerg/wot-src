from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class WTEventParamsWidgetMeta(InjectComponentAdaptor):

    def updateWidgetLayout(self, value):
        self._printOverrideError('updateWidgetLayout')

    def as_showWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showWidget()

    def as_hideWidgetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWidget()