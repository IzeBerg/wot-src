from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class DemountKitInfoMeta(AbstractWindowView):

    def onCancelClick(self):
        self._printOverrideError('onCancelClick')

    def as_setDemountKitInfoS(self, demountKitInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setDemountKitInfo(demountKitInfo)