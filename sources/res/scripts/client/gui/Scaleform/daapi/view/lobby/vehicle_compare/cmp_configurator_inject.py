from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.lobby.vehicle_compare.ammunition_panel import CompareAmmunitionPanelView

class VehicleCompareConfiguratorInject(InjectComponentAdaptor):

    def update(self):
        self.getInjectView().update()

    def updateShells(self):
        self.getInjectView().updateSection(TankSetupConstants.TOGGLE_SHELLS)

    def updateCamouflage(self):
        self.getInjectView().updateSection(TankSetupConstants.TOGGLE_CAMOUFLAGE)

    def _makeInjectView(self):
        ammunitionPanel = CompareAmmunitionPanelView()
        return ammunitionPanel