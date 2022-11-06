from gui.Scaleform.framework.entities.View import View

class BCBattleResultMeta(View):

    def click(self):
        self._printOverrideError('click')

    def onAnimationAwardStart(self, id):
        self._printOverrideError('onAnimationAwardStart')

    def onToolTipShow(self, rendererId):
        self._printOverrideError('onToolTipShow')

    def onVideoButtonClick(self, index):
        self._printOverrideError('onVideoButtonClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)