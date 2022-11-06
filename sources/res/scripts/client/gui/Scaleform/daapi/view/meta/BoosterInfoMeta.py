from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class BoosterInfoMeta(AbstractWindowView):

    def onCancelClick(self):
        self._printOverrideError('onCancelClick')

    def as_setBoosterInfoS(self, moduleInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setBoosterInfo(moduleInfo)