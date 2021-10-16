from constants import DeviceRepairMode
DEVICE_SLOWED_REPAIR_MASK = 128

def packDeviceRepairProgress(progress, repairMode):
    if repairMode != DeviceRepairMode.NORMAL:
        return progress | DEVICE_SLOWED_REPAIR_MASK
    return progress


def unpackDeviceRepairProgress(progressData):
    return (
     progressData & ~DEVICE_SLOWED_REPAIR_MASK,
     bool(progressData & DEVICE_SLOWED_REPAIR_MASK))