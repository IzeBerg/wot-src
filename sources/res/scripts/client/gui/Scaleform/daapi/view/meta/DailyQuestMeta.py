from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DailyQuestMeta(BaseDAAPIComponent):

    def updateWidgetLayout(self, value):
        self._printOverrideError('updateWidgetLayout')

    def as_setEnabledS(self, isEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(isEnabled)