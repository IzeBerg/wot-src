from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BaseStorageCategoryViewMeta(BaseDAAPIComponent):

    def setActiveState(self, isActive):
        self._printOverrideError('setActiveState')

    def playInfoSound(self):
        self._printOverrideError('playInfoSound')

    def scrolledToBottom(self):
        self._printOverrideError('scrolledToBottom')

    def as_showDummyScreenS(self, show):
        if self._isDAAPIInited():
            return self.flashObject.as_showDummyScreen(show)

    def as_showFilterWarningS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showFilterWarning(data)

    def as_getCardsDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getCardsDP()

    def as_scrollToItemS(self, itemIntCD):
        if self._isDAAPIInited():
            return self.flashObject.as_scrollToItem(itemIntCD)