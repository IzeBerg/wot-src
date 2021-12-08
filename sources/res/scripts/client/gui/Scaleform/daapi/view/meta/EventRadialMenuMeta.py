from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventRadialMenuMeta(BaseDAAPIComponent):

    def showHandCursor(self):
        self._printOverrideError('showHandCursor')

    def hideHandCursor(self):
        self._printOverrideError('hideHandCursor')

    def leaveRadialMode(self):
        self._printOverrideError('leaveRadialMode')

    def as_showWithNameS(self, radialState, offset, ratio, targetDisplayName):
        if self._isDAAPIInited():
            return self.flashObject.as_showWithName(radialState, offset, ratio, targetDisplayName)