from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class BattleTypeSelectorMeta(InjectComponentAdaptor):

    def startFirstShowAnimation(self):
        self._printOverrideError('startFirstShowAnimation')

    def startIdleAnimation(self):
        self._printOverrideError('startIdleAnimation')

    def setIsVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.setIsVisible(value)