from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CorrodingShotIndicatorMeta(BaseDAAPIComponent):

    def as_showS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_show()

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()

    def as_updateLayoutS(self, x, y):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLayout(x, y)