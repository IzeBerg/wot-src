from gui.Scaleform.daapi.view.battle.shared.consumables_panel import ConsumablesPanel

class ConsumablesPanelMeta(ConsumablesPanel):

    def as_setShellInfinityS(self, idx, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setShellInfinity(idx, value)

    def as_addAbilitySlotS(self, idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addAbilitySlot(idx, keyCode, sfKeyCode, quantity, timeRemaining, reloadingTime, iconPath, tooltipText)

    def as_updateAbilityS(self, idx, stage, count, timeRemaining, maxTime):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAbility(idx, stage, count, timeRemaining, maxTime)

    def as_addPassiveAbilitySlotS(self, idx, iconPath, state, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addPassiveAbilitySlot(idx, iconPath, state, tooltipText)

    def as_updatePassiveAbilityS(self, idx, iconPath, state, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePassiveAbility(idx, iconPath, state, tooltipText)

    def as_resetPassiveAbilitiesS(self, slots=None):
        if self._isDAAPIInited():
            return self.flashObject.as_resetPassiveAbilities(slots)