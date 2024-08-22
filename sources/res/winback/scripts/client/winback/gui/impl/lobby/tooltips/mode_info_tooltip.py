from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class ModeInfoTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.winback.lobby.tooltips.ModeInfoTooltip())
        settings.model = ViewModel()
        super(ModeInfoTooltip, self).__init__(settings)