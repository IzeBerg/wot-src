from gui.Scaleform.daapi.view.battle.shared.tabbed_full_stats import TabbedFullStatsComponent

class Comp7FullStatsMeta(TabbedFullStatsComponent):

    def onVoiceChatControlClick(self):
        self._printOverrideError('onVoiceChatControlClick')

    def as_setVoiceChatDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setVoiceChatData(data)

    def as_setVoiceChatControlVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVoiceChatControlVisible(value)

    def as_setVoiceChatControlSelectedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVoiceChatControlSelected(value)