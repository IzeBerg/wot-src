from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MapsTrainingGoalsMeta(BaseDAAPIComponent):

    def as_updateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_update(data)

    def as_destroyGoalS(self, vehClass):
        if self._isDAAPIInited():
            return self.flashObject.as_destroyGoal(vehClass)

    def as_showHintS(self, hintType, description, time=None):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(hintType, description, time)

    def as_hideHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHint()

    def as_setVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(isVisible)