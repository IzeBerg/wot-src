from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RadialMenuMeta(BaseDAAPIComponent):

    def onSelect(self):
        self._printOverrideError('onSelect')

    def onAction(self, action):
        self._printOverrideError('onAction')

    def onHideCompleted(self):
        self._printOverrideError('onHideCompleted')

    def as_buildDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_buildData(data)

    def as_showS(self, cursorX, cursorY, radialState, replyStateDiff, offset):
        if self._isDAAPIInited():
            return self.flashObject.as_show(cursorX, cursorY, radialState, replyStateDiff, offset)

    def as_hideS(self, allowAction):
        if self._isDAAPIInited():
            return self.flashObject.as_hide(allowAction)