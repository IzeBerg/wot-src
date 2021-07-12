from gui.Scaleform.framework.entities.View import View

class DemoPageMeta(View):

    def onButtonClicked(self, buttonID):
        self._printOverrideError('onButtonClicked')

    def as_setContentS(self, buttons):
        if self._isDAAPIInited():
            return self.flashObject.as_setContent(buttons)