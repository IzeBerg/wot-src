from gui.Scaleform.framework.entities.View import View

class BattleMattersAnimLoaderViewMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def as_setAnimationS(self, alias):
        if self._isDAAPIInited():
            return self.flashObject.as_setAnimation(alias)