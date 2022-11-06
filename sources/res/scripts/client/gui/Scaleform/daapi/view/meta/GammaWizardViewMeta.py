from gui.Scaleform.framework.entities.View import View

class GammaWizardViewMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onApply(self):
        self._printOverrideError('onApply')

    def onChangeGamma(self, value):
        self._printOverrideError('onChangeGamma')

    def onReset(self):
        self._printOverrideError('onReset')

    def updateTexture(self, x, y, size):
        self._printOverrideError('updateTexture')

    def as_initDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initData(data)