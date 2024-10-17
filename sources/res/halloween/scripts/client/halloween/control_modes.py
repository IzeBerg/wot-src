import CommandMapping
from AvatarInputHandler import control_modes

class HWArcadeControlMode(control_modes.ArcadeControlMode):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        cmdMap = CommandMapping.g_instance
        if cmdMap.isFired(CommandMapping.CMD_CM_VEHICLE_SWITCH_AUTOROTATION, key) and isDown:
            return False
        return super(HWArcadeControlMode, self).handleKeyEvent(isDown, key, mods, event)


class HWSniperControlMode(control_modes.SniperControlMode):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        cmdMap = CommandMapping.g_instance
        if cmdMap.isFired(CommandMapping.CMD_CM_VEHICLE_SWITCH_AUTOROTATION, key) and isDown:
            return False
        return super(HWSniperControlMode, self).handleKeyEvent(isDown, key, mods, event)