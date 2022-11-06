from frameworks.wulf import ViewModel, ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class BattlePassLockIconTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.battle_pass.tooltips.BattlePassLockIconTooltipView())
        settings.model = ViewModel()
        super(BattlePassLockIconTooltipView, self).__init__(settings)