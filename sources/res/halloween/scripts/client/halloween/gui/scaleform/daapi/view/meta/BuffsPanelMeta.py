from gui.Scaleform.daapi.view.battle.shared.situation_indicators import SituationIndicators

class BuffsPanelMeta(SituationIndicators):

    def as_addBuffSlotS(self, id, imageName, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addBuffSlot(id, imageName, tooltipText)

    def as_removeBuffSlotS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBuffSlot(id)

    def as_setBuffEnabledS(self, id, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBuffEnabled(id, value)