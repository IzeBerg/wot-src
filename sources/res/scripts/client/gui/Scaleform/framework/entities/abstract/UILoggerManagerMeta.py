from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class UILoggerManagerMeta(BaseDAAPIComponent):

    def onLog(self, feature, group, action, logLevel, params):
        self._printOverrideError('onLog')