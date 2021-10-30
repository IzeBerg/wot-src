from gui.Scaleform.daapi.view.meta.DAAPISimpleContainerMeta import DAAPISimpleContainerMeta

class WaitingTransitionMeta(DAAPISimpleContainerMeta):

    def as_setTransitionTextS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setTransitionText(text)

    def as_updateStageS(self, width, height, scale):
        if self._isDAAPIInited():
            return self.flashObject.as_updateStage(width, height, scale)

    def as_showBGS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showBG()

    def as_hideBGS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideBG()