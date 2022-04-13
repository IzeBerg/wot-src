import BigWorld, CommandMapping
from gui.Scaleform.locale.READABLE_KEY_NAMES import READABLE_KEY_NAMES
from helpers.i18n import makeString

def getHotKeyList(command):
    keys = [ makeString(READABLE_KEY_NAMES.key(vKey)) for vKey in getHotKeyVkList(command) ]
    return keys


def getHotKeyVkList(command):
    key, satelliteKeys = CommandMapping.g_instance.getCommandKeys(command)
    keys = [ BigWorld.keyToString(satelliteKey) for satelliteKey in satelliteKeys ]
    keys.append(BigWorld.keyToString(key))
    return keys