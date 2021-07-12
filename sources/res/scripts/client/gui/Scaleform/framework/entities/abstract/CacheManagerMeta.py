from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CacheManagerMeta(BaseDAAPIComponent):

    def getSettings(self):
        self._printOverrideError('getSettings')