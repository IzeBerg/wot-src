from gui.Scaleform.daapi.view.lobby.rally.AbstractRallyView import AbstractRallyView

class BaseRallyViewMeta(AbstractRallyView):

    def as_setCoolDownS(self, value, requestId):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDown(value, requestId)