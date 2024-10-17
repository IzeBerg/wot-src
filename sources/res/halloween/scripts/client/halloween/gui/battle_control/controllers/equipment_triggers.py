from gui.battle_control.controllers.consumables.equipment_ctrl import _OrderItem, _ReplayOrderItem
from gui.Scaleform.genConsts.BATTLE_MARKERS_CONSTS import BATTLE_MARKERS_CONSTS

class _EventArtilleryItem(_OrderItem):

    def getMarker(self):
        return 'EventDeathZoneUI'

    def getMarkerColor(self):
        return BATTLE_MARKERS_CONSTS.COLOR_RED


class _ReplayEventArtilleryItem(_ReplayOrderItem):

    def getMarker(self):
        return 'EventDeathZoneUI'

    def getMarkerColor(self):
        return BATTLE_MARKERS_CONSTS.COLOR_RED