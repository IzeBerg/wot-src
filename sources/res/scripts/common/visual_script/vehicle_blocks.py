from block import Block, Meta
from slot_types import SLOT_TYPE

class VehicleMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 16738047

    @classmethod
    def blockCategory(cls):
        return 'Vehicle'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/tank'


class VehicleEventsMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 16738047

    @classmethod
    def blockCategory(cls):
        return 'Vehicle'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/arena_event'


class GetVehicleId(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(GetVehicleId, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._res = self._makeDataOutputSlot('id', SLOT_TYPE.INT, self._exec)

    def _exec(self):
        vehicle = self._vehicle.getValue()
        if vehicle:
            self._res.setValue(vehicle.id)