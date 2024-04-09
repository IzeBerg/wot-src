from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DeathCamHudMeta(BaseDAAPIComponent):

    def onAnimationFinished(self):
        self._printOverrideError('onAnimationFinished')

    def as_setTextsS(self, cameraText, skipText):
        if self._isDAAPIInited():
            return self.flashObject.as_setTexts(cameraText, skipText)

    def as_showBarsS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showBars()

    def as_hideBarsS(self, isActive):
        if self._isDAAPIInited():
            return self.flashObject.as_hideBars(isActive)