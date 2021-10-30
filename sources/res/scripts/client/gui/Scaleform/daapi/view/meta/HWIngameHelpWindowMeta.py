from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class HWIngameHelpWindowMeta(AbstractWindowView):

    def clickSettingWindow(self):
        self._printOverrideError('clickSettingWindow')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setPaginatorDataS(self, pages):
        if self._isDAAPIInited():
            return self.flashObject.as_setPaginatorData(pages)