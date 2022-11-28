from gui.Scaleform.framework.entities.View import View

class NYMainViewMeta(View):

    def onEscPress(self):
        self._printOverrideError('onEscPress')

    def onSwitchView(self):
        self._printOverrideError('onSwitchView')

    def as_switchViewS(self, toInject):
        if self._isDAAPIInited():
            return self.flashObject.as_switchView(toInject)