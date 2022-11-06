from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class FragPanelMeta(BaseDAAPIComponent):

    def as_setLeftFieldS(self, info):
        if self._isDAAPIInited():
            return self.flashObject.as_setLeftField(info)

    def as_setRightFieldS(self, info):
        if self._isDAAPIInited():
            return self.flashObject.as_setRightField(info)