from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class FunRandomNYHangarWidgetMeta(InjectComponentAdaptor):

    def as_updateHitAreaS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHitArea()