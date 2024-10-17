import BigWorld, Event, CommandMapping

class HWNitroAccelerationControl(BigWorld.DynamicScriptComponent):

    def __init__(self):
        self._eManager = Event.EventManager()
        self.onActivate = Event.Event(self._eManager)

    def onDestroy(self):
        self._eManager.clear()

    def handleKey(self, isDown, key, _):
        cmdMap = CommandMapping.g_instance
        keyCaptured = cmdMap.isFired(CommandMapping.CMD_CM_VEHICLE_SWITCH_AUTOROTATION, key) and isDown
        if not keyCaptured:
            return False
        else:
            vehicle = BigWorld.player().getVehicleAttached()
            if vehicle is not None and vehicle.isPlayerVehicle and vehicle.isAlive():
                self.onActivate()
            return True