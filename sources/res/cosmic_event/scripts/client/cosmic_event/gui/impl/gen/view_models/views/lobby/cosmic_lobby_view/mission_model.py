from frameworks.wulf import Array
from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
from gui.impl.gen.view_models.views.lobby.missions.widget.widget_quest_model import WidgetQuestModel

class MissionModel(WidgetQuestModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(MissionModel, self).__init__(properties=properties, commands=commands)

    def getTitle(self):
        return self._getString(7)

    def setTitle(self, value):
        self._setString(7, value)

    def getBonuses(self):
        return self._getArray(8)

    def setBonuses(self, value):
        self._setArray(8, value)

    @staticmethod
    def getBonusesType():
        return BonusModel

    def _initialize(self):
        super(MissionModel, self)._initialize()
        self._addStringProperty('title', '')
        self._addArrayProperty('bonuses', Array())