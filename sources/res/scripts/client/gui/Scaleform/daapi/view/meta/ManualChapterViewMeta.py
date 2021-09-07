from gui.Scaleform.framework.entities.View import View

class ManualChapterViewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def pageButtonClicked(self, pageType):
        self._printOverrideError('pageButtonClicked')

    def bootcampHighlighted(self):
        self._printOverrideError('bootcampHighlighted')

    def onPreviewClicked(self, videoUrl):
        self._printOverrideError('onPreviewClicked')

    def onPageChanged(self, id):
        self._printOverrideError('onPageChanged')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setPagesS(self, pages):
        if self._isDAAPIInited():
            return self.flashObject.as_setPages(pages)

    def as_showPageS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_showPage(index)