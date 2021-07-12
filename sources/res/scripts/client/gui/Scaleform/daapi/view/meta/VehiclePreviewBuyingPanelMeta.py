from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewBuyingPanelMeta(BaseDAAPIComponent):

    def onBuyOrResearchClick(self):
        self._printOverrideError('onBuyOrResearchClick')

    def onCarouselVehicleSelected(self, intCD):
        self._printOverrideError('onCarouselVehicleSelected')

    def onOfferSelected(self, offerID):
        self._printOverrideError('onOfferSelected')

    def showTooltip(self, intCD, itemType):
        self._printOverrideError('showTooltip')

    def updateData(self, useCompactData):
        self._printOverrideError('updateData')

    def onCouponSelected(self, isActive):
        self._printOverrideError('onCouponSelected')

    def as_setBuyDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBuyData(data)

    def as_setSetItemsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSetItemsData(data)

    def as_setCouponS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoupon(data)

    def as_setSetVehiclesDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSetVehiclesData(data)

    def as_setOffersDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setOffersData(data)

    def as_setSetTitleTooltipS(self, tooltip):
        if self._isDAAPIInited():
            return self.flashObject.as_setSetTitleTooltip(tooltip)

    def as_updateLeftTimeS(self, formattedTime, hasHoursAndMinutes=False):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLeftTime(formattedTime, hasHoursAndMinutes)