from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RadarButtonMeta(BaseDAAPIComponent):

    def onClick(self):
        self._printOverrideError('onClick')

    def as_initS(self, keyCode, sfKeyCode, iconPath, tooltipText, isReplay):
        if self._isDAAPIInited():
            return self.flashObject.as_init(keyCode, sfKeyCode, iconPath, tooltipText, isReplay)

    def as_setCoolDownTimeS(self, duration, baseTime, startTime, animation):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownTime(duration, baseTime, startTime, animation)

    def as_updateEnableS(self, isEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEnable(isEnabled)

    def as_setCoolDownPosAsPercentS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownPosAsPercent(percent)

    def as_setCoolDownTimeSnapshotS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownTimeSnapshot(time)