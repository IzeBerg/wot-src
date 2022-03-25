from gui.impl.gen.view_models.common.missions.quest_model import QuestModel

class DailyQuestModel(QuestModel):
    __slots__ = ()

    def __init__(self, properties=14, commands=0):
        super(DailyQuestModel, self).__init__(properties=properties, commands=commands)

    def getIcon(self):
        return self._getString(13)

    def setIcon(self, value):
        self._setString(13, value)

    def _initialize(self):
        super(DailyQuestModel, self)._initialize()
        self._addStringProperty('icon', '')