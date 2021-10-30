import BigWorld, CommandMapping
from gui.Scaleform.locale.READABLE_KEY_NAMES import READABLE_KEY_NAMES
from helpers.i18n import makeString

def getHotKeyList(command):
    keys = []
    key, satelliteKeys = CommandMapping.g_instance.getCommandKeys(command)
    for satelliteKey in satelliteKeys:
        keys.append(makeString(READABLE_KEY_NAMES.key(BigWorld.keyToString(satelliteKey))))

    keys.append(makeString(READABLE_KEY_NAMES.key(BigWorld.keyToString(key))))
    return keys