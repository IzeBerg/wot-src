from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class WTBattleHintMeta(BaseDAAPIComponent):

    def as_showHintS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(data)

    def as_hideHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHint()