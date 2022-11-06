from gui.Scaleform.daapi.view.lobby.hangar.VehicleParameters import VehicleParameters, TankSetupParamsDataProvider
from gui.Scaleform.daapi.view.lobby.tank_setup.ammunition_setup_vehicle import g_tankSetupVehicle
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS

class AmmunitionSetupViewVehicleParams(VehicleParameters):

    def _createDataProvider(self):
        return TankSetupParamsDataProvider(TOOLTIPS_CONSTANTS.VEHICLE_TANK_SETUP_PARAMETERS)

    def _getVehicleCache(self):
        return g_tankSetupVehicle