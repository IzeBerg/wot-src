from gui.impl.gen.view_models.views.lobby.common.vehicle_model import VehicleModel
from gui.impl.lobby.platoon.platoon_helpers import removeNationFromTechName
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.utils.functions import replaceHyphenToUnderscore

def fillVehicleModel(model, vehicleItem):
    model.setIsPremium(vehicleItem.isPremium or vehicleItem.isElite)
    model.setName(vehicleItem.shortUserName)
    model.setTechName(replaceHyphenToUnderscore(removeNationFromTechName(vehicleItem.name)))
    model.setTier(vehicleItem.level)
    model.setType(vehicleItem.type)
    model.setNation(vehicleItem.nationName)
    model.setVehicleCD(vehicleItem.compactDescr)