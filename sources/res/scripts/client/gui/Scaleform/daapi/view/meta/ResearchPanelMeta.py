from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ResearchPanelMeta(BaseDAAPIComponent):

    def goToResearch(self):
        self._printOverrideError('goToResearch')

    def goToPostProgression(self):
        self._printOverrideError('goToPostProgression')

    def addVehToCompare(self):
        self._printOverrideError('addVehToCompare')

    def as_updateCurrentVehicleS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCurrentVehicle(data)

    def as_setEarnedXPS(self, earnedXP):
        if self._isDAAPIInited():
            return self.flashObject.as_setEarnedXP(earnedXP)

    def as_setEliteS(self, isElite):
        if self._isDAAPIInited():
            return self.flashObject.as_setElite(isElite)

    def as_setIGRLabelS(self, visible, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIGRLabel(visible, value)

    def as_actionIGRDaysLeftS(self, visible, value):
        if self._isDAAPIInited():
            return self.flashObject.as_actionIGRDaysLeft(visible, value)

    def as_setNavigationEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setNavigationEnabled(value)