from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.crew.tooltips.skills_by_role import SkillsByRole

class VehCmpSkillsTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(VehCmpSkillsTooltipModel, self).__init__(properties=properties, commands=commands)

    def getSkills(self):
        return self._getArray(0)

    def setSkills(self, value):
        self._setArray(0, value)

    @staticmethod
    def getSkillsType():
        return SkillsByRole

    def _initialize(self):
        super(VehCmpSkillsTooltipModel, self)._initialize()
        self._addArrayProperty('skills', Array())