from gui.Scaleform.daapi.view.battle.shared.consumables_panel import ConsumablesPanel

class WTConsumablesPanelMeta(ConsumablesPanel):

    def as_setChargeProgressS(self, idx, charge, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setChargeProgress(idx, charge, isVisible)

    def as_setSelectedS(self, idx, isSelected):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelected(idx, isSelected)

    def as_setDebuffViewS(self, idx, isDebuffMode):
        if self._isDAAPIInited():
            return self.flashObject.as_setDebuffView(idx, isDebuffMode)