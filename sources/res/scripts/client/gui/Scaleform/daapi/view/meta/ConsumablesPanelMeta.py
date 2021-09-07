from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ConsumablesPanelMeta(BaseDAAPIComponent):

    def onClickedToSlot(self, keyCode, idx):
        self._printOverrideError('onClickedToSlot')

    def onPopUpClosed(self):
        self._printOverrideError('onPopUpClosed')

    def as_setKeysToSlotsS(self, slots):
        if self._isDAAPIInited():
            return self.flashObject.as_setKeysToSlots(slots)

    def as_setItemQuantityInSlotS(self, idx, quantity):
        if self._isDAAPIInited():
            return self.flashObject.as_setItemQuantityInSlot(idx, quantity)

    def as_setItemTimeQuantityInSlotS(self, idx, quantity, timeRemaining, maxTime, animation):
        if self._isDAAPIInited():
            return self.flashObject.as_setItemTimeQuantityInSlot(idx, quantity, timeRemaining, maxTime, animation)

    def as_setCoolDownTimeS(self, idx, duration, baseTime, startTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownTime(idx, duration, baseTime, startTime)

    def as_setCoolDownPosAsPercentS(self, idx, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownPosAsPercent(idx, percent)

    def as_setCoolDownTimeSnapshotS(self, idx, time, isBaseTime, isFlash):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownTimeSnapshot(idx, time, isBaseTime, isFlash)

    def as_addShellSlotS(self, idx, keyCode, sfKeyCode, quantity, clipCapacity, shellIconPath, noShellIconPath, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addShellSlot(idx, keyCode, sfKeyCode, quantity, clipCapacity, shellIconPath, noShellIconPath, tooltipText)

    def as_setNextShellS(self, idx):
        if self._isDAAPIInited():
            return self.flashObject.as_setNextShell(idx)

    def as_setCurrentShellS(self, idx):
        if self._isDAAPIInited():
            return self.flashObject.as_setCurrentShell(idx)

    def as_addEquipmentSlotS(self, idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, tooltipText, animation):
        if self._isDAAPIInited():
            return self.flashObject.as_addEquipmentSlot(idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, tooltipText, animation)

    def as_showEquipmentSlotsS(self, show):
        if self._isDAAPIInited():
            return self.flashObject.as_showEquipmentSlots(show)

    def as_expandEquipmentSlotS(self, idx, slots):
        if self._isDAAPIInited():
            return self.flashObject.as_expandEquipmentSlot(idx, slots)

    def as_collapseEquipmentSlotS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_collapseEquipmentSlot()

    def as_updateLockedInformationS(self, idx, lockedID, tooltipStr):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLockedInformation(idx, lockedID, tooltipStr)

    def as_updateLevelInformationS(self, idx, level):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLevelInformation(idx, level)

    def as_addOptionalDeviceSlotS(self, idx, timeRemaining, iconPath, tooltipText, isTooltipSpecial, intCD, isUsed):
        if self._isDAAPIInited():
            return self.flashObject.as_addOptionalDeviceSlot(idx, timeRemaining, iconPath, tooltipText, isTooltipSpecial, intCD, isUsed)

    def as_setOptionalDeviceUsedS(self, idx, isUsed):
        if self._isDAAPIInited():
            return self.flashObject.as_setOptionalDeviceUsed(idx, isUsed)

    def as_setGlowS(self, idx, glowID):
        if self._isDAAPIInited():
            return self.flashObject.as_setGlow(idx, glowID)

    def as_hideGlowS(self, idx):
        if self._isDAAPIInited():
            return self.flashObject.as_hideGlow(idx)

    def as_setEquipmentActivatedS(self, idx, isActivated):
        if self._isDAAPIInited():
            return self.flashObject.as_setEquipmentActivated(idx, isActivated)

    def as_handleAsReplayS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_handleAsReplay()

    def as_isVisibleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_isVisible()

    def as_resetS(self, slots=None):
        if self._isDAAPIInited():
            return self.flashObject.as_reset(slots)

    def as_updateEntityStateS(self, entityName, entityState):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEntityState(entityName, entityState)

    def as_setPanelSettingsS(self, settingsId):
        if self._isDAAPIInited():
            return self.flashObject.as_setPanelSettings(settingsId)

    def as_setSPGShotResultS(self, shellIdx, shotResult):
        if self._isDAAPIInited():
            return self.flashObject.as_setSPGShotResult(shellIdx, shotResult)