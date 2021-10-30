from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RoleDescriptionMeta(BaseDAAPIComponent):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(isVisible)