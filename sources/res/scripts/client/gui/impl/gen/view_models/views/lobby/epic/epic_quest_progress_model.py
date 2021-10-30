from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class EpicQuestProgressModel(ViewModel):
    __slots__ = ('showQuestById', )

    def __init__(self, properties=1, commands=1):
        super(EpicQuestProgressModel, self).__init__(properties=properties, commands=commands)

    def getQuests(self):
        return self._getArray(0)

    def setQuests(self, value):
        self._setArray(0, value)

    def _initialize(self):
        super(EpicQuestProgressModel, self)._initialize()
        self._addArrayProperty('quests', Array())
        self.showQuestById = self._addCommand('showQuestById')