import typing
if typing.TYPE_CHECKING:
    from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel
    from gui.shared.gui_items.Vehicle import Vehicle

def fillVehicleInfo(vehInfo, vehicle):
    isElite = not vehicle.getEliteStatusProgress().toUnlock or vehicle.isElite
    vehInfo.setIsElite(isElite)
    vehInfo.setVehicleLvl(vehicle.level)
    vehInfo.setVehicleName(vehicle.userName)
    vehInfo.setVehicleType(vehicle.type)
    vehInfo.setVehicleNation(vehicle.nationName)
    vehInfo.setVehicleShortName(vehicle.shortUserName)