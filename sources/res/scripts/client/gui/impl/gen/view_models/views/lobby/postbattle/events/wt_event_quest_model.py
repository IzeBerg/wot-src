from gui.impl.gen.view_models.common.missions.daily_quest_model import DailyQuestModel

class WtEventQuestModel(DailyQuestModel):
    __slots__ = ()

    def __init__(self, properties=13, commands=0):
        super(WtEventQuestModel, self).__init__(properties=properties, commands=commands)

    def getStatusLabel(self):
        return self._getString(12)

    def setStatusLabel(self, value):
        self._setString(12, value)

    def _initialize(self):
        super(WtEventQuestModel, self)._initialize()
        self._addStringProperty('statusLabel', '')