from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewBottomPanelOfferGiftMeta(BaseDAAPIComponent):

    def onBuyClick(self):
        self._printOverrideError('onBuyClick')

    def showTooltip(self, intCD, itemType):
        self._printOverrideError('showTooltip')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setSetItemsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSetItemsData(data)