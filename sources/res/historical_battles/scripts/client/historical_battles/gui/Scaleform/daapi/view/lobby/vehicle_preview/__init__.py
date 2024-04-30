from gui.Scaleform.framework import ComponentSettings, ScopeTemplates
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
from historical_battles.gui.Scaleform.daapi.view.lobby.vehicle_preview.hb_vehicle_preview import HBVehiclePreviewPanel, HBVehicleRestorePanel

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ComponentSettings(VEHPREVIEW_CONSTANTS.HB_PANEL_LINKAGE, HBVehiclePreviewPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.HB_RESTORE_PANEL_LINKAGE, HBVehicleRestorePanel, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return ()