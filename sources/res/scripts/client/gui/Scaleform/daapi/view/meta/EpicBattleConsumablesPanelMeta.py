from gui.Scaleform.daapi.view.meta.ConsumablesPanelMeta import ConsumablesPanelMeta

class EpicBattleConsumablesPanelMeta(ConsumablesPanelMeta):

    def as_addEpicBattleEquipmentSlotS(self, idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, isTooltipSpecial, tooltipText, animation):
        if self._isDAAPIInited():
            return self.flashObject.as_addEpicBattleEquipmentSlot(idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, isTooltipSpecial, tooltipText, animation)

    def as_updateLockedInformationS(self, idx, lockedID, tooltipStr, isSlotEmpty):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLockedInformation(idx, lockedID, tooltipStr, isSlotEmpty)

    def as_updateLevelInformationS(self, idx, level):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLevelInformation(idx, level)

    def as_showPossibleStacksS(self, idx, stack):
        if self._isDAAPIInited():
            return self.flashObject.as_showPossibleStacks(idx, stack)

    def as_updateStacksS(self, idx, stack):
        if self._isDAAPIInited():
            return self.flashObject.as_updateStacks(idx, stack)