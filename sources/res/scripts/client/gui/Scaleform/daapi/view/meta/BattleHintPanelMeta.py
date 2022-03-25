from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleHintPanelMeta(BaseDAAPIComponent):

    def onPlaySound(self, soundType):
        self._printOverrideError('onPlaySound')

    def onHideComplete(self):
        self._printOverrideError('onHideComplete')

    def as_setDataS(self, vKey, key, messageLeft, messageRight, offsetX, offsetY, reducedPanning):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(vKey, key, messageLeft, messageRight, offsetX, offsetY, reducedPanning)

    def as_toggleS(self, isShow):
        if self._isDAAPIInited():
            return self.flashObject.as_toggle(isShow)