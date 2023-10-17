from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class VideoTooltipView(ViewImpl):

    def __init__(self, layoutID=R.views.halloween.lobby.tooltips.VideoTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = ViewModel()
        super(VideoTooltipView, self).__init__(settings)