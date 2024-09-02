from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class Comp7ReconFlightMeta(BaseDAAPIComponent):

    def as_showS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_show()

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()