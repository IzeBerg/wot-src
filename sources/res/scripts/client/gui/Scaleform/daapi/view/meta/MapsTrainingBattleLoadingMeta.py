from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MapsTrainingBattleLoadingMeta(BaseDAAPIComponent):

    def gotoBattle(self):
        self._printOverrideError('gotoBattle')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setDataPageS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDataPage(data)

    def as_updateProgressS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(percent)