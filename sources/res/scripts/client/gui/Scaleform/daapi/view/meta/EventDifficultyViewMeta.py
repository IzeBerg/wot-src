from gui.Scaleform.framework.entities.View import View

class EventDifficultyViewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def selectDifficulty(self, idx):
        self._printOverrideError('selectDifficulty')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setProgressS(self, value, condition, level):
        if self._isDAAPIInited():
            return self.flashObject.as_setProgress(value, condition, level)