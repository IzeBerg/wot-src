from gui.Scaleform.framework.entities.View import View

class MissionsPageMeta(View):

    def resetFilters(self):
        self._printOverrideError('resetFilters')

    def onTabSelected(self, alias, prefix):
        self._printOverrideError('onTabSelected')

    def onClose(self):
        self._printOverrideError('onClose')

    def as_setTabsDataProviderS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_setTabsDataProvider(dataProvider)

    def as_showFilterS(self, visible, topShadowVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_showFilter(visible, topShadowVisible)

    def as_showFilterCounterS(self, countText, isFilterApplied):
        if self._isDAAPIInited():
            return self.flashObject.as_showFilterCounter(countText, isFilterApplied)

    def as_blinkFilterCounterS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_blinkFilterCounter()

    def as_setTabsCounterDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTabsCounterData(data)