from block import Block
from slot_types import SLOT_TYPE, arrayOf
from visual_script.vehicle_blocks import VehicleMeta

class NoCrewCriticalBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(NoCrewCriticalBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._execute)

    def _execute(self):
        pass


class NoDeviceCriticalBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(NoDeviceCriticalBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._execute)

    def _execute(self):
        pass


class NoInnerDeviceDamagedBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(NoInnerDeviceDamagedBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._execute)

    def _execute(self):
        pass


class OptionalDevicesBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(OptionalDevicesBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', arrayOf(SLOT_TYPE.STR), self._execute)

    def _execute(self):
        pass


class VehicleClassBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(VehicleClassBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('className', SLOT_TYPE.STR, self._execute)

    def _execute(self):
        pass


class GetTankOptDevicesHPModBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(GetTankOptDevicesHPModBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.FLOAT, self._execute)

    def _execute(self):
        pass


class GunTypeInfoBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(GunTypeInfoBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', arrayOf(SLOT_TYPE.STR), self._execute)

    def _execute(self):
        pass


class VehicleForwardSpeedBase(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(VehicleForwardSpeedBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('fwdSpeed', SLOT_TYPE.FLOAT, self._execute)

    def _execute(self):
        pass


class VehicleCooldownEquipmentBase(Block):

    def __init__(self, *args, **kwargs):
        super(VehicleCooldownEquipmentBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('cdEquipment', arrayOf(SLOT_TYPE.STR), self._execute)

    def _execute(self):
        pass


class VehicleClipFullAndReadyBase(Block):

    def __init__(self, *args, **kwargs):
        super(VehicleClipFullAndReadyBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._execute)

    def _execute(self):
        pass


class IsInHangarBase(Block):

    def __init__(self, *args, **kwargs):
        super(IsInHangarBase, self).__init__(*args, **kwargs)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._execute)

    def _execute(self):
        pass


class VehicleRadioDistanceBase(Block):

    def __init__(self, *args, **kwargs):
        super(VehicleRadioDistanceBase, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._outSlot = self._makeDataOutputSlot('res', SLOT_TYPE.FLOAT, self._execute)

    def _execute(self):
        pass