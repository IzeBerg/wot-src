from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class RtsMetaWidgetMeta(InjectComponentAdaptor):

    def as_setSparkVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSparkVisible(value)