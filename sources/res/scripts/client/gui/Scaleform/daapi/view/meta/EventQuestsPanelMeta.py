from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventQuestsPanelMeta(BaseDAAPIComponent):

    def onQuestPanelClick(self):
        self._printOverrideError('onQuestPanelClick')

    def as_setListDataProviderS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setListDataProvider(data)