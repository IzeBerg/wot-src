from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class IngameDetailsHelpWindowMeta(AbstractWindowView):

    def requestPageData(self, index):
        self._printOverrideError('requestPageData')

    def as_setPaginatorDataS(self, pages):
        if self._isDAAPIInited():
            return self.flashObject.as_setPaginatorData(pages)

    def as_setPageDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setPageData(data)