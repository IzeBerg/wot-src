from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleDamageLogPanelMeta(BaseDAAPIComponent):

    def as_setSettingsDamageLogComponentS(self, isVisible, isColorBlind):
        if self._isDAAPIInited():
            return self.flashObject.as_setSettingsDamageLogComponent(isVisible, isColorBlind)

    def as_summaryStatsS(self, damage, blocked, assist, stun, supplyDamage, showSumIcon):
        if self._isDAAPIInited():
            return self.flashObject.as_summaryStats(damage, blocked, assist, stun, supplyDamage, showSumIcon)

    def as_updateSummaryDamageValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSummaryDamageValue(value)

    def as_updateSummaryBlockedValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSummaryBlockedValue(value)

    def as_updateSummaryAssistValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSummaryAssistValue(value)

    def as_updateSummaryStunValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSummaryStunValue(value)

    def as_updateSummarySupplyDamageValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSummarySupplyDamageValue(value)

    def as_detailStatsTopS(self, isVisible, isShortMode, messages):
        if self._isDAAPIInited():
            return self.flashObject.as_detailStatsTop(isVisible, isShortMode, messages)

    def as_addDetailMessageTopS(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
        if self._isDAAPIInited():
            return self.flashObject.as_addDetailMessageTop(value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)

    def as_detailStatsBottomS(self, isVisible, isShortMode, messages):
        if self._isDAAPIInited():
            return self.flashObject.as_detailStatsBottom(isVisible, isShortMode, messages)

    def as_addDetailMessageBottomS(self, value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG):
        if self._isDAAPIInited():
            return self.flashObject.as_addDetailMessageBottom(value, actionTypeImg, vehicleTypeImg, vehicleName, shellTypeStr, shellTypeBG)

    def as_isDownCtrlButtonS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_isDownCtrlButton(value)

    def as_isDownAltButtonS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_isDownAltButton(value)