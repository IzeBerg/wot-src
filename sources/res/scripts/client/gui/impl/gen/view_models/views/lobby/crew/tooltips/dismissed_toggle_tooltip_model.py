from gui.impl.gen.view_models.views.lobby.crew.common.tankman_restore_info import TankmanRestoreInfo

class DismissedToggleTooltipModel(TankmanRestoreInfo):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(DismissedToggleTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(DismissedToggleTooltipModel, self)._initialize()