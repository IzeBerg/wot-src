from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class WarningHintMeta(BaseDAAPIComponent):

    def as_showHintS(self, msg, iconPath):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(msg, iconPath)

    def as_hideHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHint()