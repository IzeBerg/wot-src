from gui.Scaleform.daapi.view.battle.shared.markers2d.plugins import EquipmentsMarkerPlugin
from gui.Scaleform.daapi.view.battle.shared.markers2d import settings

class HalloweenEquipmentsMarkerPlugin(EquipmentsMarkerPlugin):
    HW_EQUIPMENT_MARKER_LINKAGE = 'HWFortConsumablesMarkerUI'
    HW_MARKERS = ('EventDeathZoneUI', )

    def _getMarkerLinkage(self, item):
        if item.getMarker() in self.HW_MARKERS:
            return self.HW_EQUIPMENT_MARKER_LINKAGE
        return settings.MARKER_SYMBOL_NAME.EQUIPMENT_MARKER