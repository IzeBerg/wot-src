from enum import Enum
from white_tiger.gui.impl.gen.view_models.views.lobby.wt_event_portal_awards_base_model import WtEventPortalAwardsBaseModel

class EventTankType(Enum):
    PRIMARY = 'R212_Object_265T'
    SECONDARY = 'G168_KJpz_T_III'
    MAIN = 'Pl26_Czolg_P_Wz_46'
    BOSS = 'Pl26_Czolg_P_Wz_46_Verbesserter'


class WtEventVehiclePortalModel(WtEventPortalAwardsBaseModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=5):
        super(WtEventVehiclePortalModel, self).__init__(properties=properties, commands=commands)

    def getEventTank(self):
        return EventTankType(self._getString(8))

    def setEventTank(self, value):
        self._setString(8, value.value)

    def _initialize(self):
        super(WtEventVehiclePortalModel, self)._initialize()
        self._addStringProperty('eventTank')