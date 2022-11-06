from gui.Scaleform.framework.entities.View import View

class BCPrebattleHintsMeta(View):

    def as_setHintsVisibilityS(self, visible, hidden):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintsVisibility(visible, hidden)

    def as_setCrewCountS(self, count):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrewCount(count)