from gui.Scaleform.framework.entities.View import View

class BattleRoyaleLevelUpViewMeta(View):

    def onIntroStartsPlaying(self):
        self._printOverrideError('onIntroStartsPlaying')

    def onRibbonStartsPlaying(self):
        self._printOverrideError('onRibbonStartsPlaying')

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)