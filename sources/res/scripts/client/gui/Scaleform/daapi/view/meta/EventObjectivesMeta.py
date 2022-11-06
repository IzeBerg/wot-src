from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventObjectivesMeta(BaseDAAPIComponent):

    def as_updateObjectivesS(self, txt):
        if self._isDAAPIInited():
            return self.flashObject.as_updateObjectives(txt)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()