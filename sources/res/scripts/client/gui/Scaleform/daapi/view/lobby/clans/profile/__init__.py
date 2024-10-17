from gui.shared.utils.functions import getArenaGeometryName
from gui.impl import backport
from gui.impl.gen import R
MAX_MEMBERS_IN_CLAN = 100

def getI18ArenaById(arenaId):
    mapName = getArenaGeometryName(arenaId)
    dynAccessor = R.strings.arenas.dyn(('c_{}').format(mapName))
    if dynAccessor.isValid():
        return backport.text(dynAccessor.name())
    return mapName