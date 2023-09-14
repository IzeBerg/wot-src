from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class AnimatedBattleHintMeta(BaseDAAPIComponent):

    def animFinish(self):
        self._printOverrideError('animFinish')

    def as_showHintS(self, frame, msgStr, isCompleted):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(frame, msgStr, isCompleted)

    def as_hideHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHint()

    def as_closeHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_closeHint()

    def as_setPenetrationS(self, penetrationType, isPurple):
        if self._isDAAPIInited():
            return self.flashObject.as_setPenetration(penetrationType, isPurple)