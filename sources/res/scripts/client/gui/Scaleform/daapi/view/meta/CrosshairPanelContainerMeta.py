from gui.Scaleform.daapi.view.meta.DAAPISimpleContainerMeta import DAAPISimpleContainerMeta

class CrosshairPanelContainerMeta(DAAPISimpleContainerMeta):

    def as_playSound(self, value):
        self._printOverrideError('as_playSound')

    def as_setSettingsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSettings(data)

    def as_setScaleS(self, scale):
        if self._isDAAPIInited():
            return self.flashObject.as_setScale(scale)

    def as_setViewS(self, viewId, settingId):
        if self._isDAAPIInited():
            return self.flashObject.as_setView(viewId, settingId)

    def as_recreateDeviceS(self, offsetX, offsetY):
        if self._isDAAPIInited():
            return self.flashObject.as_recreateDevice(offsetX, offsetY)

    def as_setReloadingCounterShownS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setReloadingCounterShown(visible)

    def as_setReloadingS(self, duration, baseTime, startTime, isReloading):
        if self._isDAAPIInited():
            return self.flashObject.as_setReloading(duration, baseTime, startTime, isReloading)

    def as_setReloadingAsPercentS(self, percent, isReloading):
        if self._isDAAPIInited():
            return self.flashObject.as_setReloadingAsPercent(percent, isReloading)

    def as_setBoostAsPercentS(self, percent, duration):
        if self._isDAAPIInited():
            return self.flashObject.as_setBoostAsPercent(percent, duration)

    def as_setHealthS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setHealth(percent)

    def as_setAmmoStockS(self, quantity, quantityInClip, clipState, clipReloaded=False):
        if self._isDAAPIInited():
            return self.flashObject.as_setAmmoStock(quantity, quantityInClip, clipState, clipReloaded)

    def as_setClipParamsS(self, clipCapacity, burst, isAutoloader=False):
        if self._isDAAPIInited():
            return self.flashObject.as_setClipParams(clipCapacity, burst, isAutoloader)

    def as_setDistanceS(self, dist):
        if self._isDAAPIInited():
            return self.flashObject.as_setDistance(dist)

    def as_clearDistanceS(self, immediate):
        if self._isDAAPIInited():
            return self.flashObject.as_clearDistance(immediate)

    def as_updatePlayerInfoS(self, info):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePlayerInfo(info)

    def as_updateAmmoStateS(self, ammoState):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAmmoState(ammoState)

    def as_setZoomS(self, zoomStr):
        if self._isDAAPIInited():
            return self.flashObject.as_setZoom(zoomStr)

    def as_createGunMarkerS(self, viewID, linkage, name):
        if self._isDAAPIInited():
            return self.flashObject.as_createGunMarker(viewID, linkage, name)

    def as_destroyGunMarkerS(self, name):
        if self._isDAAPIInited():
            return self.flashObject.as_destroyGunMarker(name)

    def as_setGunMarkerColorS(self, name, colorName):
        if self._isDAAPIInited():
            return self.flashObject.as_setGunMarkerColor(name, colorName)

    def as_setNetVisibleS(self, mask):
        if self._isDAAPIInited():
            return self.flashObject.as_setNetVisible(mask)

    def as_setNetSeparatorVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setNetSeparatorVisible(isVisible)

    def as_setNetTypeS(self, netType):
        if self._isDAAPIInited():
            return self.flashObject.as_setNetType(netType)

    def as_autoloaderUpdateS(self, timeLeft, baseTime, isPause=False, isStun=False, isTimerOn=False, isRedText=False):
        if self._isDAAPIInited():
            return self.flashObject.as_autoloaderUpdate(timeLeft, baseTime, isPause, isStun, isTimerOn, isRedText)

    def as_setAutoloaderReloadingS(self, duration, baseTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoloaderReloading(duration, baseTime)

    def as_showBoostS(self, duration, baseTime):
        if self._isDAAPIInited():
            return self.flashObject.as_showBoost(duration, baseTime)

    def as_hideBoostS(self, showAnimation):
        if self._isDAAPIInited():
            return self.flashObject.as_hideBoost(showAnimation)

    def as_showShotS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showShot()

    def as_setAutoloaderReloadasPercentS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoloaderReloadasPercent(percent)

    def as_setAutoloaderPercentS(self, percent, sec, isTimerOn, isTimerRed):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoloaderPercent(percent, sec, isTimerOn, isTimerRed)

    def as_setSpeedModeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSpeedMode(value)

    def as_updateSpeedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSpeed(value)

    def as_updateBurnoutS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBurnout(value)

    def as_addSpeedometerS(self, maxSpeedNormalMode, maxSpeedSpeedMode):
        if self._isDAAPIInited():
            return self.flashObject.as_addSpeedometer(maxSpeedNormalMode, maxSpeedSpeedMode)

    def as_removeSpeedometerS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeSpeedometer()

    def as_setBurnoutWarningS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBurnoutWarning(value)

    def as_stopBurnoutWarningS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_stopBurnoutWarning()

    def as_setEngineCrushErrorS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setEngineCrushError(value)

    def as_stopEngineCrushErrorS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_stopEngineCrushError()

    def as_startDualGunChargingS(self, timeLeft, totalTime):
        if self._isDAAPIInited():
            return self.flashObject.as_startDualGunCharging(timeLeft, totalTime)

    def as_cancelDualGunChargeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_cancelDualGunCharge()

    def as_updateDualGunMarkerStateS(self, markerState):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDualGunMarkerState(markerState)

    def as_runCameraTransitionFxS(self, activeGunId, animationDuration):
        if self._isDAAPIInited():
            return self.flashObject.as_runCameraTransitionFx(activeGunId, animationDuration)

    def as_updateScaleWidgetS(self, positionValue):
        if self._isDAAPIInited():
            return self.flashObject.as_updateScaleWidget(positionValue)

    def as_updateScaleStepsS(self, count):
        if self._isDAAPIInited():
            return self.flashObject.as_updateScaleSteps(count)

    def as_setGunMarkersIndicatorsS(self, indicators):
        if self._isDAAPIInited():
            return self.flashObject.as_setGunMarkersIndicators(indicators)

    def as_setShotFlyTimesS(self, shotFlyTimes):
        if self._isDAAPIInited():
            return self.flashObject.as_setShotFlyTimes(shotFlyTimes)

    def as_setShellChangeTimeS(self, quickChangerIsActive, shellChangeTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setShellChangeTime(quickChangerIsActive, shellChangeTime)

    def as_isFadedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_isFaded(value)

    def as_blinkReloadTimeS(self, blinkType):
        if self._isDAAPIInited():
            return self.flashObject.as_blinkReloadTime(blinkType)

    def as_setDualAccActiveS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setDualAccActive(value)

    def as_setOverheatProgressS(self, value, isOverheated):
        if self._isDAAPIInited():
            return self.flashObject.as_setOverheatProgress(value, isOverheated)

    def as_addOverheatS(self, overheatMark):
        if self._isDAAPIInited():
            return self.flashObject.as_addOverheat(overheatMark)

    def as_removeOverheatS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeOverheat()

    def as_showPlasmaIndicatorS(self, plasmaValue, isPlasmaChanged, plasmaMultiplicatorText):
        if self._isDAAPIInited():
            return self.flashObject.as_showPlasmaIndicator(plasmaValue, isPlasmaChanged, plasmaMultiplicatorText)

    def as_showExplosiveShotIndicatorS(self, isActive):
        if self._isDAAPIInited():
            return self.flashObject.as_showExplosiveShotIndicator(isActive)