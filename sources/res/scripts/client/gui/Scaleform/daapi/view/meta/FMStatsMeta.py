from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class FMStatsMeta(BaseDAAPIComponent):

    def as_setSubTypeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSubType(value)