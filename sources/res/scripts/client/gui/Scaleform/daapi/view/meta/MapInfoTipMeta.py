from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MapInfoTipMeta(BaseDAAPIComponent):

    def as_setEnabledS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(enabled)