from gui.impl.gen.view_models.views.lobby.new_year.components.reward_item_model import RewardItemModel

class BundleRewardItemModel(RewardItemModel):
    __slots__ = ()

    def __init__(self, properties=15, commands=0):
        super(BundleRewardItemModel, self).__init__(properties=properties, commands=commands)

    def getIntCD(self):
        return self._getNumber(14)

    def setIntCD(self, value):
        self._setNumber(14, value)

    def _initialize(self):
        super(BundleRewardItemModel, self)._initialize()
        self._addNumberProperty('intCD', 0)