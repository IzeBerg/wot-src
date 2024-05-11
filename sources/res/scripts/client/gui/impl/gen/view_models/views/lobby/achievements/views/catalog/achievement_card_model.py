from gui.impl.gen.view_models.views.lobby.achievements.views.catalog.details_model import DetailsModel

class AchievementCardModel(DetailsModel):
    __slots__ = ()

    def __init__(self, properties=23, commands=0):
        super(AchievementCardModel, self).__init__(properties=properties, commands=commands)

    def getIsProgressive(self):
        return self._getBool(16)

    def setIsProgressive(self, value):
        self._setBool(16, value)

    def getIsSingleStage(self):
        return self._getBool(17)

    def setIsSingleStage(self, value):
        self._setBool(17, value)

    def getSpecificItemName(self):
        return self._getString(18)

    def setSpecificItemName(self, value):
        self._setString(18, value)

    def getSpecificItemIconName(self):
        return self._getString(19)

    def setSpecificItemIconName(self, value):
        self._setString(19, value)

    def getSpecificItemId(self):
        return self._getNumber(20)

    def setSpecificItemId(self, value):
        self._setNumber(20, value)

    def getNewItemsCount(self):
        return self._getNumber(21)

    def setNewItemsCount(self, value):
        self._setNumber(21, value)

    def getIsResearchable(self):
        return self._getBool(22)

    def setIsResearchable(self, value):
        self._setBool(22, value)

    def _initialize(self):
        super(AchievementCardModel, self)._initialize()
        self._addBoolProperty('isProgressive', True)
        self._addBoolProperty('isSingleStage', False)
        self._addStringProperty('specificItemName', '')
        self._addStringProperty('specificItemIconName', '')
        self._addNumberProperty('specificItemId', 0)
        self._addNumberProperty('newItemsCount', 0)
        self._addBoolProperty('isResearchable', False)