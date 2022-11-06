from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventEntryPointsContainerMeta(BaseDAAPIComponent):

    def as_updateEntriesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEntries(data)