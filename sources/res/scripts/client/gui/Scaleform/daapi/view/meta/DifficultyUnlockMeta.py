from gui.Scaleform.framework.entities.View import View

class DifficultyUnlockMeta(View):

    def onCloseClick(self):
        self._printOverrideError('onCloseClick')

    def onDifficultyChangeClick(self):
        self._printOverrideError('onDifficultyChangeClick')

    def as_setDifficultyS(self, value, btnEnable=True):
        if self._isDAAPIInited():
            return self.flashObject.as_setDifficulty(value, btnEnable)

    def as_blurOtherWindowsS(self, layer):
        if self._isDAAPIInited():
            return self.flashObject.as_blurOtherWindows(layer)