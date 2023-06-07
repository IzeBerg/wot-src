from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class SkillDropForFreeMeta(AbstractWindowView):

    def dropSkills(self):
        self._printOverrideError('dropSkills')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)