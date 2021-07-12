from gui.battle_control.controllers.appearance_cache_ctrls import getWholeVehModels
from gui.battle_control.controllers.appearance_cache_ctrls.default_appearance_cache_ctrl import DefaultAppearanceCacheController

class BattleRoyaleAppearanceCacheController(DefaultAppearanceCacheController):

    def arenaLoadCompleted(self):
        super(BattleRoyaleAppearanceCacheController, self).arenaLoadCompleted()
        self._precacheExtraResources()

    def _precacheExtraResources(self):
        cachedDescs = set()
        for veh in self._arena.vehicles.values():
            vDesc = veh['vehicleType']
            if vDesc.name in cachedDescs:
                continue
            cachedDescs.add(vDesc.name)
            self._appearanceCache.loadResources(vDesc.makeCompactDescr(), getWholeVehModels(vDesc))