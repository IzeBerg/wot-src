import re, nations
from items import vehicles
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from items import vehicle_items
_FORMAT_REXP = re.compile('{([a-zA-Z]+)}?')
_VEH_INFO_ARGS = {'level': lambda descr: str(descr.type.level), 
   'class': lambda descr: descr.type.getVehicleClass(), 
   'vehName': lambda descr: descr.type.name.split(':')[1], 
   'clip': lambda descr: 'hasClip' if 'clip' in descr.gun.tags else 'noClip', 
   'autoreload': lambda descr: 'hasAutoReload' if 'autoreload' in descr.gun.tags else 'noAutoreload', 
   'wheels': lambda descr: 'hasWheels' if descr.isWheeledVehicle else 'noWheels', 
   'burst': lambda descr: 'hasBurst' if descr.hasBurst else 'noBurst', 
   'dualGun': lambda descr: 'hasDualGun' if descr.isDualgunVehicle else 'noDualGun'}

def formatVehicleInfoString(fmtStr, descr):

    def replaceMatch(match):
        specifier = match.group(1)
        handler = _VEH_INFO_ARGS.get(specifier, None)
        if specifier and handler:
            return handler(descr)
        else:
            return specifier

    return _FORMAT_REXP.sub(replaceMatch, fmtStr)


def getShellDescrByName(name):
    shellNation, shellName = name.split(':')
    nationID = nations.INDICES[shellNation]
    shellID = vehicles.g_cache.shellIDs(nationID)[shellName]
    return vehicles.g_cache.shells(nationID)[shellID]