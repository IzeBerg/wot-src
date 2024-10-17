from gui.Scaleform.daapi.view.meta.RocketAcceleratorIndicatorMeta import RocketAcceleratorIndicatorMeta

class NitroIndicatorMeta(RocketAcceleratorIndicatorMeta):

    def as_setKeyS(self, key):
        if self._isDAAPIInited():
            return self.flashObject.as_setKey(key)

    def as_setTooltipS(self, tooltip):
        if self._isDAAPIInited():
            return self.flashObject.as_setTooltip(tooltip)