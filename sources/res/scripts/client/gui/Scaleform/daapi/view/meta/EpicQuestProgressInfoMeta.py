from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicQuestProgressInfoMeta(BaseDAAPIComponent):

    def showQuestById(self, id, eventType):
        self._printOverrideError('showQuestById')

    def as_updateDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateData(data)