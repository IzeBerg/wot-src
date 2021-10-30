from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class StorageCategoryStorageViewMeta(BaseDAAPIComponent):

    def setActiveState(self, isActive):
        self._printOverrideError('setActiveState')

    def onOpenTab(self, index):
        self._printOverrideError('onOpenTab')

    def as_setTabsDataS(self, tabs):
        if self._isDAAPIInited():
            return self.flashObject.as_setTabsData(tabs)

    def as_setTabCounterS(self, sectionIdx, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTabCounter(sectionIdx, value)