from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.battle_results.simple_stats_parameter_model import SimpleStatsParameterModel

class DetailedStatsParameterModel(SimpleStatsParameterModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(DetailedStatsParameterModel, self).__init__(properties=properties, commands=commands)

    def getDetails(self):
        return self._getArray(3)

    def setDetails(self, value):
        self._setArray(3, value)

    @staticmethod
    def getDetailsType():
        return SimpleStatsParameterModel

    def _initialize(self):
        super(DetailedStatsParameterModel, self)._initialize()
        self._addArrayProperty('details', Array())