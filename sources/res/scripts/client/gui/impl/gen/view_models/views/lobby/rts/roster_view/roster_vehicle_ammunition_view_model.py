from gui.impl.gen.view_models.views.lobby.rts.roster_view.roster_vehicle_equipment_view_model import RosterVehicleEquipmentViewModel

class RosterVehicleAmmunitionViewModel(RosterVehicleEquipmentViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(RosterVehicleAmmunitionViewModel, self).__init__(properties=properties, commands=commands)

    def getCount(self):
        return self._getNumber(2)

    def setCount(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(RosterVehicleAmmunitionViewModel, self)._initialize()
        self._addNumberProperty('count', 0)