from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class BattleRoyaleHangarWidgetContentMeta(InjectComponentAdaptor):

    def as_onWrapperInitializedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_onWrapperInitialized()