from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DualGunPanelMeta(BaseDAAPIComponent):

    def as_resetS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_reset()

    def as_setViewS(self, viewId):
        if self._isDAAPIInited():
            return self.flashObject.as_setView(viewId)

    def as_setVisibleS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(visible)

    def as_setPlaybackSpeedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlaybackSpeed(value)

    def as_updateActiveGunS(self, activeGunId, timeLeft, totalTime):
        if self._isDAAPIInited():
            return self.flashObject.as_updateActiveGun(activeGunId, timeLeft, totalTime)

    def as_readyForChargeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_readyForCharge()

    def as_setGunStateS(self, gunId, state, timeLeft, totalTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setGunState(gunId, state, timeLeft, totalTime)

    def as_startChargingS(self, timeLeft, totalTime):
        if self._isDAAPIInited():
            return self.flashObject.as_startCharging(timeLeft, totalTime)

    def as_cancelChargeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_cancelCharge()

    def as_disableChargeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_disableCharge()

    def as_setCooldownS(self, timeLeft):
        if self._isDAAPIInited():
            return self.flashObject.as_setCooldown(timeLeft)

    def as_setDualShotModeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_setDualShotMode()

    def as_collapsePanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_collapsePanel()

    def as_expandPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_expandPanel()

    def as_setReloadingTimeIncreasedS(self, hasNegativeEffect):
        if self._isDAAPIInited():
            return self.flashObject.as_setReloadingTimeIncreased(hasNegativeEffect)

    def as_updateTotalTimeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTotalTime(value)

    def as_setTimerVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerVisible(value)

    def as_setChangeGunTweenPropsS(self, duration, delay):
        if self._isDAAPIInited():
            return self.flashObject.as_setChangeGunTweenProps(duration, delay)