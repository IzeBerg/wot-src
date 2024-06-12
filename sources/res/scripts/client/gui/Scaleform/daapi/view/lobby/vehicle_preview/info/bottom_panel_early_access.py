from frameworks.wulf import ViewSettings, ViewFlags, ViewModel
from gui.Scaleform.daapi.view.meta.VehiclePreviewBottomPanelEarlyAccessMeta import VehiclePreviewBottomPanelEarlyAccessMeta
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class VehiclePreviewBottomPanelEarlyAccess(VehiclePreviewBottomPanelEarlyAccessMeta):

    def _makeInjectView(self, *args):
        return _EarlyAccessBottomPanelView()


class _EarlyAccessBottomPanelView(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.vehicle_preview.buying_panel.EarlyAccessPanel())
        settings.flags = ViewFlags.VIEW
        settings.model = ViewModel()
        super(_EarlyAccessBottomPanelView, self).__init__(settings)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.early_access.tooltips.EarlyAccessCommonDescriptionTooltip():
            return ViewImpl(ViewSettings(contentID, model=ViewModel()))
        return super(_EarlyAccessBottomPanelView, self).createToolTipContent(event, contentID)