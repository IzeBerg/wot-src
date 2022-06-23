from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class GoodieInfoMeta(AbstractWindowView):

    def onCancelClick(self):
        self._printOverrideError('onCancelClick')

    def as_setInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInfo(data)