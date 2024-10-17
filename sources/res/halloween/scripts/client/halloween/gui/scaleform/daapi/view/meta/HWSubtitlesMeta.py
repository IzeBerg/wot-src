from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HWSubtitlesMeta(BaseDAAPIComponent):

    def as_showS(self, message):
        if self._isDAAPIInited():
            return self.flashObject.as_show(message)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()