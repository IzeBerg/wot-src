from gui.Scaleform.framework.entities.View import View

class ManualMainViewMeta(View):

    def onChapterOpenedS(self, id):
        self._printOverrideError('onChapterOpenedS')

    def closeView(self):
        self._printOverrideError('closeView')

    def as_setChaptersS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setChapters(data)

    def as_setPageBackgroundS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPageBackground(value)

    def as_showCloseBtnS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showCloseBtn(value)