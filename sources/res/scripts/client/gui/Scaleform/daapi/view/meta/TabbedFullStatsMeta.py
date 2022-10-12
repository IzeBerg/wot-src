from gui.Scaleform.daapi.view.battle.shared.base_stats import StatsBase

class TabbedFullStatsMeta(StatsBase):

    def as_setActiveTabS(self, tabIndex):
        if self._isDAAPIInited():
            return self.flashObject.as_setActiveTab(tabIndex)

    def as_resetActiveTabS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetActiveTab()

    def as_updateTabsS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTabs(dataProvider)