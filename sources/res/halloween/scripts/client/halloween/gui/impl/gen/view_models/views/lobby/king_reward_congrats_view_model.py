from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel

class KingRewardCongratsViewModel(ViewModel):
    __slots__ = ('onClose', 'onAccept', 'onShowClick')

    def __init__(self, properties=2, commands=3):
        super(KingRewardCongratsViewModel, self).__init__(properties=properties, commands=commands)

    def getIsVideoInLastArtefact(self):
        return self._getBool(0)

    def setIsVideoInLastArtefact(self, value):
        self._setBool(0, value)

    def getRewards(self):
        return self._getArray(1)

    def setRewards(self, value):
        self._setArray(1, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(KingRewardCongratsViewModel, self)._initialize()
        self._addBoolProperty('isVideoInLastArtefact', False)
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')
        self.onAccept = self._addCommand('onAccept')
        self.onShowClick = self._addCommand('onShowClick')