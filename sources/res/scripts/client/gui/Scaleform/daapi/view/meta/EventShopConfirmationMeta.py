from gui.Scaleform.framework.entities.View import View

class EventShopConfirmationMeta(View):

    def onCancelClick(self):
        self._printOverrideError('onCancelClick')

    def onBuyClick(self):
        self._printOverrideError('onBuyClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)