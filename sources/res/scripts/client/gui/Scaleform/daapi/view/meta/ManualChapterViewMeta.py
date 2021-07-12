from gui.Scaleform.framework.entities.View import View

class ManualChapterViewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def bootcampButtonClicked(self):
        self._printOverrideError('bootcampButtonClicked')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_showPageS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_showPage(index)