from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBasesPanelMeta(BaseDAAPIComponent):

    def as_setBase1IDS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase1ID(id)

    def as_setBase2IDS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase2ID(id)

    def as_setBase1StateS(self, owningTeam, attackingTeam):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase1State(owningTeam, attackingTeam)

    def as_setBase2StateS(self, owningTeam, attackingTeam):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase2State(owningTeam, attackingTeam)

    def as_setBase1ProgressS(self, progress, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase1Progress(progress, time)

    def as_setBase2ProgressS(self, progress, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setBase2Progress(progress, time)

    def as_setVisibilityS(self, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisibility(vis)

    def as_setColorBlindS(self, isBlind):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorBlind(isBlind)