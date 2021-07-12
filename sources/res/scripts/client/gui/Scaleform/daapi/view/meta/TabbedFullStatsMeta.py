from gui.Scaleform.daapi.view.battle.classic.base_stats import StatsBase

class TabbedFullStatsMeta(StatsBase):

    def onSelectQuest(self, questID):
        self._printOverrideError('onSelectQuest')

    def as_setActiveTabS(self, tabIndex):
        if self._isDAAPIInited():
            return self.flashObject.as_setActiveTab(tabIndex)

    def as_questProgressPerformS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_questProgressPerform(data)

    def as_resetActiveTabS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetActiveTab()

    def as_updateProgressTrackingS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgressTracking(data)

    def as_updateTabsS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTabs(dataProvider)