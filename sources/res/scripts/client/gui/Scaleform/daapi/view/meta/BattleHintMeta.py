from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleHintMeta(BaseDAAPIComponent):

    def onFadeOutFinished(self):
        self._printOverrideError('onFadeOutFinished')

    def as_showHintS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(data)

    def as_hideHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHint()

    def as_cancelFadeOutS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_cancelFadeOut()