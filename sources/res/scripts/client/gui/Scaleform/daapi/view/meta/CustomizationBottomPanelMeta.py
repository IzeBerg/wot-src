from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CustomizationBottomPanelMeta(BaseDAAPIComponent):

    def resetFilter(self):
        self._printOverrideError('resetFilter')

    def showBuyWindow(self):
        self._printOverrideError('showBuyWindow')

    def refreshFilterData(self):
        self._printOverrideError('refreshFilterData')

    def onSelectItem(self, index, intCD, progressionLevel):
        self._printOverrideError('onSelectItem')

    def onEditItem(self, intCD):
        self._printOverrideError('onEditItem')

    def showGroupFromTab(self, groupId):
        self._printOverrideError('showGroupFromTab')

    def onSelectHotFilter(self, index, value):
        self._printOverrideError('onSelectHotFilter')

    def switchMode(self, index):
        self._printOverrideError('switchMode')

    def returnToStyledMode(self):
        self._printOverrideError('returnToStyledMode')

    def as_showBillS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showBill()

    def as_hideBillS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideBill()

    def as_setBottomPanelInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBottomPanelInitData(data)

    def as_setSwitchersDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSwitchersData(data)

    def as_setBottomPanelTabsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBottomPanelTabsData(data)

    def as_setBottomPanelTabsPlusesS(self, pluses):
        if self._isDAAPIInited():
            return self.flashObject.as_setBottomPanelTabsPluses(pluses)

    def as_setCarouselDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCarouselData(data)

    def as_setCarouselInfoLabelDataS(self, text, tooltip):
        if self._isDAAPIInited():
            return self.flashObject.as_setCarouselInfoLabelData(text, tooltip)

    def as_setFilterDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setFilterData(data)

    def as_setBottomPanelPriceStateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBottomPanelPriceState(data)

    def as_setCarouselFiltersDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCarouselFiltersData(data)

    def as_setProjectionDecalHintVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setProjectionDecalHintVisibility(value)

    def as_setEditableStyleHintVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setEditableStyleHintVisibility(value)

    def as_setEditableProgressionRequiredStyleHintVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setEditableProgressionRequiredStyleHintVisibility(value)

    def as_showPopoverBtnIconS(self, src, tooltip):
        if self._isDAAPIInited():
            return self.flashObject.as_showPopoverBtnIcon(src, tooltip)

    def as_getDataProviderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDataProvider()

    def as_setItemsPopoverBtnEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setItemsPopoverBtnEnabled(value)

    def as_setNotificationCountersS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setNotificationCounters(data)

    def as_scrollToSlotS(self, intCD, immediately=False):
        if self._isDAAPIInited():
            return self.flashObject.as_scrollToSlot(intCD, immediately)

    def as_playFilterBlinkS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_playFilterBlink()

    def as_carouselFilterMessageS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_carouselFilterMessage(value)

    def as_setStageSwitcherVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setStageSwitcherVisibility(value)