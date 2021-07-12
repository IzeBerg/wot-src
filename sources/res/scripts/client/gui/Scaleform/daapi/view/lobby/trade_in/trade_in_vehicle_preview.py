from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VehiclePreview
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS

class TradeInVehiclePreview(VehiclePreview):

    def setBottomPanel(self):
        self.as_setBottomPanelS(VEHPREVIEW_CONSTANTS.TRADE_IN_BUYING_PANEL_LINKAGE)

    def _onRegisterFlashComponent(self, viewPy, alias):
        super(TradeInVehiclePreview, self)._onRegisterFlashComponent(viewPy, alias)
        if alias == VEHPREVIEW_CONSTANTS.TRADE_IN_BUYING_PANEL_PY_ALIAS:
            viewPy.setBackAlias(self._backAlias)
            viewPy.setBackCallback(self._previewBackCb)